import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../nutrition/data/nutrition_repository.dart';
import '../../nutrition/domain/nutrition_calculator.dart';
import '../data/run_repository.dart';
import '../domain/gps_filter.dart';
import 'route_map_widget.dart';

class RunTrackerScreen extends ConsumerStatefulWidget {
  const RunTrackerScreen({super.key});

  @override
  ConsumerState<RunTrackerScreen> createState() => _RunTrackerScreenState();
}

class _RunTrackerScreenState extends ConsumerState<RunTrackerScreen> {
  StreamSubscription<Position>? _posSub;
  Timer? _clockTimer;

  bool _isTracking = false;
  bool _isPaused = false;
  bool _isAutoPaused = false;
  String _sportType = 'Run';
  String _statusMessage = 'Ready to track outdoor GPS route';

  int _startEpochMs = 0;
  int _elapsedSec = 0;
  double _distanceM = 0.0;
  int? _lowSpeedSinceMs;
  final List<TrackedPoint> _points = [];

  @override
  void dispose() {
    _posSub?.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }

  Future<bool> _ensureLocationPermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      setState(() => _statusMessage = 'Please enable GPS / Location services');
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() =>
          _statusMessage = 'Location permission denied. Enable in Settings.');
      return false;
    }
    return true;
  }

  Future<void> _startRun() async {
    final ok = await _ensureLocationPermission();
    if (!ok) return;

    setState(() {
      _isTracking = true;
      _isPaused = false;
      _isAutoPaused = false;
      _startEpochMs = DateTime.now().millisecondsSinceEpoch;
      _elapsedSec = 0;
      _distanceM = 0.0;
      _lowSpeedSinceMs = null;
      _points.clear();
      _statusMessage = 'Acquiring GPS signal...';
    });

    _clockTimer?.cancel();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isTracking && !_isPaused && !_isAutoPaused && mounted) {
        setState(() => _elapsedSec += 1);
      }
    });

    final LocationSettings settings = defaultTargetPlatform == TargetPlatform.android
        ? AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 2,
            intervalDuration: const Duration(seconds: 2),
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationTitle: 'PulseTrack Run Active',
              notificationText: 'Recording GPS route & pace in background',
              enableWakeLock: true,
            ),
          )
        : const LocationSettings(
            accuracy: LocationAccuracy.best,
            distanceFilter: 2,
          );

    _posSub?.cancel();
    _posSub = Geolocator.getPositionStream(locationSettings: settings).listen(
      _onPositionUpdate,
      onError: (e) {
        if (mounted) {
          setState(() => _statusMessage = 'GPS stream error: $e');
        }
      },
    );
  }

  void _onPositionUpdate(Position pos) {
    if (!_isTracking || _isPaused || !mounted) return;

    final candidate = TrackedPoint(
      lat: pos.latitude,
      lng: pos.longitude,
      altitudeM: pos.altitude,
      accuracyM: pos.accuracy,
      speedMps: pos.speed,
      timestampEpochMs: pos.timestamp.millisecondsSinceEpoch,
    );

    final prev = _points.isNotEmpty ? _points.last : null;
    if (candidate.speedMps < GpsFilter.autoPauseSpeedThresholdMps) {
      _lowSpeedSinceMs ??= candidate.timestampEpochMs;
    } else {
      _lowSpeedSinceMs = null;
    }

    final result = GpsFilter.evaluatePoint(
      previous: prev,
      candidate: candidate,
      lowSpeedSinceEpochMs: _lowSpeedSinceMs,
    );

    setState(() {
      switch (result.verdict) {
        case GpsFilterVerdict.accepted:
          _isAutoPaused = false;
          _points.add(candidate);
          _distanceM += result.addedDistanceMeters;
          _statusMessage =
              'GPS Locked (±${candidate.accuracyM.round()}m) • ${_points.length} pts';
          break;
        case GpsFilterVerdict.autoPaused:
          _isAutoPaused = true;
          _statusMessage = 'Auto-paused (stationary)';
          break;
        case GpsFilterVerdict.rejectedLowAccuracy:
          _statusMessage =
              'Weak GPS (±${candidate.accuracyM.round()}m > 20m) ignored';
          break;
        case GpsFilterVerdict.rejectedMicroJitter:
        case GpsFilterVerdict.rejectedUnrealisticSpike:
          break;
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      _statusMessage = _isPaused ? 'Run paused' : 'Run resumed';
    });
  }

  Future<void> _finishAndSave() async {
    await _posSub?.cancel();
    _clockTimer?.cancel();

    final profile = ref.read(metabolicProfileStreamProvider).valueOrNull;
    final weightKg = profile?.weightKg ?? 75.0;
    final met = _sportType == 'Cycle'
        ? 7.5
        : (_sportType == 'Walk' ? 3.8 : 9.8);
    final kcal = _distanceM < 20.0
        ? 0.0
        : NutritionCalculator.calculateNetMetBurn(
            met: met,
            weightKg: weightKg,
            durationMinutes: _elapsedSec / 60.0,
          );

    if (_elapsedSec > 0 || _points.isNotEmpty) {
      await ref.read(runRepositoryProvider).saveCompletedRun(
            sportType: _sportType,
            startEpochMs: _startEpochMs,
            durationSec: _elapsedSec,
            distanceM: _distanceM,
            caloriesKcal: kcal,
            points: List<TrackedPoint>.from(_points),
          );
    }

    if (mounted) {
      setState(() {
        _isTracking = false;
        _isPaused = false;
        _isAutoPaused = false;
        _statusMessage = 'Workout saved to Drift SQLite!';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0F766E),
          content: Text(
            'Saved $_sportType: ${(_distanceM / 1000).toStringAsFixed(2)} km • ${kcal.round()} kcal',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(recentWorkoutsProvider);
    final km = (_distanceM / 1000.0).toStringAsFixed(2);
    final duration = GpsFilter.formatDuration(_elapsedSec);
    final pace = GpsFilter.formatPacePerKm(
      distanceMeters: _distanceM,
      durationSeconds: _elapsedSec,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'GPS Run & Map Tracker',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Map View
            RouteMapWidget(
              points: _points,
              height: 240,
              fallbackCenter: const LatLng(28.6139, 77.2090),
            ),
            const SizedBox(height: 12),

            // GPS Status + Sport Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _isTracking
                          ? const Color(0xFF0F766E)
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
                if (!_isTracking)
                  DropdownButton<String>(
                    value: _sportType,
                    isDense: true,
                    items: const [
                      DropdownMenuItem(value: 'Run', child: Text('Run')),
                      DropdownMenuItem(value: 'Walk', child: Text('Walk')),
                      DropdownMenuItem(value: 'Cycle', child: Text('Cycle')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _sportType = v);
                    },
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Live Metrics HUD
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE7E5E4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _metricCol('$km km', 'Distance'),
                  _metricCol(duration, 'Duration'),
                  _metricCol('$pace /km', 'Avg Pace'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Controls
            if (!_isTracking)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startRun,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: Text(
                    'Start $_sportType',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _togglePause,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                      label: Text(_isPaused ? 'Resume' : 'Pause'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _finishAndSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.stop),
                      label: const Text('Finish'),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),
            const Text(
              'Saved GPS Activities',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 10),

            workoutsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error loading workouts: $e'),
              data: (workouts) {
                if (workouts.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE7E5E4)),
                    ),
                    child: Text(
                      'No GPS runs recorded yet. Tap Start Run above to record your first outdoor route.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                    ),
                  );
                }

                return Column(
                  children: workouts.map((w) {
                    final pts = GpsFilter.decodePolyline(w.polylineJson);
                    final distKm = (w.distanceM / 1000.0).toStringAsFixed(2);
                    final dur = GpsFilter.formatDuration(w.durationSec);
                    final wPace = GpsFilter.formatPacePerKm(
                      distanceMeters: w.distanceM,
                      durationSeconds: w.durationSec,
                    );
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE7E5E4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${w.type} • $distKm km',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '$dur • $wPace/km • ${w.caloriesKcal.round()} kcal',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 20, color: Colors.redAccent),
                                tooltip: 'Delete Activity',
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () async {
                                  final db = ref.read(runRepositoryProvider).db;
                                  await (db.delete(db.routePoints)
                                        ..where((t) => t.workoutId.equals(w.id)))
                                      .go();
                                  await (db.delete(db.workouts)
                                        ..where((t) => t.id.equals(w.id)))
                                      .go();
                                },
                              ),
                            ],
                          ),
                          if (pts.length >= 2) ...[
                            const SizedBox(height: 10),
                            RouteMapWidget(
                              points: pts,
                              height: 130,
                              interactive: false,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCol(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F766E),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
