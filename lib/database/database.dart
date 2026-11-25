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

class RoutePoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get workoutId => text()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  RealColumn get altitudeM => real().withDefault(const Constant(0.0))();
  RealColumn get accuracyM => real().withDefault(const Constant(0.0))();
  RealColumn get speedMps => real().withDefault(const Constant(0.0))();
  IntColumn get timestampEpochMs => integer()();
}

// --- Phase 5: Community & Social Fitness Cache Tables ---
class CommunityProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get displayName => text()();
  RealColumn get dailyGoalKm => real().withDefault(const Constant(5.0))();
  RealColumn get todayDistanceKm => real().withDefault(const Constant(0.0))();
  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();
  BoolColumn get isFollowing => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityPosts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get authorName => text()();
  TextColumn get title => text()();
  RealColumn get distanceKm => real()();
  IntColumn get durationSec => integer()();
  TextColumn get paceLabel => text()();
  TextColumn get polylineJson => text().nullable()();
  TextColumn get workoutBadge => text().nullable()();
  TextColumn get visibility => text().withDefault(const Constant('public'))();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityPostLikes extends Table {
  TextColumn get postId => text()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {postId, userId};
}

class CommunityComments extends Table {
  TextColumn get id => text()();
  TextColumn get postId => text()();
  TextColumn get userId => text()();
  TextColumn get authorName => text()();
  TextColumn get body => text()();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityGroups extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();
  TextColumn get ownerId => text()();
  IntColumn get memberCount => integer().withDefault(const Constant(1))();
  BoolColumn get isJoined => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityChallenges extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get targetKm => real()();
  IntColumn get durationDays => integer()();
  TextColumn get challengeType => text()();
  IntColumn get participantCount => integer().withDefault(const Constant(1))();
  BoolColumn get isJoined => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CommunityNotifications extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class BlockedUsers extends Table {
  TextColumn get blockerId => text()();
  TextColumn get blockedId => text()();

  @override
  Set<Column> get primaryKey => {blockerId, blockedId};
}

class FoodCatalog extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get hindiName => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant('General'))();
  TextColumn get barcode => text().nullable()();
  TextColumn get source => text().withDefault(const Constant('ifct_2017'))();
  TextColumn get defaultBasis => text().withDefault(const Constant('cooked'))();
  RealColumn get yieldFactor => real().withDefault(const Constant(1.0))();
  RealColumn get kcalPer100g => real()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  RealColumn get fibrePer100g => real().withDefault(const Constant(0.0))();
  RealColumn get saturatedFatPer100g => real().nullable()();
  RealColumn get sugarPer100g => real().nullable()();
  RealColumn get sodiumMgPer100g => real().nullable()();
  RealColumn get defaultServingG => real().withDefault(const Constant(100.0))();
  TextColumn get servingLabel => text().withDefault(const Constant('100g'))();

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

  // Phase 3 nutrition metadata (nullable/defaulted for safe v1 -> v2 migration)
  TextColumn get foodId => text().nullable()();
  TextColumn get basis => text().withDefault(const Constant('cooked'))();
  RealColumn get rawEquivalentG => real().withDefault(const Constant(0.0))();
  RealColumn get extraOilTsp => real().withDefault(const Constant(0.0))();
  RealColumn get fibreG => real().withDefault(const Constant(0.0))();
  RealColumn get saturatedFatG => real().nullable()();
  RealColumn get sugarG => real().nullable()();
  RealColumn get sodiumMg => real().nullable()();
  BoolColumn get isEstimate => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class UserMetabolicProfiles extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withDefault(const Constant('Athlete'))();
  IntColumn get age => integer().withDefault(const Constant(24))();
  TextColumn get sex => text().withDefault(const Constant('male'))();
  RealColumn get heightCm => real().withDefault(const Constant(175.0))();
  RealColumn get weightKg => real().withDefault(const Constant(75.0))();
  RealColumn get bodyFatPct => real().nullable()();
  TextColumn get bmrFormula => text().withDefault(const Constant('mifflin'))();
  RealColumn get activityMultiplier => real().withDefault(const Constant(1.2))();
  IntColumn get goalDeltaKcal => integer().withDefault(const Constant(0))();
  IntColumn get dailyCalorieGoal => integer().withDefault(const Constant(2200))();
  RealColumn get proteinTargetG => real().withDefault(const Constant(140.0))();
  RealColumn get carbsTargetG => real().withDefault(const Constant(220.0))();
  RealColumn get fatTargetG => real().withDefault(const Constant(60.0))();
  RealColumn get fibreTargetG => real().withDefault(const Constant(30.0))();

  @override
  Set<Column> get primaryKey => {id};
}

class SleepRecords extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  IntColumn get durationMinutes => integer()();
  IntColumn get deepMinutes => integer().nullable()();
  IntColumn get lightMinutes => integer().nullable()();
  IntColumn get remMinutes => integer().nullable()();
  IntColumn get awakeMinutes => integer().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  IntColumn get qualityRating => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    DailySummaries,
    Workouts,
    RoutePoints,
    FoodCatalog,
    MealLogs,
    UserMetabolicProfiles,
    CommunityProfiles,
    CommunityPosts,
    CommunityPostLikes,
    CommunityComments,
    CommunityGroups,
    CommunityChallenges,
    CommunityNotifications,
    BlockedUsers,
    SleepRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e])
      : super(e ?? driftDatabase(name: 'fitness_app'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 5) {
            await m.createTable(sleepRecords);
          }
          if (from < 2) {
            await m.createTable(foodCatalog);
            await m.createTable(userMetabolicProfiles);
            await m.addColumn(mealLogs, mealLogs.foodId);
            await m.addColumn(mealLogs, mealLogs.basis);
            await m.addColumn(mealLogs, mealLogs.rawEquivalentG);
            await m.addColumn(mealLogs, mealLogs.extraOilTsp);
            await m.addColumn(mealLogs, mealLogs.fibreG);
            await m.addColumn(mealLogs, mealLogs.saturatedFatG);
            await m.addColumn(mealLogs, mealLogs.sugarG);
            await m.addColumn(mealLogs, mealLogs.sodiumMg);
            await m.addColumn(mealLogs, mealLogs.isEstimate);
          }
          if (from < 3) {
            await m.createTable(routePoints);
          }
          if (from < 4) {
            await m.createTable(communityProfiles);
            await m.createTable(communityPosts);
            await m.createTable(communityPostLikes);
            await m.createTable(communityComments);
            await m.createTable(communityGroups);
            await m.createTable(communityChallenges);
            await m.createTable(communityNotifications);
            await m.createTable(blockedUsers);
          }
        },
      );

  // --- Phase 2 Existing Convenience Queries ---
  Future<DailySummary?> getSummaryForDate(String date) {
    return (select(dailySummaries)..where((tbl) => tbl.date.equals(date)))
        .getSingleOrNull();
  }

  Future<int> insertOrUpdateSummary(DailySummariesCompanion summary) {
    return into(dailySummaries).insertOnConflictUpdate(summary);
  }

  Stream<List<DailySummary>> watchRecentSummaries({int limit = 7}) {
    return (select(dailySummaries)
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(limit))
        .watch();
  }

  Future<List<Workout>> getRecentWorkouts({int limit = 10}) {
    return (select(workouts)
          ..orderBy([(t) => OrderingTerm.desc(t.startEpochMs)])
          ..limit(limit))
        .get();
  }

  Future<int> insertWorkout(WorkoutsCompanion workout) {
    return into(workouts).insertOnConflictUpdate(workout);
  }

  Stream<List<Workout>> watchRecentWorkouts({int limit = 20}) {
    return (select(workouts)
          ..orderBy([(t) => OrderingTerm.desc(t.startEpochMs)])
          ..limit(limit))
        .watch();
  }

  Future<void> insertRoutePoints(List<RoutePointsCompanion> points) async {
    if (points.isEmpty) return;
    await batch((batch) {
      batch.insertAll(routePoints, points);
    });
  }

  Future<List<RoutePoint>> getRoutePointsForWorkout(String workoutId) {
    return (select(routePoints)
          ..where((t) => t.workoutId.equals(workoutId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestampEpochMs)]))
        .get();
  }

  // --- Phase 3 Food Catalog Queries ---
  Future<int> countFoods() async {
    final rows = await select(foodCatalog).get();
    return rows.length;
  }

  Future<void> seedFoods(List<FoodCatalogCompanion> items) async {
    await batch((batch) {
      batch.insertAll(
        foodCatalog,
        items,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<int> upsertFood(FoodCatalogCompanion food) {
    return into(foodCatalog).insertOnConflictUpdate(food);
  }

  Stream<List<FoodCatalogData>> watchFoodCatalog({
    String query = '',
    String? category,
  }) {
    final q = select(foodCatalog);
    final trimmed = query.trim().toLowerCase();
    if (category != null && category.isNotEmpty && category != 'All') {
      q.where((t) => t.category.equals(category));
    }
    if (trimmed.isNotEmpty) {
      q.where(
        (t) =>
            t.name.lower().contains(trimmed) |
            t.hindiName.lower().contains(trimmed) |
            t.category.lower().contains(trimmed),
      );
    }
    q.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return q.watch();
  }

  Future<FoodCatalogData?> findFoodById(String id) {
    return (select(foodCatalog)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  // --- Phase 3 Meal Logs Queries ---
  Stream<List<MealLog>> watchMealsBetween(DateTime start, DateTime end) {
    return (select(mealLogs)
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch();
  }

  Future<List<MealLog>> getMealsBetween(DateTime start, DateTime end) {
    return (select(mealLogs)
          ..where(
            (t) =>
                t.timestamp.isBiggerOrEqualValue(start) &
                t.timestamp.isSmallerThanValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  Future<int> upsertMealLog(MealLogsCompanion meal) {
    return into(mealLogs).insertOnConflictUpdate(meal);
  }

  Future<int> deleteMealLogById(String id) {
    return (delete(mealLogs)..where((t) => t.id.equals(id))).go();
  }

  // --- Phase 3 Metabolic Profile Queries ---
  Future<UserMetabolicProfile?> getMetabolicProfile() {
    return (select(userMetabolicProfiles)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
  }

  Stream<UserMetabolicProfile?> watchMetabolicProfile() {
    return (select(userMetabolicProfiles)..where((t) => t.id.equals(1)))
        .watchSingleOrNull();
  }

  Future<int> upsertMetabolicProfile(UserMetabolicProfilesCompanion profile) {
    return into(userMetabolicProfiles).insertOnConflictUpdate(profile);
  }
}
