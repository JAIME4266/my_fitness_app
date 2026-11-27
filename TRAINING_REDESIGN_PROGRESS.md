# Training Section Redesign — Progress Tracker

## Architecture & Audit Summary (Phase 0)
- **Existing Navigation**: `AppShell` in `lib/main.dart` keeps all 5 bottom tabs (`Home`, `Training`, `Start Run`, `Community`, `Challenges`) intact.
- **Database Schema (Drift v5 -> v6)**: Preserved `Workouts` and all existing tables untouched. Added `ProgrammeEnrolments`, `ProgrammeSessionCompletions`, and `ScheduledWorkouts` via additive migration `from < 6` (`lib/database/database.dart`).
- **Media & Storage**: Bundled 5 high-contrast sports photos in `assets/images/workouts/` (`warmup.jpg`, `recovery.jpg`, `strength.jpg`, `endurance.jpg`, `mobility.jpg`). Implemented `TrainingMediaService` (`lib/features/workouts/data/training_media_service.dart`) with honest image/timer fallback and optional Supabase Storage support without inventing URLs.

## Phases
- [x] **Phase 0**: Inspect & Plan + Source photography assets (`endurance.jpg`, `mobility.jpg`)
- [x] **Phase 1**: Drift v6 migration + Design System (`training_theme.dart`) + Training Home (`WorkoutRoutinesScreen`)
- [x] **Phase 2**: Exercise Library & Exercise Detail (`exercise_library_screen.dart`)
- [x] **Phase 3**: Multi-week Programmes & Enrolment (`programmes_screen.dart`)
- [x] **Phase 4**: Upgraded Workout Detail, Active Player & Media Abstraction (`workout_detail_and_session_screen.dart`)
- [x] **Phase 5**: Workout History, Training Analytics & Rule-Based Recommendations (`workout_history_screen.dart`, `training_analytics_screen.dart`, `training_analytics_engine.dart`)
- [x] **Phase 6**: Full QA, Migration Tests (v5 -> v6), Static Analysis (`dart analyze lib test`: 0 issues) & Full Test Suite (`flutter test --no-pub`: 37/37 passed)

## Modified / Created Files
- Modified: `lib/database/database.dart`, `lib/database/database.g.dart`, `lib/features/workouts/domain/workout_models.dart`, `lib/features/workouts/data/workout_routines_repository.dart`, `lib/features/workouts/presentation/workout_routines_screen.dart`, `lib/features/workouts/presentation/workout_detail_and_session_screen.dart`, `test/workout_routines_test.dart`
- Created: `assets/images/workouts/endurance.jpg`, `assets/images/workouts/mobility.jpg`, `lib/features/workouts/theme/training_theme.dart`, `lib/features/workouts/data/training_media_service.dart`, `lib/features/workouts/domain/training_analytics_engine.dart`, `lib/features/workouts/presentation/widgets/training_weekly_calendar.dart`, `lib/features/workouts/presentation/widgets/featured_focus_card.dart`, `lib/features/workouts/presentation/widgets/programme_card.dart`, `lib/features/workouts/presentation/widgets/routine_card.dart`, `lib/features/workouts/presentation/exercise_library_screen.dart`, `lib/features/workouts/presentation/programmes_screen.dart`, `lib/features/workouts/presentation/workout_history_screen.dart`, `lib/features/workouts/presentation/training_analytics_screen.dart`
