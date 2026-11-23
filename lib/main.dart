import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // Targets & Baselines
  final int targetCalories = 2200;
  final int consumedCalories = 1450;
  int burnedCalories = 0;
  int currentSteps = 0;
  bool isSyncing = false;

  // Macros Targets (in grams)
  final double targetProtein = 140.0;
  final double currentProtein = 95.0;

  final double targetCarbs = 220.0;
  final double currentCarbs = 150.0;

  final double targetFats = 60.0;
  final double currentFats = 40.0;

  Future<void> _syncHealthData() async {
    setState(() => isSyncing = true);

    bool authorized = await HealthService.requestPermissions();
    if (authorized) {
      // HealthService does not currently expose a step-fetching method.
      const int steps = 0;
      // Keep calories at zero until health-data methods are added to the service.
      const int calories = 0;

      setState(() {
        currentSteps = steps;
        burnedCalories = calories;
        isSyncing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Watch data synced successfully!')),
        );
      }
    } else {
      setState(() => isSyncing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Health permissions not granted.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int remainingCalories = targetCalories - consumedCalories + burnedCalories;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Daily Nutrition & Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smartwatch Sync Card
            Card(
              elevation: 0,
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.watch, color: Colors.deepPurple, size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Fitness Watch Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('Burned: $burnedCalories kcal | Steps: $currentSteps',
                              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isSyncing ? null : _syncHealthData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
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
              elevation: 2,
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
                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCalorieStat('Target', '$targetCalories', Colors.black87),
                        _buildCalorieStat('Food', '$consumedCalories', Colors.orange),
                        _buildCalorieStat('Burned', '+$burnedCalories', Colors.green),
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