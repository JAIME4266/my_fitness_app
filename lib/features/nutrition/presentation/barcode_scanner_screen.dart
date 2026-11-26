import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../data/barcode_food_service.dart';
import '../data/nutrition_repository.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final NutritionRepository repository;
  final OpenFoodFactsService? service;
  final bool enableCamera;

  const BarcodeScannerScreen({
    super.key,
    required this.repository,
    this.service,
    this.enableCamera = true,
  });

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  late final OpenFoodFactsService _service;
  final TextEditingController _barcodeController = TextEditingController();
  MobileScannerController? _scannerController;

  bool _isLoading = false;
  bool _isSaving = false;
  bool _hasCameraPermission = false;
  BarcodeLookupResult? _result;
  double _grams = 100.0;
  String _mealType = 'Snack';
  String? _lastScannedCode;

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? OpenFoodFactsService();
    if (widget.enableCamera) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (status.isGranted) {
      setState(() {
        _hasCameraPermission = true;
        _scannerController ??= MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        );
      });
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _scannerController?.dispose();
    super.dispose();
  }

  Future<void> _lookup(String code) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
      _lastScannedCode = trimmed;
    });

    final res = await _service.lookupBarcode(trimmed);
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _result = res;
      if (res.product != null) {
        _grams = res.product!.servingSizeGrams ?? 100.0;
      }
    });
  }

  Future<void> _saveToDiary(BarcodeProduct product) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    await widget.repository.logCustomOrEstimatedMeal(
      foodName: product.brand != null
          ? '${product.name} (${product.brand})'
          : product.name,
      mealType: _mealType,
      portionGrams: _grams,
      calories: product.scaleCalories(_grams) ?? 0.0,
      proteinG: product.scaleProtein(_grams) ?? 0.0,
      carbsG: product.scaleCarbs(_grams) ?? 0.0,
      fatG: product.scaleFat(_grams) ?? 0.0,
      fibreG: product.scaleFiber(_grams) ?? 0.0,
      sodiumMg: product.scaleSodiumMg(_grams) ?? 0.0,
      isEstimate: false,
    );

    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to $_mealType')),
    );
    Navigator.of(context).pop(true);
  }

  Future<void> _openOnlineSearchDialog() async {
    final queryCtrl = TextEditingController();
    List<BarcodeProduct> results = const [];
    bool searching = false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Online Food Search'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: queryCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Search any food (e.g. Paneer, Oats)',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (q) async {
                          setDialogState(() => searching = true);
                          final found = await _service.searchProductsOnline(q);
                          if (ctx.mounted) {
                            setDialogState(() {
                              searching = false;
                              results = found;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: searching
                          ? null
                          : () async {
                              setDialogState(() => searching = true);
                              final found = await _service
                                  .searchProductsOnline(queryCtrl.text);
                              if (ctx.mounted) {
                                setDialogState(() {
                                  searching = false;
                                  results = found;
                                });
                              }
                            },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (searching)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )
                else if (results.isEmpty)
                  const Text(
                    'Enter a food name and tap search to query Open Food Facts online.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                else
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, i) {
                        final p = results[i];
                        final kcal = p.caloriesPer100g?.round();
                        return ListTile(
                          dense: true,
                          title: Text(p.name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            '${p.brand ?? "Generic"} • ${kcal != null ? "$kcal kcal/100g" : "Calories unavailable"}',
                          ),
                          onTap: () {
                            Navigator.of(ctx).pop();
                            setState(() {
                              _result = BarcodeLookupResult(
                                status: BarcodeLookupStatus.found,
                                product: p,
                              );
                              _grams = p.servingSizeGrams ?? 100.0;
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openManualEntryDialog() async {
    final nameController = TextEditingController();
    final calController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatController = TextEditingController();

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter Food Manually'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              TextField(
                controller: calController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Calories (kcal)'),
              ),
              TextField(
                controller: proteinController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Protein (g)'),
              ),
              TextField(
                controller: carbsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Carbs (g)'),
              ),
              TextField(
                controller: fatController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Fat (g)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              await widget.repository.logCustomOrEstimatedMeal(
                foodName: name,
                mealType: _mealType,
                portionGrams: 100.0,
                calories: double.tryParse(calController.text.trim()) ?? 0.0,
                proteinG: double.tryParse(proteinController.text.trim()) ?? 0.0,
                carbsG: double.tryParse(carbsController.text.trim()) ?? 0.0,
                fatG: double.tryParse(fatController.text.trim()) ?? 0.0,
                isEstimate: false,
              );
              if (ctx.mounted) Navigator.of(ctx).pop(true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (saved == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Food Scanner'),
        actions: [
          if (_scannerController != null)
            IconButton(
              icon: const Icon(Icons.flash_on),
              tooltip: 'Toggle Torch',
              onPressed: () => _scannerController?.toggleTorch(),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.enableCamera) ...[
            if (_hasCameraPermission && _scannerController != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 220,
                  child: MobileScanner(
                    controller: _scannerController!,
                    onDetect: (capture) {
                      final barcodes = capture.barcodes;
                      if (barcodes.isEmpty) return;
                      final code = barcodes.first.rawValue;
                      if (code != null && code != _lastScannedCode) {
                        _barcodeController.text = code;
                        _lookup(code);
                      }
                    },
                  ),
                ),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Camera permission is needed to scan barcodes.'),
                      const SizedBox(height: 8),
                      FilledButton.icon(
                        onPressed: _initCamera,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Grant Camera Permission'),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _barcodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Barcode (e.g. 8901058851234)',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: _lookup,
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _isLoading
                    ? null
                    : () => _lookup(_barcodeController.text),
                icon: const Icon(Icons.search),
                label: const Text('Lookup'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _openOnlineSearchDialog,
            icon: const Icon(Icons.public),
            label: const Text('Search Any Food Online (Open Food Facts)'),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_result != null)
            _buildResultCard(theme, _result!),
        ],
      ),
    );
  }

  Widget _buildResultCard(ThemeData theme, BarcodeLookupResult res) {
    if (res.status == BarcodeLookupStatus.notFound) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Not Found',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This barcode was not found in Open Food Facts. You can search the local food catalog or enter it manually.',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(false),
                    icon: const Icon(Icons.search),
                    label: const Text('Search Food Catalog'),
                  ),
                  FilledButton.icon(
                    onPressed: _openManualEntryDialog,
                    icon: const Icon(Icons.edit),
                    label: const Text('Enter Manually'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (res.status != BarcodeLookupStatus.found || res.product == null) {
      return Card(
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            res.errorMessage ?? 'Unable to look up barcode.',
            style: TextStyle(color: theme.colorScheme.onErrorContainer),
          ),
        ),
      );
    }

    final product = res.product!;
    String fmt(double? val, String unit) =>
        val == null ? 'Unavailable' : '${val.toStringAsFixed(1)} $unit';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (product.brand != null) ...[
              const SizedBox(height: 2),
              Text(
                product.brand!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (product.servingSizeLabel != null) ...[
              const SizedBox(height: 4),
              Text(
                'Label serving: ${product.servingSizeLabel}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Serving: ${_grams.round()} g',
                  style: theme.textTheme.titleSmall,
                ),
                DropdownButton<String>(
                  value: _mealType,
                  items: const [
                    DropdownMenuItem(value: 'Breakfast', child: Text('Breakfast')),
                    DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                    DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                    DropdownMenuItem(value: 'Snack', child: Text('Snack')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _mealType = v);
                  },
                ),
              ],
            ),
            Slider(
              value: _grams.clamp(10.0, 500.0),
              min: 10.0,
              max: 500.0,
              divisions: 49,
              label: '${_grams.round()} g',
              onChanged: (v) => setState(() => _grams = v),
            ),
            const SizedBox(height: 8),
            _nutrientRow('Calories', fmt(product.scaleCalories(_grams), 'kcal')),
            _nutrientRow('Protein', fmt(product.scaleProtein(_grams), 'g')),
            _nutrientRow('Carbs', fmt(product.scaleCarbs(_grams), 'g')),
            _nutrientRow('Fat', fmt(product.scaleFat(_grams), 'g')),
            _nutrientRow('Fiber', fmt(product.scaleFiber(_grams), 'g')),
            _nutrientRow('Sodium', fmt(product.scaleSodiumMg(_grams), 'mg')),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : () => _saveToDiary(product),
                icon: const Icon(Icons.check),
                label: Text(_isSaving ? 'SAVING...' : 'ADD TO FOOD DIARY'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutrientRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
