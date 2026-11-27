import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/training_media_service.dart';
import '../data/workout_routines_repository.dart';
import '../domain/workout_models.dart';
import '../theme/training_theme.dart';
import 'workout_detail_and_session_screen.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  String _query = '';
  String _selectedCategory = 'ALL';

  @override
  Widget build(BuildContext context) {
    final categories = ['ALL', ...workoutCategories];
    final filtered = curatedExerciseLibrary.where((ex) {
      final matchesCat =
          _selectedCategory == 'ALL' || ex.category == _selectedCategory;
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          ex.name.toLowerCase().contains(q) ||
          ex.movementPattern.toLowerCase().contains(q) ||
          ex.equipment.toLowerCase().contains(q);
      return matchesCat && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: const Text('EXERCISE LIBRARY', style: TrainingTheme.sectionTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: TextField(
              style: const TextStyle(color: TrainingTheme.textPrimary),
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search exercises, movement, equipment...',
                hintStyle: const TextStyle(color: TrainingTheme.textMuted),
                prefixIcon: const Icon(Icons.search,
                    color: TrainingTheme.textSecondary),
                filled: true,
                fillColor: TrainingTheme.surface,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: TrainingTheme.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: TrainingTheme.border),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = categories[i];
                final selected = cat == _selectedCategory;
                final label = cat == 'ALL'
                    ? 'ALL'
                    : TrainingTheme.shortBadgeForCategory(cat);
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: TrainingTheme.lime,
                  backgroundColor: TrainingTheme.surface,
                  side: BorderSide(
                    color: selected ? TrainingTheme.lime : TrainingTheme.border,
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? TrainingTheme.onLime
                        : TrainingTheme.textSecondary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      'No exercises match your filter.',
                      style: TextStyle(color: TrainingTheme.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final ex = filtered[i];
                      final accent =
                          TrainingTheme.accentForCategory(ex.category);
                      final poster = ex.posterAsset ??
                          TrainingTheme.imageAssetForCategory(ex.category);
                      return Material(
                        color: TrainingTheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: TrainingTheme.border),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ExerciseDetailScreen(exercise: ex),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 96,
                                child: Image.asset(
                                  poster,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    color: TrainingTheme.surfaceElevated,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ex.movementPattern.toUpperCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: accent,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ex.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TrainingTheme.cardTitle
                                            .copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${ex.difficulty} • ${ex.equipment}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TrainingTheme.metaLabel,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: TrainingTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ExerciseDetailScreen extends ConsumerWidget {
  final TrainingExerciseItem exercise;
  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final media = TrainingMediaService.resolveForExercise(exercise);
    final accent = TrainingTheme.accentForCategory(exercise.category);
    final relatedRoutines = curatedRunnerRoutines
        .where((r) => exercise.relatedRoutineIds.contains(r.id))
        .toList();

    return Scaffold(
      backgroundColor: TrainingTheme.bg,
      appBar: AppBar(
        backgroundColor: TrainingTheme.bg,
        foregroundColor: TrainingTheme.textPrimary,
        elevation: 0,
        title: Text(
          exercise.name.toUpperCase(),
          style: TrainingTheme.sectionTitle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: 200,
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
                        colors: [Colors.transparent, Color(0xDD101214)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            exercise.difficulty.toUpperCase(),
                            style: const TextStyle(
                              color: TrainingTheme.onLime,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          exercise.name,
                          style: TrainingTheme.displayHero.copyWith(fontSize: 22),
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
                      ? Icons.play_circle_outline
                      : Icons.info_outline,
                  color: TrainingTheme.lime,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    media.statusNote,
                    style: TrainingTheme.metaLabel,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            exercise.description,
            style: const TextStyle(
              color: TrainingTheme.textPrimary,
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _metaPill(Icons.fitness_center, exercise.equipment),
              _metaPill(Icons.category_outlined, exercise.movementPattern),
            ],
          ),
          const SizedBox(height: 20),
          const Text('STEP-BY-STEP FORM', style: TrainingTheme.sectionTitle),
          const SizedBox(height: 10),
          ...List.generate(exercise.instructions.length, (i) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: TrainingTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: TrainingTheme.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: TrainingTheme.limeMuted,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: TrainingTheme.lime,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      exercise.instructions[i],
                      style: const TextStyle(
                        color: TrainingTheme.textPrimary,
                        fontSize: 13.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0x22FB923C),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: TrainingTheme.recoveryAccent.withValues(alpha: 0.45),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.health_and_safety_outlined,
                  color: TrainingTheme.recoveryAccent,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TECHNIQUE & SAFETY CUE',
                        style: TextStyle(
                          color: TrainingTheme.recoveryAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exercise.safetyCue,
                        style: const TextStyle(
                          color: TrainingTheme.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (relatedRoutines.isNotEmpty) ...[
            const SizedBox(height: 22),
            const Text('USED IN ROUTINES', style: TrainingTheme.sectionTitle),
            const SizedBox(height: 10),
            ...relatedRoutines.map((r) => Card(
                  color: TrainingTheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: TrainingTheme.border),
                  ),
                  child: ListTile(
                    title: Text(r.title, style: TrainingTheme.cardTitle),
                    subtitle: Text(
                      '${r.totalMinutes} Min • ${r.difficulty}',
                      style: TrainingTheme.metaLabel,
                    ),
                    trailing: const Icon(Icons.arrow_forward,
                        color: TrainingTheme.lime),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkoutDetailScreen(
                            routine: r,
                            isFavourite: false,
                            onToggleFavourite: () async {
                              await ref
                                  .read(workoutRoutinesRepositoryProvider)
                                  .toggleFavourite(r.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _metaPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: TrainingTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TrainingTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: TrainingTheme.lime),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: TrainingTheme.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
