import 'package:flutter_test/flutter_test.dart';
import 'package:my_fitness_app/features/run_tracking/domain/gps_filter.dart';

void main() {
  group('GpsFilter Haversine, noise & auto-pause', () {
    test('Haversine distance computes ~111.19m for 0.001 deg latitude', () {
      final dist = GpsFilter.haversineDistanceMeters(
        28.6139,
        77.2090,
        28.6149,
        77.2090,
      );
      expect(dist, closeTo(111.19, 1.0));
    });

    test('Rejects low accuracy (> 20m) and micro-jitter (< 2.5m)', () {
      const prev = TrackedPoint(
        lat: 28.613900,
        lng: 77.209000,
        accuracyM: 6.0,
        timestampEpochMs: 1000,
      );

      const badAccuracy = TrackedPoint(
        lat: 28.614000,
        lng: 77.209000,
        accuracyM: 35.0,
        timestampEpochMs: 3000,
      );
      expect(
        GpsFilter.evaluatePoint(previous: prev, candidate: badAccuracy).verdict,
        GpsFilterVerdict.rejectedLowAccuracy,
      );

      const jitter = TrackedPoint(
        lat: 28.613910, // ~1.1m
        lng: 77.209000,
        accuracyM: 6.0,
        timestampEpochMs: 3000,
      );
      expect(
        GpsFilter.evaluatePoint(previous: prev, candidate: jitter).verdict,
        GpsFilterVerdict.rejectedMicroJitter,
      );
    });

    test('Rejects unrealistic GPS teleport spikes (> 10.5 m/s)', () {
      const prev = TrackedPoint(
        lat: 28.6139,
        lng: 77.2090,
        timestampEpochMs: 1000,
      );
      const teleport = TrackedPoint(
        lat: 28.6239, // ~1.11 km in 1 second!
        lng: 77.2090,
        accuracyM: 5.0,
        timestampEpochMs: 2000,
      );
      expect(
        GpsFilter.evaluatePoint(previous: prev, candidate: teleport).verdict,
        GpsFilterVerdict.rejectedUnrealisticSpike,
      );
    });

    test('Auto-pauses when speed stays below 0.8 m/s for >= 6s', () {
      const prev = TrackedPoint(
        lat: 28.61390,
        lng: 77.20900,
        timestampEpochMs: 10000,
      );
      const stationary = TrackedPoint(
        lat: 28.61393,
        lng: 77.20900,
        speedMps: 0.2,
        accuracyM: 5.0,
        timestampEpochMs: 17000,
      );
      final res = GpsFilter.evaluatePoint(
        previous: prev,
        candidate: stationary,
        lowSpeedSinceEpochMs: 10000,
      );
      expect(res.verdict, GpsFilterVerdict.autoPaused);
      expect(res.isMoving, isFalse);
    });

    test('Polyline encode/decode round-trips and pace formats cleanly', () {
      const pts = [
        TrackedPoint(lat: 28.6139, lng: 77.2090, timestampEpochMs: 1000),
        TrackedPoint(lat: 28.6149, lng: 77.2095, timestampEpochMs: 30000),
      ];
      final encoded = GpsFilter.encodePolyline(pts);
      final decoded = GpsFilter.decodePolyline(encoded);
      expect(decoded.length, 2);
      expect(decoded.first.lat, 28.6139);
      expect(decoded.last.lng, 77.2095);

      expect(
        GpsFilter.formatPacePerKm(distanceMeters: 5000, durationSeconds: 1500),
        '5:00',
      );
      expect(GpsFilter.formatDuration(1960), '32:40');
    });
  });
}
