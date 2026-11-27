import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/workouts/data/training_media_service.dart';
import 'package:my_fitness_app/features/workouts/data/workout_routines_repository.dart';
import 'package:my_fitness_app/features/workouts/domain/training_analytics_engine.dart';
import 'package:my_fitness_app/features/workouts/domain/workout_models.dart';
import 'package:my_fitness_app/features/workouts/presentation/exercise_library_screen.dart';
import 'package:my_fitness_app/features/workouts/presentation/programmes_screen.dart';
import 'package:my_fitness_app/features/workouts/presentation/training_analytics_screen.dart';
import 'package:my_fitness_app/features/workouts/presentation/workout_history_screen.dart';
import 'package:my_fitness_app/features/workouts/presentation/workout_routines_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('Training Redesign — Repository, Analytics & Schema v6', () {
    test('Saves favourites, custom routines, programmes, schedules & sessions',
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

      final prog = curatedTrainingProgrammes.first;
      await repo.enrolInProgramme(prog.id);
      final enrolments = await db.watchProgrammeEnrolments().first;
      expect(enrolments.length, 1);
      expect(enrolments.first.programmeId, prog.id);

      await repo.completeProgrammeSession(
        programmeId: prog.id,
        session: prog.allSessions.first,
        routine: curatedRunnerRoutines.first,
        elapsedSeconds: 300,
      );

      final workouts = await db.getRecentWorkouts();
      expect(workouts.length, 1);
      expect(workouts.first.type, contains('Prep Your Stride'));

      final completions = await db.watchProgrammeCompletions(prog.id).first;
      expect(completions.length, 1);

      await repo.scheduleRoutineForDate(
        routine: curatedRunnerRoutines.first,
        date: DateTime(2026, 11, 28),
      );
      final sched = await db.watchScheduledWorkouts().first;
      expect(sched.length, 1);
      expect(sched.first.scheduledDateKey, '2026-11-28');
    });

    test('Drift schema v5 -> v6 migration preserves existing Workouts records',
        () async {
      final db = AppDatabase(NativeDatabase.memory(
        setup: (rawDb) {
          rawDb.execute('PRAGMA user_version = 5;');
          rawDb.execute('''
            CREATE TABLE IF NOT EXISTS workouts (
              id TEXT NOT NULL PRIMARY KEY,
              type TEXT NOT NULL,
              start_epoch_ms INTEGER NOT NULL,
              duration_sec INTEGER NOT NULL DEFAULT 0,
              distance_m REAL NOT NULL DEFAULT 0.0,
              calories_kcal REAL NOT NULL DEFAULT 0.0,
              polyline_json TEXT
            );
          ''');
          rawDb.execute('''
            INSERT INTO workouts (id, type, start_epoch_ms, duration_sec, distance_m, calories_kcal)
            VALUES ('legacy_1', 'Run', 1700000000000, 900, 2000.0, 150.0);
          ''');
        },
      ));
      addTearDown(() async => db.close());

      final workouts = await db.getRecentWorkouts();
      expect(workouts.length, 1);
      expect(workouts.first.id, 'legacy_1');

      final repo = WorkoutRoutinesRepository(db);
      await repo.enrolInProgramme(curatedTrainingProgrammes.first.id);
      final enrolments = await db.watchProgrammeEnrolments().first;
      expect(enrolments.length, 1);
    });

    test('Analytics engine computes streak, summary & rule-based recovery pick',
        () {
      final now = DateTime(2026, 11, 28, 10, 0);
      final workouts = [
        Workout(
          id: 'w1',
          type: 'Routine: Power & Endurance',
          startEpochMs: now.millisecondsSinceEpoch,
          durationSec: 1200,
          distanceM: 0,
          caloriesKcal: 100,
          polylineJson: '[]',
        ),
        Workout(
          id: 'w2',
          type: 'Run',
          startEpochMs:
              now.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
          durationSec: 1800,
          distanceM: 5000,
          caloriesKcal: 300,
          polylineJson: '[]',
        ),
      ];

      expect(TrainingAnalyticsEngine.computeStreakDays(workouts, now), 2);
      final summary = TrainingAnalyticsEngine.computeSummary(
        workouts: workouts,
        allRoutines: curatedRunnerRoutines,
        now: now,
      );
      expect(summary.totalSessions, 2);
      expect(summary.totalMinutes, 50);

      final rec = TrainingAnalyticsEngine.recommendRoutine(
        history: workouts,
        favourites: const {},
        allRoutines: curatedRunnerRoutines,
        enrolments: const [],
        completions: const [],
        now: now,
      );
      expect(rec.badge, 'RECOVERY PICK');
      expect(rec.routine.id, 'recovery_recharge');
    });

    test('TrainingMediaService returns honest image fallback without fake URLs',
        () {
      final res =
          TrainingMediaService.resolveForRoutine(curatedRunnerRoutines.first);
      expect(res.hasPlayableVideo, isFalse);
      expect(res.posterAssetPath, contains('assets/images/workouts/'));
    });

    testWidgets(
        'Training Home renders, opens routine detail, completes active session & persists',
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

      expect(find.text('TRAINING'), findsOneWidget);
      expect(find.text('ATHLETIC BUILD PROGRAMS'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('DAILY ROUTINES'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('DAILY ROUTINES'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('PREP YOUR STRIDE'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text('PREP YOUR STRIDE'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('PREP YOUR STRIDE'));
      await tester.pumpAndSettle();

      expect(find.text('Start Workout'), findsOneWidget);
      await tester.tap(find.text('Start Workout'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('EXERCISE 1 OF 4'), findsOneWidget);
      await tester.ensureVisible(find.text('End & Save Workout'));
      await tester.pump();
      await tester.tap(find.text('End & Save Workout'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Workout Complete!'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });

    testWidgets(
        'Secondary destinations (Exercise Library, Programmes, History, Analytics) render cleanly',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const MaterialApp(home: ExerciseLibraryScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('EXERCISE LIBRARY'), findsOneWidget);
      expect(find.text('Goblet / Bodyweight Squats'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const MaterialApp(home: ProgrammesScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('TRAINING PROGRAMMES'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const MaterialApp(home: WorkoutHistoryScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('No completed workouts yet'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const MaterialApp(home: TrainingAnalyticsScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Not enough training data yet'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
