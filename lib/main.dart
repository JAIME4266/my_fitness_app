import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database/database.dart';
import 'database/fitness_repository.dart';
import 'health_service.dart';

void main() {
  runApp(const ProviderScope(child: MyFitnessApp()));
}

class MyFitnessApp extends StatelessWidget {
  const MyFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          primary: const Color(0xFF0F766E),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Targets & Baselines
  final int targetCalories = 2200;
  final int consumedCalories = 1450;
  int burnedCalories = 0;
  int currentSteps = 0;
  bool isSyncing = false;
  String? lastSyncTime;
  bool isLoadedFromDb = false;

  // Macros Targets (in grams)
  final double targetProtein = 140.0;
  final double currentProtein = 95.0;

  final double targetCarbs = 220.0;
  final double currentCarbs = 150.0;

  final double targetFats = 60.0;
  final double currentFats = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCachedTodayData();
    });
  }

  Future<void> _loadCachedTodayData() async {
    try {
      final repository = ref.read(fitnessRepositoryProvider);
      final cached = await repository.getTodaySummary();
      if (cached != null && mounted) {
        setState(() {
          currentSteps = cached.steps;
          burnedCalories = cached.activeCalories;
          if (cached.lastSync != null) {
            final t = cached.lastSync!;
            lastSyncTime = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
          }
          isLoadedFromDb = true;
        });
      }
    } catch (e) {
      debugPrint('[Dashboard] Error loading cached summary: $e');
    }
  }

  Future<void> _syncHealthData() async {
    setState(() => isSyncing = true);

    bool authorized = await HealthService.requestPermissions();
    if (authorized) {
      final healthData = await HealthService.syncToday();
      final steps = healthData['steps'] ?? 0;
      final calories = healthData['caloriesBurned'] ?? 0;

      final now = DateTime.now();
      final formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      // Persist to Drift SQLite
      try {
        final repository = ref.read(fitnessRepositoryProvider);
        await repository.saveDailySync(
          steps: steps,
          activeCalories: calories,
          consumedCalories: consumedCalories,
          targetCalories: targetCalories,
        );
      } catch (e) {
        debugPrint('[Dashboard] Error persisting to SQLite: $e');
      }

      if (mounted) {
        setState(() {
          currentSteps = steps;
          burnedCalories = calories;
          lastSyncTime = formattedTime;
          isLoadedFromDb = true;
          isSyncing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF0F766E),
            content: Text('Watch data synced & saved: $steps steps, $calories kcal burned!'),
          ),
        );
      }
    } else {
      if (mounted) {
        setState(() => isSyncing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Health Connect permissions not granted.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int remainingCalories = targetCalories - consumedCalories + burnedCalories;
    final repository = ref.watch(fitnessRepositoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Fitness & Nutrition Pro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isLoadedFromDb ? const Color(0xFFE6F4EA) : const Color(0xFFF1F3F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.storage, size: 14, color: isLoadedFromDb ? const Color(0xFF137333) : Colors.grey),
                const SizedBox(width: 4),
                Text(
                  isLoadedFromDb ? 'SQLite Cached' : 'Live Mode',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isLoadedFromDb ? const Color(0xFF137333) : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smartwatch & SQLite Sync Card
            Card(
              elevation: 0,
              color: const Color(0xFFE6F2F0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.watch, color: Color(0xFF0F766E), size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Redmi Watch / Wearable Sync', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(
                            'Burned: $burnedCalories kcal  •  Steps: $currentSteps',
                            style: TextStyle(color: Colors.grey[800], fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          if (lastSyncTime != null)
                            Text(
                              'Synced at $lastSyncTime (Saved to DB)',
                              style: const TextStyle(color: Color(0xFF0F766E), fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isSyncing ? null : _syncHealthData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F766E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: isSyncing
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Sync'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Calories Main Bracket Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('Calories Remaining', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                      '$remainingCalories',
                      style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Color(0xFF0F766E)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCalorieStat('Target', '$targetCalories', Colors.black87),
                        _buildCalorieStat('Food', '$consumedCalories', Colors.orange.shade800),
                        _buildCalorieStat('Burned', '+$burnedCalories', const Color(0xFF0F766E)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text('Macros Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Macros Brackets
            _buildMacroBracket('Protein', currentProtein, targetProtein, Colors.blue, 'g'),
            const SizedBox(height: 12),
            _buildMacroBracket('Carbs', currentCarbs, targetCarbs, Colors.amber.shade700, 'g'),
            const SizedBox(height: 12),
            _buildMacroBracket('Fats', currentFats, targetFats, Colors.redAccent, 'g'),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('7-Day Activity History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Drift SQLite', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 12),

            // Drift Stream of Historical Summaries
            StreamBuilder<List<DailySummary>>(
              stream: repository.watchRecentSummaries(limit: 7),
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                if (list.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE7E5E4)),
                    ),
                    child: Center(
                      child: Text(
                        'No historical summaries yet.\nTap "Sync" above to save today’s steps into SQLite!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ),
                  );
                }

                return Column(
                  children: list.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Color(0xFF0F766E)),
                              const SizedBox(width: 8),
                              Text(item.date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${item.steps} steps', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                              const SizedBox(width: 12),
                              Text('+${item.activeCalories} kcal', style: const TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMacroBracket(String title, double current, double target, Color progressColor, String unit) {
    double progress = (current / target).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Text('${current.toInt()} / ${target.toInt()} $unit', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }
}
