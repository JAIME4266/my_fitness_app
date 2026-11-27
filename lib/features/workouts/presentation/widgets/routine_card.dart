import 'package:flutter/material.dart';
import '../../domain/workout_models.dart';
import '../../theme/training_theme.dart';

class RoutineCard extends StatelessWidget {
  final WorkoutRoutine routine;
  final bool isFavourite;
  final VoidCallback onTap;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.isFavourite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = TrainingTheme.accentForCategory(routine.category);
    final badgeLabel = TrainingTheme.shortBadgeForCategory(routine.category);
    final imagePath = routine.imageAsset ??
        TrainingTheme.imageAssetForCategory(routine.category);

    return SizedBox(
      width: 190,
      child: Material(
        color: TrainingTheme.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: TrainingTheme.border),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 102,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: TrainingTheme.surfaceElevated,
                        child: Icon(routine.icon,
                            size: 36, color: badgeColor),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeLabel,
                          style: const TextStyle(
                            color: TrainingTheme.onLime,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    if (isFavourite)
                      const Positioned(
                        top: 8,
                        left: 8,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xCC101214),
                          child: Icon(
                            Icons.bookmark,
                            size: 14,
                            color: TrainingTheme.lime,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routine.title.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: TrainingTheme.textPrimary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${routine.totalMinutes} Min • ${routine.difficulty}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: TrainingTheme.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
