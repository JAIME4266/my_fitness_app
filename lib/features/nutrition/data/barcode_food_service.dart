import 'dart:convert';
import 'package:http/http.dart' as http;

enum BarcodeLookupStatus {
  found,
  notFound,
  networkError,
  invalidBarcode,
}

class BarcodeProduct {
  final String barcode;
  final String name;
  final String? brand;
  final double? servingSizeGrams;
  final String? servingSizeLabel;
  final double? caloriesPer100g;
  final double? proteinPer100g;
  final double? carbsPer100g;
  final double? fatPer100g;
  final double? fiberPer100g;
  final double? sodiumMgPer100g;

  const BarcodeProduct({
    required this.barcode,
    required this.name,
    this.brand,
    this.servingSizeGrams,
    this.servingSizeLabel,
    this.caloriesPer100g,
    this.proteinPer100g,
    this.carbsPer100g,
    this.fatPer100g,
    this.fiberPer100g,
    this.sodiumMgPer100g,
  });

  double? scaleCalories(double grams) =>
      caloriesPer100g == null ? null : caloriesPer100g! * (grams / 100.0);
  double? scaleProtein(double grams) =>
      proteinPer100g == null ? null : proteinPer100g! * (grams / 100.0);
  double? scaleCarbs(double grams) =>
      carbsPer100g == null ? null : carbsPer100g! * (grams / 100.0);
  double? scaleFat(double grams) =>
      fatPer100g == null ? null : fatPer100g! * (grams / 100.0);
  double? scaleFiber(double grams) =>
      fiberPer100g == null ? null : fiberPer100g! * (grams / 100.0);
  double? scaleSodiumMg(double grams) =>
      sodiumMgPer100g == null ? null : sodiumMgPer100g! * (grams / 100.0);
}

class BarcodeLookupResult {
  final BarcodeLookupStatus status;
  final BarcodeProduct? product;
  final String? errorMessage;

  const BarcodeLookupResult({
    required this.status,
    this.product,
    this.errorMessage,
  });
}

class OpenFoodFactsService {
  static const String userAgent =
      'StrideIQFitnessApp/1.0 (https://github.com/strideiq; contact@strideiq.local)';

  final http.Client _client;

  OpenFoodFactsService({http.Client? client})
      : _client = client ?? http.Client();

  Future<BarcodeLookupResult> lookupBarcode(String rawBarcode) async {
    final barcode = rawBarcode.trim();
    if (barcode.isEmpty || !RegExp(r'^[0-9A-Za-z\-]{4,32}$').hasMatch(barcode)) {
      return const BarcodeLookupResult(
        status: BarcodeLookupStatus.invalidBarcode,
        errorMessage: 'Please enter or scan a valid barcode.',
      );
    }

    final uri = Uri.parse(
      'https://world.openfoodfacts.org/api/v2/product/$barcode.json'
      '?fields=product_name,brands,serving_size,serving_quantity,nutriments',
    );

    try {
      final response = await _client.get(
        uri,
        headers: const {
          'User-Agent': userAgent,
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode == 404) {
        return const BarcodeLookupResult(
          status: BarcodeLookupStatus.notFound,
          errorMessage: 'Product Not Found in Open Food Facts.',
        );
      }

      if (response.statusCode != 200) {
        return BarcodeLookupResult(
          status: BarcodeLookupStatus.networkError,
          errorMessage: 'Open Food Facts returned HTTP ${response.statusCode}.',
        );
      }

      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final status = jsonMap['status'] as int? ?? 0;
      final productMap = jsonMap['product'] as Map<String, dynamic>?;

      if (status != 1 || productMap == null) {
        return const BarcodeLookupResult(
          status: BarcodeLookupStatus.notFound,
          errorMessage: 'Product Not Found in Open Food Facts.',
        );
      }

      final rawName = (productMap['product_name'] as String?)?.trim();
      final name = (rawName == null || rawName.isEmpty)
          ? 'Unnamed Product ($barcode)'
          : rawName;
      final brand = (productMap['brands'] as String?)?.trim();
      final servingLabel = (productMap['serving_size'] as String?)?.trim();
      final servingQty = _toDouble(productMap['serving_quantity']);

      final nutriments =
          (productMap['nutriments'] as Map<String, dynamic>?) ?? const {};

      final sodiumGrams = _toDouble(nutriments['sodium_100g']);

      return BarcodeLookupResult(
        status: BarcodeLookupStatus.found,
        product: BarcodeProduct(
          barcode: barcode,
          name: name,
          brand: (brand == null || brand.isEmpty) ? null : brand,
          servingSizeGrams: servingQty != null && servingQty > 0 ? servingQty : null,
          servingSizeLabel:
              (servingLabel == null || servingLabel.isEmpty) ? null : servingLabel,
          caloriesPer100g: _toDouble(nutriments['energy-kcal_100g']),
          proteinPer100g: _toDouble(nutriments['proteins_100g']),
          carbsPer100g: _toDouble(nutriments['carbohydrates_100g']),
          fatPer100g: _toDouble(nutriments['fat_100g']),
          fiberPer100g: _toDouble(nutriments['fiber_100g']),
          sodiumMgPer100g: sodiumGrams != null ? sodiumGrams * 1000.0 : null,
        ),
      );
    } catch (e) {
      return BarcodeLookupResult(
        status: BarcodeLookupStatus.networkError,
        errorMessage: 'Network error while looking up barcode: $e',
      );
    }
  }

  Future<List<BarcodeProduct>> searchProductsOnline(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const [];

    final uri = Uri.https(
      'world.openfoodfacts.org',
      '/cgi/search.pl',
      {
        'search_terms': trimmed,
        'search_simple': '1',
        'action': 'process',
        'json': '1',
        'page_size': '15',
        'fields': 'code,product_name,brands,serving_size,serving_quantity,nutriments',
      },
    );

    try {
      final response = await _client.get(
        uri,
        headers: const {
          'User-Agent': userAgent,
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 12));

      if (response.statusCode != 200) return const [];
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      final products = (jsonMap['products'] as List?) ?? const [];

      final results = <BarcodeProduct>[];
      for (final raw in products) {
        if (raw is! Map<String, dynamic>) continue;
        final name = (raw['product_name'] as String?)?.trim();
        if (name == null || name.isEmpty) continue;
        final code = (raw['code'] as String?)?.trim() ?? 'online_${results.length}';
        final brand = (raw['brands'] as String?)?.trim();
        final servingLabel = (raw['serving_size'] as String?)?.trim();
        final servingQty = _toDouble(raw['serving_quantity']);
        final nutriments =
            (raw['nutriments'] as Map<String, dynamic>?) ?? const {};
        final sodiumGrams = _toDouble(nutriments['sodium_100g']);

        results.add(BarcodeProduct(
          barcode: code,
          name: name,
          brand: (brand == null || brand.isEmpty) ? null : brand,
          servingSizeGrams:
              servingQty != null && servingQty > 0 ? servingQty : null,
          servingSizeLabel:
              (servingLabel == null || servingLabel.isEmpty) ? null : servingLabel,
          caloriesPer100g: _toDouble(nutriments['energy-kcal_100g']),
          proteinPer100g: _toDouble(nutriments['proteins_100g']),
          carbsPer100g: _toDouble(nutriments['carbohydrates_100g']),
          fatPer100g: _toDouble(nutriments['fat_100g']),
          fiberPer100g: _toDouble(nutriments['fiber_100g']),
          sodiumMgPer100g: sodiumGrams != null ? sodiumGrams * 1000.0 : null,
        ));
      }
      return results;
    } catch (_) {
      return const [];
    }
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim());
    return null;
  }
}
