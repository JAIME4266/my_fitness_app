import 'dart:convert';
import 'dart:math' as math;

class TrackedPoint {
  final double lat;
  final double lng;
  final double altitudeM;
  final double accuracyM;
  final double speedMps;
  final int timestampEpochMs;

  const TrackedPoint({
    required this.lat,
    required this.lng,
    this.altitudeM = 0.0,
    this.accuracyM = 5.0,
    this.speedMps = 0.0,
    required this.timestampEpochMs,
  });

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'alt': altitudeM,
        't': timestampEpochMs,
      };

  factory TrackedPoint.fromJson(Map<String, dynamic> json) => TrackedPoint(
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        altitudeM: (json['alt'] as num?)?.toDouble() ?? 0.0,
        timestampEpochMs: (json['t'] as num?)?.toInt() ?? 0,
      );
}

enum GpsFilterVerdict {
  accepted,
  rejectedLowAccuracy,
  rejectedMicroJitter,
  rejectedUnrealisticSpike,
  autoPaused,
}

class GpsFilterResult {
  final GpsFilterVerdict verdict;
  final double addedDistanceMeters;
  final bool isMoving;

  const GpsFilterResult({
    required this.verdict,
    this.addedDistanceMeters = 0.0,
    this.isMoving = true,
  });
}

/// 5-stage GPS noise, Haversine distance, and auto-pause filter.
class GpsFilter {
  static const double maxAccuracyMeters = 20.0;
  static const double minDisplacementMeters = 2.5;
  static const double maxRunningSpeedMps = 10.5; // ~37.8 km/h sprint ceiling
  static const double autoPauseSpeedThresholdMps = 0.8;
  static const int autoPauseWindowMs = 6000;

  static double haversineDistanceMeters(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadiusM = 6371000.0;
    final dLat = _toRad(lat2 - lat1);
    final dLng = _toRad(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRad(lat1)) *
            math.cos(_toRad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusM * c;
  }

  static GpsFilterResult evaluatePoint({
    required TrackedPoint? previous,
    required TrackedPoint candidate,
    int? lowSpeedSinceEpochMs,
  }) {
    if (candidate.accuracyM > maxAccuracyMeters) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.rejectedLowAccuracy,
        isMoving: false,
      );
    }

    if (previous == null) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.accepted,
        addedDistanceMeters: 0.0,
        isMoving: true,
      );
    }

    final dtMs = candidate.timestampEpochMs - previous.timestampEpochMs;
    if (dtMs <= 0) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.rejectedMicroJitter,
        isMoving: false,
      );
    }

    final distM = haversineDistanceMeters(
      previous.lat,
      previous.lng,
      candidate.lat,
      candidate.lng,
    );
    final derivedSpeedMps = distM / (dtMs / 1000.0);

    if (derivedSpeedMps > maxRunningSpeedMps) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.rejectedUnrealisticSpike,
        isMoving: true,
      );
    }

    final effectiveSpeed =
        candidate.speedMps > 0 ? candidate.speedMps : derivedSpeedMps;
    if (effectiveSpeed < autoPauseSpeedThresholdMps &&
        lowSpeedSinceEpochMs != null &&
        (candidate.timestampEpochMs - lowSpeedSinceEpochMs) >=
            autoPauseWindowMs) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.autoPaused,
        isMoving: false,
      );
    }

    if (distM < minDisplacementMeters) {
      return const GpsFilterResult(
        verdict: GpsFilterVerdict.rejectedMicroJitter,
        isMoving: true,
      );
    }

    return GpsFilterResult(
      verdict: GpsFilterVerdict.accepted,
      addedDistanceMeters: distM,
      isMoving: true,
    );
  }

  static String encodePolyline(List<TrackedPoint> points) {
    return jsonEncode(points.map((p) => p.toJson()).toList());
  }

  static List<TrackedPoint> decodePolyline(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) return const [];
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(TrackedPoint.fromJson)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  static String formatPacePerKm({
    required double distanceMeters,
    required int durationSeconds,
  }) {
    if (distanceMeters < 10 || durationSeconds <= 0) return '--:--';
    final km = distanceMeters / 1000.0;
    final secPerKm = (durationSeconds / km).round();
    final mins = secPerKm ~/ 60;
    final secs = secPerKm % 60;
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  static String formatDuration(int totalSeconds) {
    final hrs = totalSeconds ~/ 3600;
    final mins = (totalSeconds % 3600) ~/ 60;
    final secs = totalSeconds % 60;
    if (hrs > 0) {
      return '$hrs:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  static double _toRad(double deg) => deg * (math.pi / 180.0);
}
