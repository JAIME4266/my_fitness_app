import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/nutrition/data/nutrition_repository.dart';
import 'package:my_fitness_app/main.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  testWidgets(
      'AppShell renders real database calories, logs meal via bottom sheet, and deletes cleanly',
      (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(() async => db.close());

    final repo = NutritionRepository(db);
    await repo.ensureSeeded();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const MaterialApp(
          home: AppShell(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Dashboard should NOT show legacy hardcoded 1450 kcal food intake
    expect(find.text('1450'), findsNothing);
    expect(find.text('Jaime'), findsOneWidget);
    expect(find.text('Log Meal'), findsOneWidget);

    // Tap Log Meal button on Dashboard to open IFCT 2017 bottom sheet
    await tester.tap(find.text('Log Meal'));
    await tester.pumpAndSettle();

    expect(find.text('IFCT 2017 Indian Food Search'), findsOneWidget);

    // Search for Moong Dal and tap it
    await tester.enterText(find.byType(TextField), 'Moong');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yellow Moong Dal (Split)'));
    await tester.pumpAndSettle();

    // Confirm raw-vs-cooked yield badge appears and save meal
    expect(find.textContaining('yield'), findsWidgets);
    await tester.tap(find.text('Add to Lunch Diary'));
    await tester.pumpAndSettle();

    // Default serving 160g cooked moong dal -> 50g raw -> 174 kcal
    expect(find.text('Burn Target'), findsOneWidget);

    // Navigate to Nutrition screen via Food Diary button and verify diary displays logged item
    await tester.tap(find.text('Food Diary'));
    await tester.pumpAndSettle();

    expect(find.text('Nutrition & IFCT Lab'), findsOneWidget);
    await tester.ensureVisible(find.text('Yellow Moong Dal (Split)'));
    await tester.pumpAndSettle();
    expect(find.text('Yellow Moong Dal (Split)'), findsOneWidget);
    expect(find.text('174 kcal'), findsOneWidget);

    // Delete the logged meal and confirm UI reverts cleanly to 0
    await tester.ensureVisible(find.byIcon(Icons.delete_outline).first);
    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    expect(find.text('Yellow Moong Dal (Split)'), findsNothing);

    // Unmount widget tree, close Drift DB, and pump a frame so Drift's
    // StreamQueryStore cleanup timers complete before FakeAsync invariant check.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
    await db.close();
  });
}
