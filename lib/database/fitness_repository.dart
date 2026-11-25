import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final fitnessRepositoryProvider = Provider<FitnessRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FitnessRepository(db);
});

class FitnessRepository {
  final AppDatabase db;

  FitnessRepository(this.db);

  static String todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<DailySummary?> getTodaySummary() async {
    return db.getSummaryForDate(todayKey());
  }

  Future<void> saveDailySync({
    required int steps,
    required int activeCalories,
    int? consumedCalories,
    int? targetCalories,
  }) async {
    final key = todayKey();
    final existing = await db.getSummaryForDate(key);

    await db.insertOrUpdateSummary(
      DailySummariesCompanion(
        date: Value(key),
        steps: Value(steps),
        activeCalories: Value(activeCalories),
        consumedCalories: Value(consumedCalories ?? existing?.consumedCalories ?? 0),
        targetCalories: Value(targetCalories ?? existing?.targetCalories ?? 2200),
        waterMl: Value(existing?.waterMl ?? 0),
        lastSync: Value(DateTime.now()),
      ),
    );
  }

  Stream<List<DailySummary>> watchRecentSummaries({int limit = 7}) {
    return db.watchRecentSummaries(limit: limit);
  }

  Future<List<Workout>> getWorkouts({int limit = 10}) {
    return db.getRecentWorkouts(limit: limit);
  }

  Future<void> logWorkout({
    required String type,
    required int durationSec,
    required double distanceM,
    required double caloriesKcal,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await db.insertWorkout(
      WorkoutsCompanion(
        id: Value(id),
        type: Value(type),
        startEpochMs: Value(DateTime.now().millisecondsSinceEpoch),
        durationSec: Value(durationSec),
        distanceM: Value(distanceM),
        caloriesKcal: Value(caloriesKcal),
      ),
    );
  }
}
