import 'package:health/health.dart';

class HealthService {
  static final Health _health = Health();

  static final List<HealthDataType> types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  static Future<bool> requestPermissions() async {
    try {
      await _health.configure();
      bool? has = await _health.hasPermissions(types);
      if (has == true) return true;
      return await _health.requestAuthorization(types);
    } catch (e) {
      print('Health permission error: $e');
      return false;
    }
  }


  static Future<Map<String, dynamic>> fetchDailyData() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0).toUtc();
    final endOfDay = now.toUtc();

    int steps = 0;
    int caloriesBurned = 0;

    try {
      print('[HEALTH] Querying between $startOfDay and $endOfDay');

      int? aggregated = await _health.getTotalStepsInInterval(startOfDay, endOfDay);
      print('GHEALTH] getTotalStepsInInterval returned: $aggregated');

      if (aggregated != null && aggregated > 0) {
        steps = aggregated;
      } else {
        List<HealthDataPoint> stepPoints = await _health.getHealthDataFromTypes(
          startTime: startOfDay,
          endTime: endOfDay,
          types: [HealthDataType.STEPS],
        );
        print('[HEALTH] Raw step data points found: ${stepPoints.length}');

        for (var point in stepPoints) {
          final v = point.value;
          if (v is NumericHealthValue) {
            steps += v.numericValue.round();
          }
        }
      }

      List<HealthDataPoint> caloriePoints = await _health.getHealthDataFromTypes(
        startTime: startOfDay,
        endTime: endOfDay,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );

      for (var point in caloriePoints) {
        final v = point.value;
        if (v is NumericHealthValue) {
          caloriesBurned += v.numericValue.round();
        }
      }

      if (caloriesBurned == 0 && steps > 0) {
        caloriesBurned = (steps * 0.04).round();
      }

      print('[HEALTH] Final Calculated: Steps=$steps, Calories=$caloriesBurned');
    } catch (e) {
      print('Error fetching health data: $e');
    }

    return {
      'steps': steps,
      'caloriesBurned': caloriesBurned,
    };
  }
}
