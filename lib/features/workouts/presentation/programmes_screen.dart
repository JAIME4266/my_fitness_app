import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_routines_repository.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';
import 'workout_detail_and_session_screen.dart';

class ProgrammesScreen extends ConsumerWidget {
  const ProgrammesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text('TRAINING PROGRAMMES',
            style: TrainingTheme.sectionTitle),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: curatedTrainingProgrammes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, i) {
          final p = curatedTrainingProgrammes[i];
          final enrolled = enrolments.any((e) => e.programmeId == p.id);
          final doneCount =
              completions.where((c) => c.programmeId == p.id).length;
          final total = p.allSessions.length;
          final progress = total > 0 ? (doneCount / total).clamp(0.0, 1.0) : 0.0;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProgrammeDetailScreen(programme: p),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: TrainingTheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: TrainingTheme.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 155,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          p.coverAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              Container(color: TrainingTheme.surfaceElevated),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xEE101214)],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  p.title.toUpperCase(),
                                  style: TrainingTheme.displayHero
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              if (enrolled)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: TrainingTheme.lime,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'ENROLLED',
                                    style: TextStyle(
                                      color: TrainingTheme.onLime,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.objective,
                          style: const TextStyle(
                            color: TrainingTheme.textPrimary,
                            fontSize: 13,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${p.durationWeeks} Weeks • ${p.phases.length} Phases • $total Sessions',
                              style: TrainingTheme.metaLabel,
                            ),
                            Text(
                              p.difficulty.toUpperCase(),
                              style: TextStyle(
                                color: p.accentColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        if (enrolled) ...[
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 5,
                              backgroundColor: TrainingTheme.border,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                TrainingTheme.lime,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$doneCount of $total sessions completed',
                            style: const TextStyle(
                              color: TrainingTheme.lime,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgrammeDetailScreen extends ConsumerWidget {
  final TrainingProgramme programme;
  const ProgrammeDetailScreen({super.key, required this.programme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolments =
        ref.watch(programmeEnrolmentsProvider).valueOrNull ?? const [];
    final completions =
        ref.watch(allProgrammeCompletionsProvider).valueOrNull ?? const [];

    final isEnrolled = enrolments.any((e) => e.programmeId == programme.id);
    final doneSessionIds = completions
        .where((c) => c.programmeId == programme.id)
        .map((c) => c.sessionId)
        .toSet();
    final allSessions = programme.allSessions;
    final nextSession = allSessions
        .where((s) => !doneSessionIds.contains(s.id))
        .firstOrNull;

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: Text(
          programme.title.toUpperCase(),
          style: TrainingTheme.sectionTitle,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: TrainingTheme.lime,
              foregroundColor: TrainingTheme.onLime,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () async {
              final repo = ref.read(workoutRoutinesRepositoryProvider);
              if (!isEnrolled) {
                await repo.enrolInProgramme(programme.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Enrolled in ${programme.title}!'),
                    ),
                  );
                }
                return;
              }
              if (nextSession != null) {
                final routine = WorkoutRoutinesRepository.findRoutineById(
                  nextSession.routineId,
                  curatedRunnerRoutines,
                );
                if (routine != null && context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ActiveWorkoutSessionScreen(
                        routine: routine,
                        programmeId: programme.id,
                        programmeSession: nextSession,
                      ),
                    ),
                  );
                }
              }
            },
            icon: Icon(
              isEnrolled ? Icons.play_arrow_rounded : Icons.flag_outlined,
            ),
            label: Text(
              !isEnrolled
                  ? 'ENROL IN PROGRAMME'
                  : (nextSession != null
                      ? 'START NEXT: ${nextSession.title.toUpperCase()}'
                      : 'PROGRAMME COMPLETED'),
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: 175,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(programme.coverAsset, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xEE101214)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${programme.durationWeeks} WEEKS • ${programme.difficulty.toUpperCase()}',
                          style: const TextStyle(
                            color: TrainingTheme.lime,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          programme.title,
                          style:
                              TrainingTheme.displayHero.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            programme.objective,
            style: const TextStyle(
              color: TrainingTheme.textPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          if (isEnrolled) ...[
            Container(
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
                    'PROGRESS: ${doneSessionIds.length} / ${allSessions.length} SESSIONS',
                    style: const TextStyle(
                      color: TrainingTheme.lime,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: allSessions.isEmpty
                          ? 0
                          : doneSessionIds.length / allSessions.length,
                      minHeight: 6,
                      backgroundColor: TrainingTheme.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        TrainingTheme.lime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
          ...programme.phases.map((phase) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase.title.toUpperCase(),
                  style: TrainingTheme.sectionTitle.copyWith(
                    color: programme.accentColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(phase.summary, style: TrainingTheme.metaLabel),
                const SizedBox(height: 10),
                ...phase.sessions.map((s) {
                  final done = doneSessionIds.contains(s.id);
                  final isNext = nextSession?.id == s.id;
                  final routine = WorkoutRoutinesRepository.findRoutineById(
                    s.routineId,
                    curatedRunnerRoutines,
                  );
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: TrainingTheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isNext && isEnrolled
                            ? TrainingTheme.lime
                            : TrainingTheme.border,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: done
                            ? TrainingTheme.lime
                            : TrainingTheme.surfaceElevated,
                        child: Icon(
                          done ? Icons.check : Icons.play_arrow,
                          color: done
                              ? TrainingTheme.onLime
                              : TrainingTheme.textPrimary,
                          size: 18,
                        ),
                      ),
                      title: Text(
                        'W${s.weekNumber} D${s.dayOfWeek} • ${s.title}',
                        style: TrainingTheme.cardTitle.copyWith(fontSize: 14),
                      ),
                      subtitle: Text(
                        '${s.estimatedMinutes} min • ${s.focusNote}',
                        style: TrainingTheme.metaLabel,
                      ),
                      trailing: isNext && isEnrolled
                          ? const Text(
                              'UP NEXT',
                              style: TextStyle(
                                color: TrainingTheme.lime,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          : null,
                      onTap: routine == null
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => WorkoutDetailScreen(
                                    routine: routine,
                                    isFavourite: false,
                                    onToggleFavourite: () {},
                                    programmeId: programme.id,
                                    programmeSession: s,
                                  ),
                                ),
                              );
                            },
                    ),
                  );
                }),
                const SizedBox(height: 12),
              ],
            );
          }),
        ],
      ),
    );
  }
}
