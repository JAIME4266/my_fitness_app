import 'dart:typed_data';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/database/database.dart';
import 'package:my_fitness_app/database/fitness_repository.dart';
import 'package:my_fitness_app/features/run_tracking/data/run_repository.dart';
import 'package:my_fitness_app/features/run_tracking/domain/gps_filter.dart';
import 'package:my_fitness_app/features/run_tracking/presentation/route_map_widget.dart';

class _MemoryTestTileProvider extends TileProvider {
  static final Uint8List _transparentPng = Uint8List.fromList(<int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
  ]);

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    return MemoryImage(_transparentPng);
  }
}

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  group('Phase 4 RunRepository & RouteMapWidget', () {
    test('Saves completed run, RoutePoints, and updates DailySummaries burn',
        () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(() async => db.close());

      final runRepo = RunRepository(db);
      final fitnessRepo = FitnessRepository(db);

      final id = await runRepo.saveCompletedRun(
        sportType: 'Run',
        startEpochMs: 1732500000000,
        durationSec: 1800,
        distanceM: 5200.0,
        caloriesKcal: 360.0,
        points: const [
          TrackedPoint(lat: 28.6139, lng: 77.2090, timestampEpochMs: 1000),
          TrackedPoint(lat: 28.6169, lng: 77.2110, timestampEpochMs: 600000),
        ],
      );

      final workouts = await runRepo.watchRecentWorkouts().first;
      expect(workouts.length, 1);
      expect(workouts.first.id, id);
      expect(workouts.first.distanceM, 5200.0);

      final pts = await runRepo.getRoutePoints(id);
      expect(pts.length, 2);
      expect(pts.first.lat, 28.6139);

      final summary = await fitnessRepo.getTodaySummary();
      expect(summary!.activeCalories, 360);
    });

    testWidgets('RouteMapWidget renders polyline & attribution without errors',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteMapWidget(
              tileProvider: _MemoryTestTileProvider(),
              points: const [
                TrackedPoint(
                    lat: 28.6139, lng: 77.2090, timestampEpochMs: 1000),
                TrackedPoint(
                    lat: 28.6159, lng: 77.2105, timestampEpochMs: 20000),
              ],
              interactive: false,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('© OpenStreetMap • CARTO'), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.flag_circle), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });
  });
}
