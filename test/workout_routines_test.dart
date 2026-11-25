import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/workouts/data/workout_routines_repository.dart';
import 'package:my_fitness_app/features/workouts/domain/workout_models.dart';
import 'package:my_fitness_app/features/workouts/presentation/workout_routines_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('Phase 6 WorkoutRoutines', () {
    test('Saves favourites, custom routines, and completes workout into Drift',
        () async {
      SharedPreferences.setMockInitialValues({});
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async => db.close());

      final repo = WorkoutRoutinesRepository(db);
      final favs = await repo.toggleFavourite('warmup_stride');
      expect(favs.contains('warmup_stride'), isTrue);

      await repo.saveCustomRoutine(
        title: 'Hill Sprint Prep',
        category: workoutCategories.first,
        description: 'Quick activation',
        difficulty: 'Intermediate',
        totalMinutes: 10,
      );
      final custom = await repo.getCustomRoutines();
      expect(custom.length, 1);

      await repo.completeRoutineSession(
        routine: curatedRunnerRoutines.first,
        elapsedSeconds: 300,
      );
      final workouts = await db.getRecentWorkouts();
      expect(workouts.length, 1);
      expect(workouts.first.type, contains('Prep Your Stride'));
    });

    testWidgets('WorkoutRoutinesScreen renders categories and opens detail + timer',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      final db = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const MaterialApp(home: WorkoutRoutinesScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('WORKOUT ROUTINES'), findsOneWidget);
      expect(find.text('PRE-RUN WARMUP'), findsOneWidget);
      expect(find.text('Prep Your Stride'), findsOneWidget);

      await tester.tap(find.text('Prep Your Stride'));
      await tester.pumpAndSettle();

      expect(find.text('Start Workout'), findsOneWidget);
      await tester.tap(find.text('Start Workout'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('EXERCISE 1 OF 4'), findsOneWidget);
      await tester.tap(find.text('End & Save Workout'));
      await tester.pumpAndSettle();
      expect(find.text('Workout Complete!'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
