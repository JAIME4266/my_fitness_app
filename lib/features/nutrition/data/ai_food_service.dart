import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class RecognizedFoodItem {
  String name;
  double basePortionGrams;
  double portionGrams;
  double baseCalories;
  double baseProteinG;
  double baseCarbsG;
  double baseFatG;
  double baseFibreG;
  double? baseSaturatedFatG;
  double? baseSugarG;
  double? baseSodiumMg;

  RecognizedFoodItem({
    required this.name,
    required this.basePortionGrams,
    double? portionGrams,
    required this.baseCalories,
    required this.baseProteinG,
    required this.baseCarbsG,
    required this.baseFatG,
    this.baseFibreG = 0.0,
    this.baseSaturatedFatG,
    this.baseSugarG,
    this.baseSodiumMg,
  }) : portionGrams = portionGrams ?? basePortionGrams;

  double get _scale =>
      basePortionGrams > 0 ? (portionGrams / basePortionGrams) : 1.0;

  double get calories => baseCalories * _scale;
  double get proteinG => baseProteinG * _scale;
  double get carbsG => baseCarbsG * _scale;
  double get fatG => baseFatG * _scale;
  double get fibreG => baseFibreG * _scale;
  double? get saturatedFatG =>
      baseSaturatedFatG != null ? baseSaturatedFatG! * _scale : null;
  double? get sugarG => baseSugarG != null ? baseSugarG! * _scale : null;
  double? get sodiumMg => baseSodiumMg != null ? baseSodiumMg! * _scale : null;

  factory RecognizedFoodItem.fromJson(Map<String, dynamic> json) {
    final g = (json['portionGrams'] as num?)?.toDouble() ?? 100.0;
    return RecognizedFoodItem(
      name: (json['name'] as String?)?.trim() ?? 'Food Item',
      basePortionGrams: g > 0 ? g : 100.0,
      baseCalories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      baseProteinG: (json['proteinG'] as num?)?.toDouble() ?? 0.0,
      baseCarbsG: (json['carbsG'] as num?)?.toDouble() ?? 0.0,
      baseFatG: (json['fatG'] as num?)?.toDouble() ?? 0.0,
      baseFibreG: (json['fibreG'] as num?)?.toDouble() ?? 0.0,
      baseSaturatedFatG: (json['saturatedFatG'] as num?)?.toDouble(),
      baseSugarG: (json['sugarG'] as num?)?.toDouble(),
      baseSodiumMg: (json['sodiumMg'] as num?)?.toDouble(),
    );
  }
}

class AiFoodRecognitionResult {
  final bool success;
  final List<RecognizedFoodItem> items;
  final String? errorMessage;

  const AiFoodRecognitionResult({
    required this.success,
    this.items = const [],
    this.errorMessage,
  });
}

/// Modular AI food recognition interface so providers can be swapped without
/// rewriting nutrition or diary logic.
abstract class FoodRecognitionProvider {
  bool get isConfigured;
  Future<AiFoodRecognitionResult> analyzeMealImage(Uint8List imageBytes);
}

/// Calls a secure server-side proxy (e.g., Cloudflare Worker / Supabase Edge Function)
/// holding the Gemini API key. Never stores API keys inside the APK.
class GeminiProxyFoodRecognitionProvider implements FoodRecognitionProvider {
  static const String proxyUrl = String.fromEnvironment('AI_FOOD_PROXY_URL');
  final http.Client _client;

  GeminiProxyFoodRecognitionProvider({http.Client? client})
      : _client = client ?? http.Client();

  @override
  bool get isConfigured => proxyUrl.isNotEmpty;

  @override
  Future<AiFoodRecognitionResult> analyzeMealImage(Uint8List imageBytes) async {
    if (!isConfigured) {
      return const AiFoodRecognitionResult(
        success: false,
        errorMessage:
            'AI Food Proxy URL is not configured. Use IFCT 2017 manual search or add items manually.',
      );
    }

    try {
      final resp = await _client.post(
        Uri.parse(proxyUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'imageBase64': base64Encode(imageBytes),
          'prompt':
              'Identify all individual food items on this plate, estimate portionGrams and nutrition JSON.',
        }),
      );

      if (resp.statusCode == 429) {
        return const AiFoodRecognitionResult(
          success: false,
          errorMessage:
              'Free-tier AI rate limit reached. Please retry shortly or use manual IFCT search.',
        );
      }
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        return AiFoodRecognitionResult(
          success: false,
          errorMessage: 'AI service returned HTTP ${resp.statusCode}.',
        );
      }

      final decoded = jsonDecode(resp.body) as Map<String, dynamic>;
      final rawItems = decoded['items'] as List<dynamic>? ?? const [];
      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(RecognizedFoodItem.fromJson)
          .toList();

      if (items.isEmpty) {
        return const AiFoodRecognitionResult(
          success: false,
          errorMessage:
              'No food items recognized clearly. Please enter items manually.',
        );
      }

      return AiFoodRecognitionResult(success: true, items: items);
    } catch (e) {
      return AiFoodRecognitionResult(
        success: false,
        errorMessage: 'Network/AI error: $e',
      );
    }
  }
}
