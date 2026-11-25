import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../data/ai_food_service.dart';
import '../data/nutrition_repository.dart';
import 'log_meal_bottom_sheet.dart';

final foodRecognitionProvider = Provider<FoodRecognitionProvider>((ref) {
  return GeminiProxyFoodRecognitionProvider();
});

class AiFoodScannerScreen extends ConsumerStatefulWidget {
  final VoidCallback? onOpenBarcodeScanner;

  const AiFoodScannerScreen({
    super.key,
    this.onOpenBarcodeScanner,
  });

  @override
  ConsumerState<AiFoodScannerScreen> createState() =>
      _AiFoodScannerScreenState();
}

class _AiFoodScannerScreenState extends ConsumerState<AiFoodScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  bool _analyzing = false;
  String? _statusMessage;
  String _mealType = 'Lunch';
  List<RecognizedFoodItem> _items = [];

  Future<void> _pickAndAnalyze(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1280,
        imageQuality: 85,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _analyzing = true;
        _statusMessage = 'Analyzing meal items...';
      });

      final result =
          await ref.read(foodRecognitionProvider).analyzeMealImage(bytes);

      if (!mounted) return;
      setState(() {
        _analyzing = false;
        if (result.success) {
          _items = result.items;
          _statusMessage =
              'Estimated breakdown ready. Adjust portions before saving.';
        } else {
          _statusMessage = result.errorMessage;
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _analyzing = false;
          _statusMessage = 'Camera/gallery unavailable: $e';
        });
      }
    }
  }

  Future<void> _addManualItem() async {
    final nameCtrl = TextEditingController();
    final kcalCtrl = TextEditingController(text: '200');
    final pCtrl = TextEditingController(text: '8');
    final cCtrl = TextEditingController(text: '28');
    final fCtrl = TextEditingController(text: '6');
    final gCtrl = TextEditingController(text: '100');

    final added = await showDialog<RecognizedFoodItem>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Missing Ingredient'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Food Name')),
              TextField(
                  controller: gCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Portion (g)')),
              TextField(
                  controller: kcalCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Calories')),
              TextField(
                  controller: pCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Protein (g)')),
              TextField(
                  controller: cCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Carbs (g)')),
              TextField(
                  controller: fCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Fat (g)')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty) return;
              Navigator.pop(
                ctx,
                RecognizedFoodItem(
                  name: nameCtrl.text.trim(),
                  basePortionGrams: double.tryParse(gCtrl.text) ?? 100,
                  baseCalories: double.tryParse(kcalCtrl.text) ?? 0,
                  baseProteinG: double.tryParse(pCtrl.text) ?? 0,
                  baseCarbsG: double.tryParse(cCtrl.text) ?? 0,
                  baseFatG: double.tryParse(fCtrl.text) ?? 0,
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (added != null && mounted) {
      setState(() => _items.add(added));
    }
  }

  Future<void> _saveToDiary() async {
    if (_items.isEmpty) return;
    final repo = ref.read(nutritionRepositoryProvider);
    for (final item in _items) {
      await repo.logCustomOrEstimatedMeal(
        foodName: item.name,
        mealType: _mealType,
        portionGrams: item.portionGrams,
        calories: item.calories,
        proteinG: item.proteinG,
        carbsG: item.carbsG,
        fatG: item.fatG,
        fibreG: item.fibreG,
        saturatedFatG: item.saturatedFatG,
        sugarG: item.sugarG,
        sodiumMg: item.sodiumMg,
        isEstimate: true,
      );
    }
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0F766E),
          content: Text('Saved ${_items.length} item(s) to $_mealType diary!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalKcal = _items.fold<double>(0, (s, i) => s + i.calories);
    final totalP = _items.fold<double>(0, (s, i) => s + i.proteinG);
    final totalC = _items.fold<double>(0, (s, i) => s + i.carbsG);
    final totalF = _items.fold<double>(0, (s, i) => s + i.fatG);
    final totalFib = _items.fold<double>(0, (s, i) => s + i.fibreG);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('AI Food Scanner',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 4 Entry Options
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              _entryButton(
                Icons.camera_alt,
                'Scan Food with Camera',
                () => _pickAndAnalyze(ImageSource.camera),
              ),
              _entryButton(
                Icons.photo_library,
                'Upload Food Image',
                () => _pickAndAnalyze(ImageSource.gallery),
              ),
              _entryButton(
                Icons.search,
                'Search Food Manually',
                () => showLogMealBottomSheet(context, initialMealType: _mealType),
              ),
              _entryButton(
                Icons.qr_code_scanner,
                'Scan Barcode',
                widget.onOpenBarcodeScanner ??
                    () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Barcode scanner ready in Phase 8.')),
                        ),
              ),
            ],
          ),

          if (_imageBytes != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.memory(_imageBytes!, height: 170, fit: BoxFit.cover),
            ),
          ],

          if (_analyzing)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),

          if (_statusMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Text(
                _statusMessage!,
                style: TextStyle(fontSize: 12.5, color: Colors.amber.shade900),
              ),
            ),
          ],

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FOOD ANALYSIS (Estimate)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextButton.icon(
                onPressed: _addManualItem,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Ingredient'),
              ),
            ],
          ),

          if (_items.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE7E5E4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Total: ${totalKcal.round()} kcal',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF0F766E)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Protein: ${totalP.toStringAsFixed(1)}g • Carbs: ${totalC.toStringAsFixed(1)}g • Fat: ${totalF.toStringAsFixed(1)}g • Fibre: ${totalFib.toStringAsFixed(1)}g',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(_items.length, (i) {
              final item = _items[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE7E5E4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () => setState(() => _items.removeAt(i)),
                        ),
                      ],
                    ),
                    Text(
                      '${item.portionGrams.round()}g • ${item.calories.round()} kcal (P ${item.proteinG.toStringAsFixed(1)}g)',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade700),
                    ),
                    Slider(
                      value: item.portionGrams.clamp(10, 600),
                      min: 10,
                      max: 600,
                      activeColor: const Color(0xFF0F766E),
                      onChanged: (v) =>
                          setState(() => item.portionGrams = v.roundToDouble()),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: NutritionRepository.mealCategories
                  .map((c) => ChoiceChip(
                        label: Text(c),
                        selected: _mealType == c,
                        onSelected: (_) => setState(() => _mealType = c),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _saveToDiary,
                child: const Text('ADD TO FOOD DIARY',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _entryButton(IconData icon, String label, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE7E5E4)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF0F766E), size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
