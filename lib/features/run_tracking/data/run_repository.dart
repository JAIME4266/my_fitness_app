import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../../../database/fitness_repository.dart';
import '../../nutrition/data/nutrition_repository.dart';
import '../domain/gps_filter.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return RunRepository(db);
});

final recentWorkoutsProvider = StreamProvider<List<Workout>>((ref) {
  return ref.watch(runRepositoryProvider).watchRecentWorkouts();
});

class RunRepository {
  final AppDatabase db;
  RunRepository(this.db);

  Stream<List<Workout>> watchRecentWorkouts({int limit = 20}) {
    return db.watchRecentWorkouts(limit: limit);
  }

  Future<List<RoutePoint>> getRoutePoints(String workoutId) {
    return db.getRoutePointsForWorkout(workoutId);
  }

  Future<String> saveCompletedRun({
    required String sportType,
    required int startEpochMs,
    required int durationSec,
    required double distanceM,
    required double caloriesKcal,
    required List<TrackedPoint> points,
  }) async {
    final workoutId = 'run_${DateTime.now().microsecondsSinceEpoch}';
    final polylineJson = GpsFilter.encodePolyline(points);

    await db.transaction(() async {
      await db.insertWorkout(
        WorkoutsCompanion(
          id: Value(workoutId),
          type: Value(sportType),
          startEpochMs: Value(startEpochMs),
          durationSec: Value(durationSec),
          distanceM: Value(distanceM),
          caloriesKcal: Value(caloriesKcal),
          polylineJson: Value(polylineJson),
        ),
      );

      if (points.isNotEmpty) {
        await db.insertRoutePoints(
          points
              .map(
                (p) => RoutePointsCompanion(
                  workoutId: Value(workoutId),
                  lat: Value(p.lat),
                  lng: Value(p.lng),
                  altitudeM: Value(p.altitudeM),
                  accuracyM: Value(p.accuracyM),
                  speedMps: Value(p.speedMps),
                  timestampEpochMs: Value(p.timestampEpochMs),
                ),
              )
              .toList(),
        );
      }

      final todayKey = NutritionRepository.dateKeyFor(DateTime.now());
      final existing = await db.getSummaryForDate(todayKey);
      await db.insertOrUpdateSummary(
        DailySummariesCompanion(
          date: Value(todayKey),
          steps: Value(existing?.steps ?? 0),
          activeCalories:
              Value((existing?.activeCalories ?? 0) + caloriesKcal.round()),
          consumedCalories: Value(existing?.consumedCalories ?? 0),
          targetCalories: Value(existing?.targetCalories ?? 2200),
          waterMl: Value(existing?.waterMl ?? 0),
          lastSync: Value(DateTime.now()),
        ),
      );
    });

    return workoutId;
  }
}
