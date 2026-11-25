import 'package:flutter/material.dart';

class RoutineExercise {
  final String name;
  final String instructions;
  final int durationSeconds;
  final int restSeconds;
  final String? repsLabel;

  const RoutineExercise({
    required this.name,
    required this.instructions,
    required this.durationSeconds,
    this.restSeconds = 15,
    this.repsLabel,
  });
}

class WorkoutRoutine {
  final String id;
  final String title;
  final String category;
  final String description;
  final String difficulty;
  final int totalMinutes;
  final Color accentColor;
  final IconData icon;
  final List<RoutineExercise> exercises;
  final bool isCustom;

  const WorkoutRoutine({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.difficulty,
    required this.totalMinutes,
    required this.accentColor,
    required this.icon,
    required this.exercises,
    this.isCustom = false,
  });
}

const List<String> workoutCategories = [
  'PRE-RUN WARMUP',
  'POST-RUN RECOVERY',
  'RUNNER STRENGTH TRAINING',
  'ENDURANCE TRAINING',
  'FLEXIBILITY & MOBILITY',
];

const List<WorkoutRoutine> curatedRunnerRoutines = [
  // A. Pre-Run Warmup
  WorkoutRoutine(
    id: 'warmup_stride',
    title: 'Prep Your Stride',
    category: 'PRE-RUN WARMUP',
    description: 'Essential active warmups to activate muscles before running.',
    difficulty: 'Beginner',
    totalMinutes: 10,
    accentColor: Color(0xFF0F766E),
    icon: Icons.directions_run,
    exercises: [
      RoutineExercise(
        name: 'Leg Swings (Front & Back)',
        instructions: 'Hold a wall lightly and swing each leg smoothly through a comfortable range.',
        durationSeconds: 45,
        repsLabel: '12 reps / side',
      ),
      RoutineExercise(
        name: 'High Knees March',
        instructions: 'Drive knees to hip height with tall posture and rhythmic arm swing.',
        durationSeconds: 45,
      ),
      RoutineExercise(
        name: 'A-Skips',
        instructions: 'Light, bouncy skips focusing on midfoot landing beneath your center of mass.',
        durationSeconds: 45,
      ),
      RoutineExercise(
        name: 'Ankle Circles & Calf Raises',
        instructions: 'Roll ankles slowly then perform controlled double-leg calf raises.',
        durationSeconds: 45,
        repsLabel: '15 reps',
      ),
    ],
  ),
  WorkoutRoutine(
    id: 'warmup_dynamic',
    title: 'Dynamic Leg Warmup',
    category: 'PRE-RUN WARMUP',
    description: 'Walking lunges, hip openers, and glute activation drills.',
    difficulty: 'Intermediate',
    totalMinutes: 12,
    accentColor: Color(0xFF0284C7),
    icon: Icons.flash_on,
    exercises: [
      RoutineExercise(
        name: 'World’s Greatest Stretch',
        instructions: 'Step into a deep lunge and rotate torso toward the front knee.',
        durationSeconds: 60,
        repsLabel: '6 reps / side',
      ),
      RoutineExercise(
        name: 'Butt Kicks',
        instructions: 'Quickly heel-tap toward glutes while keeping knees pointing down.',
        durationSeconds: 45,
      ),
      RoutineExercise(
        name: 'Lateral Band / Monster Walks',
        instructions: 'Stay in a quarter squat and step side-to-side with controlled tension.',
        durationSeconds: 45,
      ),
    ],
  ),
  // B. Post-Run Recovery
  WorkoutRoutine(
    id: 'recovery_recharge',
    title: 'Recharge & Recover',
    category: 'POST-RUN RECOVERY',
    description: 'Stretches and mobility drills to cool down and ease stiffness.',
    difficulty: 'Beginner',
    totalMinutes: 15,
    accentColor: Color(0xFF0D9488),
    icon: Icons.self_improvement,
    exercises: [
      RoutineExercise(
        name: 'Kneeling Hip Flexor Stretch',
        instructions: 'Tuck pelvis gently and lean forward until you feel a mild front-hip stretch.',
        durationSeconds: 60,
        restSeconds: 10,
      ),
      RoutineExercise(
        name: 'Standing Calf Wall Stretch',
        instructions: 'Keep back heel pressed down with knee straight, then slightly bent.',
        durationSeconds: 60,
        restSeconds: 10,
      ),
      RoutineExercise(
        name: 'Supine Figure-4 Glute Stretch',
        instructions: 'Cross ankle over opposite knee and draw thigh gently toward chest.',
        durationSeconds: 60,
        restSeconds: 10,
      ),
    ],
  ),
  WorkoutRoutine(
    id: 'recovery_full_body',
    title: 'Full Body Stretch',
    category: 'POST-RUN RECOVERY',
    description: 'Gentle post-run decompression for hamstrings, calves, and back.',
    difficulty: 'Beginner',
    totalMinutes: 12,
    accentColor: Color(0xFF059669),
    icon: Icons.spa,
    exercises: [
      RoutineExercise(
        name: 'Seated Hamstring Fold',
        instructions: 'Hinge from hips with a neutral spine; avoid rounding your lower back.',
        durationSeconds: 60,
      ),
      RoutineExercise(
        name: 'Child’s Pose Breathing',
        instructions: 'Sit hips back toward heels and take slow nasal breaths.',
        durationSeconds: 60,
      ),
    ],
  ),
  // C. Runner Strength Training
  WorkoutRoutine(
    id: 'strength_power',
    title: 'Power & Endurance',
    category: 'RUNNER STRENGTH TRAINING',
    description: 'Core and lower-body strength to build resilient running form.',
    difficulty: 'Intermediate',
    totalMinutes: 25,
    accentColor: Color(0xFF1D4ED8),
    icon: Icons.fitness_center,
    exercises: [
      RoutineExercise(
        name: 'Goblet / Bodyweight Squats',
        instructions: 'Lower hips with chest tall and knees tracking over toes.',
        durationSeconds: 50,
        restSeconds: 20,
        repsLabel: '15 reps',
      ),
      RoutineExercise(
        name: 'Single-Leg Glute Bridge',
        instructions: 'Drive through heel to lift hips level without arching lower back.',
        durationSeconds: 50,
        restSeconds: 20,
        repsLabel: '12 reps / side',
      ),
      RoutineExercise(
        name: 'Forearm Plank Hold',
        instructions: 'Brace core and glutes in a straight line from shoulders to heels.',
        durationSeconds: 45,
        restSeconds: 20,
      ),
    ],
  ),
  WorkoutRoutine(
    id: 'strength_single_leg',
    title: 'Single-Leg Stability',
    category: 'RUNNER STRENGTH TRAINING',
    description: 'Balance and unilateral control for efficient stride mechanics.',
    difficulty: 'Advanced',
    totalMinutes: 20,
    accentColor: Color(0xFF4338CA),
    icon: Icons.accessibility_new,
    exercises: [
      RoutineExercise(
        name: 'Split Squats',
        instructions: 'Drop back knee smoothly toward the floor and drive up.',
        durationSeconds: 50,
        restSeconds: 20,
        repsLabel: '10 reps / leg',
      ),
      RoutineExercise(
        name: 'Single-Leg RDL',
        instructions: 'Hinge at the hip while extending the free leg straight behind you.',
        durationSeconds: 50,
        restSeconds: 20,
        repsLabel: '10 reps / leg',
      ),
    ],
  ),
  // D. Endurance Training
  WorkoutRoutine(
    id: 'endurance_aerobic',
    title: 'Running Stamina',
    category: 'ENDURANCE TRAINING',
    description: 'Aerobic conditioning circuits to sustain steady-state pace.',
    difficulty: 'Intermediate',
    totalMinutes: 20,
    accentColor: Color(0xFFD97706),
    icon: Icons.timer,
    exercises: [
      RoutineExercise(
        name: 'Tempo March / Jog Intervals',
        instructions: 'Alternate 60s brisk effort with 30s easy recovery.',
        durationSeconds: 90,
        restSeconds: 20,
      ),
      RoutineExercise(
        name: 'Step-Ups',
        instructions: 'Step onto a sturdy bench or stair with full hip extension at the top.',
        durationSeconds: 60,
        restSeconds: 20,
        repsLabel: '16 reps',
      ),
    ],
  ),
  // E. Flexibility & Mobility
  WorkoutRoutine(
    id: 'mobility_hip_ankle',
    title: 'Hip & Ankle Mobility',
    category: 'FLEXIBILITY & MOBILITY',
    description: 'Unlock dorsiflexion and hip rotation for smoother strides.',
    difficulty: 'Beginner',
    totalMinutes: 15,
    accentColor: Color(0xFF7C3AED),
    icon: Icons.loop,
    exercises: [
      RoutineExercise(
        name: '90/90 Hip Switches',
        instructions: 'Sit with knees at 90 degrees and rotate knees side-to-side smoothly.',
        durationSeconds: 60,
      ),
      RoutineExercise(
        name: 'Knee-to-Wall Ankle Mobilization',
        instructions: 'Drive knee gently over toes while keeping heel planted on the ground.',
        durationSeconds: 50,
        repsLabel: '12 reps / side',
      ),
    ],
  ),
];
