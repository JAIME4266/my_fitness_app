import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/features/nutrition/data/nutrition_repository.dart';
import 'package:my_fitness_app/features/nutrition/presentation/nutrition_goals_screen.dart';

void main() {
  group('Phase 9 Custom Calorie & Macro Goals', () {
    test('saveCustomNutritionGoals persists goals without altering MealLogs',
        () async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = NutritionRepository(db);

      await repo.logCustomOrEstimatedMeal(
        foodName: 'Oats',
        mealType: 'Breakfast',
        portionGrams: 50,
        calories: 190,
        proteinG: 7,
        carbsG: 32,
        fatG: 3.5,
      );

      await repo.saveCustomNutritionGoals(
        dailyCalorieGoal: 2450,
        proteinTargetG: 155,
        carbsTargetG: 270,
        fatTargetG: 75,
        fibreTargetG: 35,
        goalType: 'custom',
      );

      final profile = await db.getMetabolicProfile();
      final meals = await db.select(db.mealLogs).get();

      expect(profile?.dailyCalorieGoal, 2450);
      expect(profile?.proteinTargetG, 155.0);
      expect(meals.length, 1);
      expect(meals.first.foodName, 'Oats');

      await db.close();
    });

    test('getMealBreakdownForDate aggregates by meal type', () async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = NutritionRepository(db);

      await repo.logCustomOrEstimatedMeal(
        foodName: 'Idli',
        mealType: 'Breakfast',
        portionGrams: 120,
        calories: 180,
        proteinG: 6,
        carbsG: 36,
        fatG: 1,
      );
      await repo.logCustomOrEstimatedMeal(
        foodName: 'Dal Rice',
        mealType: 'Lunch',
        portionGrams: 300,
        calories: 420,
        proteinG: 16,
        carbsG: 72,
        fatG: 6,
      );

      final breakdown = await repo.getMealBreakdownForDate(DateTime.now());
      expect(breakdown['Breakfast']!.calories, 180.0);
      expect(breakdown['Lunch']!.calories, 420.0);
      expect(breakdown['Dinner']!.calories, 0.0);

      await db.close();
    });

    testWidgets('NutritionGoalsScreen saves custom goals and shows Meal & Trends',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = NutritionRepository(db);

      await tester.pumpWidget(
        MaterialApp(home: NutritionGoalsScreen(repository: repo)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Muscle & Strength'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('SAVE NUTRITION GOALS'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text('SAVE NUTRITION GOALS'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('SAVE NUTRITION GOALS'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final profile = await tester.runAsync(() => db.getMetabolicProfile());
      expect(profile?.dailyCalorieGoal, 2550);

      await tester.tap(find.text('Meal & Trends'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Today by Meal'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
