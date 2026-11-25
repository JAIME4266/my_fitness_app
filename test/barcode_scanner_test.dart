import 'dart:convert';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/features/nutrition/data/barcode_food_service.dart';
import 'package:my_fitness_app/features/nutrition/data/nutrition_repository.dart';
import 'package:my_fitness_app/features/nutrition/presentation/barcode_scanner_screen.dart';

void main() {
  group('Phase 8 Barcode Food Scanner', () {
    test('OpenFoodFactsService parses product and preserves missing fields as null',
        () async {
      String? capturedUserAgent;
      final client = MockClient((request) async {
        capturedUserAgent = request.headers['User-Agent'];
        return http.Response(
          jsonEncode({
            'status': 1,
            'product': {
              'product_name': 'Masala Oats',
              'brands': 'Saffola',
              'serving_size': '40 g',
              'serving_quantity': 40,
              'nutriments': {
                'energy-kcal_100g': 380,
                'proteins_100g': 11.5,
                'carbohydrates_100g': 65.0,
                // fat_100g intentionally omitted
              },
            },
          }),
          200,
        );
      });

      final service = OpenFoodFactsService(client: client);
      final result = await service.lookupBarcode('8901058851234');

      expect(capturedUserAgent, OpenFoodFactsService.userAgent);
      expect(result.status, BarcodeLookupStatus.found);
      expect(result.product!.name, 'Masala Oats');
      expect(result.product!.brand, 'Saffola');
      expect(result.product!.servingSizeGrams, 40.0);
      expect(result.product!.scaleCalories(40.0), closeTo(152.0, 0.01));
      expect(result.product!.scaleFat(40.0), isNull);
    });

    test('OpenFoodFactsService returns notFound when status is 0', () async {
      final client = MockClient((_) async {
        return http.Response(jsonEncode({'status': 0}), 200);
      });

      final service = OpenFoodFactsService(client: client);
      final result = await service.lookupBarcode('0000000000000');

      expect(result.status, BarcodeLookupStatus.notFound);
      expect(result.product, isNull);
    });

    testWidgets(
        'BarcodeScannerScreen looks up barcode, shows Unavailable, and saves to diary',
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final repo = NutritionRepository(db);
      final client = MockClient((_) async {
        return http.Response(
          jsonEncode({
            'status': 1,
            'product': {
              'product_name': 'Roasted Makhana',
              'brands': 'Farmley',
              'serving_size': '30 g',
              'serving_quantity': 30,
              'nutriments': {
                'energy-kcal_100g': 400,
                'proteins_100g': 10.0,
              },
            },
          }),
          200,
        );
      });
      final service = OpenFoodFactsService(client: client);

      await tester.pumpWidget(
        MaterialApp(
          home: BarcodeScannerScreen(
            repository: repo,
            service: service,
            enableCamera: false,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '8906000000001');
      await tester.tap(find.text('Lookup'));
      await tester.pumpAndSettle();

      expect(find.text('Roasted Makhana'), findsOneWidget);
      expect(find.text('Unavailable'), findsWidgets);

      await tester.scrollUntilVisible(
        find.text('ADD TO FOOD DIARY'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text('ADD TO FOOD DIARY'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ADD TO FOOD DIARY'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final meals = await tester.runAsync(() => db.select(db.mealLogs).get());
      expect(
        meals!.any((m) => m.foodName.contains('Roasted Makhana') && !m.isEstimate),
        isTrue,
      );

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 10));
      await db.close();
    });
  });
}
