import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../database/database.dart';
import '../../../database/fitness_repository.dart';
import '../../run_tracking/data/run_repository.dart';
import '../domain/workout_models.dart';

final workoutRoutinesRepositoryProvider =
    Provider<WorkoutRoutinesRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return WorkoutRoutinesRepository(db);
});

class WorkoutRoutinesRepository {
  static const _favKey = 'workout_favourite_ids_v1';
  static const _customKey = 'workout_custom_routines_v1';

  final AppDatabase db;
  WorkoutRoutinesRepository(this.db);

  Future<Set<String>> getFavouriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_favKey) ?? const []).toSet();
  }

  Future<Set<String>> toggleFavourite(String routineId) async {
    final prefs = await SharedPreferences.getInstance();
    final set = (prefs.getStringList(_favKey) ?? const []).toSet();
    if (set.contains(routineId)) {
      set.remove(routineId);
    } else {
      set.add(routineId);
    }
    await prefs.setStringList(_favKey, set.toList());
    return set;
  }

  Future<List<WorkoutRoutine>> getCustomRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_customKey) ?? const [];
    return raw.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return WorkoutRoutine(
        id: map['id'] as String,
        title: map['title'] as String,
        category: map['category'] as String,
        description: map['description'] as String,
        difficulty: map['difficulty'] as String,
        totalMinutes: map['totalMinutes'] as int,
        accentColor: const Color(0xFF0F766E),
        icon: Icons.fitness_center,
        isCustom: true,
        exercises: [
          RoutineExercise(
            name: map['title'] as String,
            instructions: map['description'] as String,
            durationSeconds: (map['totalMinutes'] as int) * 60,
          ),
        ],
      );
    }).toList();
  }

  Future<void> saveCustomRoutine({
    required String title,
    required String category,
    required String description,
    required String difficulty,
    required int totalMinutes,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final list = List<String>.from(prefs.getStringList(_customKey) ?? const []);
    final id = 'custom_${DateTime.now().microsecondsSinceEpoch}';
    list.add(jsonEncode({
      'id': id,
      'title': title.trim(),
      'category': category,
      'description': description.trim(),
      'difficulty': difficulty,
      'totalMinutes': totalMinutes,
    }));
    await prefs.setStringList(_customKey, list);
  }

  Future<void> completeRoutineSession({
    required WorkoutRoutine routine,
    required int elapsedSeconds,
  }) async {
    final runRepo = RunRepository(db);
    await runRepo.saveCompletedRun(
      sportType: 'Routine: ${routine.title}',
      startEpochMs: DateTime.now().millisecondsSinceEpoch,
      durationSec: elapsedSeconds,
      distanceM: 0.0,
      caloriesKcal: (elapsedSeconds / 60.0) * 5.0,
      points: const [],
    );
  }
}
