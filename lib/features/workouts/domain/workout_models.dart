import 'package:flutter/material.dart';

class RoutineExercise {
  final String name;
  final String instructions;
  final int durationSeconds;
  final int restSeconds;
  final String? repsLabel;
  final String equipment;
  final String? safetyCue;

  const RoutineExercise({
    required this.name,
    required this.instructions,
    required this.durationSeconds,
    this.restSeconds = 15,
    this.repsLabel,
    this.equipment = 'Bodyweight',
    this.safetyCue,
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
  final String? imageAsset;
  final String equipment;
  final String intensityLabel;
  final String? remoteVideoPath;

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
    this.imageAsset,
    this.equipment = 'Bodyweight',
    this.intensityLabel = 'Moderate Intensity',
    this.remoteVideoPath,
  });
}

class TrainingExerciseItem {
  final String id;
  final String name;
  final String category;
  final String movementPattern;
  final String difficulty;
  final String equipment;
  final String description;
  final List<String> instructions;
  final String safetyCue;
  final String? posterAsset;
  final String? remoteDemoClipPath;
  final List<String> relatedRoutineIds;

  const TrainingExerciseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.movementPattern,
    required this.difficulty,
    required this.equipment,
    required this.description,
    required this.instructions,
    required this.safetyCue,
    this.posterAsset,
    this.remoteDemoClipPath,
    this.relatedRoutineIds = const [],
  });
}

class ProgrammeSession {
  final String id;
  final int weekNumber;
  final int dayOfWeek; // 1 = Mon .. 7 = Sun
  final String title;
  final String routineId;
  final int estimatedMinutes;
  final String focusNote;

  const ProgrammeSession({
    required this.id,
    required this.weekNumber,
    required this.dayOfWeek,
    required this.title,
    required this.routineId,
    required this.estimatedMinutes,
    required this.focusNote,
  });
}

class ProgrammePhase {
  final String id;
  final int phaseNumber;
  final String title;
  final String summary;
  final int startWeek;
  final int endWeek;
  final List<ProgrammeSession> sessions;

  const ProgrammePhase({
    required this.id,
    required this.phaseNumber,
    required this.title,
    required this.summary,
    required this.startWeek,
    required this.endWeek,
    required this.sessions,
  });
}

class TrainingProgramme {
  final String id;
  final String title;
  final String subtitle;
  final String objective;
  final String difficulty;
  final int durationWeeks;
  final String coverAsset;
  final Color accentColor;
  final List<ProgrammePhase> phases;

  const TrainingProgramme({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.objective,
    required this.difficulty,
    required this.durationWeeks,
    required this.coverAsset,
    required this.accentColor,
    required this.phases,
  });

  List<ProgrammeSession> get allSessions =>
      phases.expand((p) => p.sessions).toList();
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

const List<TrainingExerciseItem> curatedExerciseLibrary = [
  TrainingExerciseItem(
    id: 'ex_leg_swings',
    name: 'Leg Swings (Front & Back)',
    category: 'PRE-RUN WARMUP',
    movementPattern: 'Dynamic Hip Flexion / Extension',
    difficulty: 'Beginner',
    equipment: 'Wall or Rail Support',
    description: 'Dynamic sagittal-plane hip opener that primes stride length before running.',
    instructions: [
      'Stand tall beside a wall or fence with light hand support.',
      'Keep your standing leg slightly soft and torso upright.',
      'Swing the working leg smoothly forward and back without arching your lower back.',
      'Build range gradually over 12 controlled swings per side.',
    ],
    safetyCue: 'Avoid kicking aggressively or twisting the lumbar spine at end range.',
    posterAsset: 'assets/images/workouts/warmup.jpg',
    relatedRoutineIds: ['warmup_stride'],
  ),
  TrainingExerciseItem(
    id: 'ex_worlds_greatest',
    name: 'World’s Greatest Stretch',
    category: 'PRE-RUN WARMUP',
    movementPattern: 'Multi-Planar Lunge & Thoracic Rotation',
    difficulty: 'Intermediate',
    equipment: 'Bodyweight / Mat',
    description: 'All-in-one hip flexor, hamstring, groin, and upper-back activation drill.',
    instructions: [
      'Step your right foot outside your right hand into a deep runner lunge.',
      'Keep the back knee lifted and glute lightly engaged.',
      'Rotate your right arm up toward the sky, following your hand with your gaze.',
      'Return hand to floor and briefly rock hips back to lengthen the front hamstring.',
    ],
    safetyCue: 'Move within a comfortable hip depth; place back knee down if tight.',
    posterAsset: 'assets/images/workouts/mobility.jpg',
    relatedRoutineIds: ['warmup_dynamic'],
  ),
  TrainingExerciseItem(
    id: 'ex_goblet_squat',
    name: 'Goblet / Bodyweight Squats',
    category: 'RUNNER STRENGTH TRAINING',
    movementPattern: 'Knee-Dominant Lower Push',
    difficulty: 'Intermediate',
    equipment: 'Bodyweight or Dumbbell / Kettlebell',
    description: 'Builds quad, glute, and trunk strength for hill climbing and late-run resilience.',
    instructions: [
      'Set feet shoulder-width apart with toes turned out 10–15 degrees.',
      'Brace your core and sit hips down and back between your knees.',
      'Keep heels planted and chest tall throughout descent.',
      'Drive through mid-foot to stand tall without locking knees sharply.',
    ],
    safetyCue: 'Keep knees tracking in line with your second and third toes; avoid inward collapse.',
    posterAsset: 'assets/images/workouts/strength.jpg',
    relatedRoutineIds: ['strength_power'],
  ),
  TrainingExerciseItem(
    id: 'ex_single_leg_rdl',
    name: 'Single-Leg RDL',
    category: 'RUNNER STRENGTH TRAINING',
    movementPattern: 'Unilateral Hip Hinge',
    difficulty: 'Advanced',
    equipment: 'Bodyweight or Light Kettlebell',
    description: 'Strengthens hamstrings, glute medius, and ankle stability on one leg.',
    instructions: [
      'Shift weight onto one softly bent leg with hips level.',
      'Hinge at the hip while extending the free leg straight behind you.',
      'Maintain a neutral spine and square pelvis toward the floor.',
      'Squeeze standing glute to return upright with control.',
    ],
    safetyCue: 'Keep hips square—do not let the lifted hip open upward; reduce range if back rounds.',
    posterAsset: 'assets/images/workouts/strength.jpg',
    relatedRoutineIds: ['strength_single_leg'],
  ),
  TrainingExerciseItem(
    id: 'ex_tempo_intervals',
    name: 'Tempo March / Jog Intervals',
    category: 'ENDURANCE TRAINING',
    movementPattern: 'Aerobic Conditioning',
    difficulty: 'Intermediate',
    equipment: 'Bodyweight / Open Space',
    description: 'Alternating controlled effort bursts and easy active recovery to raise aerobic capacity.',
    instructions: [
      'Begin with a rhythmic fast march or easy jog for 60 seconds.',
      'Focus on upright posture and relaxed shoulders.',
      'Transition smoothly to 30 seconds of easy walking recovery.',
    ],
    safetyCue: 'Keep effort conversational-to-moderate; prioritize cadence over speed.',
    posterAsset: 'assets/images/workouts/endurance.jpg',
    relatedRoutineIds: ['endurance_aerobic'],
  ),
  TrainingExerciseItem(
    id: 'ex_hip_flexor_stretch',
    name: 'Kneeling Hip Flexor Stretch',
    category: 'POST-RUN RECOVERY',
    movementPattern: 'Anterior Hip Decompression',
    difficulty: 'Beginner',
    equipment: 'Exercise Mat',
    description: 'Releases tight hip flexors after running or long hours of sitting.',
    instructions: [
      'Kneel in a half-kneeling stance on a mat with back toes tucked.',
      'Gently tuck your tailbone under (posterior pelvic tilt) and squeeze the back glute.',
      'Shift forward just 1–2 inches until you feel a mild stretch in the front hip.',
      'Hold while taking slow, steady nasal breaths.',
    ],
    safetyCue: 'Do not hyperextend the lower back to force a deeper lean.',
    posterAsset: 'assets/images/workouts/recovery.jpg',
    relatedRoutineIds: ['recovery_recharge'],
  ),
  TrainingExerciseItem(
    id: 'ex_90_90_hip',
    name: '90/90 Hip Switches',
    category: 'FLEXIBILITY & MOBILITY',
    movementPattern: 'Internal & External Hip Rotation',
    difficulty: 'Beginner',
    equipment: 'Exercise Mat',
    description: 'Improves hip capsule mobility and rotational control for smoother running stride.',
    instructions: [
      'Sit tall on a mat with both knees bent at 90 degrees—one in front, one out to the side.',
      'Keep heels planted and smoothly rotate knees up and across to the opposite side.',
      'Use hands lightly behind you for balance if needed.',
    ],
    safetyCue: 'Move slowly without forcing knees down if you feel groin or knee pinching.',
    posterAsset: 'assets/images/workouts/mobility.jpg',
    relatedRoutineIds: ['mobility_hip_ankle'],
  ),
];

const List<TrainingProgramme> curatedTrainingProgrammes = [
  TrainingProgramme(
    id: 'prog_runner_strength',
    title: 'Runner Strength Foundation',
    subtitle: 'Phase 1: Power, Force & Single-Leg Resilience',
    objective: 'Build lower-body strength and tendon resilience to run stronger with lower fatigue.',
    difficulty: 'Intermediate',
    durationWeeks: 6,
    coverAsset: 'assets/images/workouts/strength.jpg',
    accentColor: Color(0xFF818CF8),
    phases: [
      ProgrammePhase(
        id: 'phase_rs_1',
        phaseNumber: 1,
        title: 'Phase 1: Neuromuscular Base',
        summary: 'Weeks 1–2 focus on activation, hip stability, and clean squat/hinge mechanics.',
        startWeek: 1,
        endWeek: 2,
        sessions: [
          ProgrammeSession(
            id: 'rs_w1_d1',
            weekNumber: 1,
            dayOfWeek: 1,
            title: 'Dynamic Stride Prep',
            routineId: 'warmup_stride',
            estimatedMinutes: 10,
            focusNote: 'Prime hips and ankles before base miles.',
          ),
          ProgrammeSession(
            id: 'rs_w1_d3',
            weekNumber: 1,
            dayOfWeek: 3,
            title: 'Power & Endurance Base',
            routineId: 'strength_power',
            estimatedMinutes: 25,
            focusNote: 'Foundational squat, glute bridge, and trunk bracing.',
          ),
          ProgrammeSession(
            id: 'rs_w1_d5',
            weekNumber: 1,
            dayOfWeek: 5,
            title: 'Post-Run Recharge',
            routineId: 'recovery_recharge',
            estimatedMinutes: 15,
            focusNote: 'Restore hip flexors and calves after mid-week volume.',
          ),
        ],
      ),
      ProgrammePhase(
        id: 'phase_rs_2',
        phaseNumber: 2,
        title: 'Phase 2: Unilateral Force',
        summary: 'Weeks 3–6 introduce single-leg control and aerobic power integration.',
        startWeek: 3,
        endWeek: 6,
        sessions: [
          ProgrammeSession(
            id: 'rs_w3_d2',
            weekNumber: 3,
            dayOfWeek: 2,
            title: 'Single-Leg Stability',
            routineId: 'strength_single_leg',
            estimatedMinutes: 20,
            focusNote: 'Split squats & single-leg RDL for pelvic control.',
          ),
          ProgrammeSession(
            id: 'rs_w3_d4',
            weekNumber: 3,
            dayOfWeek: 4,
            title: 'Hip & Ankle Unlock',
            routineId: 'mobility_hip_ankle',
            estimatedMinutes: 15,
            focusNote: 'Maintain ankle dorsiflexion under higher load.',
          ),
        ],
      ),
    ],
  ),
  TrainingProgramme(
    id: 'prog_endurance_base',
    title: 'Endurance Base Builder',
    subtitle: 'Aerobic Engine & Cadence Consistency',
    objective: 'Develop steady-state stamina while pairing recovery drills on easy days.',
    difficulty: 'Intermediate',
    durationWeeks: 4,
    coverAsset: 'assets/images/workouts/endurance.jpg',
    accentColor: Color(0xFF38BDF8),
    phases: [
      ProgrammePhase(
        id: 'phase_eb_1',
        phaseNumber: 1,
        title: 'Phase 1: Aerobic Rhythm',
        summary: 'Controlled interval circuits paired with dynamic leg prep.',
        startWeek: 1,
        endWeek: 4,
        sessions: [
          ProgrammeSession(
            id: 'eb_w1_d1',
            weekNumber: 1,
            dayOfWeek: 1,
            title: 'Dynamic Leg Warmup',
            routineId: 'warmup_dynamic',
            estimatedMinutes: 12,
            focusNote: 'Activate glutes before aerobic circuits.',
          ),
          ProgrammeSession(
            id: 'eb_w1_d3',
            weekNumber: 1,
            dayOfWeek: 3,
            title: 'Running Stamina Circuit',
            routineId: 'endurance_aerobic',
            estimatedMinutes: 20,
            focusNote: 'Steady tempo intervals and step-ups.',
          ),
          ProgrammeSession(
            id: 'eb_w1_d6',
            weekNumber: 1,
            dayOfWeek: 6,
            title: 'Full Body Decompression',
            routineId: 'recovery_full_body',
            estimatedMinutes: 12,
            focusNote: 'Cool down hamstrings and lower back.',
          ),
        ],
      ),
    ],
  ),
  TrainingProgramme(
    id: 'prog_mobility_resilience',
    title: 'Mobility & Joint Resilience',
    subtitle: 'Daily Stride Longevity Plan',
    objective: 'Keep hips, calves, and thoracic spine supple across training blocks.',
    difficulty: 'Beginner',
    durationWeeks: 3,
    coverAsset: 'assets/images/workouts/mobility.jpg',
    accentColor: Color(0xFF34D399),
    phases: [
      ProgrammePhase(
        id: 'phase_mr_1',
        phaseNumber: 1,
        title: 'Phase 1: Joint Space & Recovery',
        summary: 'Low-impact mobility and parasympathetic recovery routines.',
        startWeek: 1,
        endWeek: 3,
        sessions: [
          ProgrammeSession(
            id: 'mr_w1_d1',
            weekNumber: 1,
            dayOfWeek: 1,
            title: 'Hip & Ankle Mobility',
            routineId: 'mobility_hip_ankle',
            estimatedMinutes: 15,
            focusNote: '90/90 switches & ankle dorsiflexion work.',
          ),
          ProgrammeSession(
            id: 'mr_w1_d4',
            weekNumber: 1,
            dayOfWeek: 4,
            title: 'Recharge & Recover',
            routineId: 'recovery_recharge',
            estimatedMinutes: 15,
            focusNote: 'Gentle hip flexor, calf, and glute release.',
          ),
        ],
      ),
    ],
  ),
];
