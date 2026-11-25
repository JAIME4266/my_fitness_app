import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data/nutrition_repository.dart';

class NutritionGoalsScreen extends StatefulWidget {
  final NutritionRepository repository;

  const NutritionGoalsScreen({super.key, required this.repository});

  @override
  State<NutritionGoalsScreen> createState() => _NutritionGoalsScreenState();
}

class _NutritionGoalsScreenState extends State<NutritionGoalsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  bool _isGuided = true;
  String _selectedPreset = 'Maintain & Fuel';
  bool _isSaving = false;

  final _calCtrl = TextEditingController(text: '2200');
  final _proCtrl = TextEditingController(text: '130');
  final _carbCtrl = TextEditingController(text: '230');
  final _fatCtrl = TextEditingController(text: '65');
  final _fibCtrl = TextEditingController(text: '30');

  int _trendDays = 7;

  static const _presets = <String, Map<String, dynamic>>{
    'Maintain & Fuel': {
      'goalType': 'maintain',
      'kcal': 2200,
      'protein': 130.0,
      'carbs': 245.0,
      'fat': 68.0,
      'fibre': 32.0,
      'desc': 'Balanced energy for daily training and recovery.',
    },
    'Gentle Fat Loss': {
      'goalType': 'cut',
      'kcal': 1850,
      'protein': 140.0,
      'carbs': 180.0,
      'fat': 58.0,
      'fibre': 30.0,
      'desc': 'Mild, sustainable deficit prioritizing protein and satiety.',
    },
    'Muscle & Strength': {
      'goalType': 'lean_bulk',
      'kcal': 2550,
      'protein': 160.0,
      'carbs': 300.0,
      'fat': 75.0,
      'fibre': 34.0,
      'desc': 'Modest surplus to support strength and lean mass.',
    },
    'Endurance Performance': {
      'goalType': 'endurance',
      'kcal': 2700,
      'protein': 135.0,
      'carbs': 365.0,
      'fat': 72.0,
      'fibre': 35.0,
      'desc': 'Higher carbohydrate availability for long runs.',
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    final profile = await widget.repository.db.getMetabolicProfile();
    if (!mounted || profile == null) return;
    setState(() {
      _calCtrl.text = profile.dailyCalorieGoal.toString();
      _proCtrl.text = profile.proteinTargetG.round().toString();
      _carbCtrl.text = profile.carbsTargetG.round().toString();
      _fatCtrl.text = profile.fatTargetG.round().toString();
      _fibCtrl.text = profile.fibreTargetG.round().toString();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _calCtrl.dispose();
    _proCtrl.dispose();
    _carbCtrl.dispose();
    _fatCtrl.dispose();
    _fibCtrl.dispose();
    super.dispose();
  }

  void _applyPreset(String name) {
    final p = _presets[name]!;
    setState(() {
      _selectedPreset = name;
      _calCtrl.text = (p['kcal'] as int).toString();
      _proCtrl.text = (p['protein'] as double).round().toString();
      _carbCtrl.text = (p['carbs'] as double).round().toString();
      _fatCtrl.text = (p['fat'] as double).round().toString();
      _fibCtrl.text = (p['fibre'] as double).round().toString();
    });
  }

  Future<void> _saveGoals() async {
    final kcal = (int.tryParse(_calCtrl.text.trim()) ?? 2200).clamp(1200, 6000);
    final pro = (double.tryParse(_proCtrl.text.trim()) ?? 130).clamp(40.0, 400.0);
    final carb = (double.tryParse(_carbCtrl.text.trim()) ?? 230).clamp(50.0, 700.0);
    final fat = (double.tryParse(_fatCtrl.text.trim()) ?? 65).clamp(25.0, 250.0);
    final fib = (double.tryParse(_fibCtrl.text.trim()) ?? 30).clamp(15.0, 80.0);

    setState(() => _isSaving = true);
    await widget.repository.saveCustomNutritionGoals(
      dailyCalorieGoal: kcal,
      proteinTargetG: pro,
      carbsTargetG: carb,
      fatTargetG: fat,
      fibreTargetG: fib,
      goalType: _isGuided
          ? (_presets[_selectedPreset]!['goalType'] as String)
          : 'custom',
    );
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Custom nutrition goals saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Goals & Trends'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Goals Setup'),
            Tab(text: 'Meal & Trends'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGoalsTab(),
          _buildTrendsTab(),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: true, label: Text('Guided')),
            ButtonSegment(value: false, label: Text('Manual')),
          ],
          selected: {_isGuided},
          onSelectionChanged: (s) => setState(() => _isGuided = s.first),
        ),
        const SizedBox(height: 16),
        if (_isGuided) ...[
          const Text(
            'Non-restrictive goal presets',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ..._presets.entries.map((entry) {
            final selected = entry.key == _selectedPreset;
            return Card(
              color: selected ? const Color(0xFFE6F4F1) : null,
              child: ListTile(
                title: Text(entry.key,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(entry.value['desc'] as String),
                trailing: Text('${entry.value['kcal']} kcal'),
                onTap: () => _applyPreset(entry.key),
              ),
            );
          }),
          const SizedBox(height: 12),
        ],
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Targets',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _calCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Daily Calories (kcal, min 1200)',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _proCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Protein (g)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _carbCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Carbs (g)',
                          border: OutlineInputBorder(),
                          isDense: true,
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
                        controller: _fatCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Fat (g)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _fibCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Fibre (g)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _saveGoals,
                    icon: const Icon(Icons.save),
                    label: Text(_isSaving ? 'SAVING...' : 'SAVE NUTRITION GOALS'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Today by Meal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        FutureBuilder<Map<String, DailyMacroTotals>>(
          future: widget.repository.getMealBreakdownForDate(DateTime.now()),
          builder: (context, snap) {
            final data = snap.data ?? const {};
            if (snap.connectionState == ConnectionState.waiting && data.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: ['Breakfast', 'Lunch', 'Dinner', 'Snack'].map((meal) {
                final t = data[meal] ?? const DailyMacroTotals();
                return Card(
                  child: ListTile(
                    title: Text(meal,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      'P ${t.proteinG.round()}g • C ${t.carbsG.round()}g • F ${t.fatG.round()}g',
                    ),
                    trailing: Text(
                      '${t.calories.round()} kcal',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Calorie Trends',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 7, label: Text('7D')),
                ButtonSegment(value: 14, label: Text('14D')),
                ButtonSegment(value: 30, label: Text('30D')),
              ],
              selected: {_trendDays},
              onSelectionChanged: (s) => setState(() => _trendDays = s.first),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<MapEntry<DateTime, DailyMacroTotals>>>(
            future: widget.repository.getDailyCalorieHistory(_trendDays),
            builder: (context, snap) {
              final points = snap.data ?? const [];
              if (points.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final maxCal = points.fold<double>(
                2500.0,
                (prev, e) => e.value.calories > prev ? e.value.calories : prev,
              );
              return BarChart(
                BarChartData(
                  maxY: maxCal * 1.15,
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(points.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: points[i].value.calories,
                          color: const Color(0xFF0F766E),
                          width: _trendDays > 14 ? 6 : 12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
