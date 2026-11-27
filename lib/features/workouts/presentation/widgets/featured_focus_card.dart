import 'package:flutter/material.dart';
import '../../domain/workout_models.dart';
import '../../theme/training_theme.dart';

class FeaturedFocusCard extends StatelessWidget {
  final WorkoutRoutine routine;
  final String eyebrow;
  final VoidCallback onStart;
  final VoidCallback onTapCard;

  const FeaturedFocusCard({
    super.key,
    required this.routine,
    this.eyebrow = "TODAY'S FOCUS",
    required this.onStart,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = routine.imageAsset ??
        TrainingTheme.imageAssetForCategory(routine.category);

    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        height: 215,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: TrainingTheme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: TrainingTheme.surfaceElevated,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xEE101214),
                    Color(0xAA101214),
                    Color(0x33101214),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    eyebrow,
                    style: const TextStyle(
                      color: TrainingTheme.lime,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    routine.title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TrainingTheme.displayHero.copyWith(
                      color: TrainingTheme.lime,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${routine.totalMinutes} MIN • ${routine.difficulty.toUpperCase()}',
                    style: const TextStyle(
                      color: TrainingTheme.textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: TrainingTheme.lime,
                      foregroundColor: TrainingTheme.onLime,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 11),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: onStart,
                    icon: const Icon(Icons.play_arrow_rounded, size: 20),
                    label: const Text(
                      'START ROUTINE',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12.5,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
