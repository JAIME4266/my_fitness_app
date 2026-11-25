import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../data/nutrition_repository.dart';
import 'ai_food_scanner_screen.dart';
import 'barcode_scanner_screen.dart';
import 'log_meal_bottom_sheet.dart';
import 'metabolic_calculator_sheet.dart';

class NutritionScreen extends ConsumerStatefulWidget {
  const NutritionScreen({super.key});

  @override
  ConsumerState<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends ConsumerState<NutritionScreen> {
  bool _chartShowYield = false;

  static const _ifctHighlights = [
    ('Masoor Dal', 24.35, 2.73),
    ('Moong Dal', 23.88, 3.20),
    ('Soya Chunks', 52.00, 2.40),
    ('Low-Fat Paneer', 18.50, 1.00),
    ('Wheat Roti', 10.57, 1.24),
    ('White Rice', 7.94, 2.98),
  ];

  @override
  Widget build(BuildContext context) {
    final totalsAsync = ref.watch(todayNutritionTotalsProvider);
    final profileAsync = ref.watch(metabolicProfileStreamProvider);
    final repo = ref.watch(nutritionRepositoryProvider);

    final profile = profileAsync.valueOrNull;
    final calorieTarget = profile?.dailyCalorieGoal ?? 2200;
    final proteinTarget = profile?.proteinTargetG ?? 130.0;
    final carbsTarget = profile?.carbsTargetG ?? 230.0;
    final fatTarget = profile?.fatTargetG ?? 65.0;
    final fibreTarget = profile?.fibreTargetG ?? 30.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'Nutrition & IFCT Lab',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'AI Food Scanner',
            icon: const Icon(Icons.document_scanner_outlined,
                color: Color(0xFF0F766E)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AiFoodScannerScreen()),
              );
            },
          ),
          IconButton(
            tooltip: 'Barcode Scanner',
            icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF0F766E)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BarcodeScannerScreen(repository: repo),
                ),
              );
            },
          ),
          TextButton.icon(
            onPressed: () => showMetabolicCalculatorSheet(context),
            icon: const Icon(Icons.calculate_outlined, size: 18),
            label: const Text('BMR / TDEE'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showLogMealBottomSheet(context),
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Log Food'),
      ),
      body: totalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Failed to load meals: $err')),
        data: (totals) {
          final consumed = totals.totalKcal.round();
          final remaining = calorieTarget - consumed;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Daily Intake Summary Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE7E5E4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today’s Intake',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$consumed / $calorieTarget kcal',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F766E),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: remaining >= 0
                                  ? const Color(0xFFE6F2F0)
                                  : const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              remaining >= 0
                                  ? '$remaining left'
                                  : '${remaining.abs()} over',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: remaining >= 0
                                    ? const Color(0xFF0F766E)
                                    : Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _macroBar('Protein', totals.proteinG, proteinTarget,
                          Colors.blue),
                      const SizedBox(height: 8),
                      _macroBar('Carbs', totals.carbsG, carbsTarget,
                          Colors.amber.shade700),
                      const SizedBox(height: 8),
                      _macroBar(
                          'Fats', totals.fatG, fatTarget, Colors.redAccent),
                      const SizedBox(height: 8),
                      _macroBar(
                          'Fibre', totals.fibreG, fibreTarget, Colors.green),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Meal Diary Grouped by Category
                const Text(
                  'Today’s Food Diary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),

                ...NutritionRepository.mealCategories.map((slot) {
                  final slotMeals = totals.mealsByCategory[slot] ?? [];
                  final slotKcal = (totals.kcalByCategory[slot] ?? 0).round();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFE7E5E4)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              slot,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              '$slotKcal kcal • ${slotMeals.length} item${slotMeals.length == 1 ? '' : 's'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Color(0xFF0F766E)),
                              tooltip: 'Add to $slot',
                              onPressed: () => showLogMealBottomSheet(
                                context,
                                initialMealType: slot,
                              ),
                            ),
                          ),
                          if (slotMeals.isNotEmpty) const Divider(height: 1),
                          ...slotMeals.map(
                            (meal) => _MealLogTile(
                              meal: meal,
                              onTap: () => showLogMealBottomSheet(
                                context,
                                editingMeal: meal,
                              ),
                              onDelete: () => repo.deleteMealLog(meal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 14),

                // IFCT 2017 Protein vs Yield Comparison Chart
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE7E5E4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'IFCT 2017 Protein vs Yield Trap',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SegmentedButton<bool>(
                            segments: const [
                              ButtonSegment(
                                  value: false,
                                  label: Text('Protein',
                                      style: TextStyle(fontSize: 11))),
                              ButtonSegment(
                                  value: true,
                                  label: Text('Yield ×',
                                      style: TextStyle(fontSize: 11))),
                            ],
                            selected: {_chartShowYield},
                            onSelectionChanged: (s) =>
                                setState(() => _chartShowYield = s.first),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 185,
                        child: BarChart(
                          BarChartData(
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (val, _) {
                                    final idx = val.toInt();
                                    if (idx < 0 ||
                                        idx >= _ifctHighlights.length) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        _ifctHighlights[idx].$1.split(' ').first,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            barGroups: List.generate(
                              _ifctHighlights.length,
                              (i) {
                                final item = _ifctHighlights[i];
                                final y = _chartShowYield ? item.$3 : item.$2;
                                return BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: y,
                                      width: 18,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(6)),
                                      color: _chartShowYield
                                          ? Colors.amber.shade700
                                          : const Color(0xFF0F766E),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _macroBar(String label, double current, double target, Color color) {
    final safeTarget = target > 0 ? target : 1.0;
    final progress = (current / safeTarget).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
            Text(
              '${current.toStringAsFixed(1)} / ${target.toStringAsFixed(0)} g',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MealLogTile extends StatelessWidget {
  final MealLog meal;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _MealLogTile({
    required this.meal,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final oilNote = meal.extraOilTsp > 0
        ? ' + ${meal.extraOilTsp.toStringAsFixed(1)} tsp oil'
        : '';
    return ListTile(
      dense: true,
      onTap: onTap,
      title: Text(
        meal.foodName,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
      ),
      subtitle: Text(
        '${meal.cookedWeightG.round()}g cooked (${meal.rawEquivalentG.round()}g raw)$oilNote • P ${meal.proteinG.toStringAsFixed(1)}g',
        style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${meal.calculatedKcal.round()} kcal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F766E),
              fontSize: 13,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                size: 18, color: Colors.redAccent),
            onPressed: onDelete,
            tooltip: 'Remove entry',
          ),
        ],
      ),
    );
  }
}
