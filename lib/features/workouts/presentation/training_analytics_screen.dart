import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_routines_repository.dart';
import '../domain/training_analytics_engine.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';

class TrainingAnalyticsScreen extends ConsumerWidget {
  const TrainingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(allTrainingWorkoutsProvider);
    final enrolments =
        ref.watch(programmeEnrolmentsProvider).valueOrNull ?? const [];
    final completions =
        ref.watch(allProgrammeCompletionsProvider).valueOrNull ?? const [];

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: const Text('TRAINING ANALYTICS',
            style: TrainingTheme.sectionTitle),
      ),
      body: workoutsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: TrainingTheme.lime),
        ),
        error: (e, _) => Center(
          child: Text(
            'Unable to compute analytics: $e',
            style: const TextStyle(color: TrainingTheme.textSecondary),
          ),
        ),
        data: (workouts) {
          final summary = TrainingAnalyticsEngine.computeSummary(
            workouts: workouts,
            allRoutines: curatedRunnerRoutines,
          );

          if (!summary.hasData && enrolments.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bar_chart_rounded,
                        size: 52, color: TrainingTheme.textMuted),
                    SizedBox(height: 12),
                    Text(
                      'Not enough training data yet',
                      style: TrainingTheme.cardTitle,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Complete your first workout or enrol in a programme to unlock real duration trends and category insights.',
                      textAlign: TextAlign.center,
                      style: TrainingTheme.metaLabel,
                    ),
                  ],
                ),
              ),
            );
          }

          final maxMins = summary.dailyMinutesLast7.fold<int>(
            20,
            (prev, e) => e.value > prev ? e.value : prev,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _statTile(
                      'SESSIONS',
                      '${summary.totalSessions}',
                      TrainingTheme.lime,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statTile(
                      'MINUTES',
                      '${summary.totalMinutes}',
                      TrainingTheme.enduranceAccent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statTile(
                      'STREAK',
                      '${summary.currentStreakDays}d',
                      TrainingTheme.mobilityAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('7-DAY TRAINING DURATION (MIN)',
                  style: TrainingTheme.sectionTitle),
              const SizedBox(height: 10),
              Container(
                height: 210,
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                decoration: BoxDecoration(
                  color: TrainingTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: TrainingTheme.border),
                ),
                child: BarChart(
                  BarChartData(
                    maxY: maxMins * 1.2,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (v, _) => Text(
                            '${v.toInt()}',
                            style: const TextStyle(
                              color: TrainingTheme.textMuted,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, _) {
                            final idx = v.toInt();
                            if (idx < 0 ||
                                idx >= summary.dailyMinutesLast7.length) {
                              return const SizedBox.shrink();
                            }
                            final d = summary.dailyMinutesLast7[idx].key;
                            const letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Text(
                              letters[d.weekday - 1],
                              style: const TextStyle(
                                color: TrainingTheme.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups:
                        List.generate(summary.dailyMinutesLast7.length, (i) {
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: summary.dailyMinutesLast7[i].value.toDouble(),
                            color: TrainingTheme.lime,
                            width: 14,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (summary.categoryCounts.isNotEmpty) ...[
                const Text('CATEGORY DISTRIBUTION',
                    style: TrainingTheme.sectionTitle),
                const SizedBox(height: 10),
                ...summary.categoryCounts.entries.map((entry) {
                  final accent = TrainingTheme.accentForCategory(entry.key);
                  final ratio = summary.totalSessions > 0
                      ? entry.value / summary.totalSessions
                      : 0.0;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: TrainingTheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: TrainingTheme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key,
                                style: const TextStyle(
                                  color: TrainingTheme.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text(
                              '${entry.value} session(s)',
                              style: TrainingTheme.metaLabel,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6,
                            backgroundColor: TrainingTheme.border,
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
              if (enrolments.isNotEmpty) ...[
                const SizedBox(height: 14),
                const Text('PROGRAMME PROGRESS',
                    style: TrainingTheme.sectionTitle),
                const SizedBox(height: 10),
                ...enrolments.map((e) {
                  final prog = curatedTrainingProgrammes
                      .where((p) => p.id == e.programmeId)
                      .firstOrNull;
                  if (prog == null) return const SizedBox.shrink();
                  final done = completions
                      .where((c) => c.programmeId == prog.id)
                      .length;
                  final total = prog.allSessions.length;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: TrainingTheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: TrainingTheme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(prog.title, style: TrainingTheme.cardTitle),
                        const SizedBox(height: 4),
                        Text(
                          '$done / $total sessions completed',
                          style: const TextStyle(
                            color: TrainingTheme.lime,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _statTile(String label, String value, Color accent) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TrainingTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TrainingTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: TrainingTheme.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
