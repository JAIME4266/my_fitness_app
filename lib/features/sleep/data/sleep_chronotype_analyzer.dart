import '../../../database/database.dart';

enum SleepAnimal {
  lion(
    title: 'Lion',
    subtitle: 'Early Riser • Peak energy in the morning',
    peakWindow: '6:00 AM – 11:00 AM',
    idealBedtime: '9:30 PM – 10:15 PM',
  ),
  bear(
    title: 'Bear',
    subtitle: 'Solar Rhythm • Steady daytime energy',
    peakWindow: '10:00 AM – 2:00 PM',
    idealBedtime: '10:30 PM – 11:30 PM',
  ),
  wolf(
    title: 'Wolf',
    subtitle: 'Night Owl • Creative & alert in the evening',
    peakWindow: '5:00 PM – 11:00 PM',
    idealBedtime: '12:00 AM – 1:30 AM',
  ),
  dolphin(
    title: 'Dolphin',
    subtitle: 'Light Sleeper • Variable sleep schedule',
    peakWindow: '10:00 AM – 12:00 PM',
    idealBedtime: '11:00 PM – 12:00 AM',
  );

  final String title;
  final String subtitle;
  final String peakWindow;
  final String idealBedtime;

  const SleepAnimal({
    required this.title,
    required this.subtitle,
    required this.peakWindow,
    required this.idealBedtime,
  });
}

class SleepChronotypeResult {
  final SleepAnimal animal;
  final double averageDurationHours;
  final int consistencyScore;
  final String disclaimer;

  const SleepChronotypeResult({
    required this.animal,
    required this.averageDurationHours,
    required this.consistencyScore,
    this.disclaimer =
        'Informational chronotype insight only — not a medical or clinical sleep assessment.',
  });
}

class SleepChronotypeAnalyzer {
  static SleepChronotypeResult analyze(List<SleepRecord> records) {
    if (records.isEmpty) {
      return const SleepChronotypeResult(
        animal: SleepAnimal.bear,
        averageDurationHours: 0.0,
        consistencyScore: 0,
      );
    }

    final avgMinutes = records
            .map((r) => r.durationMinutes)
            .reduce((a, b) => a + b) /
        records.length;

    // Normalize bedtime minutes from 18:00 (0) to 06:00 (720)
    final bedtimeOffsets = records.map((r) {
      final h = r.startTime.hour;
      final m = r.startTime.minute;
      final totalMins = h * 60 + m;
      return totalMins >= 18 * 60 ? totalMins - 18 * 60 : totalMins + 6 * 60;
    }).toList();

    final avgBedOffset =
        bedtimeOffsets.reduce((a, b) => a + b) / bedtimeOffsets.length;

    final variance = bedtimeOffsets
            .map((o) => (o - avgBedOffset) * (o - avgBedOffset))
            .reduce((a, b) => a + b) /
        bedtimeOffsets.length;
    final stdDevMins = variance > 0 ? _sqrt(variance) : 0.0;
    final consistency = (100 - (stdDevMins * 0.7)).round().clamp(15, 100);

    // 18:00 = 0, 22:00 = 240, 23:30 = 330, 00:00 = 360
    final SleepAnimal animal;
    if (stdDevMins > 75 || avgMinutes < 360) {
      animal = SleepAnimal.dolphin;
    } else if (avgBedOffset <= 255) {
      // <= 22:15
      animal = SleepAnimal.lion;
    } else if (avgBedOffset <= 345) {
      // <= 23:45
      animal = SleepAnimal.bear;
    } else {
      animal = SleepAnimal.wolf;
    }

    return SleepChronotypeResult(
      animal: animal,
      averageDurationHours: (avgMinutes / 60.0 * 10).roundToDouble() / 10.0,
      consistencyScore: consistency,
    );
  }

  static double _sqrt(double value) {
    if (value <= 0) return 0;
    double x = value;
    for (int i = 0; i < 12; i++) {
      x = 0.5 * (x + value / x);
    }
    return x;
  }
}
