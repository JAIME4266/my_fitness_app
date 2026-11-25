import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/features/sleep/data/sleep_chronotype_analyzer.dart';
import 'package:my_fitness_app/features/sleep/presentation/sleep_tracking_screen.dart';

void main() {
  group('Phase 10 Smart Sleep Tracking', () {
    test('SleepChronotypeAnalyzer classifies Lion, Bear, Wolf, Dolphin', () {
      SleepRecord rec(int bedHour, int mins) => SleepRecord(
            id: 'r_${bedHour}_$mins',
            startTime: DateTime(2026, 11, 20, bedHour, 0),
            endTime: DateTime(2026, 11, 21, bedHour, 0)
                .add(Duration(minutes: mins)),
            durationMinutes: mins,
            source: 'manual',
          );

      final lion = SleepChronotypeAnalyzer.analyze([rec(21, 480), rec(21, 470)]);
      expect(lion.animal, SleepAnimal.lion);
      expect(lion.disclaimer, contains('not a medical'));

      final bear = SleepChronotypeAnalyzer.analyze([rec(23, 450), rec(23, 460)]);
      expect(bear.animal, SleepAnimal.bear);

      final wolf = SleepChronotypeAnalyzer.analyze([rec(1, 440), rec(1, 450)]);
      expect(wolf.animal, SleepAnimal.wolf);

      final dolphin =
          SleepChronotypeAnalyzer.analyze([rec(23, 300), rec(23, 320)]);
      expect(dolphin.animal, SleepAnimal.dolphin);
    });

    testWidgets('SleepTrackingScreen logs manual sleep without inventing stages',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(
        MaterialApp(home: SleepTrackingScreen(db: db)),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Sleep Animal:'), findsOneWidget);

      await tester.tap(find.text('Log Sleep'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final records =
          await tester.runAsync(() => db.select(db.sleepRecords).get());
      expect(records!.length, 1);
      expect(records.first.source, 'manual');
      expect(records.first.deepMinutes, isNull);
      expect(records.first.remMinutes, isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
