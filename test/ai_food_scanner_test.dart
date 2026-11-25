import 'dart:typed_data';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/nutrition/data/ai_food_service.dart';
import 'package:my_fitness_app/features/nutrition/data/nutrition_repository.dart';
import 'package:my_fitness_app/features/nutrition/presentation/ai_food_scanner_screen.dart';

class _FakeAiProvider implements FoodRecognitionProvider {
  @override
  bool get isConfigured => true;

  @override
  Future<AiFoodRecognitionResult> analyzeMealImage(Uint8List imageBytes) async {
    return AiFoodRecognitionResult(
      success: true,
      items: [
        RecognizedFoodItem(
          name: 'Paneer Curry',
          basePortionGrams: 150,
          baseCalories: 320,
          baseProteinG: 16,
          baseCarbsG: 12,
          baseFatG: 22,
          baseFibreG: 3,
        ),
        RecognizedFoodItem(
          name: 'Steamed Rice',
          basePortionGrams: 150,
          baseCalories: 200,
          baseProteinG: 4,
          baseCarbsG: 44,
          baseFatG: 0.5,
        ),
      ],
    );
  }
}

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('Phase 7 AI Food Recognition & Portion Adjustment', () {
    test('RecognizedFoodItem scales nutrition proportionally on portion change',
        () {
      final item = RecognizedFoodItem.fromJson({
        'name': 'Paneer Rice Bowl',
        'portionGrams': 200,
        'calories': 400,
        'proteinG': 20,
        'carbsG': 50,
        'fatG': 12,
        'fibreG': 4,
      });

      item.portionGrams = 300; // 1.5x
      expect(item.calories, 600);
      expect(item.proteinG, 30);
      expect(item.carbsG, 75);
      expect(item.fatG, 18);
      expect(item.fibreG, 6);
    });

    test('Unconfigured GeminiProxyFoodRecognitionProvider fails gracefully',
        () async {
      final provider = GeminiProxyFoodRecognitionProvider();
      expect(provider.isConfigured, isFalse);
      final res = await provider.analyzeMealImage(Uint8List.fromList([1, 2, 3]));
      expect(res.success, isFalse);
      expect(res.errorMessage, contains('manual'));
    });

    testWidgets('AiFoodScannerScreen allows adding ingredient and saving to Diary',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = NutritionRepository(db);
      await repo.ensureSeeded();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
            foodRecognitionProvider.overrideWithValue(_FakeAiProvider()),
          ],
          child: const MaterialApp(home: AiFoodScannerScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Scan Food with Camera'), findsOneWidget);
      expect(find.text('Upload Food Image'), findsOneWidget);
      expect(find.text('Search Food Manually'), findsOneWidget);
      expect(find.text('Scan Barcode'), findsOneWidget);

      await tester.tap(find.text('Add Ingredient'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Roti');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('Roti'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('ADD TO FOOD DIARY'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text('ADD TO FOOD DIARY'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ADD TO FOOD DIARY'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final meals = await tester.runAsync(
        () => db.select(db.mealLogs).get(),
      );
      expect(meals!.any((m) => m.foodName == 'Roti' && m.isEstimate), isTrue);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
