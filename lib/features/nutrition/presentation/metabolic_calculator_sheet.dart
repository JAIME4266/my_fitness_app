import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../data/nutrition_repository.dart';
import '../domain/nutrition_calculator.dart';

Future<void> showMetabolicCalculatorSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: const Color(0xFFFAF8F5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const _MetabolicCalculatorSheet(),
  );
}

class _MetabolicCalculatorSheet extends ConsumerStatefulWidget {
  const _MetabolicCalculatorSheet();

  @override
  ConsumerState<_MetabolicCalculatorSheet> createState() =>
      _MetabolicCalculatorSheetState();
}

class _MetabolicCalculatorSheetState
    extends ConsumerState<_MetabolicCalculatorSheet> {
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _bodyFatCtrl = TextEditingController();

  String _name = 'Athlete';
  String _sex = 'male';
  String _bmrFormula = 'mifflin';
  int _goalDelta = 0;
  double _sampleMet = 9.8;
  double _sampleHr = 155;
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _bodyFatCtrl.dispose();
    super.dispose();
  }

  void _initFromProfile(UserMetabolicProfile profile) {
    if (_initialized) return;
    _initialized = true;
    _name = profile.name;
    _sex = profile.sex;
    _bmrFormula = profile.bmrFormula;
    _goalDelta = profile.goalDeltaKcal;
    _ageCtrl.text = profile.age.toString();
    _heightCtrl.text = profile.heightCm.toStringAsFixed(0);
    _weightCtrl.text = profile.weightKg.toStringAsFixed(1);
    _bodyFatCtrl.text = (profile.bodyFatPct ?? 18.0).toStringAsFixed(0);
  }

  double get _weightKg =>
      (double.tryParse(_weightCtrl.text) ?? 75.0).clamp(35.0, 220.0);
  double get _heightCm =>
      (double.tryParse(_heightCtrl.text) ?? 175.0).clamp(120.0, 230.0);
  int get _age => (int.tryParse(_ageCtrl.text) ?? 24).clamp(16, 90);
  double get _bodyFat =>
      (double.tryParse(_bodyFatCtrl.text) ?? 18.0).clamp(4.0, 60.0);

  double _computeActiveBmr() {
    if (_bmrFormula == 'katch') {
      return NutritionCalculator.calculateKatchMcArdleBmr(
        weightKg: _weightKg,
        bodyFatPct: _bodyFat,
      );
    }
    return NutritionCalculator.calculateMifflinStJeorBmr(
      weightKg: _weightKg,
      heightCm: _heightCm,
      age: _age,
      sex: _sex,
    );
  }

  Future<void> _saveTargets(int dailyCalorieGoal) async {
    setState(() => _saving = true);
    final repo = ref.read(nutritionRepositoryProvider);
    // Non-restrictive balanced athletic macro distribution
    final proteinG = (_weightKg * 1.6).roundToDouble();
    final fatG = ((dailyCalorieGoal * 0.25) / 9.0).roundToDouble();
    final remainingKcal = (dailyCalorieGoal - (proteinG * 4) - (fatG * 9))
        .clamp(200.0, 2500.0);
    final carbsG = (remainingKcal / 4.0).roundToDouble();

    await repo.saveMetabolicProfile(
      name: _name,
      age: _age,
      sex: _sex,
      heightCm: _heightCm,
      weightKg: _weightKg,
      bodyFatPct: _bodyFat,
      bmrFormula: _bmrFormula,
      activityMultiplier: 1.2,
      goalDeltaKcal: _goalDelta,
      dailyCalorieGoal: dailyCalorieGoal,
      proteinTargetG: proteinG,
      carbsTargetG: carbsG,
      fatTargetG: fatG,
      fibreTargetG: 30.0,
    );

    if (mounted) {
      setState(() => _saving = false);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0F766E),
          content: Text(
            'Updated daily baseline target to $dailyCalorieGoal kcal',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(metabolicProfileStreamProvider);
    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading profile: $e')),
      data: (profile) {
        if (profile != null) _initFromProfile(profile);

        final mifflinBmr = NutritionCalculator.calculateMifflinStJeorBmr(
          weightKg: _weightKg,
          heightCm: _heightCm,
          age: _age,
          sex: _sex,
        );
        final katchBmr = NutritionCalculator.calculateKatchMcArdleBmr(
          weightKg: _weightKg,
          bodyFatPct: _bodyFat,
        );
        final activeBmr = _computeActiveBmr();
        final sedentaryTdee =
            NutritionCalculator.calculateBaselineTdee(bmr: activeBmr);
        final minFloor = _sex == 'female' ? 1200 : 1500;
        final suggestedTarget =
            (sedentaryTdee + _goalDelta).round().clamp(minFloor, 5000);

        final durations = [15.0, 30.0, 45.0, 60.0, 75.0];
        final metSpots = durations
            .map((d) => FlSpot(
                d,
                NutritionCalculator.calculateNetMetBurn(
                  met: _sampleMet,
                  weightKg: _weightKg,
                  durationMinutes: d,
                )))
            .toList();
        final hrSpots = durations
            .map((d) => FlSpot(
                d,
                NutritionCalculator.calculateKeytelNetBurn(
                  heartRateBpm: _sampleHr,
                  weightKg: _weightKg,
                  age: _age,
                  sex: _sex,
                  durationMinutes: d,
                  restingBmrPerDay: activeBmr,
                )))
            .toList();

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          minChildSize: 0.6,
          maxChildSize: 0.96,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BMR, TDEE & Net Burn Engine',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Sedentary baseline (1.2×) prevents double-counting watch workouts',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Biometric inputs
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _sex,
                        decoration: const InputDecoration(
                          labelText: 'Sex',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'female', child: Text('Female')),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _sex = v);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _ageCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _weightCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _heightCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Height (cm)',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _bodyFatCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Body Fat (%)',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Text(
                  'BMR Formula',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'mifflin',
                      label: Text('Mifflin (${mifflinBmr.round()})'),
                    ),
                    ButtonSegment(
                      value: 'katch',
                      label: Text('Katch-McArdle (${katchBmr.round()})'),
                    ),
                  ],
                  selected: {_bmrFormula},
                  onSelectionChanged: (s) =>
                      setState(() => _bmrFormula = s.first),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Daily Calorie Adjustment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: [
                    _goalChip('Mild Cut (-300)', -300),
                    _goalChip('Maintain (0)', 0),
                    _goalChip('Lean Gain (+250)', 250),
                  ],
                ),

                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F2F0),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Baseline TDEE: ${sedentaryTdee.round()} kcal',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0F766E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Daily Budget: $suggestedTarget kcal',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed:
                            _saving ? null : () => _saveTargets(suggestedTarget),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F766E),
                          foregroundColor: Colors.white,
                        ),
                        child: _saving
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Apply'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),
                const Text(
                  'Net Active Burn: 2024 Compendium MET vs Keytel HR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Run MET: ${_sampleMet.toStringAsFixed(1)} | Avg HR: ${_sampleHr.round()} bpm',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Slider(
                  value: _sampleMet,
                  min: 3.5,
                  max: 14.5,
                  divisions: 22,
                  activeColor: const Color(0xFF0F766E),
                  onChanged: (v) => setState(() => _sampleMet = v),
                ),
                Slider(
                  value: _sampleHr,
                  min: 110,
                  max: 190,
                  divisions: 40,
                  activeColor: Colors.amber.shade700,
                  onChanged: (v) => setState(() => _sampleHr = v),
                ),
                SizedBox(
                  height: 190,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) => Text(
                              '${v.round()}m',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: metSpots,
                          isCurved: true,
                          color: const Color(0xFF0F766E),
                          barWidth: 3,
                        ),
                        LineChartBarData(
                          spots: hrSpots,
                          isCurved: true,
                          color: Colors.amber.shade700,
                          barWidth: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _legendDot(const Color(0xFF0F766E), 'Net METs (GPS/Lift)'),
                    const SizedBox(width: 16),
                    _legendDot(Colors.amber.shade700, 'Keytel HR Net'),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _goalChip(String label, int delta) {
    final selected = _goalDelta == delta;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: selected,
      selectedColor: const Color(0xFF0F766E),
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _goalDelta = delta),
    );
  }

  Widget _legendDot(Color c, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11.5)),
      ],
    );
  }
}
