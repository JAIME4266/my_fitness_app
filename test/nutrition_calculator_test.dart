import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/features/nutrition/domain/nutrition_calculator.dart';

void main() {
  group('NutritionCalculator IFCT raw-vs-cooked conversion', () {
    test('Cooked steamed white rice (2.98x) converts accurately to raw baseline', () {
      // 149g cooked rice -> 149 / 2.98 = 50g raw
      final res = NutritionCalculator.calculateFoodNutrition(
        inputGrams: 149.0,
        basis: MeasurementBasis.cooked,
        yieldFactor: 2.98,
        rawKcalPer100g: 356.0,
        rawProteinPer100g: 7.94,
        rawCarbsPer100g: 78.2,
        rawFatPer100g: 0.5,
        rawFibrePer100g: 2.8,
      );

      expect(res.cookedWeightG, 149.0);
      expect(res.rawEquivalentG, 50.0);
      expect(res.calories, 178.0);
      expect(res.proteinG, 4.0);
      expect(res.carbsG, 39.1);
      expect(res.fatG, 0.3);
      expect(res.fibreG, 1.4);
    });

    test('Raw yellow moong dal (3.20x) computes cooked weight and tadka oil', () {
      // 50g raw moong dal -> 160g cooked + 1 tsp oil (5g fat, 45 kcal)
      final res = NutritionCalculator.calculateFoodNutrition(
        inputGrams: 50.0,
        basis: MeasurementBasis.raw,
        yieldFactor: 3.20,
        rawKcalPer100g: 348.0,
        rawProteinPer100g: 23.88,
        rawCarbsPer100g: 59.9,
        rawFatPer100g: 1.2,
        extraOilTsp: 1.0,
      );

      expect(res.rawEquivalentG, 50.0);
      expect(res.cookedWeightG, 160.0);
      expect(res.extraOilFatG, 5.0);
      expect(res.extraOilKcal, 45.0);
      // 174 + 45 = 219 kcal; 0.6 + 5.0 = 5.6g fat
      expect(res.calories, 219.0);
      expect(res.proteinG, 11.9);
      expect(res.fatG, 5.6);
    });

    test('Meat cooking shrinkage (< 1.0 yield) scales cooked-to-raw upwards', () {
      // 150g cooked chicken breast (0.75x yield) -> 200g raw equivalent
      final res = NutritionCalculator.calculateFoodNutrition(
        inputGrams: 150.0,
        basis: MeasurementBasis.cooked,
        yieldFactor: 0.75,
        rawKcalPer100g: 120.0,
        rawProteinPer100g: 22.5,
        rawCarbsPer100g: 0.0,
        rawFatPer100g: 2.6,
      );

      expect(res.rawEquivalentG, 200.0);
      expect(res.calories, 240.0);
      expect(res.proteinG, 45.0);
    });
  });

  group('NutritionCalculator BMR & Net Burn Engines', () {
    test('Mifflin-St Jeor & Katch-McArdle compute expected BMR', () {
      final mifflinMale = NutritionCalculator.calculateMifflinStJeorBmr(
        weightKg: 75,
        heightCm: 175,
        age: 24,
        sex: 'male',
      );
      // 750 + 1093.75 - 120 + 5 = 1728.75
      expect(mifflinMale, closeTo(1728.75, 0.01));

      final katch = NutritionCalculator.calculateKatchMcArdleBmr(
        weightKg: 75,
        bodyFatPct: 18,
      );
      // lean = 61.5 -> 370 + 21.6*61.5 = 1698.4
      expect(katch, closeTo(1698.4, 0.01));
    });

    test('Net MET & Keytel HR subtract resting expenditure cleanly', () {
      final netMet = NutritionCalculator.calculateNetMetBurn(
        met: 9.8,
        weightKg: 75,
        durationMinutes: 40,
      );
      // (8.8 * 3.5 * 75 / 200) * 40 = 462 kcal
      expect(netMet, closeTo(462.0, 0.1));

      final keytelNet = NutritionCalculator.calculateKeytelNetBurn(
        heartRateBpm: 155,
        weightKg: 75,
        age: 24,
        sex: 'male',
        durationMinutes: 40,
        restingBmrPerDay: 1728.75,
      );
      expect(keytelNet, greaterThan(400.0));
      expect(keytelNet, lessThan(650.0));
    });
  });
}
