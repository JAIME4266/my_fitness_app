import 'package:flutter/foundation.dart';
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
      debugPrint('[HealthService] Permission request failed: $e');
      return false;
    }
  }

  static Future<Map<String, int>> syncToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endOfDay = now;

    int steps = 0;
    int caloriesBurned = 0;

    try {
      await _health.configure();

      // 1. First attempt interval aggregation for steps
      int? aggregatedSteps = await _health.getTotalStepsInInterval(startOfDay, endOfDay);
      debugPrint('[HealthService] getTotalStepsInInterval: $aggregatedSteps');

      if (aggregatedSteps != null && aggregatedSteps > 0) {
        steps = aggregatedSteps;
      } else {
        // Fallback: Query raw step data points and sum
        List<HealthDataPoint> stepPoints = await _health.getHealthDataFromTypes(
          startTime: startOfDay,
          endTime: endOfDay,
          types: [HealthDataType.STEPS],
        );
        debugPrint('[HealthService] Raw step data points found: ${stepPoints.length}');

        // Track seen time intervals to prevent double-counting between phone & watch
        final Map<String, int> intervalMax = {};
        for (var point in stepPoints) {
          final v = point.value;
          if (v is NumericHealthValue) {
            final key = '${point.dateFrom.millisecondsSinceEpoch}_${point.dateTo.millisecondsSinceEpoch}';
            final val = v.numericValue.round();
            if (!intervalMax.containsKey(key) || intervalMax[key]! < val) {
              intervalMax[key] = val;
            }
          }
        }
        if (intervalMax.isNotEmpty) {
          steps = intervalMax.values.fold(0, (sum, item) => sum + item);
        } else {
          for (var point in stepPoints) {
            final v = point.value;
            if (v is NumericHealthValue) {
              steps += v.numericValue.round();
            }
          }
        }
      }

      // 2. Fetch Active Calories Burned
      List<HealthDataPoint> caloriePoints = await _health.getHealthDataFromTypes(
        startTime: startOfDay,
        endTime: endOfDay,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );
      debugPrint('[HealthService] Active calorie points found: ${caloriePoints.length}');

      for (var point in caloriePoints) {
        final v = point.value;
        if (v is NumericHealthValue) {
          caloriesBurned += v.numericValue.round();
        }
      }

      // 3. Fallback calculation if wearable reports steps but no calorie record
      if (caloriesBurned == 0 && steps > 0) {
        // Typical walking active burn: ~0.04 kcal per step
        caloriesBurned = (steps * 0.04).round();
      }

      debugPrint('[HealthService] Final Synced: Steps=$steps, Calories=$caloriesBurned');
    } catch (e) {
      debugPrint('[HealthService] Error during syncToday: $e');
    }

    return {
      'steps': steps,
      'caloriesBurned': caloriesBurned,
    };
  }
}
