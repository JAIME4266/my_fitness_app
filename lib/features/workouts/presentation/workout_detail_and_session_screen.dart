import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/training_media_service.dart';
import '../data/workout_routines_repository.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final WorkoutRoutine routine;
  final bool isFavourite;
  final VoidCallback onToggleFavourite;
  final String? programmeId;
  final ProgrammeSession? programmeSession;

  const WorkoutDetailScreen({
    super.key,
    required this.routine,
    required this.isFavourite,
    required this.onToggleFavourite,
    this.programmeId,
    this.programmeSession,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final media = TrainingMediaService.resolveForRoutine(routine);
    final accent = TrainingTheme.accentForCategory(routine.category);

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: Text(
          routine.title.toUpperCase(),
          style: TrainingTheme.sectionTitle,
        ),
        actions: [
          IconButton(
            tooltip: 'Save Routine',
            onPressed: onToggleFavourite,
            icon: Icon(
              isFavourite ? Icons.bookmark : Icons.bookmark_border,
              color: TrainingTheme.lime,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: TrainingTheme.lime,
              foregroundColor: TrainingTheme.onLime,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ActiveWorkoutSessionScreen(
                    routine: routine,
                    programmeId: programmeId,
                    programmeSession: programmeSession,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text(
              'Start Workout',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 190,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    media.posterAssetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: TrainingTheme.surfaceElevated),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x55101214), Color(0xEE101214)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: accent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                routine.difficulty.toUpperCase(),
                                style: const TextStyle(
                                  color: TrainingTheme.onLime,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xCC101214),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                routine.equipment,
                                style: const TextStyle(
                                  color: TrainingTheme.textPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              routine.category,
                              style: TextStyle(
                                color: accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.7,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${routine.totalMinutes}:00 • ${routine.exercises.length} exercises',
                              style: TrainingTheme.displayHero
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TrainingTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TrainingTheme.border),
            ),
            child: Row(
              children: [
                Icon(
                  media.hasPlayableVideo
                      ? Icons.play_circle_filled
                      : Icons.timer_outlined,
                  color: TrainingTheme.lime,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    media.statusNote,
                    style: TrainingTheme.metaLabel,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            routine.description,
            style: const TextStyle(
              fontSize: 14,
              color: TrainingTheme.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          const Text('EXERCISES', style: TrainingTheme.sectionTitle),
          const SizedBox(height: 10),
          ...List.generate(routine.exercises.length, (i) {
            final ex = routine.exercises[i];
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${i + 1}. ${ex.name}',
                          style: TrainingTheme.cardTitle.copyWith(fontSize: 14.5),
                        ),
                      ),
                      Text(
                        ex.repsLabel ?? '${ex.durationSeconds}s',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: TrainingTheme.lime,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(ex.instructions, style: TrainingTheme.metaLabel),
                  const SizedBox(height: 4),
                  Text(
                    'Rest: ${ex.restSeconds}s • ${ex.equipment}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: TrainingTheme.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ActiveWorkoutSessionScreen extends ConsumerStatefulWidget {
  final WorkoutRoutine routine;
  final String? programmeId;
  final ProgrammeSession? programmeSession;

  const ActiveWorkoutSessionScreen({
    super.key,
    required this.routine,
    this.programmeId,
    this.programmeSession,
  });

  @override
  ConsumerState<ActiveWorkoutSessionScreen> createState() =>
      _ActiveWorkoutSessionScreenState();
}

class _ActiveWorkoutSessionScreenState
    extends ConsumerState<ActiveWorkoutSessionScreen> {
  Timer? _timer;
  int _exerciseIdx = 0;
  int _secondsLeft = 0;
  int _totalElapsed = 0;
  bool _isResting = false;
  bool _isPaused = false;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.routine.exercises.first.durationSeconds;
    _startTicker();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isPaused || _isCompleted || !mounted) return;
      setState(() {
        _totalElapsed += 1;
        if (_secondsLeft > 1) {
          _secondsLeft -= 1;
        } else {
          _advancePhase();
        }
      });
    });
  }

  void _advancePhase() {
    final current = widget.routine.exercises[_exerciseIdx];
    if (!_isResting && _exerciseIdx < widget.routine.exercises.length - 1) {
      _isResting = true;
      _secondsLeft = current.restSeconds;
    } else if (_exerciseIdx < widget.routine.exercises.length - 1) {
      _isResting = false;
      _exerciseIdx += 1;
      _secondsLeft = widget.routine.exercises[_exerciseIdx].durationSeconds;
    } else {
      _finishWorkout();
    }
  }

  void _previousExercise() {
    if (_exerciseIdx == 0 && !_isResting) return;
    setState(() {
      if (_isResting) {
        _isResting = false;
        _secondsLeft = widget.routine.exercises[_exerciseIdx].durationSeconds;
      } else {
        _exerciseIdx -= 1;
        _isResting = false;
        _secondsLeft = widget.routine.exercises[_exerciseIdx].durationSeconds;
      }
    });
  }

  Future<void> _finishWorkout() async {
    _timer?.cancel();
    setState(() => _isCompleted = true);
    final repo = ref.read(workoutRoutinesRepositoryProvider);
    final duration = _totalElapsed > 0 ? _totalElapsed : 60;
    if (widget.programmeId != null && widget.programmeSession != null) {
      await repo.completeProgrammeSession(
        programmeId: widget.programmeId!,
        session: widget.programmeSession!,
        routine: widget.routine,
        elapsedSeconds: duration,
      );
    } else {
      await repo.completeRoutineSession(
        routine: widget.routine,
        elapsedSeconds: duration,
      );
    }
  }

  Future<bool> _confirmSafeExit() async {
    if (_isCompleted) return true;
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TrainingTheme.surface,
        title: const Text(
          'End Session?',
          style: TextStyle(color: TrainingTheme.textPrimary),
        ),
        content: const Text(
          'Your current progress has not been saved yet. Exit without saving?',
          style: TextStyle(color: TrainingTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep Training'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Discard & Exit',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
    return leave == true;
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.routine.exercises[_exerciseIdx];
    final next = _exerciseIdx + 1 < widget.routine.exercises.length
        ? widget.routine.exercises[_exerciseIdx + 1]
        : null;
    final progress =
        (_exerciseIdx + 1) / widget.routine.exercises.length;
    final media = TrainingMediaService.resolveForRoutine(widget.routine);

    return PopScope(
      canPop: _isCompleted,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _confirmSafeExit();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: TrainingTheme.bg,
        appBar: AppBar(
          backgroundColor: TrainingTheme.bg,
          foregroundColor: TrainingTheme.textPrimary,
          elevation: 0,
          title: Text(
            widget.routine.title.toUpperCase(),
            style: TrainingTheme.sectionTitle,
          ),
        ),
        body: _isCompleted
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: TrainingTheme.limeMuted,
                        child: Icon(
                          Icons.check_circle,
                          size: 46,
                          color: TrainingTheme.lime,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Workout Complete!',
                        style: TrainingTheme.displayHero,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Saved ${_totalElapsed > 0 ? _totalElapsed : 60}s session to your training history.',
                        textAlign: TextAlign.center,
                        style: TrainingTheme.metaLabel,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Consistent effort builds lasting resilience. Hydrate and recover well.',
                        textAlign: TextAlign.center,
                        style: TrainingTheme.metaLabel.copyWith(
                          color: TrainingTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: TrainingTheme.lime,
                          foregroundColor: TrainingTheme.onLime,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: TrainingTheme.border,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          TrainingTheme.lime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _isResting
                          ? 'REST INTERVAL'
                          : 'EXERCISE ${_exerciseIdx + 1} OF ${widget.routine.exercises.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: _isResting
                            ? TrainingTheme.recoveryAccent
                            : TrainingTheme.lime,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isResting ? 'Recover & Breathe' : current.name,
                      textAlign: TextAlign.center,
                      style: TrainingTheme.displayHero.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        height: 110,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              media.posterAssetPath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                color: TrainingTheme.surfaceElevated,
                              ),
                            ),
                            Container(
                              color: const Color(0x88101214),
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                media.hasPlayableVideo
                                    ? 'Follow-along clip ready'
                                    : 'Visual Timer Mode • ${current.equipment}',
                                style: const TextStyle(
                                  color: TrainingTheme.textPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TrainingTheme.surface,
                          border: Border.all(
                            color: _isResting
                                ? TrainingTheme.recoveryAccent
                                : TrainingTheme.lime,
                            width: 6,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$_secondsLeft s',
                          style: const TextStyle(
                            color: TrainingTheme.textPrimary,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isResting
                          ? (next != null
                              ? 'Up Next: ${next.name}'
                              : 'Almost done!')
                          : current.instructions,
                      textAlign: TextAlign.center,
                      style: TrainingTheme.metaLabel.copyWith(fontSize: 13.5),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        IconButton.outlined(
                          tooltip: 'Previous Exercise',
                          onPressed: _previousExercise,
                          icon: const Icon(Icons.skip_previous,
                              color: TrainingTheme.textPrimary),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: TrainingTheme.textPrimary,
                              side:
                                  const BorderSide(color: TrainingTheme.border),
                            ),
                            onPressed: () =>
                                setState(() => _isPaused = !_isPaused),
                            icon: Icon(
                                _isPaused ? Icons.play_arrow : Icons.pause),
                            label: Text(_isPaused ? 'Resume' : 'Pause'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: TrainingTheme.textPrimary,
                              side:
                                  const BorderSide(color: TrainingTheme.border),
                            ),
                            onPressed: () => setState(_advancePhase),
                            icon: const Icon(Icons.skip_next),
                            label: const Text('Skip'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TrainingTheme.lime,
                        foregroundColor: TrainingTheme.onLime,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _finishWorkout,
                      child: const Text(
                        'End & Save Workout',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
