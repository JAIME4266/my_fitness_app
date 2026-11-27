import '../../../core/config/supabase_config.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';

enum TrainingMediaAvailability {
  imageOnly,
  bundledVideo,
  remoteStorageVideo,
}

class TrainingMediaResolution {
  final TrainingMediaAvailability availability;
  final String posterAssetPath;
  final String? videoPathOrUrl;
  final String statusNote;

  const TrainingMediaResolution({
    required this.availability,
    required this.posterAssetPath,
    this.videoPathOrUrl,
    required this.statusNote,
  });

  bool get hasPlayableVideo =>
      availability != TrainingMediaAvailability.imageOnly &&
      videoPathOrUrl != null &&
      videoPathOrUrl!.isNotEmpty;
}

/// Resolves exercise demonstration and follow-along workout media cleanly
/// without inventing external URLs or pretending unconfigured buckets work.
class TrainingMediaService {
  static TrainingMediaResolution resolveForRoutine(WorkoutRoutine routine) {
    final poster = routine.imageAsset ??
        TrainingTheme.imageAssetForCategory(routine.category);

    // No bundled .mp4 or configured Supabase training-videos bucket yet;
    // return an honest, responsive visual guidance fallback.
    if (SupabaseConfig.isConfigured && routine.remoteVideoPath != null) {
      return TrainingMediaResolution(
        availability: TrainingMediaAvailability.remoteStorageVideo,
        posterAssetPath: poster,
        videoPathOrUrl:
            '${SupabaseConfig.url}/storage/v1/object/public/training-videos/${routine.remoteVideoPath}',
        statusNote: 'Follow-along video available via configured Supabase Storage.',
      );
    }

    return TrainingMediaResolution(
      availability: TrainingMediaAvailability.imageOnly,
      posterAssetPath: poster,
      statusNote:
          'Guided visual & timer mode active. Add bundled .mp4 clips or a public Supabase "training-videos" bucket to enable video playback.',
    );
  }

  static TrainingMediaResolution resolveForExercise(
      TrainingExerciseItem exercise) {
    final poster =
        exercise.posterAsset ?? TrainingTheme.imageAssetForCategory(exercise.category);
    if (SupabaseConfig.isConfigured && exercise.remoteDemoClipPath != null) {
      return TrainingMediaResolution(
        availability: TrainingMediaAvailability.remoteStorageVideo,
        posterAssetPath: poster,
        videoPathOrUrl:
            '${SupabaseConfig.url}/storage/v1/object/public/training-videos/${exercise.remoteDemoClipPath}',
        statusNote: 'Exercise demo clip ready via Supabase Storage.',
      );
    }
    return TrainingMediaResolution(
      availability: TrainingMediaAvailability.imageOnly,
      posterAssetPath: poster,
      statusNote:
          'Technique cues & form guide active (no demo video file bundled yet).',
    );
  }
}
