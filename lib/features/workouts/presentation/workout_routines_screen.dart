import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_routines_repository.dart';
import '../domain/training_analytics_engine.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';
import 'exercise_library_screen.dart';
import 'programmes_screen.dart';
import 'training_analytics_screen.dart';
import 'widgets/featured_focus_card.dart';
import 'widgets/programme_card.dart';
import 'widgets/routine_card.dart';
import 'widgets/training_weekly_calendar.dart';
import 'workout_detail_and_session_screen.dart';
import 'workout_history_screen.dart';

class WorkoutRoutinesScreen extends ConsumerStatefulWidget {
  const WorkoutRoutinesScreen({super.key});

  @override
  ConsumerState<WorkoutRoutinesScreen> createState() =>
      _WorkoutRoutinesScreenState();
}

class _WorkoutRoutinesScreenState extends ConsumerState<WorkoutRoutinesScreen> {
  Set<String> _favourites = {};
  List<WorkoutRoutine> _customRoutines = [];
  String _selectedCategory = 'ALL';
  late DateTime _today;
  late DateTime _selectedDate;
  late DateTime _weekMonday;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _selectedDate = _today;
    _weekMonday = TrainingAnalyticsEngine.startOfWeekMonday(_today);
    _loadUserRoutines();
  }

  Future<void> _loadUserRoutines() async {
    final repo = ref.read(workoutRoutinesRepositoryProvider);
    final favs = await repo.getFavouriteIds();
    final custom = await repo.getCustomRoutines();
    if (mounted) {
      setState(() {
        _favourites = favs;
        _customRoutines = custom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allRoutines = [...curatedRunnerRoutines, ..._customRoutines];
    final workouts =
        ref.watch(allTrainingWorkoutsProvider).valueOrNull ?? const [];
    final scheduled =
        ref.watch(scheduledWorkoutsProvider).valueOrNull ?? const [];
    final enrolments =
        ref.watch(programmeEnrolmentsProvider).valueOrNull ?? const [];
    final completions =
        ref.watch(allProgrammeCompletionsProvider).valueOrNull ?? const [];

    final streak = TrainingAnalyticsEngine.computeStreakDays(workouts, _today);
    final weekDays = TrainingAnalyticsEngine.buildWeekCalendar(
      weekMonday: _weekMonday,
      workouts: workouts,
      scheduled: scheduled,
    );
    final selectedKey = TrainingAnalyticsEngine.dateKeyFor(_selectedDate);
    final selectedDayStatus = weekDays.firstWhere(
      (d) => d.dateKey == selectedKey,
      orElse: () => TrainingDayStatus(
        date: _selectedDate,
        dateKey: selectedKey,
        completedWorkouts: const [],
        scheduledWorkouts: const [],
      ),
    );

    final recommendation = TrainingAnalyticsEngine.recommendRoutine(
      history: workouts,
      favourites: _favourites,
      allRoutines: allRoutines,
      enrolments: enrolments,
      completions: completions,
      now: _today,
    );

    final filteredRoutines = _selectedCategory == 'ALL'
        ? allRoutines
        : allRoutines.where((r) => r.category == _selectedCategory).toList();

    final featuredRoutine = selectedDayStatus.hasScheduled
        ? (WorkoutRoutinesRepository.findRoutineById(
                selectedDayStatus.scheduledWorkouts.first.routineId,
                allRoutines) ??
            recommendation.routine)
        : recommendation.routine;

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      body: SafeArea(
        child: RefreshIndicator(
          color: TrainingTheme.lime,
          backgroundColor: TrainingTheme.surface,
          onRefresh: _loadUserRoutines,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            children: [
              // 1. Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text('TRAINING', style: TrainingTheme.displayHero),
                  ),
                  if (streak > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 6),
                      decoration: BoxDecoration(
                        color: TrainingTheme.surfaceElevated,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: TrainingTheme.lime.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Text(
                        '$streak-DAY STREAK',
                        style: const TextStyle(
                          color: TrainingTheme.lime,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  const SizedBox(width: 6),
                  IconButton(
                    tooltip: 'Workout History',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const WorkoutHistoryScreen()),
                      );
                    },
                    icon: const Icon(Icons.history,
                        color: TrainingTheme.textSecondary),
                  ),
                  IconButton(
                    tooltip: 'Training Analytics',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const TrainingAnalyticsScreen()),
                      );
                    },
                    icon: const Icon(Icons.bar_chart_rounded,
                        color: TrainingTheme.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 2. Interactive Weekly Calendar
              TrainingWeeklyCalendar(
                days: weekDays,
                selectedDate: _selectedDate,
                today: _today,
                onSelectDate: (d) => setState(() => _selectedDate = d),
                onPreviousWeek: () => setState(() {
                  _weekMonday = _weekMonday.subtract(const Duration(days: 7));
                  _selectedDate = _weekMonday;
                }),
                onNextWeek: () => setState(() {
                  _weekMonday = _weekMonday.add(const Duration(days: 7));
                  _selectedDate = _weekMonday;
                }),
              ),
              const SizedBox(height: 10),
              _buildSelectedDayStrip(context, selectedDayStatus, allRoutines),
              const SizedBox(height: 14),

              // 3. Category Filter Strip
              _buildCategoryChips(),
              const SizedBox(height: 16),

              // 4. Today's Focus Featured Hero
              FeaturedFocusCard(
                routine: featuredRoutine,
                eyebrow: selectedDayStatus.hasScheduled
                    ? 'SCHEDULED FOR ${selectedDayStatus.dateKey}'
                    : "TODAY'S FOCUS",
                onStart: () => _startRoutineDirect(featuredRoutine),
                onTapCard: () => _openRoutineDetail(featuredRoutine),
              ),
              const SizedBox(height: 22),

              // 5. Athletic Build Programs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('ATHLETIC BUILD PROGRAMS',
                      style: TrainingTheme.sectionTitle),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ProgrammesScreen()),
                      );
                    },
                    child: const Text(
                      'SEE ALL',
                      style: TextStyle(
                        color: TrainingTheme.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 175,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: curatedTrainingProgrammes.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final prog = curatedTrainingProgrammes[i];
                    final isEnrolled =
                        enrolments.any((e) => e.programmeId == prog.id);
                    final doneCount = completions
                        .where((c) => c.programmeId == prog.id)
                        .length;
                    return ProgrammeCard(
                      programme: prog,
                      completedSessions: doneCount,
                      isEnrolled: isEnrolled,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ProgrammeDetailScreen(programme: prog),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),

              // 6. Daily Routines
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('DAILY ROUTINES',
                      style: TrainingTheme.sectionTitle),
                  TextButton.icon(
                    onPressed: _showCreateRoutineDialog,
                    icon: const Icon(Icons.add,
                        size: 16, color: TrainingTheme.lime),
                    label: const Text(
                      'CREATE',
                      style: TextStyle(
                        color: TrainingTheme.lime,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 172,
                child: filteredRoutines.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TrainingTheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: TrainingTheme.border),
                        ),
                        child: const Text(
                          'No routines in this category yet.',
                          style: TrainingTheme.metaLabel,
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredRoutines.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (_, i) {
                          final r = filteredRoutines[i];
                          return RoutineCard(
                            routine: r,
                            isFavourite: _favourites.contains(r.id),
                            onTap: () => _openRoutineDetail(r),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 22),

              // 7. Rule-Based Recommendation
              _buildRecommendationCard(recommendation),
              const SizedBox(height: 22),

              // 8. Explore Destinations & Categories
              const Text('TRAINING HUB', style: TrainingTheme.sectionTitle),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.15,
                children: [
                  _hubTile(
                    icon: Icons.menu_book_outlined,
                    title: 'Exercise Library',
                    subtitle: '${curatedExerciseLibrary.length} movements',
                    accent: TrainingTheme.lime,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ExerciseLibraryScreen()),
                    ),
                  ),
                  _hubTile(
                    icon: Icons.layers_outlined,
                    title: 'Programmes',
                    subtitle: '${curatedTrainingProgrammes.length} plans',
                    accent: TrainingTheme.strengthAccent,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ProgrammesScreen()),
                    ),
                  ),
                  _hubTile(
                    icon: Icons.history,
                    title: 'History',
                    subtitle: '${workouts.length} logged',
                    accent: TrainingTheme.enduranceAccent,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const WorkoutHistoryScreen()),
                    ),
                  ),
                  _hubTile(
                    icon: Icons.insights,
                    title: 'Analytics',
                    subtitle: 'Trends & stats',
                    accent: TrainingTheme.mobilityAccent,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const TrainingAnalyticsScreen()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDayStrip(
    BuildContext context,
    TrainingDayStatus dayStatus,
    List<WorkoutRoutine> allRoutines,
  ) {
    final completedCount = dayStatus.completedWorkouts.length;
    final scheduledCount = dayStatus.scheduledWorkouts.length;
    final summaryText = completedCount > 0
        ? '$completedCount completed session(s) on ${dayStatus.dateKey}'
        : (scheduledCount > 0
            ? 'Planned: ${dayStatus.scheduledWorkouts.first.routineTitle}'
            : 'No sessions logged or scheduled for ${dayStatus.dateKey}');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: TrainingTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TrainingTheme.border),
      ),
      child: Row(
        children: [
          Icon(
            completedCount > 0
                ? Icons.check_circle
                : (scheduledCount > 0
                    ? Icons.event_available
                    : Icons.calendar_today_outlined),
            size: 16,
            color: completedCount > 0
                ? TrainingTheme.lime
                : (scheduledCount > 0
                    ? TrainingTheme.enduranceAccent
                    : TrainingTheme.textSecondary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              summaryText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TrainingTheme.metaLabel.copyWith(
                color: TrainingTheme.textPrimary,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              foregroundColor: TrainingTheme.lime,
            ),
            onPressed: () => _showScheduleDialog(allRoutines),
            child: const Text(
              '+ Schedule',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final cats = ['ALL', ...workoutCategories];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = cats[i];
          final selected = cat == _selectedCategory;
          final label = cat == 'ALL'
              ? 'ALL'
              : TrainingTheme.shortBadgeForCategory(cat);
          return ChoiceChip(
            label: Text(label),
            selected: selected,
            onSelected: (_) => setState(() => _selectedCategory = cat),
            selectedColor: TrainingTheme.surfaceElevated,
            backgroundColor: TrainingTheme.surface,
            side: BorderSide(
              color: selected ? TrainingTheme.lime : TrainingTheme.border,
            ),
            labelStyle: TextStyle(
              color: selected
                  ? TrainingTheme.textPrimary
                  : TrainingTheme.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendationCard(TrainingRecommendation rec) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TrainingTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TrainingTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: TrainingTheme.limeMuted,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  rec.badge,
                  style: const TextStyle(
                    color: TrainingTheme.lime,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  rec.headline,
                  style: TrainingTheme.cardTitle.copyWith(fontSize: 14.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(rec.reason, style: TrainingTheme.metaLabel),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${rec.routine.title} • ${rec.routine.totalMinutes} min',
                style: const TextStyle(
                  color: TrainingTheme.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: TrainingTheme.lime,
                  side: const BorderSide(color: TrainingTheme.lime),
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () => _openRoutineDetail(rec.routine),
                child: const Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hubTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return Material(
      color: TrainingTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: TrainingTheme.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: accent.withValues(alpha: 0.16),
                child: Icon(icon, color: accent, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TrainingTheme.cardTitle.copyWith(fontSize: 13),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TrainingTheme.metaLabel.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openRoutineDetail(WorkoutRoutine r) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutDetailScreen(
          routine: r,
          isFavourite: _favourites.contains(r.id),
          onToggleFavourite: () async {
            final next = await ref
                .read(workoutRoutinesRepositoryProvider)
                .toggleFavourite(r.id);
            if (mounted) setState(() => _favourites = next);
          },
        ),
      ),
    );
  }

  void _startRoutineDirect(WorkoutRoutine r) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActiveWorkoutSessionScreen(routine: r),
      ),
    );
  }

  Future<void> _showScheduleDialog(List<WorkoutRoutine> allRoutines) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TrainingTheme.surface,
        title: Text(
          'Schedule for ${TrainingAnalyticsEngine.dateKeyFor(_selectedDate)}',
          style: const TextStyle(color: TrainingTheme.textPrimary, fontSize: 16),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 260,
          child: ListView.builder(
            itemCount: allRoutines.length,
            itemBuilder: (_, i) {
              final r = allRoutines[i];
              return ListTile(
                dense: true,
                title: Text(r.title,
                    style: const TextStyle(color: TrainingTheme.textPrimary)),
                subtitle: Text('${r.totalMinutes} min • ${r.difficulty}',
                    style: TrainingTheme.metaLabel),
                onTap: () async {
                  await ref
                      .read(workoutRoutinesRepositoryProvider)
                      .scheduleRoutineForDate(routine: r, date: _selectedDate);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateRoutineDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final minsCtrl = TextEditingController(text: '15');
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TrainingTheme.surface,
        title: const Text('Create Custom Routine',
            style: TextStyle(color: TrainingTheme.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              style: const TextStyle(color: TrainingTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Routine Name',
                labelStyle: TextStyle(color: TrainingTheme.textSecondary),
              ),
            ),
            TextField(
              controller: descCtrl,
              style: const TextStyle(color: TrainingTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: TrainingTheme.textSecondary),
              ),
            ),
            TextField(
              controller: minsCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: TrainingTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Duration (min)',
                labelStyle: TextStyle(color: TrainingTheme.textSecondary),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: TrainingTheme.lime,
              foregroundColor: TrainingTheme.onLime,
            ),
            onPressed: () async {
              if (titleCtrl.text.trim().isEmpty) return;
              await ref.read(workoutRoutinesRepositoryProvider).saveCustomRoutine(
                    title: titleCtrl.text,
                    category: workoutCategories.first,
                    description: descCtrl.text,
                    difficulty: 'Intermediate',
                    totalMinutes: int.tryParse(minsCtrl.text) ?? 15,
                  );
              await _loadUserRoutines();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
