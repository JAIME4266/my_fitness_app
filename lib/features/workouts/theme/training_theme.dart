import 'package:flutter/material.dart';

/// Design tokens for the dark athletic Training experience.
class TrainingTheme {
  static const Color bg = Color(0xFF101214);
  static const Color surface = Color(0xFF181B20);
  static const Color surfaceElevated = Color(0xFF21252C);
  static const Color border = Color(0xFF2B303A);
  static const Color lime = Color(0xFFD4FF00);
  static const Color limeMuted = Color(0x22D4FF00);
  static const Color onLime = Color(0xFF101214);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFA1A8B3);
  static const Color textMuted = Color(0xFF6B7280);

  // Controlled category accents
  static const Color warmupAccent = Color(0xFFD4FF00);
  static const Color recoveryAccent = Color(0xFFFB923C);
  static const Color strengthAccent = Color(0xFF818CF8);
  static const Color enduranceAccent = Color(0xFF38BDF8);
  static const Color mobilityAccent = Color(0xFF34D399);

  static const TextStyle displayHero = TextStyle(
    color: textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.6,
    height: 1.05,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: textPrimary,
    fontSize: 13.5,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.1,
  );

  static const TextStyle cardTitle = TextStyle(
    color: textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle metaLabel = TextStyle(
    color: textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static Color accentForCategory(String category) {
    final c = category.toUpperCase();
    if (c.contains('WARMUP') || c.contains('WARM-UP')) return warmupAccent;
    if (c.contains('RECOVERY') || c.contains('STRETCH')) return recoveryAccent;
    if (c.contains('STRENGTH')) return strengthAccent;
    if (c.contains('ENDURANCE')) return enduranceAccent;
    if (c.contains('MOBILITY') || c.contains('FLEXIBILITY')) {
      return mobilityAccent;
    }
    return lime;
  }

  static String shortBadgeForCategory(String category) {
    final c = category.toUpperCase();
    if (c.contains('WARMUP') || c.contains('WARM-UP')) return 'WARMUP';
    if (c.contains('RECOVERY')) return 'STRETCH';
    if (c.contains('STRENGTH')) return 'STRENGTH';
    if (c.contains('ENDURANCE')) return 'ENDURANCE';
    if (c.contains('MOBILITY') || c.contains('FLEXIBILITY')) return 'MOBILITY';
    return 'CUSTOM';
  }

  static String imageAssetForCategory(String category) {
    final c = category.toUpperCase();
    if (c.contains('WARMUP') || c.contains('WARM-UP')) {
      return 'assets/images/workouts/warmup.jpg';
    }
    if (c.contains('RECOVERY') || c.contains('STRETCH')) {
      return 'assets/images/workouts/recovery.jpg';
    }
    if (c.contains('ENDURANCE')) {
      return 'assets/images/workouts/endurance.jpg';
    }
    if (c.contains('MOBILITY') || c.contains('FLEXIBILITY')) {
      return 'assets/images/workouts/mobility.jpg';
    }
    return 'assets/images/workouts/strength.jpg';
  }
}
