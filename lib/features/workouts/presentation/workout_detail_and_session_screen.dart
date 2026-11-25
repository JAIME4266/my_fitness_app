import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/workout_routines_repository.dart';
import '../domain/workout_models.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final WorkoutRoutine routine;
  final bool isFavourite;
  final VoidCallback onToggleFavourite;

  const WorkoutDetailScreen({
    super.key,
    required this.routine,
    required this.isFavourite,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: Text(routine.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: onToggleFavourite,
            icon: Icon(
              isFavourite ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFF0F766E),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ActiveWorkoutSessionScreen(routine: routine),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Workout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  routine.accentColor,
                  routine.accentColor.withValues(alpha: 0.75),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(routine.difficulty,
                          style: const TextStyle(fontSize: 11)),
                      backgroundColor: Colors.white,
                    ),
                    Icon(routine.icon, color: Colors.white, size: 36),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(routine.category,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    Text('${routine.totalMinutes}:00 • ${routine.exercises.length} exercises',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(routine.description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
          const SizedBox(height: 20),
          const Text('Exercises',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 10),
          ...List.generate(routine.exercises.length, (i) {
            final ex = routine.exercises[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE7E5E4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${i + 1}. ${ex.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.5)),
                      ),
                      Text(
                        ex.repsLabel ?? '${ex.durationSeconds}s',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F766E),
                            fontSize: 12.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(ex.instructions,
                      style: TextStyle(
                          fontSize: 12.5, color: Colors.grey.shade700)),
                  const SizedBox(height: 4),
                  Text('Rest: ${ex.restSeconds}s',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade500)),
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
  const ActiveWorkoutSessionScreen({super.key, required this.routine});

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

  Future<void> _finishWorkout() async {
    _timer?.cancel();
    setState(() => _isCompleted = true);
    await ref.read(workoutRoutinesRepositoryProvider).completeRoutineSession(
          routine: widget.routine,
          elapsedSeconds: _totalElapsed > 0 ? _totalElapsed : 60,
        );
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.routine.exercises[_exerciseIdx];
    final next = _exerciseIdx + 1 < widget.routine.exercises.length
        ? widget.routine.exercises[_exerciseIdx + 1]
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: Text(widget.routine.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isCompleted
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle,
                        size: 64, color: Color(0xFF0F766E)),
                    const SizedBox(height: 12),
                    const Text('Workout Complete!',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      'Saved ${_totalElapsed}s session to your training history.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _isResting
                        ? 'REST INTERVAL'
                        : 'EXERCISE ${_exerciseIdx + 1} OF ${widget.routine.exercises.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isResting
                          ? Colors.amber.shade800
                          : const Color(0xFF0F766E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isResting ? 'Recover & Breathe' : current.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: _isResting
                              ? Colors.amber.shade700
                              : const Color(0xFF0F766E),
                          width: 6,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$_secondsLeft s',
                        style: const TextStyle(
                            fontSize: 38, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _isResting
                        ? (next != null ? 'Up Next: ${next.name}' : 'Almost done!')
                        : current.instructions,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              setState(() => _isPaused = !_isPaused),
                          icon: Icon(
                              _isPaused ? Icons.play_arrow : Icons.pause),
                          label: Text(_isPaused ? 'Resume' : 'Pause'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
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
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _finishWorkout,
                    child: const Text('End & Save Workout'),
                  ),
                ],
              ),
            ),
    );
  }
}
