import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class DailySummaries extends Table {
  TextColumn get date => text()(); // Primary key: 'YYYY-MM-DD'
  IntColumn get steps => integer().withDefault(const Constant(0))();
  IntColumn get activeCalories => integer().withDefault(const Constant(0))();
  IntColumn get targetCalories => integer().withDefault(const Constant(2200))();
  IntColumn get consumedCalories => integer().withDefault(const Constant(0))();
  IntColumn get waterMl => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {date};
}

class Workouts extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // Run, Walk, Cycle
  IntColumn get startEpochMs => integer()();
  IntColumn get durationSec => integer().withDefault(const Constant(0))();
  RealColumn get distanceM => real().withDefault(const Constant(0.0))();
  RealColumn get caloriesKcal => real().withDefault(const Constant(0.0))();
  TextColumn get polylineJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MealLogs extends Table {
  TextColumn get id => text()();
  TextColumn get foodName => text()();
  TextColumn get mealType => text()(); // Breakfast, Lunch, Dinner, Snack
  RealColumn get cookedWeightG => real().withDefault(const Constant(0.0))();
  RealColumn get calculatedKcal => real().withDefault(const Constant(0.0))();
  RealColumn get proteinG => real().withDefault(const Constant(0.0))();
  RealColumn get carbsG => real().withDefault(const Constant(0.0))();
  RealColumn get fatG => real().withDefault(const Constant(0.0))();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [DailySummaries, Workouts, MealLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? driftDatabase(name: 'fitness_app'));

  @override
  int get schemaVersion => 1;

  // Convenience queries
  Future<DailySummary?> getSummaryForDate(String date) {
    return (select(dailySummaries)..where((tbl) => tbl.date.equals(date))).getSingleOrNull();
  }

  Future<int> insertOrUpdateSummary(DailySummariesCompanion summary) {
    return into(dailySummaries).insertOnConflictUpdate(summary);
  }

  Stream<List<DailySummary>> watchRecentSummaries({int limit = 7}) {
    return (select(dailySummaries)
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(limit)
    ).watch();
  }

  Future<List<Workout>> getRecentWorkouts({int limit = 10}) {
    return (select(workouts)
      ..orderBy([(t) => OrderingTerm.desc(t.startEpochMs)])
      ..limit(limit)
    ).get();
  }

  Future<int> insertWorkout(WorkoutsCompanion workout) {
    return into(workouts).insertOnConflictUpdate(workout);
  }
}
