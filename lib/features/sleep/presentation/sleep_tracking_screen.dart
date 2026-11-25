import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import '../../../database/database.dart';
import '../data/sleep_chronotype_analyzer.dart';

class SleepTrackingScreen extends StatefulWidget {
  final AppDatabase db;

  const SleepTrackingScreen({super.key, required this.db});

  @override
  State<SleepTrackingScreen> createState() => _SleepTrackingScreenState();
}

class _SleepTrackingScreenState extends State<SleepTrackingScreen> {
  bool _isSyncing = false;
  String? _syncStatus;

  Future<void> _syncFromHealthConnect() async {
    if (_isSyncing) return;
    setState(() {
      _isSyncing = true;
      _syncStatus = null;
    });

    try {
      final health = Health();
      await health.configure();
      final types = [
        HealthDataType.SLEEP_SESSION,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_REM,
        HealthDataType.SLEEP_AWAKE,
      ];
      final granted = await health.requestAuthorization(types);
      if (!granted) {
        if (!mounted) return;
        setState(() {
          _isSyncing = false;
          _syncStatus = 'Health Connect sleep permission not granted.';
        });
        return;
      }

      final now = DateTime.now();
      final start = now.subtract(const Duration(days: 14));
      final points = await health.getHealthDataFromTypes(
        types: types,
        startTime: start,
        endTime: now,
      );

      final sessions = points
          .where((p) => p.type == HealthDataType.SLEEP_SESSION)
          .toList();

      int saved = 0;
      for (final s in sessions) {
        final durationMins = s.dateTo.difference(s.dateFrom).inMinutes;
        if (durationMins <= 0) continue;

        int? sumStage(HealthDataType stageType) {
          final matching = points.where((p) =>
              p.type == stageType &&
              !p.dateFrom.isBefore(s.dateFrom) &&
              !p.dateTo.isAfter(s.dateTo));
          if (matching.isEmpty) return null;
          return matching.fold<int>(
            0,
            (acc, p) => acc + p.dateTo.difference(p.dateFrom).inMinutes,
          );
        }

        await widget.db.into(widget.db.sleepRecords).insertOnConflictUpdate(
              SleepRecordsCompanion(
                id: Value('hc_${s.dateFrom.millisecondsSinceEpoch}'),
                startTime: Value(s.dateFrom),
                endTime: Value(s.dateTo),
                durationMinutes: Value(durationMins),
                deepMinutes: Value(sumStage(HealthDataType.SLEEP_DEEP)),
                lightMinutes: Value(sumStage(HealthDataType.SLEEP_LIGHT)),
                remMinutes: Value(sumStage(HealthDataType.SLEEP_REM)),
                awakeMinutes: Value(sumStage(HealthDataType.SLEEP_AWAKE)),
                source: const Value('health_connect'),
              ),
            );
        saved++;
      }

      if (!mounted) return;
      setState(() {
        _isSyncing = false;
        _syncStatus = 'Synced $saved sleep session(s) from Health Connect.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSyncing = false;
        _syncStatus = 'Health Connect unavailable on this device ($e).';
      });
    }
  }

  Future<void> _showManualLogDialog() async {
    double hours = 7.5;
    int bedtimeHour = 23;
    int quality = 4;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Log Sleep Manually'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Duration: ${hours.toStringAsFixed(1)} hrs'),
              Slider(
                value: hours,
                min: 3.0,
                max: 12.0,
                divisions: 18,
                onChanged: (v) => setDialogState(() => hours = v),
              ),
              Text('Bedtime: $bedtimeHour:00'),
              Slider(
                value: bedtimeHour.toDouble(),
                min: 20,
                max: 26,
                divisions: 6,
                onChanged: (v) =>
                    setDialogState(() => bedtimeHour = v.round() % 24),
              ),
              Text('Quality: $quality / 5'),
              Slider(
                value: quality.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (v) => setDialogState(() => quality = v.round()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final now = DateTime.now();
                final start = DateTime(
                  now.year,
                  now.month,
                  now.day - 1,
                  bedtimeHour,
                );
                final mins = (hours * 60).round();
                final end = start.add(Duration(minutes: mins));
                await widget.db
                    .into(widget.db.sleepRecords)
                    .insertOnConflictUpdate(
                      SleepRecordsCompanion(
                        id: Value('manual_${now.microsecondsSinceEpoch}'),
                        startTime: Value(start),
                        endTime: Value(end),
                        durationMinutes: Value(mins),
                        source: const Value('manual'),
                        qualityRating: Value(quality),
                      ),
                    );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Sleep & Chronotype'),
        actions: [
          IconButton(
            tooltip: 'Sync Health Connect',
            icon: const Icon(Icons.sync),
            onPressed: _isSyncing ? null : _syncFromHealthConnect,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showManualLogDialog,
        icon: const Icon(Icons.bedtime),
        label: const Text('Log Sleep'),
      ),
      body: StreamBuilder<List<SleepRecord>>(
        stream: (widget.db.select(widget.db.sleepRecords)
              ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
            .watch(),
        builder: (context, snap) {
          final records = snap.data ?? const [];
          final analysis = SleepChronotypeAnalyzer.analyze(records);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_syncStatus != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(_syncStatus!),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Card(
                color: const Color(0xFF0F172A),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sleep Animal: ${analysis.animal.title}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        analysis.animal.subtitle,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Avg: ${analysis.averageDurationHours} hrs',
                            style: const TextStyle(color: Colors.tealAccent),
                          ),
                          Text(
                            'Consistency: ${analysis.consistencyScore}%',
                            style: const TextStyle(color: Colors.tealAccent),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Peak focus: ${analysis.animal.peakWindow} • Ideal bedtime: ${analysis.animal.idealBedtime}',
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        analysis.disclaimer,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Recent Sleep Sessions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (records.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No sleep sessions logged yet. Tap "Log Sleep" or sync with Health Connect.',
                    ),
                  ),
                )
              else
                ...records.map((r) {
                  final hrs = (r.durationMinutes / 60.0).toStringAsFixed(1);
                  final hasStages = r.deepMinutes != null ||
                      r.lightMinutes != null ||
                      r.remMinutes != null;
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.nights_stay_outlined),
                      title: Text('$hrs hrs (${r.source})'),
                      subtitle: Text(
                        hasStages
                            ? 'Deep ${r.deepMinutes ?? 0}m • Light ${r.lightMinutes ?? 0}m • REM ${r.remMinutes ?? 0}m'
                            : 'Bedtime ${r.startTime.hour.toString().padLeft(2, '0')}:${r.startTime.minute.toString().padLeft(2, '0')}',
                      ),
                      trailing: r.qualityRating != null
                          ? Text('${r.qualityRating}/5 ★')
                          : null,
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}
