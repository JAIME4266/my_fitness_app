import '../../../database/database.dart';
import 'workout_models.dart';

class TrainingDayStatus {
  final DateTime date;
  final String dateKey;
  final List<Workout> completedWorkouts;
  final List<ScheduledWorkout> scheduledWorkouts;

  const TrainingDayStatus({
    required this.date,
    required this.dateKey,
    required this.completedWorkouts,
    required this.scheduledWorkouts,
  });

  bool get hasCompleted => completedWorkouts.isNotEmpty;
  bool get hasScheduled => scheduledWorkouts.isNotEmpty;
}

class TrainingRecommendation {
  final WorkoutRoutine routine;
  final String badge;
  final String headline;
  final String reason;

  const TrainingRecommendation({
    required this.routine,
    required this.badge,
    required this.headline,
    required this.reason,
  });
}

class TrainingAnalyticsSummary {
  final int totalSessions;
  final int totalMinutes;
  final int activeDaysLast30;
  final int currentStreakDays;
  final Map<String, int> categoryCounts;
  final List<MapEntry<DateTime, int>> dailyMinutesLast7;

  const TrainingAnalyticsSummary({
    required this.totalSessions,
    required this.totalMinutes,
    required this.activeDaysLast30,
    required this.currentStreakDays,
    required this.categoryCounts,
    required this.dailyMinutesLast7,
  });

  bool get hasData => totalSessions > 0;
}

class TrainingAnalyticsEngine {
  static String dateKeyFor(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime startOfWeekMonday(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.subtract(Duration(days: normalized.weekday - 1));
  }

  static int computeStreakDays(List<Workout> workouts, DateTime now) {
    if (workouts.isEmpty) return 0;
    final dayKeys = workouts
        .map((w) => dateKeyFor(
            DateTime.fromMillisecondsSinceEpoch(w.startEpochMs)))
        .toSet();

    var cursor = DateTime(now.year, now.month, now.day);
    if (!dayKeys.contains(dateKeyFor(cursor))) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!dayKeys.contains(dateKeyFor(cursor))) {
        return 0;
      }
    }

    int streak = 0;
    while (dayKeys.contains(dateKeyFor(cursor))) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static List<TrainingDayStatus> buildWeekCalendar({
    required DateTime weekMonday,
    required List<Workout> workouts,
    required List<ScheduledWorkout> scheduled,
  }) {
    return List.generate(7, (i) {
      final day = weekMonday.add(Duration(days: i));
      final key = dateKeyFor(day);
      final dayWorkouts = workouts.where((w) {
        final d = DateTime.fromMillisecondsSinceEpoch(w.startEpochMs);
        return dateKeyFor(d) == key;
      }).toList();
      final dayScheduled =
          scheduled.where((s) => s.scheduledDateKey == key).toList();
      return TrainingDayStatus(
        date: day,
        dateKey: key,
        completedWorkouts: dayWorkouts,
        scheduledWorkouts: dayScheduled,
      );
    });
  }

  static String inferCategoryForWorkout(
    Workout workout,
    List<WorkoutRoutine> allRoutines,
  ) {
    if (workout.type.startsWith('Routine: ')) {
      final title = workout.type.substring('Routine: '.length).trim();
      for (final r in allRoutines) {
        if (r.title == title) return r.category;
      }
    }
    final t = workout.type.toLowerCase();
    if (t.contains('run') || t.contains('walk') || t.contains('cycle')) {
      return 'ENDURANCE TRAINING';
    }
    return 'RUNNER STRENGTH TRAINING';
  }

  static TrainingAnalyticsSummary computeSummary({
    required List<Workout> workouts,
    required List<WorkoutRoutine> allRoutines,
    DateTime? now,
  }) {
    final refNow = now ?? DateTime.now();
    final today = DateTime(refNow.year, refNow.month, refNow.day);
    final cutoff30 = today.subtract(const Duration(days: 29));

    int totalSec = 0;
    final active30Keys = <String>{};
    final catCounts = <String, int>{};

    for (final w in workouts) {
      totalSec += w.durationSec;
      final dt = DateTime.fromMillisecondsSinceEpoch(w.startEpochMs);
      final normalized = DateTime(dt.year, dt.month, dt.day);
      if (!normalized.isBefore(cutoff30)) {
        active30Keys.add(dateKeyFor(normalized));
      }
      final cat = inferCategoryForWorkout(w, allRoutines);
      catCounts[cat] = (catCounts[cat] ?? 0) + 1;
    }

    final daily7 = <MapEntry<DateTime, int>>[];
    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final key = dateKeyFor(day);
      final mins = workouts
          .where((w) =>
              dateKeyFor(DateTime.fromMillisecondsSinceEpoch(w.startEpochMs)) ==
              key)
          .fold<int>(0, (acc, w) => acc + (w.durationSec / 60).round());
      daily7.add(MapEntry(day, mins));
    }

    return TrainingAnalyticsSummary(
      totalSessions: workouts.length,
      totalMinutes: (totalSec / 60).round(),
      activeDaysLast30: active30Keys.length,
      currentStreakDays: computeStreakDays(workouts, refNow),
      categoryCounts: catCounts,
      dailyMinutesLast7: daily7,
    );
  }

  static TrainingRecommendation recommendRoutine({
    required List<Workout> history,
    required Set<String> favourites,
    required List<WorkoutRoutine> allRoutines,
    required List<ProgrammeEnrolment> enrolments,
    required List<ProgrammeSessionCompletion> completions,
    DateTime? now,
  }) {
    final refNow = now ?? DateTime.now();
    final todayKey = dateKeyFor(refNow);

    // Rule 1: If the user already trained intensely today, suggest recovery/mobility
    final workedOutToday = history.any((w) =>
        dateKeyFor(DateTime.fromMillisecondsSinceEpoch(w.startEpochMs)) ==
        todayKey);
    if (workedOutToday) {
      final recovery = allRoutines.firstWhere(
        (r) => r.id == 'recovery_recharge',
        orElse: () => allRoutines.first,
      );
      return TrainingRecommendation(
        routine: recovery,
        badge: 'RECOVERY PICK',
        headline: 'Cool Down & Restore',
        reason:
            'You already logged activity today — a light post-run stretch helps prevent stiffness without overloading.',
      );
    }

    // Rule 2: If enrolled in a programme, surface the next uncompleted session
    for (final enrolment in enrolments.where((e) => e.isActive)) {
      final prog = curatedTrainingProgrammes.where(
        (p) => p.id == enrolment.programmeId,
      );
      if (prog.isEmpty) continue;
      final completedIds = completions
          .where((c) => c.programmeId == enrolment.programmeId)
          .map((c) => c.sessionId)
          .toSet();
      final nextSession = prog.first.allSessions
          .where((s) => !completedIds.contains(s.id))
          .firstOrNull;
      if (nextSession != null) {
        final matched = allRoutines.firstWhere(
          (r) => r.id == nextSession.routineId,
          orElse: () => allRoutines.first,
        );
        return TrainingRecommendation(
          routine: matched,
          badge: 'NEXT IN PROGRAMME',
          headline: prog.first.title,
          reason:
              'Up next in ${prog.first.title}: "${nextSession.title}" (${nextSession.focusNote}).',
        );
      }
    }

    // Rule 3: If the user ran recently in GPS history, suggest Runner Strength or Warmup
    if (history.isNotEmpty) {
      final last = history.first;
      final lastCat = inferCategoryForWorkout(last, allRoutines);
      if (lastCat == 'ENDURANCE TRAINING') {
        final mob = allRoutines.firstWhere(
          (r) => r.id == 'mobility_hip_ankle',
          orElse: () => allRoutines.first,
        );
        return TrainingRecommendation(
          routine: mob,
          badge: 'BALANCE PICK',
          headline: 'Support Your Miles',
          reason:
              'Your recent session was endurance-focused — ankle & hip mobility balances repetitive stride load.',
        );
      }
    }

    // Rule 4: Highlight a bookmarked routine or sensible dynamic warmup
    if (favourites.isNotEmpty) {
      final favMatch =
          allRoutines.where((r) => favourites.contains(r.id)).firstOrNull;
      if (favMatch != null) {
        return TrainingRecommendation(
          routine: favMatch,
          badge: 'SAVED FAVOURITE',
          headline: 'Ready to Train',
          reason:
              'Picked from your saved routines — balanced duration for a clean daily session.',
        );
      }
    }

    final defaultPick = allRoutines.firstWhere(
      (r) => r.id == 'warmup_dynamic',
      orElse: () => allRoutines.first,
    );
    return TrainingRecommendation(
      routine: defaultPick,
      badge: 'DAILY ACTIVATION',
      headline: 'Prime Your Stride',
      reason:
          'A balanced 12-minute dynamic warmup to activate glutes and hips before any run or strength block.',
    );
  }
}
