import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../run_tracking/data/run_repository.dart';
import '../data/workout_routines_repository.dart';
import '../domain/workout_models.dart';
import 'workout_detail_and_session_screen.dart';

class WorkoutRoutinesScreen extends ConsumerStatefulWidget {
  const WorkoutRoutinesScreen({super.key});

  @override
  ConsumerState<WorkoutRoutinesScreen> createState() =>
      _WorkoutRoutinesScreenState();
}

class _WorkoutRoutinesScreenState extends ConsumerState<WorkoutRoutinesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Set<String> _favourites = {};
  List<WorkoutRoutine> _customRoutines = [];
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserRoutines();
  }

  Future<void> _loadUserRoutines() async {
    final repo = ref.read(workoutRoutinesRepositoryProvider);
    final favs = await repo.getFavouriteIds();
    final custom = await repo.getCustomRoutines();
    if (mounted) {
      setState(() {
        _favourites = favs;
        _customRoutines = custom;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allRoutines = [...curatedRunnerRoutines, ..._customRoutines];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'WORKOUT ROUTINES',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0F766E),
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: const Color(0xFF0F766E),
          tabs: const [
            Tab(text: 'EXPLORE'),
            Tab(text: 'ROUTINES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExploreTab(allRoutines),
          _buildPersonalRoutinesTab(allRoutines),
        ],
      ),
    );
  }

  Widget _buildExploreTab(List<WorkoutRoutine> allRoutines) {
    final visibleCats =
        _showAll ? workoutCategories : workoutCategories.take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...visibleCats.map((cat) {
          final items =
              allRoutines.where((r) => r.category == cat).toList();
          if (items.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cat,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                      letterSpacing: 0.4)),
              const SizedBox(height: 10),
              SizedBox(
                height: 225,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _buildRoutineCard(items[i]),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0284C7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => setState(() => _showAll = !_showAll),
            child: Text(
              _showAll ? 'SHOW TOP CATEGORIES' : 'EXPLORE ALL ROUTINES',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutineCard(WorkoutRoutine r) {
    final isFav = _favourites.contains(r.id);
    return SizedBox(
      width: 175,
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFE7E5E4)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WorkoutDetailScreen(
                  routine: r,
                  isFavourite: isFav,
                  onToggleFavourite: () async {
                    final next = await ref
                        .read(workoutRoutinesRepositoryProvider)
                        .toggleFavourite(r.id);
                    if (mounted) setState(() => _favourites = next);
                  },
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 92,
                width: double.infinity,
                child: Image.asset(
                  _imageForCategory(r.category),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: r.accentColor.withValues(alpha: 0.14),
                    child: Icon(r.icon, size: 42, color: r.accentColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 13, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text('${r.totalMinutes}:00 • ${r.difficulty}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(r.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 3),
                    Text(r.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalRoutinesTab(List<WorkoutRoutine> allRoutines) {
    final favRoutines =
        allRoutines.where((r) => _favourites.contains(r.id)).toList();
    final historyAsync = ref.watch(recentWorkoutsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Saved & Custom Routines',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextButton.icon(
              onPressed: _showCreateRoutineDialog,
              icon: const Icon(Icons.add),
              label: const Text('Create'),
            ),
          ],
        ),
        if (favRoutines.isEmpty && _customRoutines.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Bookmark any routine or create your own custom routine.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ...{...favRoutines, ..._customRoutines}.map((r) => ListTile(
              leading: Icon(r.icon, color: r.accentColor),
              title: Text(r.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${r.totalMinutes} min • ${r.difficulty}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WorkoutDetailScreen(
                      routine: r,
                      isFavourite: _favourites.contains(r.id),
                      onToggleFavourite: () async {
                        final next = await ref
                            .read(workoutRoutinesRepositoryProvider)
                            .toggleFavourite(r.id);
                        if (mounted) setState(() => _favourites = next);
                      },
                    ),
                  ),
                );
              },
            )),
        const Divider(height: 28),
        const Text('Completed Training History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        historyAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error: $e'),
          data: (list) {
            if (list.isEmpty) {
              return const Text('No completed routines yet.',
                  style: TextStyle(color: Colors.grey, fontSize: 13));
            }
            return Column(
              children: list
                  .map((w) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.check_circle,
                            color: Color(0xFF0F766E)),
                        title: Text(w.type,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            '${w.durationSec}s • ${w.caloriesKcal.round()} kcal'),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showCreateRoutineDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final minsCtrl = TextEditingController(text: '15');
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Custom Routine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Routine Name')),
            TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description')),
            TextField(
                controller: minsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duration (min)')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (titleCtrl.text.trim().isEmpty) return;
              await ref.read(workoutRoutinesRepositoryProvider).saveCustomRoutine(
                    title: titleCtrl.text,
                    category: workoutCategories.first,
                    description: descCtrl.text,
                    difficulty: 'Intermediate',
                    totalMinutes: int.tryParse(minsCtrl.text) ?? 15,
                  );
              await _loadUserRoutines();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  static String _imageForCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('warmup')) {
      return 'assets/images/workouts/warmup.jpg';
    }
    if (lower.contains('recovery')) {
      return 'assets/images/workouts/recovery.jpg';
    }
    return 'assets/images/workouts/strength.jpg';
  }
}
