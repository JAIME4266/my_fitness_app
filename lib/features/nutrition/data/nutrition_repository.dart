import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../../../database/fitness_repository.dart';
import '../domain/nutrition_calculator.dart';
import 'ifct_seed_data.dart';

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return NutritionRepository(db);
});

final metabolicProfileStreamProvider =
    StreamProvider<UserMetabolicProfile?>((ref) {
  final repo = ref.watch(nutritionRepositoryProvider);
  return repo.watchMetabolicProfile();
});

final todayNutritionTotalsProvider = StreamProvider<DailyNutritionTotals>((ref) {
  final repo = ref.watch(nutritionRepositoryProvider);
  return repo.watchDailyNutritionTotals(DateTime.now());
});

class DailyNutritionTotals {
  final double totalKcal;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double fibreG;
  final List<MealLog> allMeals;
  final Map<String, List<MealLog>> mealsByCategory;
  final Map<String, double> kcalByCategory;

  const DailyNutritionTotals({
    this.totalKcal = 0.0,
    this.proteinG = 0.0,
    this.carbsG = 0.0,
    this.fatG = 0.0,
    this.fibreG = 0.0,
    this.allMeals = const [],
    this.mealsByCategory = const {},
    this.kcalByCategory = const {},
  });

  static DailyNutritionTotals fromMeals(List<MealLog> meals) {
    final grouped = <String, List<MealLog>>{
      'Breakfast': [],
      'Lunch': [],
      'Dinner': [],
      'Snack': [],
    };
    final kcalMap = <String, double>{
      'Breakfast': 0.0,
      'Lunch': 0.0,
      'Dinner': 0.0,
      'Snack': 0.0,
    };

    double kcal = 0;
    double p = 0;
    double c = 0;
    double f = 0;
    double fib = 0;

    for (final meal in meals) {
      kcal += meal.calculatedKcal;
      p += meal.proteinG;
      c += meal.carbsG;
      f += meal.fatG;
      fib += meal.fibreG;

      final cat = grouped.containsKey(meal.mealType) ? meal.mealType : 'Snack';
      grouped[cat]!.add(meal);
      kcalMap[cat] = (kcalMap[cat] ?? 0.0) + meal.calculatedKcal;
    }

    return DailyNutritionTotals(
      totalKcal: kcal,
      proteinG: p,
      carbsG: c,
      fatG: f,
      fibreG: fib,
      allMeals: meals,
      mealsByCategory: grouped,
      kcalByCategory: kcalMap,
    );
  }
}

class NutritionRepository {
  final AppDatabase db;
  Future<void>? _seedFuture;
  int _idCounter = 0;

  NutritionRepository(this.db);

  static const List<String> mealCategories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  static const List<String> foodCategories = [
    'All',
    'Grains & Roti',
    'Dals & Legumes',
    'Dairy & Paneer',
    'Eggs & Meat',
    'Vegetables & Sabzi',
    'Fruits & Nuts',
    'Indian Meals & Snacks',
    'Custom',
  ];

  Future<void> ensureSeeded() {
    return _seedFuture ??= _runSeed();
  }

  Future<void> _runSeed() async {
    await db.seedFoods(buildIfctSeedCatalog());
    final existingProfile = await db.getMetabolicProfile();
    if (existingProfile == null) {
      final bmr = NutritionCalculator.calculateMifflinStJeorBmr(
        weightKg: 75.0,
        heightCm: 175.0,
        age: 24,
        sex: 'male',
      );
      final tdee = NutritionCalculator.calculateBaselineTdee(bmr: bmr).round();
      await db.upsertMetabolicProfile(
        UserMetabolicProfilesCompanion(
          id: const Value(1),
          name: const Value('Athlete'),
          age: const Value(24),
          sex: const Value('male'),
          heightCm: const Value(175.0),
          weightKg: const Value(75.0),
          bodyFatPct: const Value(18.0),
          bmrFormula: const Value('mifflin'),
          activityMultiplier: const Value(1.2),
          goalDeltaKcal: const Value(0),
          dailyCalorieGoal: Value(tdee),
          proteinTargetG: const Value(130.0),
          carbsTargetG: const Value(230.0),
          fatTargetG: const Value(65.0),
          fibreTargetG: const Value(30.0),
        ),
      );
    }
  }

  Stream<List<FoodCatalogData>> watchFoodCatalog({
    String query = '',
    String? category,
  }) async* {
    await ensureSeeded();
    yield* db.watchFoodCatalog(query: query, category: category);
  }

  Future<FoodCatalogData?> findFoodById(String id) async {
    await ensureSeeded();
    return db.findFoodById(id);
  }

  Future<FoodCatalogData> addCustomFood({
    required String name,
    String hindiName = '',
    String category = 'Custom',
    required MeasurementBasis defaultBasis,
    required double yieldFactor,
    required double kcalPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    double fibrePer100g = 0.0,
    double defaultServingG = 100.0,
    String servingLabel = '100g serving',
  }) async {
    await ensureSeeded();
    final id = _nextId('custom_food');
    final companion = FoodCatalogCompanion(
      id: Value(id),
      name: Value(name.trim()),
      hindiName: Value(hindiName.trim()),
      category: Value(category),
      source: const Value('custom'),
      defaultBasis: Value(defaultBasis.name),
      yieldFactor: Value(yieldFactor > 0 ? yieldFactor : 1.0),
      kcalPer100g: Value(kcalPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      fibrePer100g: Value(fibrePer100g),
      defaultServingG: Value(defaultServingG > 0 ? defaultServingG : 100.0),
      servingLabel: Value(servingLabel.trim().isEmpty ? '100g' : servingLabel.trim()),
    );
    await db.upsertFood(companion);
    return (await db.findFoodById(id))!;
  }

  Stream<List<MealLog>> watchMealsForDate(DateTime date) async* {
    await ensureSeeded();
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    yield* db.watchMealsBetween(start, end);
  }

  Stream<DailyNutritionTotals> watchDailyNutritionTotals(DateTime date) {
    return watchMealsForDate(date).map(DailyNutritionTotals.fromMeals);
  }

  Future<void> logFoodFromCatalog({
    required FoodCatalogData food,
    required String mealType,
    required double inputGrams,
    required MeasurementBasis basis,
    double extraOilTsp = 0.0,
    DateTime? timestamp,
    bool isEstimate = false,
  }) async {
    await ensureSeeded();
    final ts = timestamp ?? DateTime.now();
    final computed = NutritionCalculator.calculateFoodNutrition(
      inputGrams: inputGrams,
      basis: basis,
      yieldFactor: food.yieldFactor,
      rawKcalPer100g: food.kcalPer100g,
      rawProteinPer100g: food.proteinPer100g,
      rawCarbsPer100g: food.carbsPer100g,
      rawFatPer100g: food.fatPer100g,
      rawFibrePer100g: food.fibrePer100g,
      rawSaturatedFatPer100g: food.saturatedFatPer100g,
      rawSugarPer100g: food.sugarPer100g,
      rawSodiumMgPer100g: food.sodiumMgPer100g,
      extraOilTsp: extraOilTsp,
    );

    await db.transaction(() async {
      await db.upsertMealLog(
        MealLogsCompanion(
          id: Value(_nextId('meal')),
          foodId: Value(food.id),
          foodName: Value(food.name),
          mealType: Value(mealType),
          basis: Value(basis.name),
          cookedWeightG: Value(computed.cookedWeightG),
          rawEquivalentG: Value(computed.rawEquivalentG),
          extraOilTsp: Value(extraOilTsp),
          calculatedKcal: Value(computed.calories),
          proteinG: Value(computed.proteinG),
          carbsG: Value(computed.carbsG),
          fatG: Value(computed.fatG),
          fibreG: Value(computed.fibreG),
          saturatedFatG: Value(computed.saturatedFatG),
          sugarG: Value(computed.sugarG),
          sodiumMg: Value(computed.sodiumMg),
          isEstimate: Value(isEstimate),
          timestamp: Value(ts),
        ),
      );
      await _recomputeDailySummaryConsumedCalories(ts);
    });
  }

  Future<void> logCustomOrEstimatedMeal({
    required String foodName,
    required String mealType,
    required double portionGrams,
    required double calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    double fibreG = 0.0,
    double? saturatedFatG,
    double? sugarG,
    double? sodiumMg,
    bool isEstimate = true,
  }) async {
    await ensureSeeded();
    final ts = DateTime.now();
    await db.transaction(() async {
      await db.upsertMealLog(
        MealLogsCompanion(
          id: Value(_nextId('meal')),
          foodName: Value(foodName.trim()),
          mealType: Value(mealType),
          basis: const Value('cooked'),
          cookedWeightG: Value(_round1(portionGrams)),
          rawEquivalentG: Value(_round1(portionGrams)),
          extraOilTsp: const Value(0.0),
          calculatedKcal: Value(_round1(calories)),
          proteinG: Value(_round1(proteinG)),
          carbsG: Value(_round1(carbsG)),
          fatG: Value(_round1(fatG)),
          fibreG: Value(_round1(fibreG)),
          saturatedFatG: Value(saturatedFatG != null ? _round1(saturatedFatG) : null),
          sugarG: Value(sugarG != null ? _round1(sugarG) : null),
          sodiumMg: Value(sodiumMg != null ? _round1(sodiumMg) : null),
          isEstimate: Value(isEstimate),
          timestamp: Value(ts),
        ),
      );
      await _recomputeDailySummaryConsumedCalories(ts);
    });
  }

  Future<void> updateMealPortion({
    required MealLog existing,
    FoodCatalogData? catalogFood,
    required String mealType,
    required double inputGrams,
    required MeasurementBasis basis,
    required double extraOilTsp,
  }) async {
    await ensureSeeded();

    late final MealLogsCompanion updated;
    if (catalogFood != null) {
      final computed = NutritionCalculator.calculateFoodNutrition(
        inputGrams: inputGrams,
        basis: basis,
        yieldFactor: catalogFood.yieldFactor,
        rawKcalPer100g: catalogFood.kcalPer100g,
        rawProteinPer100g: catalogFood.proteinPer100g,
        rawCarbsPer100g: catalogFood.carbsPer100g,
        rawFatPer100g: catalogFood.fatPer100g,
        rawFibrePer100g: catalogFood.fibrePer100g,
        rawSaturatedFatPer100g: catalogFood.saturatedFatPer100g,
        rawSugarPer100g: catalogFood.sugarPer100g,
        rawSodiumMgPer100g: catalogFood.sodiumMgPer100g,
        extraOilTsp: extraOilTsp,
      );
      updated = MealLogsCompanion(
        id: Value(existing.id),
        foodId: Value(existing.foodId),
        foodName: Value(existing.foodName),
        mealType: Value(mealType),
        basis: Value(basis.name),
        cookedWeightG: Value(computed.cookedWeightG),
        rawEquivalentG: Value(computed.rawEquivalentG),
        extraOilTsp: Value(extraOilTsp),
        calculatedKcal: Value(computed.calories),
        proteinG: Value(computed.proteinG),
        carbsG: Value(computed.carbsG),
        fatG: Value(computed.fatG),
        fibreG: Value(computed.fibreG),
        saturatedFatG: Value(computed.saturatedFatG),
        sugarG: Value(computed.sugarG),
        sodiumMg: Value(computed.sodiumMg),
        isEstimate: Value(existing.isEstimate),
        timestamp: Value(existing.timestamp),
      );
    } else {
      final oldWeight = existing.cookedWeightG > 0 ? existing.cookedWeightG : 100.0;
      final ratio = inputGrams / oldWeight;
      final oilDeltaTsp = extraOilTsp - existing.extraOilTsp;
      final oilDeltaKcal = oilDeltaTsp * NutritionCalculator.kcalPerTspFat;
      final oilDeltaFat = oilDeltaTsp * NutritionCalculator.gramsFatPerTsp;
      updated = MealLogsCompanion(
        id: Value(existing.id),
        foodId: Value(existing.foodId),
        foodName: Value(existing.foodName),
        mealType: Value(mealType),
        basis: Value(basis.name),
        cookedWeightG: Value(_round1(inputGrams)),
        rawEquivalentG: Value(_round1(existing.rawEquivalentG * ratio)),
        extraOilTsp: Value(extraOilTsp),
        calculatedKcal: Value(_round1(
            ((existing.calculatedKcal - existing.extraOilTsp * 45.0) * ratio) +
                (extraOilTsp * 45.0) +
                (oilDeltaKcal * 0))),
        proteinG: Value(_round1(existing.proteinG * ratio)),
        carbsG: Value(_round1(existing.carbsG * ratio)),
        fatG: Value(_round1(
            ((existing.fatG - existing.extraOilTsp * 5.0) * ratio) +
                (extraOilTsp * 5.0) +
                (oilDeltaFat * 0))),
        fibreG: Value(_round1(existing.fibreG * ratio)),
        saturatedFatG: Value(existing.saturatedFatG != null
            ? _round1(existing.saturatedFatG! * ratio)
            : null),
        sugarG: Value(
            existing.sugarG != null ? _round1(existing.sugarG! * ratio) : null),
        sodiumMg: Value(existing.sodiumMg != null
            ? _round1(existing.sodiumMg! * ratio)
            : null),
        isEstimate: Value(existing.isEstimate),
        timestamp: Value(existing.timestamp),
      );
    }

    await db.transaction(() async {
      await db.upsertMealLog(updated);
      await _recomputeDailySummaryConsumedCalories(existing.timestamp);
    });
  }

  Future<void> deleteMealLog(MealLog meal) async {
    await db.transaction(() async {
      await db.deleteMealLogById(meal.id);
      await _recomputeDailySummaryConsumedCalories(meal.timestamp);
    });
  }

  Stream<UserMetabolicProfile?> watchMetabolicProfile() async* {
    await ensureSeeded();
    yield* db.watchMetabolicProfile();
  }

  Future<UserMetabolicProfile> getMetabolicProfile() async {
    await ensureSeeded();
    return (await db.getMetabolicProfile())!;
  }

  Future<void> saveMetabolicProfile({
    required String name,
    required int age,
    required String sex,
    required double heightCm,
    required double weightKg,
    double? bodyFatPct,
    required String bmrFormula,
    required double activityMultiplier,
    required int goalDeltaKcal,
    required int dailyCalorieGoal,
    required double proteinTargetG,
    required double carbsTargetG,
    required double fatTargetG,
    required double fibreTargetG,
  }) async {
    await ensureSeeded();
    await db.transaction(() async {
      await db.upsertMetabolicProfile(
        UserMetabolicProfilesCompanion(
          id: const Value(1),
          name: Value(name.trim().isEmpty ? 'Athlete' : name.trim()),
          age: Value(age),
          sex: Value(sex),
          heightCm: Value(heightCm),
          weightKg: Value(weightKg),
          bodyFatPct: Value(bodyFatPct),
          bmrFormula: Value(bmrFormula),
          activityMultiplier: Value(activityMultiplier),
          goalDeltaKcal: Value(goalDeltaKcal),
          dailyCalorieGoal: Value(dailyCalorieGoal),
          proteinTargetG: Value(proteinTargetG),
          carbsTargetG: Value(carbsTargetG),
          fatTargetG: Value(fatTargetG),
          fibreTargetG: Value(fibreTargetG),
        ),
      );

      final today = dateKeyFor(DateTime.now());
      final existing = await db.getSummaryForDate(today);
      await db.insertOrUpdateSummary(
        DailySummariesCompanion(
          date: Value(today),
          steps: Value(existing?.steps ?? 0),
          activeCalories: Value(existing?.activeCalories ?? 0),
          consumedCalories: Value(existing?.consumedCalories ?? 0),
          targetCalories: Value(dailyCalorieGoal),
          waterMl: Value(existing?.waterMl ?? 0),
          lastSync: Value(existing?.lastSync),
        ),
      );
    });
  }

  Future<void> _recomputeDailySummaryConsumedCalories(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final meals = await db.getMealsBetween(start, end);
    final totalKcal =
        meals.fold<double>(0.0, (sum, m) => sum + m.calculatedKcal).round();

    final key = dateKeyFor(date);
    final existing = await db.getSummaryForDate(key);
    final profile = await db.getMetabolicProfile();
    final targetKcal =
        existing?.targetCalories ?? profile?.dailyCalorieGoal ?? 2200;

    await db.insertOrUpdateSummary(
      DailySummariesCompanion(
        date: Value(key),
        steps: Value(existing?.steps ?? 0),
        activeCalories: Value(existing?.activeCalories ?? 0),
        consumedCalories: Value(totalKcal),
        targetCalories: Value(targetKcal),
        waterMl: Value(existing?.waterMl ?? 0),
        lastSync: Value(existing?.lastSync),
      ),
    );
  }

  static String dateKeyFor(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _nextId(String prefix) {
    _idCounter += 1;
    return '${prefix}_${DateTime.now().microsecondsSinceEpoch}_$_idCounter';
  }

  static double _round1(double v) => (v * 10).roundToDouble() / 10.0;
}
