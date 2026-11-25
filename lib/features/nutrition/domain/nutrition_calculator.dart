import 'dart:math' as math;

/// Measurement basis for Indian foods whose dry weight expands or shrinks when cooked.
enum MeasurementBasis {
  cooked,
  raw,
}

/// Exact computed nutrient output for a single meal portion, including tadka/ghee additions.
class ComputedNutrition {
  final double cookedWeightG;
  final double rawEquivalentG;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double fibreG;
  final double? saturatedFatG;
  final double? sugarG;
  final double? sodiumMg;
  final double extraOilFatG;
  final double extraOilKcal;

  const ComputedNutrition({
    required this.cookedWeightG,
    required this.rawEquivalentG,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.fibreG,
    this.saturatedFatG,
    this.sugarG,
    this.sodiumMg,
    this.extraOilFatG = 0.0,
    this.extraOilKcal = 0.0,
  });
}

/// Core sports-nutrition and metabolic calculation engine aligned with ICMR-NIN IFCT 2017.
class NutritionCalculator {
  /// 1 teaspoon of ghee / cooking oil ≈ 5 g pure fat ≈ 45 kcal.
  static const double gramsFatPerTsp = 5.0;
  static const double kcalPerGramFat = 9.0;
  static const double kcalPerTspFat = gramsFatPerTsp * kcalPerGramFat; // 45 kcal

  /// Computes cooked/raw equivalence and macros from IFCT-style per-100g baseline values.
  ///
  /// When [basis] is [MeasurementBasis.cooked], [inputGrams] is divided by [yieldFactor]
  /// so water absorbed during cooking (e.g., 2.98x for boiled rice, 3.20x for moong dal)
  /// does not inflate calorie totals. When [basis] is [MeasurementBasis.raw],
  /// [cookedWeightG] is scaled by [yieldFactor].
  static ComputedNutrition calculateFoodNutrition({
    required double inputGrams,
    required MeasurementBasis basis,
    required double yieldFactor,
    required double rawKcalPer100g,
    required double rawProteinPer100g,
    required double rawCarbsPer100g,
    required double rawFatPer100g,
    double rawFibrePer100g = 0.0,
    double? rawSaturatedFatPer100g,
    double? rawSugarPer100g,
    double? rawSodiumMgPer100g,
    double extraOilTsp = 0.0,
  }) {
    final safeGrams = math.max(0.0, inputGrams);
    final safeYield = yieldFactor > 0 ? yieldFactor : 1.0;
    final safeOilTsp = math.max(0.0, extraOilTsp);

    final double rawGrams;
    final double cookedGrams;

    if (basis == MeasurementBasis.cooked) {
      cookedGrams = safeGrams;
      rawGrams = safeGrams / safeYield;
    } else {
      rawGrams = safeGrams;
      cookedGrams = safeGrams * safeYield;
    }

    final factor = rawGrams / 100.0;
    final extraOilFat = safeOilTsp * gramsFatPerTsp;
    final extraOilKcal = safeOilTsp * kcalPerTspFat;

    return ComputedNutrition(
      cookedWeightG: _round1(cookedGrams),
      rawEquivalentG: _round1(rawGrams),
      calories: _round1(rawKcalPer100g * factor + extraOilKcal),
      proteinG: _round1(rawProteinPer100g * factor),
      carbsG: _round1(rawCarbsPer100g * factor),
      fatG: _round1(rawFatPer100g * factor + extraOilFat),
      fibreG: _round1(rawFibrePer100g * factor),
      saturatedFatG: rawSaturatedFatPer100g != null
          ? _round1(rawSaturatedFatPer100g * factor)
          : null,
      sugarG: rawSugarPer100g != null ? _round1(rawSugarPer100g * factor) : null,
      sodiumMg: rawSodiumMgPer100g != null
          ? _round1(rawSodiumMgPer100g * factor)
          : null,
      extraOilFatG: _round1(extraOilFat),
      extraOilKcal: _round1(extraOilKcal),
    );
  }

  /// Mifflin-St Jeor Resting Metabolic Rate (kcal/day).
  static double calculateMifflinStJeorBmr({
    required double weightKg,
    required double heightCm,
    required int age,
    required String sex,
  }) {
    final base = (10.0 * weightKg) + (6.25 * heightCm) - (5.0 * age);
    return (sex.toLowerCase() == 'female') ? base - 161.0 : base + 5.0;
  }

  /// Katch-McArdle Resting Metabolic Rate (kcal/day) using lean body mass.
  static double calculateKatchMcArdleBmr({
    required double weightKg,
    required double bodyFatPct,
  }) {
    final clampedBf = bodyFatPct.clamp(4.0, 60.0);
    final leanMassKg = weightKg * (1.0 - clampedBf / 100.0);
    return 370.0 + (21.6 * leanMassKg);
  }

  /// Anchors baseline TDEE to Sedentary (BMR × 1.2) so active workout calories
  /// from Health Connect / runs can be added cleanly without double counting.
  static double calculateBaselineTdee({
    required double bmr,
    double activityMultiplier = 1.2,
  }) {
    return bmr * activityMultiplier;
  }

  /// 2024 Compendium Net Active Burn (subtracts 1.0 resting MET).
  static double calculateNetMetBurn({
    required double met,
    required double weightKg,
    required double durationMinutes,
  }) {
    final netMet = math.max(0.0, met - 1.0);
    return (netMet * 3.5 * weightKg / 200.0) * math.max(0.0, durationMinutes);
  }

  /// Keytel et al. (2005) heart-rate regression converted to Net Active Burn
  /// by subtracting resting BMR over [durationMinutes].
  static double calculateKeytelNetBurn({
    required double heartRateBpm,
    required double weightKg,
    required int age,
    required String sex,
    required double durationMinutes,
    required double restingBmrPerDay,
  }) {
    final safeDuration = math.max(0.0, durationMinutes);
    if (safeDuration == 0) return 0.0;

    final double grossKjPerMin;
    if (sex.toLowerCase() == 'female') {
      grossKjPerMin = -20.4022 +
          (0.4472 * heartRateBpm) -
          (0.1263 * weightKg) +
          (0.074 * age);
    } else {
      grossKjPerMin = -55.0969 +
          (0.6309 * heartRateBpm) +
          (0.1988 * weightKg) +
          (0.2017 * age);
    }

    final grossKcalPerMin = math.max(0.0, grossKjPerMin / 4.184);
    final restingKcalPerMin = math.max(0.0, restingBmrPerDay / 1440.0);
    return math.max(0.0, (grossKcalPerMin - restingKcalPerMin) * safeDuration);
  }

  static double _round1(double v) => (v * 10).roundToDouble() / 10.0;
}
