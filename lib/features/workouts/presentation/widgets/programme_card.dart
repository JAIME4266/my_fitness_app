import 'package:flutter/material.dart';
import '../../domain/workout_models.dart';
import '../../theme/training_theme.dart';

class ProgrammeCard extends StatelessWidget {
  final TrainingProgramme programme;
  final int completedSessions;
  final bool isEnrolled;
  final VoidCallback onTap;

  const ProgrammeCard({
    super.key,
    required this.programme,
    required this.completedSessions,
    required this.isEnrolled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = programme.allSessions.length;
    final progress = total > 0 ? (completedSessions / total).clamp(0.0, 1.0) : 0.0;

    return SizedBox(
      width: 245,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: TrainingTheme.border),
            color: TrainingTheme.surface,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                programme.coverAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: TrainingTheme.surfaceElevated),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xBB101214),
                      Color(0x66101214),
                      Color(0xEE101214),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            programme.title.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: TrainingTheme.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              height: 1.08,
                            ),
                          ),
                        ),
                        if (isEnrolled)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: TrainingTheme.lime,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'ACTIVE',
                              style: TextStyle(
                                color: TrainingTheme.onLime,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          programme.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: TrainingTheme.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '$total SESSIONS • ${programme.difficulty.toUpperCase()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: TrainingTheme.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isEnrolled
                                  ? '$completedSessions/$total done'
                                  : '${programme.durationWeeks} Weeks',
                              style: TextStyle(
                                color: isEnrolled
                                    ? TrainingTheme.lime
                                    : TrainingTheme.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        if (isEnrolled) ...[
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 4,
                              backgroundColor: TrainingTheme.border,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                TrainingTheme.lime,
                              ),
                            ),
                          ),
                        ],
                      ],
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
