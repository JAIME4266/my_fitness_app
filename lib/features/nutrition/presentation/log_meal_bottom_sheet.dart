import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/database.dart';
import '../data/nutrition_repository.dart';
import '../domain/nutrition_calculator.dart';

Future<void> showLogMealBottomSheet(
  BuildContext context, {
  String initialMealType = 'Lunch',
  MealLog? editingMeal,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: const Color(0xFFFAF8F5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _LogMealBottomSheet(
      initialMealType: editingMeal?.mealType ?? initialMealType,
      editingMeal: editingMeal,
    ),
  );
}

class _LogMealBottomSheet extends ConsumerStatefulWidget {
  final String initialMealType;
  final MealLog? editingMeal;

  const _LogMealBottomSheet({
    required this.initialMealType,
    this.editingMeal,
  });

  @override
  ConsumerState<_LogMealBottomSheet> createState() =>
      _LogMealBottomSheetState();
}

class _LogMealBottomSheetState extends ConsumerState<_LogMealBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _gramsController = TextEditingController();

  String _searchQuery = '';
  String _selectedCategory = 'All';
  late String _mealType;
  FoodCatalogData? _selectedFood;
  MeasurementBasis _basis = MeasurementBasis.cooked;
  double _portionGrams = 150.0;
  double _extraOilTsp = 0.0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _mealType = widget.initialMealType;
    if (widget.editingMeal != null) {
      final meal = widget.editingMeal!;
      _basis = meal.basis == 'raw'
          ? MeasurementBasis.raw
          : MeasurementBasis.cooked;
      _portionGrams = _basis == MeasurementBasis.raw && meal.rawEquivalentG > 0
          ? meal.rawEquivalentG
          : meal.cookedWeightG;
      _extraOilTsp = meal.extraOilTsp;
      _gramsController.text = _portionGrams.toStringAsFixed(0);
      _loadEditingCatalogFood(meal.foodId);
    } else {
      _gramsController.text = '150';
    }
  }

  Future<void> _loadEditingCatalogFood(String? foodId) async {
    if (foodId == null) return;
    final repo = ref.read(nutritionRepositoryProvider);
    final food = await repo.findFoodById(foodId);
    if (mounted && food != null) {
      setState(() {
        _selectedFood = food;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _gramsController.dispose();
    super.dispose();
  }

  void _selectFood(FoodCatalogData food) {
    setState(() {
      _selectedFood = food;
      _basis = food.defaultBasis == 'raw'
          ? MeasurementBasis.raw
          : MeasurementBasis.cooked;
      _portionGrams = food.defaultServingG;
      _gramsController.text = food.defaultServingG.toStringAsFixed(0);
    });
  }

  ComputedNutrition _previewNutrition() {
    if (_selectedFood != null) {
      final f = _selectedFood!;
      return NutritionCalculator.calculateFoodNutrition(
        inputGrams: _portionGrams,
        basis: _basis,
        yieldFactor: f.yieldFactor,
        rawKcalPer100g: f.kcalPer100g,
        rawProteinPer100g: f.proteinPer100g,
        rawCarbsPer100g: f.carbsPer100g,
        rawFatPer100g: f.fatPer100g,
        rawFibrePer100g: f.fibrePer100g,
        rawSaturatedFatPer100g: f.saturatedFatPer100g,
        rawSugarPer100g: f.sugarPer100g,
        rawSodiumMgPer100g: f.sodiumMgPer100g,
        extraOilTsp: _extraOilTsp,
      );
    }
    // Fallback preview when editing a custom/ad-hoc meal without linked catalog item
    final meal = widget.editingMeal!;
    final oldWeight = meal.cookedWeightG > 0 ? meal.cookedWeightG : 100.0;
    final ratio = _portionGrams / oldWeight;
    final baseKcal = meal.calculatedKcal - meal.extraOilTsp * 45.0;
    final baseFat = meal.fatG - meal.extraOilTsp * 5.0;
    return ComputedNutrition(
      cookedWeightG: _portionGrams,
      rawEquivalentG: meal.rawEquivalentG * ratio,
      calories: (baseKcal * ratio) + (_extraOilTsp * 45.0),
      proteinG: meal.proteinG * ratio,
      carbsG: meal.carbsG * ratio,
      fatG: (baseFat * ratio) + (_extraOilTsp * 5.0),
      fibreG: meal.fibreG * ratio,
      extraOilFatG: _extraOilTsp * 5.0,
      extraOilKcal: _extraOilTsp * 45.0,
    );
  }

  Future<void> _saveMeal() async {
    if (_portionGrams <= 0) return;
    setState(() => _isSaving = true);
    final repo = ref.read(nutritionRepositoryProvider);

    try {
      if (widget.editingMeal != null) {
        await repo.updateMealPortion(
          existing: widget.editingMeal!,
          catalogFood: _selectedFood,
          mealType: _mealType,
          inputGrams: _portionGrams,
          basis: _basis,
          extraOilTsp: _extraOilTsp,
        );
      } else if (_selectedFood != null) {
        await repo.logFoodFromCatalog(
          food: _selectedFood!,
          mealType: _mealType,
          inputGrams: _portionGrams,
          basis: _basis,
          extraOilTsp: _extraOilTsp,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF0F766E),
            content: Text(
              widget.editingMeal != null
                  ? 'Updated ${widget.editingMeal!.foodName} in $_mealType'
                  : 'Logged ${_selectedFood!.name} to $_mealType',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _openCreateCustomFoodDialog() async {
    final created = await showDialog<FoodCatalogData>(
      context: context,
      builder: (_) => const _CustomFoodDialog(),
    );
    if (created != null && mounted) {
      _selectFood(created);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(nutritionRepositoryProvider);
    final isEditing = widget.editingMeal != null;
    final showCalculator = isEditing || _selectedFood != null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.88,
        minChildSize: 0.55,
        maxChildSize: 0.96,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Handle & Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (!isEditing && _selectedFood != null)
                          IconButton(
                            onPressed: () =>
                                setState(() => _selectedFood = null),
                            icon: const Icon(Icons.arrow_back),
                            tooltip: 'Back to food list',
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEditing
                                    ? 'Edit Logged Meal'
                                    : (_selectedFood == null
                                        ? 'IFCT 2017 Indian Food Search'
                                        : _selectedFood!.name),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                isEditing
                                    ? widget.editingMeal!.foodName
                                    : (_selectedFood == null
                                        ? 'Offline ICMR-NIN staples with cooked yield math'
                                        : (_selectedFood!.hindiName.isNotEmpty
                                            ? '${_selectedFood!.hindiName} • Yield ${_selectedFood!.yieldFactor}×'
                                            : 'Yield factor ${_selectedFood!.yieldFactor}×')),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isEditing && _selectedFood == null)
                          TextButton.icon(
                            onPressed: _openCreateCustomFoodDialog,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Custom'),
                          ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: showCalculator
                    ? _buildPortionCalculator(scrollController)
                    : _buildFoodSearchList(repo, scrollController),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFoodSearchList(
    NutritionRepository repo,
    ScrollController scrollController,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search rice, dal, roti, paneer, anda...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: NutritionRepository.foodCategories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = NutritionRepository.foodCategories[index];
              final selected = cat == _selectedCategory;
              return ChoiceChip(
                label: Text(cat, style: const TextStyle(fontSize: 12)),
                selected: selected,
                selectedColor: const Color(0xFF0F766E),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                onSelected: (_) => setState(() => _selectedCategory = cat),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<List<FoodCatalogData>>(
            stream: repo.watchFoodCatalog(
              query: _searchQuery,
              category: _selectedCategory,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final foods = snapshot.data!;
              if (foods.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.restaurant_menu,
                            size: 40, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(
                          'No matching foods found.',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: _openCreateCustomFoodDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Create Custom Food'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                itemCount: foods.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final f = foods[index];
                  final basisEnum = f.defaultBasis == 'raw'
                      ? MeasurementBasis.raw
                      : MeasurementBasis.cooked;
                  final servingPreview =
                      NutritionCalculator.calculateFoodNutrition(
                    inputGrams: f.defaultServingG,
                    basis: basisEnum,
                    yieldFactor: f.yieldFactor,
                    rawKcalPer100g: f.kcalPer100g,
                    rawProteinPer100g: f.proteinPer100g,
                    rawCarbsPer100g: f.carbsPer100g,
                    rawFatPer100g: f.fatPer100g,
                  );

                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _selectFood(f),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE7E5E4)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    f.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    [
                                      if (f.hindiName.isNotEmpty) f.hindiName,
                                      f.servingLabel,
                                      if (f.yieldFactor != 1.0)
                                        'Yield ${f.yieldFactor}×',
                                    ].join(' • '),
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${servingPreview.calories.round()} kcal',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF0F766E),
                                  ),
                                ),
                                Text(
                                  'P ${servingPreview.proteinG.toStringAsFixed(1)}g',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPortionCalculator(ScrollController scrollController) {
    final preview = _previewNutrition();
    final food = _selectedFood;
    final yieldFactor = food?.yieldFactor ?? 1.0;

    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
        // Meal Slot Selector
        const Text(
          'Meal Category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: NutritionRepository.mealCategories.map((slot) {
            final selected = _mealType == slot;
            return ChoiceChip(
              label: Text(slot),
              selected: selected,
              selectedColor: const Color(0xFF0F766E),
              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              onSelected: (_) => setState(() => _mealType = slot),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // Measurement Basis Toggle (Raw vs Cooked)
        if (food != null && yieldFactor != 1.0) ...[
          const Text(
            'Weight Basis (IFCT 2017 Yield Adjustment)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          SegmentedButton<MeasurementBasis>(
            segments: const [
              ButtonSegment(
                value: MeasurementBasis.cooked,
                label: Text('Cooked Weight'),
                icon: Icon(Icons.rice_bowl_outlined, size: 18),
              ),
              ButtonSegment(
                value: MeasurementBasis.raw,
                label: Text('Raw Dry Weight'),
                icon: Icon(Icons.scale_outlined, size: 18),
              ),
            ],
            selected: {_basis},
            onSelectionChanged: (set) {
              setState(() => _basis = set.first);
            },
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _basis == MeasurementBasis.cooked
                  ? '${preview.cookedWeightG.toStringAsFixed(0)}g cooked ÷ $yieldFactor× yield = ${preview.rawEquivalentG.toStringAsFixed(1)}g raw dry baseline'
                  : '${preview.rawEquivalentG.toStringAsFixed(0)}g raw × $yieldFactor× yield = ${preview.cookedWeightG.toStringAsFixed(0)}g cooked plate weight',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F766E),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Portion Slider + Numeric Field
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portion Weight (${_basis == MeasurementBasis.raw ? "Raw" : "Cooked"})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(
              width: 96,
              child: TextField(
                controller: _gramsController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  suffixText: 'g',
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (txt) {
                  final val = double.tryParse(txt);
                  if (val != null && val >= 0) {
                    setState(() => _portionGrams = val);
                  }
                },
              ),
            ),
          ],
        ),
        Slider(
          value: _portionGrams.clamp(5.0, 500.0),
          min: 5.0,
          max: 500.0,
          divisions: 99,
          activeColor: const Color(0xFF0F766E),
          onChanged: (v) {
            setState(() {
              _portionGrams = v.roundToDouble();
              _gramsController.text = _portionGrams.toStringAsFixed(0);
            });
          },
        ),
        if (food != null)
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                label: Text(food.servingLabel, style: const TextStyle(fontSize: 11)),
                onPressed: () {
                  setState(() {
                    _portionGrams = food.defaultServingG;
                    _gramsController.text =
                        food.defaultServingG.toStringAsFixed(0);
                  });
                },
              ),
              ActionChip(
                label: const Text('100g', style: TextStyle(fontSize: 11)),
                onPressed: () {
                  setState(() {
                    _portionGrams = 100;
                    _gramsController.text = '100';
                  });
                },
              ),
              ActionChip(
                label: Text('2× (${(food.defaultServingG * 2).round()}g)',
                    style: const TextStyle(fontSize: 11)),
                onPressed: () {
                  setState(() {
                    _portionGrams = food.defaultServingG * 2;
                    _gramsController.text =
                        (food.defaultServingG * 2).toStringAsFixed(0);
                  });
                },
              ),
            ],
          ),

        const SizedBox(height: 16),

        // Added Ghee / Tadka Oil Slider
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Added Ghee / Tadka Oil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              '${_extraOilTsp.toStringAsFixed(1)} tsp (+${preview.extraOilKcal.round()} kcal)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.5,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        Slider(
          value: _extraOilTsp,
          min: 0.0,
          max: 4.0,
          divisions: 8,
          activeColor: Colors.amber.shade700,
          onChanged: (v) => setState(() => _extraOilTsp = v),
        ),

        const SizedBox(height: 12),

        // Computed Macros Preview Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE7E5E4)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Calculated Nutrition',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    '${preview.calories.round()} kcal',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF0F766E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _macroMini('Protein', '${preview.proteinG.toStringAsFixed(1)}g', Colors.blue),
                  _macroMini('Carbs', '${preview.carbsG.toStringAsFixed(1)}g', Colors.amber.shade800),
                  _macroMini('Fat', '${preview.fatG.toStringAsFixed(1)}g', Colors.redAccent),
                  _macroMini('Fibre', '${preview.fibreG.toStringAsFixed(1)}g', Colors.green),
                ],
              ),
            ],
          ),
        ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          decoration: const BoxDecoration(
            color: Color(0xFFFAF8F5),
            border: Border(top: BorderSide(color: Color(0xFFE7E5E4))),
          ),
          child: ElevatedButton(
            onPressed: _isSaving || _portionGrams <= 0 ? null : _saveMeal,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: _isSaving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    widget.editingMeal != null
                        ? 'Save Updated Portion'
                        : 'Add to $_mealType Diary',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _macroMini(String label, String val, Color color) {
    return Column(
      children: [
        Text(val,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: color)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    );
  }
}

class _CustomFoodDialog extends ConsumerStatefulWidget {
  const _CustomFoodDialog();

  @override
  ConsumerState<_CustomFoodDialog> createState() => _CustomFoodDialogState();
}

class _CustomFoodDialogState extends ConsumerState<_CustomFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _proteinCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();
  final _servingCtrl = TextEditingController(text: '100');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _kcalCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    _servingCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final repo = ref.read(nutritionRepositoryProvider);
    final created = await repo.addCustomFood(
      name: _nameCtrl.text,
      category: 'Custom',
      defaultBasis: MeasurementBasis.cooked,
      yieldFactor: 1.0,
      kcalPer100g: double.parse(_kcalCtrl.text),
      proteinPer100g: double.parse(_proteinCtrl.text),
      carbsPer100g: double.parse(_carbsCtrl.text),
      fatPer100g: double.parse(_fatCtrl.text),
      defaultServingG: double.tryParse(_servingCtrl.text) ?? 100.0,
      servingLabel: '1 serving (${_servingCtrl.text}g)',
    );
    if (mounted) {
      Navigator.of(context).pop(created);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Custom Food (per 100g)'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Food Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _kcalCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Calories (kcal / 100g)'),
                validator: _validNumber,
              ),
              TextFormField(
                controller: _proteinCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Protein (g / 100g)'),
                validator: _validNumber,
              ),
              TextFormField(
                controller: _carbsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Carbs (g / 100g)'),
                validator: _validNumber,
              ),
              TextFormField(
                controller: _fatCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Fat (g / 100g)'),
                validator: _validNumber,
              ),
              TextFormField(
                controller: _servingCtrl,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Default Serving (g)'),
                validator: _validNumber,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Save Food'),
        ),
      ],
    );
  }

  String? _validNumber(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final parsed = double.tryParse(v);
    if (parsed == null || parsed < 0) return 'Enter valid number';
    return null;
  }
}
