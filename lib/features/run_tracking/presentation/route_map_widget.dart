import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../domain/gps_filter.dart';

/// Reusable map widget powered by flutter_map + OpenStreetMap/Carto tiles.
/// Used both in the live Run Tracker (Phase 4) and Community Feed cards (Phase 5).
class RouteMapWidget extends StatelessWidget {
  final List<TrackedPoint> points;
  final double height;
  final bool interactive;
  final LatLng? fallbackCenter;
  final BorderRadius borderRadius;
  final TileProvider? tileProvider;

  const RouteMapWidget({
    super.key,
    required this.points,
    this.height = 200,
    this.interactive = true,
    this.fallbackCenter,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.tileProvider,
  });

  @override
  Widget build(BuildContext context) {
    final latLngs = points.map((p) => LatLng(p.lat, p.lng)).toList();
    final center = latLngs.isNotEmpty
        ? latLngs[latLngs.length ~/ 2]
        : (fallbackCenter ?? const LatLng(28.6139, 77.2090));

    final bounds = latLngs.length >= 2 ? LatLngBounds.fromPoints(latLngs) : null;

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 15.0,
                initialCameraFit: bounds != null
                    ? CameraFit.bounds(
                        bounds: bounds,
                        padding: const EdgeInsets.all(28),
                        maxZoom: 17.0,
                      )
                    : null,
                interactionOptions: InteractionOptions(
                  flags: interactive
                      ? InteractiveFlag.all
                      : InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.my_fitness_app',
                  tileProvider: tileProvider,
                ),
                if (latLngs.length >= 2)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: latLngs,
                        strokeWidth: 4.5,
                        color: const Color(0xFF0F766E),
                      ),
                    ],
                  ),
                if (latLngs.isNotEmpty)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: latLngs.first,
                        width: 28,
                        height: 28,
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFF0F766E),
                          size: 28,
                        ),
                      ),
                      if (latLngs.length >= 2)
                        Marker(
                          point: latLngs.last,
                          width: 28,
                          height: 28,
                          child: const Icon(
                            Icons.flag_circle,
                            color: Colors.deepOrange,
                            size: 26,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            Positioned(
              right: 6,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '© OpenStreetMap • CARTO',
                  style: TextStyle(fontSize: 9, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
