import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/nutrition/data/nutrition_repository.dart';
import 'package:my_fitness_app/features/nutrition/domain/nutrition_calculator.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('AppDatabase v1 -> v2 Migration & NutritionRepository', () {
    late AppDatabase db;
    late NutritionRepository nutritionRepo;
    late FitnessRepository fitnessRepo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      nutritionRepo = NutritionRepository(db);
      fitnessRepo = FitnessRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Seeds IFCT 2017 catalog & default metabolic profile idempotently',
        () async {
      await nutritionRepo.ensureSeeded();
      await nutritionRepo.ensureSeeded();

      final foods = await db.watchFoodCatalog().first;
      expect(foods.length, greaterThanOrEqualTo(35));

      final rice = await db.findFoodById('ifct_rice_white');
      expect(rice, isNotNull);
      expect(rice!.yieldFactor, 2.98);
      expect(rice.hindiName, contains('Chawal'));

      final profile = await nutritionRepo.getMetabolicProfile();
      expect(profile.dailyCalorieGoal, greaterThan(1500));
    });

    test(
        'Logging, updating, and deleting meals updates DailySummaries.consumedCalories',
        () async {
      await nutritionRepo.ensureSeeded();
      final rice = (await db.findFoodById('ifct_rice_white'))!;
      final dal = (await db.findFoodById('ifct_moong_dal'))!;

      // Save wearable steps first (Phase 2 regression check)
      await fitnessRepo.saveDailySync(steps: 5400, activeCalories: 216);
      final afterWearable = await fitnessRepo.getTodaySummary();
      expect(afterWearable!.steps, 5400);
      expect(afterWearable.consumedCalories, 0);

      // Log 149g cooked rice -> 50g raw -> 178 kcal
      await nutritionRepo.logFoodFromCatalog(
        food: rice,
        mealType: 'Lunch',
        inputGrams: 149.0,
        basis: MeasurementBasis.cooked,
      );

      // Log 160g cooked moong dal + 0.5 tsp oil -> 50g raw (174) + 22.5 = 196.5 kcal
      await nutritionRepo.logFoodFromCatalog(
        food: dal,
        mealType: 'Lunch',
        inputGrams: 160.0,
        basis: MeasurementBasis.cooked,
        extraOilTsp: 0.5,
      );

      final totals =
          await nutritionRepo.watchDailyNutritionTotals(DateTime.now()).first;
      expect(totals.allMeals.length, 2);
      expect(totals.totalKcal, closeTo(374.5, 0.2));

      // Verify DailySummaries kept Phase 2 wearable steps & updated consumedCalories
      final summary = await fitnessRepo.getTodaySummary();
      expect(summary!.steps, 5400);
      expect(summary.activeCalories, 216);
      expect(summary.consumedCalories, 375);

      // Update rice portion to 298g cooked -> 356 kcal
      final riceMeal =
          totals.allMeals.firstWhere((m) => m.foodId == 'ifct_rice_white');
      await nutritionRepo.updateMealPortion(
        existing: riceMeal,
        catalogFood: rice,
        mealType: 'Dinner',
        inputGrams: 298.0,
        basis: MeasurementBasis.cooked,
        extraOilTsp: 0.0,
      );

      final updatedSummary = await fitnessRepo.getTodaySummary();
      expect(updatedSummary!.consumedCalories, 553); // 356 + 196.5 = 552.5 -> 553

      // Delete dal meal -> leaves 356 kcal
      final dalMeal =
          totals.allMeals.firstWhere((m) => m.foodId == 'ifct_moong_dal');
      await nutritionRepo.deleteMealLog(dalMeal);

      final afterDelete = await fitnessRepo.getTodaySummary();
      expect(afterDelete!.consumedCalories, 356);
    });

    test('Custom foods persist and search matches English & Hindi names',
        () async {
      await nutritionRepo.ensureSeeded();
      await nutritionRepo.addCustomFood(
        name: 'Homemade Besan Ladoo',
        hindiName: 'Besan Ladoo',
        defaultBasis: MeasurementBasis.raw,
        yieldFactor: 1.0,
        kcalPer100g: 460,
        proteinPer100g: 9.5,
        carbsPer100g: 52.0,
        fatPer100g: 23.0,
        defaultServingG: 40,
      );

      final results =
          await nutritionRepo.watchFoodCatalog(query: 'ladoo').first;
      expect(results.length, 1);
      expect(results.first.source, 'custom');

      final hindiResults =
          await nutritionRepo.watchFoodCatalog(query: 'chawal').first;
      expect(hindiResults.any((f) => f.id == 'ifct_rice_white'), isTrue);
    });

    test('v1 database upgrades cleanly to v2 preserving existing rows',
        () async {
      final migratedDb = AppDatabase(
        NativeDatabase.memory(
          setup: (rawDb) {
            rawDb.execute('''
              CREATE TABLE daily_summaries (
                date TEXT NOT NULL PRIMARY KEY,
                steps INTEGER NOT NULL DEFAULT 0,
                active_calories INTEGER NOT NULL DEFAULT 0,
                target_calories INTEGER NOT NULL DEFAULT 2200,
                consumed_calories INTEGER NOT NULL DEFAULT 0,
                water_ml INTEGER NOT NULL DEFAULT 0,
                last_sync INTEGER NULL
              );
            ''');
            rawDb.execute('''
              CREATE TABLE workouts (
                id TEXT NOT NULL PRIMARY KEY,
                type TEXT NOT NULL,
                start_epoch_ms INTEGER NOT NULL,
                duration_sec INTEGER NOT NULL DEFAULT 0,
                distance_m REAL NOT NULL DEFAULT 0.0,
                calories_kcal REAL NOT NULL DEFAULT 0.0,
                polyline_json TEXT NULL
              );
            ''');
            rawDb.execute('''
              CREATE TABLE meal_logs (
                id TEXT NOT NULL PRIMARY KEY,
                food_name TEXT NOT NULL,
                meal_type TEXT NOT NULL,
                cooked_weight_g REAL NOT NULL DEFAULT 0.0,
                calculated_kcal REAL NOT NULL DEFAULT 0.0,
                protein_g REAL NOT NULL DEFAULT 0.0,
                carbs_g REAL NOT NULL DEFAULT 0.0,
                fat_g REAL NOT NULL DEFAULT 0.0,
                timestamp INTEGER NOT NULL
              );
            ''');
            rawDb.execute('''
              INSERT INTO daily_summaries (date, steps, active_calories)
              VALUES ('2026-11-24', 7639, 306);
            ''');
            rawDb.execute('''
              INSERT INTO meal_logs (id, food_name, meal_type, cooked_weight_g, calculated_kcal, protein_g, carbs_g, fat_g, timestamp)
              VALUES ('old_meal_1', 'Legacy Meal', 'Lunch', 200.0, 350.0, 15.0, 45.0, 10.0, 1732440000);
            ''');
            rawDb.execute('PRAGMA user_version = 1;');
          },
        ),
      );
      addTearDown(() => migratedDb.close());

      final preservedSummary =
          await migratedDb.getSummaryForDate('2026-11-24');
      expect(preservedSummary, isNotNull);
      expect(preservedSummary!.steps, 7639);
      expect(preservedSummary.activeCalories, 306);

      final repo = NutritionRepository(migratedDb);
      await repo.ensureSeeded();
      final catalog = await repo.watchFoodCatalog().first;
      expect(catalog, isNotEmpty);

      final preservedMeals = await migratedDb.getMealsBetween(
        DateTime.fromMillisecondsSinceEpoch(1732400000 * 1000),
        DateTime.fromMillisecondsSinceEpoch(1732500000 * 1000),
      );
      expect(preservedMeals.length, 1);
      expect(preservedMeals.first.foodName, 'Legacy Meal');
      expect(preservedMeals.first.basis, 'cooked');
    });
  });
}
