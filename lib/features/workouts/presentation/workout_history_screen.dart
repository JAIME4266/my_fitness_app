import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_routines_repository.dart';
import '../domain/training_analytics_engine.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';

class WorkoutHistoryScreen extends ConsumerStatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  ConsumerState<WorkoutHistoryScreen> createState() =>
      _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends ConsumerState<WorkoutHistoryScreen> {
  int _rangeDays = 0; // 0 = All, 7 = 7D, 30 = 30D

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(allTrainingWorkoutsProvider);

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: const Text('WORKOUT HISTORY', style: TrainingTheme.sectionTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: SegmentedButton<int>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return TrainingTheme.lime;
                  }
                  return TrainingTheme.surface;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return TrainingTheme.onLime;
                  }
                  return TrainingTheme.textSecondary;
                }),
              ),
              segments: const [
                ButtonSegment(value: 0, label: Text('All Time')),
                ButtonSegment(value: 7, label: Text('7 Days')),
                ButtonSegment(value: 30, label: Text('30 Days')),
              ],
              selected: {_rangeDays},
              onSelectionChanged: (s) => setState(() => _rangeDays = s.first),
            ),
          ),
          Expanded(
            child: workoutsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: TrainingTheme.lime),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Unable to load workouts: $e',
                  style: const TextStyle(color: TrainingTheme.textSecondary),
                ),
              ),
              data: (all) {
                final now = DateTime.now();
                final filtered = _rangeDays == 0
                    ? all
                    : all.where((w) {
                        final dt = DateTime.fromMillisecondsSinceEpoch(
                            w.startEpochMs);
                        return now.difference(dt).inDays < _rangeDays;
                      }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.history_toggle_off,
                              size: 48, color: TrainingTheme.textMuted),
                          const SizedBox(height: 12),
                          const Text(
                            'No completed workouts yet',
                            style: TrainingTheme.cardTitle,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _rangeDays == 0
                                ? 'Complete a training routine or outdoor run to see your verified history here.'
                                : 'No sessions logged in the last $_rangeDays days.',
                            textAlign: TextAlign.center,
                            style: TrainingTheme.metaLabel,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final w = filtered[i];
                    final dt =
                        DateTime.fromMillisecondsSinceEpoch(w.startEpochMs);
                    final cat = TrainingAnalyticsEngine.inferCategoryForWorkout(
                      w,
                      curatedRunnerRoutines,
                    );
                    final accent = TrainingTheme.accentForCategory(cat);
                    final mins = (w.durationSec / 60).floor();
                    final secs = w.durationSec % 60;
                    final durText = mins > 0 ? '${mins}m ${secs}s' : '${secs}s';

                    return Container(
                      decoration: BoxDecoration(
                        color: TrainingTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: TrainingTheme.border),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: accent.withValues(alpha: 0.16),
                          child: Icon(Icons.check_circle, color: accent),
                        ),
                        title: Text(
                          w.type,
                          style: TrainingTheme.cardTitle.copyWith(fontSize: 14.5),
                        ),
                        subtitle: Text(
                          '${TrainingAnalyticsEngine.dateKeyFor(dt)} • $durText • ${w.caloriesKcal.round()} kcal',
                          style: TrainingTheme.metaLabel,
                        ),
                        trailing: Text(
                          TrainingTheme.shortBadgeForCategory(cat),
                          style: TextStyle(
                            color: accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
