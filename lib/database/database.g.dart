// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DailySummariesTable extends DailySummaries
    with TableInfo<$DailySummariesTable, DailySummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailySummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _activeCaloriesMeta = const VerificationMeta(
    'activeCalories',
  );
  @override
  late final GeneratedColumn<int> activeCalories = GeneratedColumn<int>(
    'active_calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetCaloriesMeta = const VerificationMeta(
    'targetCalories',
  );
  @override
  late final GeneratedColumn<int> targetCalories = GeneratedColumn<int>(
    'target_calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2200),
  );
  static const VerificationMeta _consumedCaloriesMeta = const VerificationMeta(
    'consumedCalories',
  );
  @override
  late final GeneratedColumn<int> consumedCalories = GeneratedColumn<int>(
    'consumed_calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _waterMlMeta = const VerificationMeta(
    'waterMl',
  );
  @override
  late final GeneratedColumn<int> waterMl = GeneratedColumn<int>(
    'water_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    steps,
    activeCalories,
    targetCalories,
    consumedCalories,
    waterMl,
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailySummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('active_calories')) {
      context.handle(
        _activeCaloriesMeta,
        activeCalories.isAcceptableOrUnknown(
          data['active_calories']!,
          _activeCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('target_calories')) {
      context.handle(
        _targetCaloriesMeta,
        targetCalories.isAcceptableOrUnknown(
          data['target_calories']!,
          _targetCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('consumed_calories')) {
      context.handle(
        _consumedCaloriesMeta,
        consumedCalories.isAcceptableOrUnknown(
          data['consumed_calories']!,
          _consumedCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('water_ml')) {
      context.handle(
        _waterMlMeta,
        waterMl.isAcceptableOrUnknown(data['water_ml']!, _waterMlMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailySummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailySummary(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      activeCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_calories'],
      )!,
      targetCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_calories'],
      )!,
      consumedCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consumed_calories'],
      )!,
      waterMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_ml'],
      )!,
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $DailySummariesTable createAlias(String alias) {
    return $DailySummariesTable(attachedDatabase, alias);
  }
}

class DailySummary extends DataClass implements Insertable<DailySummary> {
  final String date;
  final int steps;
  final int activeCalories;
  final int targetCalories;
  final int consumedCalories;
  final int waterMl;
  final DateTime? lastSync;
  const DailySummary({
    required this.date,
    required this.steps,
    required this.activeCalories,
    required this.targetCalories,
    required this.consumedCalories,
    required this.waterMl,
    this.lastSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['steps'] = Variable<int>(steps);
    map['active_calories'] = Variable<int>(activeCalories);
    map['target_calories'] = Variable<int>(targetCalories);
    map['consumed_calories'] = Variable<int>(consumedCalories);
    map['water_ml'] = Variable<int>(waterMl);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  DailySummariesCompanion toCompanion(bool nullToAbsent) {
    return DailySummariesCompanion(
      date: Value(date),
      steps: Value(steps),
      activeCalories: Value(activeCalories),
      targetCalories: Value(targetCalories),
      consumedCalories: Value(consumedCalories),
      waterMl: Value(waterMl),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory DailySummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailySummary(
      date: serializer.fromJson<String>(json['date']),
      steps: serializer.fromJson<int>(json['steps']),
      activeCalories: serializer.fromJson<int>(json['activeCalories']),
      targetCalories: serializer.fromJson<int>(json['targetCalories']),
      consumedCalories: serializer.fromJson<int>(json['consumedCalories']),
      waterMl: serializer.fromJson<int>(json['waterMl']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'steps': serializer.toJson<int>(steps),
      'activeCalories': serializer.toJson<int>(activeCalories),
      'targetCalories': serializer.toJson<int>(targetCalories),
      'consumedCalories': serializer.toJson<int>(consumedCalories),
      'waterMl': serializer.toJson<int>(waterMl),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  DailySummary copyWith({
    String? date,
    int? steps,
    int? activeCalories,
    int? targetCalories,
    int? consumedCalories,
    int? waterMl,
    Value<DateTime?> lastSync = const Value.absent(),
  }) => DailySummary(
    date: date ?? this.date,
    steps: steps ?? this.steps,
    activeCalories: activeCalories ?? this.activeCalories,
    targetCalories: targetCalories ?? this.targetCalories,
    consumedCalories: consumedCalories ?? this.consumedCalories,
    waterMl: waterMl ?? this.waterMl,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  DailySummary copyWithCompanion(DailySummariesCompanion data) {
    return DailySummary(
      date: data.date.present ? data.date.value : this.date,
      steps: data.steps.present ? data.steps.value : this.steps,
      activeCalories: data.activeCalories.present
          ? data.activeCalories.value
          : this.activeCalories,
      targetCalories: data.targetCalories.present
          ? data.targetCalories.value
          : this.targetCalories,
      consumedCalories: data.consumedCalories.present
          ? data.consumedCalories.value
          : this.consumedCalories,
      waterMl: data.waterMl.present ? data.waterMl.value : this.waterMl,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailySummary(')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('activeCalories: $activeCalories, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('consumedCalories: $consumedCalories, ')
          ..write('waterMl: $waterMl, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    date,
    steps,
    activeCalories,
    targetCalories,
    consumedCalories,
    waterMl,
    lastSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailySummary &&
          other.date == this.date &&
          other.steps == this.steps &&
          other.activeCalories == this.activeCalories &&
          other.targetCalories == this.targetCalories &&
          other.consumedCalories == this.consumedCalories &&
          other.waterMl == this.waterMl &&
          other.lastSync == this.lastSync);
}

class DailySummariesCompanion extends UpdateCompanion<DailySummary> {
  final Value<String> date;
  final Value<int> steps;
  final Value<int> activeCalories;
  final Value<int> targetCalories;
  final Value<int> consumedCalories;
  final Value<int> waterMl;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const DailySummariesCompanion({
    this.date = const Value.absent(),
    this.steps = const Value.absent(),
    this.activeCalories = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.consumedCalories = const Value.absent(),
    this.waterMl = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailySummariesCompanion.insert({
    required String date,
    this.steps = const Value.absent(),
    this.activeCalories = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.consumedCalories = const Value.absent(),
    this.waterMl = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailySummary> custom({
    Expression<String>? date,
    Expression<int>? steps,
    Expression<int>? activeCalories,
    Expression<int>? targetCalories,
    Expression<int>? consumedCalories,
    Expression<int>? waterMl,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (steps != null) 'steps': steps,
      if (activeCalories != null) 'active_calories': activeCalories,
      if (targetCalories != null) 'target_calories': targetCalories,
      if (consumedCalories != null) 'consumed_calories': consumedCalories,
      if (waterMl != null) 'water_ml': waterMl,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailySummariesCompanion copyWith({
    Value<String>? date,
    Value<int>? steps,
    Value<int>? activeCalories,
    Value<int>? targetCalories,
    Value<int>? consumedCalories,
    Value<int>? waterMl,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return DailySummariesCompanion(
      date: date ?? this.date,
      steps: steps ?? this.steps,
      activeCalories: activeCalories ?? this.activeCalories,
      targetCalories: targetCalories ?? this.targetCalories,
      consumedCalories: consumedCalories ?? this.consumedCalories,
      waterMl: waterMl ?? this.waterMl,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (activeCalories.present) {
      map['active_calories'] = Variable<int>(activeCalories.value);
    }
    if (targetCalories.present) {
      map['target_calories'] = Variable<int>(targetCalories.value);
    }
    if (consumedCalories.present) {
      map['consumed_calories'] = Variable<int>(consumedCalories.value);
    }
    if (waterMl.present) {
      map['water_ml'] = Variable<int>(waterMl.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailySummariesCompanion(')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('activeCalories: $activeCalories, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('consumedCalories: $consumedCalories, ')
          ..write('waterMl: $waterMl, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startEpochMsMeta = const VerificationMeta(
    'startEpochMs',
  );
  @override
  late final GeneratedColumn<int> startEpochMs = GeneratedColumn<int>(
    'start_epoch_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  @override
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _caloriesKcalMeta = const VerificationMeta(
    'caloriesKcal',
  );
  @override
  late final GeneratedColumn<double> caloriesKcal = GeneratedColumn<double>(
    'calories_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _polylineJsonMeta = const VerificationMeta(
    'polylineJson',
  );
  @override
  late final GeneratedColumn<String> polylineJson = GeneratedColumn<String>(
    'polyline_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    startEpochMs,
    durationSec,
    distanceM,
    caloriesKcal,
    polylineJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_epoch_ms')) {
      context.handle(
        _startEpochMsMeta,
        startEpochMs.isAcceptableOrUnknown(
          data['start_epoch_ms']!,
          _startEpochMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startEpochMsMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    }
    if (data.containsKey('calories_kcal')) {
      context.handle(
        _caloriesKcalMeta,
        caloriesKcal.isAcceptableOrUnknown(
          data['calories_kcal']!,
          _caloriesKcalMeta,
        ),
      );
    }
    if (data.containsKey('polyline_json')) {
      context.handle(
        _polylineJsonMeta,
        polylineJson.isAcceptableOrUnknown(
          data['polyline_json']!,
          _polylineJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startEpochMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_epoch_ms'],
      )!,
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      )!,
      caloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_kcal'],
      )!,
      polylineJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}polyline_json'],
      ),
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final String id;
  final String type;
  final int startEpochMs;
  final int durationSec;
  final double distanceM;
  final double caloriesKcal;
  final String? polylineJson;
  const Workout({
    required this.id,
    required this.type,
    required this.startEpochMs,
    required this.durationSec,
    required this.distanceM,
    required this.caloriesKcal,
    this.polylineJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['start_epoch_ms'] = Variable<int>(startEpochMs);
    map['duration_sec'] = Variable<int>(durationSec);
    map['distance_m'] = Variable<double>(distanceM);
    map['calories_kcal'] = Variable<double>(caloriesKcal);
    if (!nullToAbsent || polylineJson != null) {
      map['polyline_json'] = Variable<String>(polylineJson);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      type: Value(type),
      startEpochMs: Value(startEpochMs),
      durationSec: Value(durationSec),
      distanceM: Value(distanceM),
      caloriesKcal: Value(caloriesKcal),
      polylineJson: polylineJson == null && nullToAbsent
          ? const Value.absent()
          : Value(polylineJson),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      startEpochMs: serializer.fromJson<int>(json['startEpochMs']),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      distanceM: serializer.fromJson<double>(json['distanceM']),
      caloriesKcal: serializer.fromJson<double>(json['caloriesKcal']),
      polylineJson: serializer.fromJson<String?>(json['polylineJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'startEpochMs': serializer.toJson<int>(startEpochMs),
      'durationSec': serializer.toJson<int>(durationSec),
      'distanceM': serializer.toJson<double>(distanceM),
      'caloriesKcal': serializer.toJson<double>(caloriesKcal),
      'polylineJson': serializer.toJson<String?>(polylineJson),
    };
  }

  Workout copyWith({
    String? id,
    String? type,
    int? startEpochMs,
    int? durationSec,
    double? distanceM,
    double? caloriesKcal,
    Value<String?> polylineJson = const Value.absent(),
  }) => Workout(
    id: id ?? this.id,
    type: type ?? this.type,
    startEpochMs: startEpochMs ?? this.startEpochMs,
    durationSec: durationSec ?? this.durationSec,
    distanceM: distanceM ?? this.distanceM,
    caloriesKcal: caloriesKcal ?? this.caloriesKcal,
    polylineJson: polylineJson.present ? polylineJson.value : this.polylineJson,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      startEpochMs: data.startEpochMs.present
          ? data.startEpochMs.value
          : this.startEpochMs,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      caloriesKcal: data.caloriesKcal.present
          ? data.caloriesKcal.value
          : this.caloriesKcal,
      polylineJson: data.polylineJson.present
          ? data.polylineJson.value
          : this.polylineJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('startEpochMs: $startEpochMs, ')
          ..write('durationSec: $durationSec, ')
          ..write('distanceM: $distanceM, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('polylineJson: $polylineJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    startEpochMs,
    durationSec,
    distanceM,
    caloriesKcal,
    polylineJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.type == this.type &&
          other.startEpochMs == this.startEpochMs &&
          other.durationSec == this.durationSec &&
          other.distanceM == this.distanceM &&
          other.caloriesKcal == this.caloriesKcal &&
          other.polylineJson == this.polylineJson);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> id;
  final Value<String> type;
  final Value<int> startEpochMs;
  final Value<int> durationSec;
  final Value<double> distanceM;
  final Value<double> caloriesKcal;
  final Value<String?> polylineJson;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.startEpochMs = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.polylineJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required String type,
    required int startEpochMs,
    this.durationSec = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.polylineJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       startEpochMs = Value(startEpochMs);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? startEpochMs,
    Expression<int>? durationSec,
    Expression<double>? distanceM,
    Expression<double>? caloriesKcal,
    Expression<String>? polylineJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (startEpochMs != null) 'start_epoch_ms': startEpochMs,
      if (durationSec != null) 'duration_sec': durationSec,
      if (distanceM != null) 'distance_m': distanceM,
      if (caloriesKcal != null) 'calories_kcal': caloriesKcal,
      if (polylineJson != null) 'polyline_json': polylineJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<int>? startEpochMs,
    Value<int>? durationSec,
    Value<double>? distanceM,
    Value<double>? caloriesKcal,
    Value<String?>? polylineJson,
    Value<int>? rowid,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      startEpochMs: startEpochMs ?? this.startEpochMs,
      durationSec: durationSec ?? this.durationSec,
      distanceM: distanceM ?? this.distanceM,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      polylineJson: polylineJson ?? this.polylineJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startEpochMs.present) {
      map['start_epoch_ms'] = Variable<int>(startEpochMs.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (caloriesKcal.present) {
      map['calories_kcal'] = Variable<double>(caloriesKcal.value);
    }
    if (polylineJson.present) {
      map['polyline_json'] = Variable<String>(polylineJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('startEpochMs: $startEpochMs, ')
          ..write('durationSec: $durationSec, ')
          ..write('distanceM: $distanceM, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('polylineJson: $polylineJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodCatalogTable extends FoodCatalog
    with TableInfo<$FoodCatalogTable, FoodCatalogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodCatalogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hindiNameMeta = const VerificationMeta(
    'hindiName',
  );
  @override
  late final GeneratedColumn<String> hindiName = GeneratedColumn<String>(
    'hindi_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('General'),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ifct_2017'),
  );
  static const VerificationMeta _defaultBasisMeta = const VerificationMeta(
    'defaultBasis',
  );
  @override
  late final GeneratedColumn<String> defaultBasis = GeneratedColumn<String>(
    'default_basis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cooked'),
  );
  static const VerificationMeta _yieldFactorMeta = const VerificationMeta(
    'yieldFactor',
  );
  @override
  late final GeneratedColumn<double> yieldFactor = GeneratedColumn<double>(
    'yield_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _kcalPer100gMeta = const VerificationMeta(
    'kcalPer100g',
  );
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
    'kcal_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fibrePer100gMeta = const VerificationMeta(
    'fibrePer100g',
  );
  @override
  late final GeneratedColumn<double> fibrePer100g = GeneratedColumn<double>(
    'fibre_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _saturatedFatPer100gMeta =
      const VerificationMeta('saturatedFatPer100g');
  @override
  late final GeneratedColumn<double> saturatedFatPer100g =
      GeneratedColumn<double>(
        'saturated_fat_per100g',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sugarPer100gMeta = const VerificationMeta(
    'sugarPer100g',
  );
  @override
  late final GeneratedColumn<double> sugarPer100g = GeneratedColumn<double>(
    'sugar_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sodiumMgPer100gMeta = const VerificationMeta(
    'sodiumMgPer100g',
  );
  @override
  late final GeneratedColumn<double> sodiumMgPer100g = GeneratedColumn<double>(
    'sodium_mg_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultServingGMeta = const VerificationMeta(
    'defaultServingG',
  );
  @override
  late final GeneratedColumn<double> defaultServingG = GeneratedColumn<double>(
    'default_serving_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(100.0),
  );
  static const VerificationMeta _servingLabelMeta = const VerificationMeta(
    'servingLabel',
  );
  @override
  late final GeneratedColumn<String> servingLabel = GeneratedColumn<String>(
    'serving_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('100g'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    hindiName,
    category,
    barcode,
    source,
    defaultBasis,
    yieldFactor,
    kcalPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    fibrePer100g,
    saturatedFatPer100g,
    sugarPer100g,
    sodiumMgPer100g,
    defaultServingG,
    servingLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_catalog';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodCatalogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hindi_name')) {
      context.handle(
        _hindiNameMeta,
        hindiName.isAcceptableOrUnknown(data['hindi_name']!, _hindiNameMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('default_basis')) {
      context.handle(
        _defaultBasisMeta,
        defaultBasis.isAcceptableOrUnknown(
          data['default_basis']!,
          _defaultBasisMeta,
        ),
      );
    }
    if (data.containsKey('yield_factor')) {
      context.handle(
        _yieldFactorMeta,
        yieldFactor.isAcceptableOrUnknown(
          data['yield_factor']!,
          _yieldFactorMeta,
        ),
      );
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
        _kcalPer100gMeta,
        kcalPer100g.isAcceptableOrUnknown(
          data['kcal_per100g']!,
          _kcalPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kcalPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('fibre_per100g')) {
      context.handle(
        _fibrePer100gMeta,
        fibrePer100g.isAcceptableOrUnknown(
          data['fibre_per100g']!,
          _fibrePer100gMeta,
        ),
      );
    }
    if (data.containsKey('saturated_fat_per100g')) {
      context.handle(
        _saturatedFatPer100gMeta,
        saturatedFatPer100g.isAcceptableOrUnknown(
          data['saturated_fat_per100g']!,
          _saturatedFatPer100gMeta,
        ),
      );
    }
    if (data.containsKey('sugar_per100g')) {
      context.handle(
        _sugarPer100gMeta,
        sugarPer100g.isAcceptableOrUnknown(
          data['sugar_per100g']!,
          _sugarPer100gMeta,
        ),
      );
    }
    if (data.containsKey('sodium_mg_per100g')) {
      context.handle(
        _sodiumMgPer100gMeta,
        sodiumMgPer100g.isAcceptableOrUnknown(
          data['sodium_mg_per100g']!,
          _sodiumMgPer100gMeta,
        ),
      );
    }
    if (data.containsKey('default_serving_g')) {
      context.handle(
        _defaultServingGMeta,
        defaultServingG.isAcceptableOrUnknown(
          data['default_serving_g']!,
          _defaultServingGMeta,
        ),
      );
    }
    if (data.containsKey('serving_label')) {
      context.handle(
        _servingLabelMeta,
        servingLabel.isAcceptableOrUnknown(
          data['serving_label']!,
          _servingLabelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodCatalogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodCatalogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hindiName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hindi_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      defaultBasis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_basis'],
      )!,
      yieldFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_factor'],
      )!,
      kcalPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      fibrePer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fibre_per100g'],
      )!,
      saturatedFatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saturated_fat_per100g'],
      ),
      sugarPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sugar_per100g'],
      ),
      sodiumMgPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium_mg_per100g'],
      ),
      defaultServingG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_serving_g'],
      )!,
      servingLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serving_label'],
      )!,
    );
  }

  @override
  $FoodCatalogTable createAlias(String alias) {
    return $FoodCatalogTable(attachedDatabase, alias);
  }
}

class FoodCatalogData extends DataClass implements Insertable<FoodCatalogData> {
  final String id;
  final String name;
  final String hindiName;
  final String category;
  final String? barcode;
  final String source;
  final String defaultBasis;
  final double yieldFactor;
  final double kcalPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double fibrePer100g;
  final double? saturatedFatPer100g;
  final double? sugarPer100g;
  final double? sodiumMgPer100g;
  final double defaultServingG;
  final String servingLabel;
  const FoodCatalogData({
    required this.id,
    required this.name,
    required this.hindiName,
    required this.category,
    this.barcode,
    required this.source,
    required this.defaultBasis,
    required this.yieldFactor,
    required this.kcalPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.fibrePer100g,
    this.saturatedFatPer100g,
    this.sugarPer100g,
    this.sodiumMgPer100g,
    required this.defaultServingG,
    required this.servingLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['hindi_name'] = Variable<String>(hindiName);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['source'] = Variable<String>(source);
    map['default_basis'] = Variable<String>(defaultBasis);
    map['yield_factor'] = Variable<double>(yieldFactor);
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['fibre_per100g'] = Variable<double>(fibrePer100g);
    if (!nullToAbsent || saturatedFatPer100g != null) {
      map['saturated_fat_per100g'] = Variable<double>(saturatedFatPer100g);
    }
    if (!nullToAbsent || sugarPer100g != null) {
      map['sugar_per100g'] = Variable<double>(sugarPer100g);
    }
    if (!nullToAbsent || sodiumMgPer100g != null) {
      map['sodium_mg_per100g'] = Variable<double>(sodiumMgPer100g);
    }
    map['default_serving_g'] = Variable<double>(defaultServingG);
    map['serving_label'] = Variable<String>(servingLabel);
    return map;
  }

  FoodCatalogCompanion toCompanion(bool nullToAbsent) {
    return FoodCatalogCompanion(
      id: Value(id),
      name: Value(name),
      hindiName: Value(hindiName),
      category: Value(category),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      source: Value(source),
      defaultBasis: Value(defaultBasis),
      yieldFactor: Value(yieldFactor),
      kcalPer100g: Value(kcalPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      fibrePer100g: Value(fibrePer100g),
      saturatedFatPer100g: saturatedFatPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(saturatedFatPer100g),
      sugarPer100g: sugarPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(sugarPer100g),
      sodiumMgPer100g: sodiumMgPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMgPer100g),
      defaultServingG: Value(defaultServingG),
      servingLabel: Value(servingLabel),
    );
  }

  factory FoodCatalogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodCatalogData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      hindiName: serializer.fromJson<String>(json['hindiName']),
      category: serializer.fromJson<String>(json['category']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      source: serializer.fromJson<String>(json['source']),
      defaultBasis: serializer.fromJson<String>(json['defaultBasis']),
      yieldFactor: serializer.fromJson<double>(json['yieldFactor']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      fibrePer100g: serializer.fromJson<double>(json['fibrePer100g']),
      saturatedFatPer100g: serializer.fromJson<double?>(
        json['saturatedFatPer100g'],
      ),
      sugarPer100g: serializer.fromJson<double?>(json['sugarPer100g']),
      sodiumMgPer100g: serializer.fromJson<double?>(json['sodiumMgPer100g']),
      defaultServingG: serializer.fromJson<double>(json['defaultServingG']),
      servingLabel: serializer.fromJson<String>(json['servingLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'hindiName': serializer.toJson<String>(hindiName),
      'category': serializer.toJson<String>(category),
      'barcode': serializer.toJson<String?>(barcode),
      'source': serializer.toJson<String>(source),
      'defaultBasis': serializer.toJson<String>(defaultBasis),
      'yieldFactor': serializer.toJson<double>(yieldFactor),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'fibrePer100g': serializer.toJson<double>(fibrePer100g),
      'saturatedFatPer100g': serializer.toJson<double?>(saturatedFatPer100g),
      'sugarPer100g': serializer.toJson<double?>(sugarPer100g),
      'sodiumMgPer100g': serializer.toJson<double?>(sodiumMgPer100g),
      'defaultServingG': serializer.toJson<double>(defaultServingG),
      'servingLabel': serializer.toJson<String>(servingLabel),
    };
  }

  FoodCatalogData copyWith({
    String? id,
    String? name,
    String? hindiName,
    String? category,
    Value<String?> barcode = const Value.absent(),
    String? source,
    String? defaultBasis,
    double? yieldFactor,
    double? kcalPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
    double? fibrePer100g,
    Value<double?> saturatedFatPer100g = const Value.absent(),
    Value<double?> sugarPer100g = const Value.absent(),
    Value<double?> sodiumMgPer100g = const Value.absent(),
    double? defaultServingG,
    String? servingLabel,
  }) => FoodCatalogData(
    id: id ?? this.id,
    name: name ?? this.name,
    hindiName: hindiName ?? this.hindiName,
    category: category ?? this.category,
    barcode: barcode.present ? barcode.value : this.barcode,
    source: source ?? this.source,
    defaultBasis: defaultBasis ?? this.defaultBasis,
    yieldFactor: yieldFactor ?? this.yieldFactor,
    kcalPer100g: kcalPer100g ?? this.kcalPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    fibrePer100g: fibrePer100g ?? this.fibrePer100g,
    saturatedFatPer100g: saturatedFatPer100g.present
        ? saturatedFatPer100g.value
        : this.saturatedFatPer100g,
    sugarPer100g: sugarPer100g.present ? sugarPer100g.value : this.sugarPer100g,
    sodiumMgPer100g: sodiumMgPer100g.present
        ? sodiumMgPer100g.value
        : this.sodiumMgPer100g,
    defaultServingG: defaultServingG ?? this.defaultServingG,
    servingLabel: servingLabel ?? this.servingLabel,
  );
  FoodCatalogData copyWithCompanion(FoodCatalogCompanion data) {
    return FoodCatalogData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      hindiName: data.hindiName.present ? data.hindiName.value : this.hindiName,
      category: data.category.present ? data.category.value : this.category,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      source: data.source.present ? data.source.value : this.source,
      defaultBasis: data.defaultBasis.present
          ? data.defaultBasis.value
          : this.defaultBasis,
      yieldFactor: data.yieldFactor.present
          ? data.yieldFactor.value
          : this.yieldFactor,
      kcalPer100g: data.kcalPer100g.present
          ? data.kcalPer100g.value
          : this.kcalPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      fibrePer100g: data.fibrePer100g.present
          ? data.fibrePer100g.value
          : this.fibrePer100g,
      saturatedFatPer100g: data.saturatedFatPer100g.present
          ? data.saturatedFatPer100g.value
          : this.saturatedFatPer100g,
      sugarPer100g: data.sugarPer100g.present
          ? data.sugarPer100g.value
          : this.sugarPer100g,
      sodiumMgPer100g: data.sodiumMgPer100g.present
          ? data.sodiumMgPer100g.value
          : this.sodiumMgPer100g,
      defaultServingG: data.defaultServingG.present
          ? data.defaultServingG.value
          : this.defaultServingG,
      servingLabel: data.servingLabel.present
          ? data.servingLabel.value
          : this.servingLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodCatalogData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('hindiName: $hindiName, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('source: $source, ')
          ..write('defaultBasis: $defaultBasis, ')
          ..write('yieldFactor: $yieldFactor, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fibrePer100g: $fibrePer100g, ')
          ..write('saturatedFatPer100g: $saturatedFatPer100g, ')
          ..write('sugarPer100g: $sugarPer100g, ')
          ..write('sodiumMgPer100g: $sodiumMgPer100g, ')
          ..write('defaultServingG: $defaultServingG, ')
          ..write('servingLabel: $servingLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    hindiName,
    category,
    barcode,
    source,
    defaultBasis,
    yieldFactor,
    kcalPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    fibrePer100g,
    saturatedFatPer100g,
    sugarPer100g,
    sodiumMgPer100g,
    defaultServingG,
    servingLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodCatalogData &&
          other.id == this.id &&
          other.name == this.name &&
          other.hindiName == this.hindiName &&
          other.category == this.category &&
          other.barcode == this.barcode &&
          other.source == this.source &&
          other.defaultBasis == this.defaultBasis &&
          other.yieldFactor == this.yieldFactor &&
          other.kcalPer100g == this.kcalPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.fibrePer100g == this.fibrePer100g &&
          other.saturatedFatPer100g == this.saturatedFatPer100g &&
          other.sugarPer100g == this.sugarPer100g &&
          other.sodiumMgPer100g == this.sodiumMgPer100g &&
          other.defaultServingG == this.defaultServingG &&
          other.servingLabel == this.servingLabel);
}

class FoodCatalogCompanion extends UpdateCompanion<FoodCatalogData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> hindiName;
  final Value<String> category;
  final Value<String?> barcode;
  final Value<String> source;
  final Value<String> defaultBasis;
  final Value<double> yieldFactor;
  final Value<double> kcalPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  final Value<double> fibrePer100g;
  final Value<double?> saturatedFatPer100g;
  final Value<double?> sugarPer100g;
  final Value<double?> sodiumMgPer100g;
  final Value<double> defaultServingG;
  final Value<String> servingLabel;
  final Value<int> rowid;
  const FoodCatalogCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.hindiName = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.source = const Value.absent(),
    this.defaultBasis = const Value.absent(),
    this.yieldFactor = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fibrePer100g = const Value.absent(),
    this.saturatedFatPer100g = const Value.absent(),
    this.sugarPer100g = const Value.absent(),
    this.sodiumMgPer100g = const Value.absent(),
    this.defaultServingG = const Value.absent(),
    this.servingLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodCatalogCompanion.insert({
    required String id,
    required String name,
    this.hindiName = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.source = const Value.absent(),
    this.defaultBasis = const Value.absent(),
    this.yieldFactor = const Value.absent(),
    required double kcalPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    this.fibrePer100g = const Value.absent(),
    this.saturatedFatPer100g = const Value.absent(),
    this.sugarPer100g = const Value.absent(),
    this.sodiumMgPer100g = const Value.absent(),
    this.defaultServingG = const Value.absent(),
    this.servingLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kcalPer100g = Value(kcalPer100g),
       proteinPer100g = Value(proteinPer100g),
       carbsPer100g = Value(carbsPer100g),
       fatPer100g = Value(fatPer100g);
  static Insertable<FoodCatalogData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? hindiName,
    Expression<String>? category,
    Expression<String>? barcode,
    Expression<String>? source,
    Expression<String>? defaultBasis,
    Expression<double>? yieldFactor,
    Expression<double>? kcalPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? fibrePer100g,
    Expression<double>? saturatedFatPer100g,
    Expression<double>? sugarPer100g,
    Expression<double>? sodiumMgPer100g,
    Expression<double>? defaultServingG,
    Expression<String>? servingLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (hindiName != null) 'hindi_name': hindiName,
      if (category != null) 'category': category,
      if (barcode != null) 'barcode': barcode,
      if (source != null) 'source': source,
      if (defaultBasis != null) 'default_basis': defaultBasis,
      if (yieldFactor != null) 'yield_factor': yieldFactor,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (fibrePer100g != null) 'fibre_per100g': fibrePer100g,
      if (saturatedFatPer100g != null)
        'saturated_fat_per100g': saturatedFatPer100g,
      if (sugarPer100g != null) 'sugar_per100g': sugarPer100g,
      if (sodiumMgPer100g != null) 'sodium_mg_per100g': sodiumMgPer100g,
      if (defaultServingG != null) 'default_serving_g': defaultServingG,
      if (servingLabel != null) 'serving_label': servingLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodCatalogCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? hindiName,
    Value<String>? category,
    Value<String?>? barcode,
    Value<String>? source,
    Value<String>? defaultBasis,
    Value<double>? yieldFactor,
    Value<double>? kcalPer100g,
    Value<double>? proteinPer100g,
    Value<double>? carbsPer100g,
    Value<double>? fatPer100g,
    Value<double>? fibrePer100g,
    Value<double?>? saturatedFatPer100g,
    Value<double?>? sugarPer100g,
    Value<double?>? sodiumMgPer100g,
    Value<double>? defaultServingG,
    Value<String>? servingLabel,
    Value<int>? rowid,
  }) {
    return FoodCatalogCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      hindiName: hindiName ?? this.hindiName,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      source: source ?? this.source,
      defaultBasis: defaultBasis ?? this.defaultBasis,
      yieldFactor: yieldFactor ?? this.yieldFactor,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      fibrePer100g: fibrePer100g ?? this.fibrePer100g,
      saturatedFatPer100g: saturatedFatPer100g ?? this.saturatedFatPer100g,
      sugarPer100g: sugarPer100g ?? this.sugarPer100g,
      sodiumMgPer100g: sodiumMgPer100g ?? this.sodiumMgPer100g,
      defaultServingG: defaultServingG ?? this.defaultServingG,
      servingLabel: servingLabel ?? this.servingLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hindiName.present) {
      map['hindi_name'] = Variable<String>(hindiName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (defaultBasis.present) {
      map['default_basis'] = Variable<String>(defaultBasis.value);
    }
    if (yieldFactor.present) {
      map['yield_factor'] = Variable<double>(yieldFactor.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (fibrePer100g.present) {
      map['fibre_per100g'] = Variable<double>(fibrePer100g.value);
    }
    if (saturatedFatPer100g.present) {
      map['saturated_fat_per100g'] = Variable<double>(
        saturatedFatPer100g.value,
      );
    }
    if (sugarPer100g.present) {
      map['sugar_per100g'] = Variable<double>(sugarPer100g.value);
    }
    if (sodiumMgPer100g.present) {
      map['sodium_mg_per100g'] = Variable<double>(sodiumMgPer100g.value);
    }
    if (defaultServingG.present) {
      map['default_serving_g'] = Variable<double>(defaultServingG.value);
    }
    if (servingLabel.present) {
      map['serving_label'] = Variable<String>(servingLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodCatalogCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('hindiName: $hindiName, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('source: $source, ')
          ..write('defaultBasis: $defaultBasis, ')
          ..write('yieldFactor: $yieldFactor, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fibrePer100g: $fibrePer100g, ')
          ..write('saturatedFatPer100g: $saturatedFatPer100g, ')
          ..write('sugarPer100g: $sugarPer100g, ')
          ..write('sodiumMgPer100g: $sodiumMgPer100g, ')
          ..write('defaultServingG: $defaultServingG, ')
          ..write('servingLabel: $servingLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealLogsTable extends MealLogs with TableInfo<$MealLogsTable, MealLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodNameMeta = const VerificationMeta(
    'foodName',
  );
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
    'food_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookedWeightGMeta = const VerificationMeta(
    'cookedWeightG',
  );
  @override
  late final GeneratedColumn<double> cookedWeightG = GeneratedColumn<double>(
    'cooked_weight_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _calculatedKcalMeta = const VerificationMeta(
    'calculatedKcal',
  );
  @override
  late final GeneratedColumn<double> calculatedKcal = GeneratedColumn<double>(
    'calculated_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
    'fat_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basisMeta = const VerificationMeta('basis');
  @override
  late final GeneratedColumn<String> basis = GeneratedColumn<String>(
    'basis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cooked'),
  );
  static const VerificationMeta _rawEquivalentGMeta = const VerificationMeta(
    'rawEquivalentG',
  );
  @override
  late final GeneratedColumn<double> rawEquivalentG = GeneratedColumn<double>(
    'raw_equivalent_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _extraOilTspMeta = const VerificationMeta(
    'extraOilTsp',
  );
  @override
  late final GeneratedColumn<double> extraOilTsp = GeneratedColumn<double>(
    'extra_oil_tsp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fibreGMeta = const VerificationMeta('fibreG');
  @override
  late final GeneratedColumn<double> fibreG = GeneratedColumn<double>(
    'fibre_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _saturatedFatGMeta = const VerificationMeta(
    'saturatedFatG',
  );
  @override
  late final GeneratedColumn<double> saturatedFatG = GeneratedColumn<double>(
    'saturated_fat_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sugarGMeta = const VerificationMeta('sugarG');
  @override
  late final GeneratedColumn<double> sugarG = GeneratedColumn<double>(
    'sugar_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sodiumMgMeta = const VerificationMeta(
    'sodiumMg',
  );
  @override
  late final GeneratedColumn<double> sodiumMg = GeneratedColumn<double>(
    'sodium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEstimateMeta = const VerificationMeta(
    'isEstimate',
  );
  @override
  late final GeneratedColumn<bool> isEstimate = GeneratedColumn<bool>(
    'is_estimate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_estimate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodName,
    mealType,
    cookedWeightG,
    calculatedKcal,
    proteinG,
    carbsG,
    fatG,
    timestamp,
    foodId,
    basis,
    rawEquivalentG,
    extraOilTsp,
    fibreG,
    saturatedFatG,
    sugarG,
    sodiumMg,
    isEstimate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_name')) {
      context.handle(
        _foodNameMeta,
        foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta),
      );
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('cooked_weight_g')) {
      context.handle(
        _cookedWeightGMeta,
        cookedWeightG.isAcceptableOrUnknown(
          data['cooked_weight_g']!,
          _cookedWeightGMeta,
        ),
      );
    }
    if (data.containsKey('calculated_kcal')) {
      context.handle(
        _calculatedKcalMeta,
        calculatedKcal.isAcceptableOrUnknown(
          data['calculated_kcal']!,
          _calculatedKcalMeta,
        ),
      );
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    }
    if (data.containsKey('basis')) {
      context.handle(
        _basisMeta,
        basis.isAcceptableOrUnknown(data['basis']!, _basisMeta),
      );
    }
    if (data.containsKey('raw_equivalent_g')) {
      context.handle(
        _rawEquivalentGMeta,
        rawEquivalentG.isAcceptableOrUnknown(
          data['raw_equivalent_g']!,
          _rawEquivalentGMeta,
        ),
      );
    }
    if (data.containsKey('extra_oil_tsp')) {
      context.handle(
        _extraOilTspMeta,
        extraOilTsp.isAcceptableOrUnknown(
          data['extra_oil_tsp']!,
          _extraOilTspMeta,
        ),
      );
    }
    if (data.containsKey('fibre_g')) {
      context.handle(
        _fibreGMeta,
        fibreG.isAcceptableOrUnknown(data['fibre_g']!, _fibreGMeta),
      );
    }
    if (data.containsKey('saturated_fat_g')) {
      context.handle(
        _saturatedFatGMeta,
        saturatedFatG.isAcceptableOrUnknown(
          data['saturated_fat_g']!,
          _saturatedFatGMeta,
        ),
      );
    }
    if (data.containsKey('sugar_g')) {
      context.handle(
        _sugarGMeta,
        sugarG.isAcceptableOrUnknown(data['sugar_g']!, _sugarGMeta),
      );
    }
    if (data.containsKey('sodium_mg')) {
      context.handle(
        _sodiumMgMeta,
        sodiumMg.isAcceptableOrUnknown(data['sodium_mg']!, _sodiumMgMeta),
      );
    }
    if (data.containsKey('is_estimate')) {
      context.handle(
        _isEstimateMeta,
        isEstimate.isAcceptableOrUnknown(data['is_estimate']!, _isEstimateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_name'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      cookedWeightG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cooked_weight_g'],
      )!,
      calculatedKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calculated_kcal'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      ),
      basis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}basis'],
      )!,
      rawEquivalentG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_equivalent_g'],
      )!,
      extraOilTsp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}extra_oil_tsp'],
      )!,
      fibreG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fibre_g'],
      )!,
      saturatedFatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saturated_fat_g'],
      ),
      sugarG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sugar_g'],
      ),
      sodiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium_mg'],
      ),
      isEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_estimate'],
      )!,
    );
  }

  @override
  $MealLogsTable createAlias(String alias) {
    return $MealLogsTable(attachedDatabase, alias);
  }
}

class MealLog extends DataClass implements Insertable<MealLog> {
  final String id;
  final String foodName;
  final String mealType;
  final double cookedWeightG;
  final double calculatedKcal;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final DateTime timestamp;
  final String? foodId;
  final String basis;
  final double rawEquivalentG;
  final double extraOilTsp;
  final double fibreG;
  final double? saturatedFatG;
  final double? sugarG;
  final double? sodiumMg;
  final bool isEstimate;
  const MealLog({
    required this.id,
    required this.foodName,
    required this.mealType,
    required this.cookedWeightG,
    required this.calculatedKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.timestamp,
    this.foodId,
    required this.basis,
    required this.rawEquivalentG,
    required this.extraOilTsp,
    required this.fibreG,
    this.saturatedFatG,
    this.sugarG,
    this.sodiumMg,
    required this.isEstimate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_name'] = Variable<String>(foodName);
    map['meal_type'] = Variable<String>(mealType);
    map['cooked_weight_g'] = Variable<double>(cookedWeightG);
    map['calculated_kcal'] = Variable<double>(calculatedKcal);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fat_g'] = Variable<double>(fatG);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<String>(foodId);
    }
    map['basis'] = Variable<String>(basis);
    map['raw_equivalent_g'] = Variable<double>(rawEquivalentG);
    map['extra_oil_tsp'] = Variable<double>(extraOilTsp);
    map['fibre_g'] = Variable<double>(fibreG);
    if (!nullToAbsent || saturatedFatG != null) {
      map['saturated_fat_g'] = Variable<double>(saturatedFatG);
    }
    if (!nullToAbsent || sugarG != null) {
      map['sugar_g'] = Variable<double>(sugarG);
    }
    if (!nullToAbsent || sodiumMg != null) {
      map['sodium_mg'] = Variable<double>(sodiumMg);
    }
    map['is_estimate'] = Variable<bool>(isEstimate);
    return map;
  }

  MealLogsCompanion toCompanion(bool nullToAbsent) {
    return MealLogsCompanion(
      id: Value(id),
      foodName: Value(foodName),
      mealType: Value(mealType),
      cookedWeightG: Value(cookedWeightG),
      calculatedKcal: Value(calculatedKcal),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      timestamp: Value(timestamp),
      foodId: foodId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodId),
      basis: Value(basis),
      rawEquivalentG: Value(rawEquivalentG),
      extraOilTsp: Value(extraOilTsp),
      fibreG: Value(fibreG),
      saturatedFatG: saturatedFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(saturatedFatG),
      sugarG: sugarG == null && nullToAbsent
          ? const Value.absent()
          : Value(sugarG),
      sodiumMg: sodiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMg),
      isEstimate: Value(isEstimate),
    );
  }

  factory MealLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealLog(
      id: serializer.fromJson<String>(json['id']),
      foodName: serializer.fromJson<String>(json['foodName']),
      mealType: serializer.fromJson<String>(json['mealType']),
      cookedWeightG: serializer.fromJson<double>(json['cookedWeightG']),
      calculatedKcal: serializer.fromJson<double>(json['calculatedKcal']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatG: serializer.fromJson<double>(json['fatG']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      foodId: serializer.fromJson<String?>(json['foodId']),
      basis: serializer.fromJson<String>(json['basis']),
      rawEquivalentG: serializer.fromJson<double>(json['rawEquivalentG']),
      extraOilTsp: serializer.fromJson<double>(json['extraOilTsp']),
      fibreG: serializer.fromJson<double>(json['fibreG']),
      saturatedFatG: serializer.fromJson<double?>(json['saturatedFatG']),
      sugarG: serializer.fromJson<double?>(json['sugarG']),
      sodiumMg: serializer.fromJson<double?>(json['sodiumMg']),
      isEstimate: serializer.fromJson<bool>(json['isEstimate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'foodName': serializer.toJson<String>(foodName),
      'mealType': serializer.toJson<String>(mealType),
      'cookedWeightG': serializer.toJson<double>(cookedWeightG),
      'calculatedKcal': serializer.toJson<double>(calculatedKcal),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatG': serializer.toJson<double>(fatG),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'foodId': serializer.toJson<String?>(foodId),
      'basis': serializer.toJson<String>(basis),
      'rawEquivalentG': serializer.toJson<double>(rawEquivalentG),
      'extraOilTsp': serializer.toJson<double>(extraOilTsp),
      'fibreG': serializer.toJson<double>(fibreG),
      'saturatedFatG': serializer.toJson<double?>(saturatedFatG),
      'sugarG': serializer.toJson<double?>(sugarG),
      'sodiumMg': serializer.toJson<double?>(sodiumMg),
      'isEstimate': serializer.toJson<bool>(isEstimate),
    };
  }

  MealLog copyWith({
    String? id,
    String? foodName,
    String? mealType,
    double? cookedWeightG,
    double? calculatedKcal,
    double? proteinG,
    double? carbsG,
    double? fatG,
    DateTime? timestamp,
    Value<String?> foodId = const Value.absent(),
    String? basis,
    double? rawEquivalentG,
    double? extraOilTsp,
    double? fibreG,
    Value<double?> saturatedFatG = const Value.absent(),
    Value<double?> sugarG = const Value.absent(),
    Value<double?> sodiumMg = const Value.absent(),
    bool? isEstimate,
  }) => MealLog(
    id: id ?? this.id,
    foodName: foodName ?? this.foodName,
    mealType: mealType ?? this.mealType,
    cookedWeightG: cookedWeightG ?? this.cookedWeightG,
    calculatedKcal: calculatedKcal ?? this.calculatedKcal,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatG: fatG ?? this.fatG,
    timestamp: timestamp ?? this.timestamp,
    foodId: foodId.present ? foodId.value : this.foodId,
    basis: basis ?? this.basis,
    rawEquivalentG: rawEquivalentG ?? this.rawEquivalentG,
    extraOilTsp: extraOilTsp ?? this.extraOilTsp,
    fibreG: fibreG ?? this.fibreG,
    saturatedFatG: saturatedFatG.present
        ? saturatedFatG.value
        : this.saturatedFatG,
    sugarG: sugarG.present ? sugarG.value : this.sugarG,
    sodiumMg: sodiumMg.present ? sodiumMg.value : this.sodiumMg,
    isEstimate: isEstimate ?? this.isEstimate,
  );
  MealLog copyWithCompanion(MealLogsCompanion data) {
    return MealLog(
      id: data.id.present ? data.id.value : this.id,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      cookedWeightG: data.cookedWeightG.present
          ? data.cookedWeightG.value
          : this.cookedWeightG,
      calculatedKcal: data.calculatedKcal.present
          ? data.calculatedKcal.value
          : this.calculatedKcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      basis: data.basis.present ? data.basis.value : this.basis,
      rawEquivalentG: data.rawEquivalentG.present
          ? data.rawEquivalentG.value
          : this.rawEquivalentG,
      extraOilTsp: data.extraOilTsp.present
          ? data.extraOilTsp.value
          : this.extraOilTsp,
      fibreG: data.fibreG.present ? data.fibreG.value : this.fibreG,
      saturatedFatG: data.saturatedFatG.present
          ? data.saturatedFatG.value
          : this.saturatedFatG,
      sugarG: data.sugarG.present ? data.sugarG.value : this.sugarG,
      sodiumMg: data.sodiumMg.present ? data.sodiumMg.value : this.sodiumMg,
      isEstimate: data.isEstimate.present
          ? data.isEstimate.value
          : this.isEstimate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealLog(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('mealType: $mealType, ')
          ..write('cookedWeightG: $cookedWeightG, ')
          ..write('calculatedKcal: $calculatedKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('timestamp: $timestamp, ')
          ..write('foodId: $foodId, ')
          ..write('basis: $basis, ')
          ..write('rawEquivalentG: $rawEquivalentG, ')
          ..write('extraOilTsp: $extraOilTsp, ')
          ..write('fibreG: $fibreG, ')
          ..write('saturatedFatG: $saturatedFatG, ')
          ..write('sugarG: $sugarG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('isEstimate: $isEstimate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    foodName,
    mealType,
    cookedWeightG,
    calculatedKcal,
    proteinG,
    carbsG,
    fatG,
    timestamp,
    foodId,
    basis,
    rawEquivalentG,
    extraOilTsp,
    fibreG,
    saturatedFatG,
    sugarG,
    sodiumMg,
    isEstimate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealLog &&
          other.id == this.id &&
          other.foodName == this.foodName &&
          other.mealType == this.mealType &&
          other.cookedWeightG == this.cookedWeightG &&
          other.calculatedKcal == this.calculatedKcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.timestamp == this.timestamp &&
          other.foodId == this.foodId &&
          other.basis == this.basis &&
          other.rawEquivalentG == this.rawEquivalentG &&
          other.extraOilTsp == this.extraOilTsp &&
          other.fibreG == this.fibreG &&
          other.saturatedFatG == this.saturatedFatG &&
          other.sugarG == this.sugarG &&
          other.sodiumMg == this.sodiumMg &&
          other.isEstimate == this.isEstimate);
}

class MealLogsCompanion extends UpdateCompanion<MealLog> {
  final Value<String> id;
  final Value<String> foodName;
  final Value<String> mealType;
  final Value<double> cookedWeightG;
  final Value<double> calculatedKcal;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatG;
  final Value<DateTime> timestamp;
  final Value<String?> foodId;
  final Value<String> basis;
  final Value<double> rawEquivalentG;
  final Value<double> extraOilTsp;
  final Value<double> fibreG;
  final Value<double?> saturatedFatG;
  final Value<double?> sugarG;
  final Value<double?> sodiumMg;
  final Value<bool> isEstimate;
  final Value<int> rowid;
  const MealLogsCompanion({
    this.id = const Value.absent(),
    this.foodName = const Value.absent(),
    this.mealType = const Value.absent(),
    this.cookedWeightG = const Value.absent(),
    this.calculatedKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.foodId = const Value.absent(),
    this.basis = const Value.absent(),
    this.rawEquivalentG = const Value.absent(),
    this.extraOilTsp = const Value.absent(),
    this.fibreG = const Value.absent(),
    this.saturatedFatG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.isEstimate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealLogsCompanion.insert({
    required String id,
    required String foodName,
    required String mealType,
    this.cookedWeightG = const Value.absent(),
    this.calculatedKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    required DateTime timestamp,
    this.foodId = const Value.absent(),
    this.basis = const Value.absent(),
    this.rawEquivalentG = const Value.absent(),
    this.extraOilTsp = const Value.absent(),
    this.fibreG = const Value.absent(),
    this.saturatedFatG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.isEstimate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodName = Value(foodName),
       mealType = Value(mealType),
       timestamp = Value(timestamp);
  static Insertable<MealLog> custom({
    Expression<String>? id,
    Expression<String>? foodName,
    Expression<String>? mealType,
    Expression<double>? cookedWeightG,
    Expression<double>? calculatedKcal,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<DateTime>? timestamp,
    Expression<String>? foodId,
    Expression<String>? basis,
    Expression<double>? rawEquivalentG,
    Expression<double>? extraOilTsp,
    Expression<double>? fibreG,
    Expression<double>? saturatedFatG,
    Expression<double>? sugarG,
    Expression<double>? sodiumMg,
    Expression<bool>? isEstimate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodName != null) 'food_name': foodName,
      if (mealType != null) 'meal_type': mealType,
      if (cookedWeightG != null) 'cooked_weight_g': cookedWeightG,
      if (calculatedKcal != null) 'calculated_kcal': calculatedKcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (timestamp != null) 'timestamp': timestamp,
      if (foodId != null) 'food_id': foodId,
      if (basis != null) 'basis': basis,
      if (rawEquivalentG != null) 'raw_equivalent_g': rawEquivalentG,
      if (extraOilTsp != null) 'extra_oil_tsp': extraOilTsp,
      if (fibreG != null) 'fibre_g': fibreG,
      if (saturatedFatG != null) 'saturated_fat_g': saturatedFatG,
      if (sugarG != null) 'sugar_g': sugarG,
      if (sodiumMg != null) 'sodium_mg': sodiumMg,
      if (isEstimate != null) 'is_estimate': isEstimate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? foodName,
    Value<String>? mealType,
    Value<double>? cookedWeightG,
    Value<double>? calculatedKcal,
    Value<double>? proteinG,
    Value<double>? carbsG,
    Value<double>? fatG,
    Value<DateTime>? timestamp,
    Value<String?>? foodId,
    Value<String>? basis,
    Value<double>? rawEquivalentG,
    Value<double>? extraOilTsp,
    Value<double>? fibreG,
    Value<double?>? saturatedFatG,
    Value<double?>? sugarG,
    Value<double?>? sodiumMg,
    Value<bool>? isEstimate,
    Value<int>? rowid,
  }) {
    return MealLogsCompanion(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
      cookedWeightG: cookedWeightG ?? this.cookedWeightG,
      calculatedKcal: calculatedKcal ?? this.calculatedKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      timestamp: timestamp ?? this.timestamp,
      foodId: foodId ?? this.foodId,
      basis: basis ?? this.basis,
      rawEquivalentG: rawEquivalentG ?? this.rawEquivalentG,
      extraOilTsp: extraOilTsp ?? this.extraOilTsp,
      fibreG: fibreG ?? this.fibreG,
      saturatedFatG: saturatedFatG ?? this.saturatedFatG,
      sugarG: sugarG ?? this.sugarG,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      isEstimate: isEstimate ?? this.isEstimate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (cookedWeightG.present) {
      map['cooked_weight_g'] = Variable<double>(cookedWeightG.value);
    }
    if (calculatedKcal.present) {
      map['calculated_kcal'] = Variable<double>(calculatedKcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (basis.present) {
      map['basis'] = Variable<String>(basis.value);
    }
    if (rawEquivalentG.present) {
      map['raw_equivalent_g'] = Variable<double>(rawEquivalentG.value);
    }
    if (extraOilTsp.present) {
      map['extra_oil_tsp'] = Variable<double>(extraOilTsp.value);
    }
    if (fibreG.present) {
      map['fibre_g'] = Variable<double>(fibreG.value);
    }
    if (saturatedFatG.present) {
      map['saturated_fat_g'] = Variable<double>(saturatedFatG.value);
    }
    if (sugarG.present) {
      map['sugar_g'] = Variable<double>(sugarG.value);
    }
    if (sodiumMg.present) {
      map['sodium_mg'] = Variable<double>(sodiumMg.value);
    }
    if (isEstimate.present) {
      map['is_estimate'] = Variable<bool>(isEstimate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealLogsCompanion(')
          ..write('id: $id, ')
          ..write('foodName: $foodName, ')
          ..write('mealType: $mealType, ')
          ..write('cookedWeightG: $cookedWeightG, ')
          ..write('calculatedKcal: $calculatedKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('timestamp: $timestamp, ')
          ..write('foodId: $foodId, ')
          ..write('basis: $basis, ')
          ..write('rawEquivalentG: $rawEquivalentG, ')
          ..write('extraOilTsp: $extraOilTsp, ')
          ..write('fibreG: $fibreG, ')
          ..write('saturatedFatG: $saturatedFatG, ')
          ..write('sugarG: $sugarG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('isEstimate: $isEstimate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserMetabolicProfilesTable extends UserMetabolicProfiles
    with TableInfo<$UserMetabolicProfilesTable, UserMetabolicProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserMetabolicProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Athlete'),
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(24),
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('male'),
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(175.0),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(75.0),
  );
  static const VerificationMeta _bodyFatPctMeta = const VerificationMeta(
    'bodyFatPct',
  );
  @override
  late final GeneratedColumn<double> bodyFatPct = GeneratedColumn<double>(
    'body_fat_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bmrFormulaMeta = const VerificationMeta(
    'bmrFormula',
  );
  @override
  late final GeneratedColumn<String> bmrFormula = GeneratedColumn<String>(
    'bmr_formula',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mifflin'),
  );
  static const VerificationMeta _activityMultiplierMeta =
      const VerificationMeta('activityMultiplier');
  @override
  late final GeneratedColumn<double> activityMultiplier =
      GeneratedColumn<double>(
        'activity_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.2),
      );
  static const VerificationMeta _goalDeltaKcalMeta = const VerificationMeta(
    'goalDeltaKcal',
  );
  @override
  late final GeneratedColumn<int> goalDeltaKcal = GeneratedColumn<int>(
    'goal_delta_kcal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dailyCalorieGoalMeta = const VerificationMeta(
    'dailyCalorieGoal',
  );
  @override
  late final GeneratedColumn<int> dailyCalorieGoal = GeneratedColumn<int>(
    'daily_calorie_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2200),
  );
  static const VerificationMeta _proteinTargetGMeta = const VerificationMeta(
    'proteinTargetG',
  );
  @override
  late final GeneratedColumn<double> proteinTargetG = GeneratedColumn<double>(
    'protein_target_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(140.0),
  );
  static const VerificationMeta _carbsTargetGMeta = const VerificationMeta(
    'carbsTargetG',
  );
  @override
  late final GeneratedColumn<double> carbsTargetG = GeneratedColumn<double>(
    'carbs_target_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(220.0),
  );
  static const VerificationMeta _fatTargetGMeta = const VerificationMeta(
    'fatTargetG',
  );
  @override
  late final GeneratedColumn<double> fatTargetG = GeneratedColumn<double>(
    'fat_target_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(60.0),
  );
  static const VerificationMeta _fibreTargetGMeta = const VerificationMeta(
    'fibreTargetG',
  );
  @override
  late final GeneratedColumn<double> fibreTargetG = GeneratedColumn<double>(
    'fibre_target_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(30.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    age,
    sex,
    heightCm,
    weightKg,
    bodyFatPct,
    bmrFormula,
    activityMultiplier,
    goalDeltaKcal,
    dailyCalorieGoal,
    proteinTargetG,
    carbsTargetG,
    fatTargetG,
    fibreTargetG,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_metabolic_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserMetabolicProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('body_fat_pct')) {
      context.handle(
        _bodyFatPctMeta,
        bodyFatPct.isAcceptableOrUnknown(
          data['body_fat_pct']!,
          _bodyFatPctMeta,
        ),
      );
    }
    if (data.containsKey('bmr_formula')) {
      context.handle(
        _bmrFormulaMeta,
        bmrFormula.isAcceptableOrUnknown(data['bmr_formula']!, _bmrFormulaMeta),
      );
    }
    if (data.containsKey('activity_multiplier')) {
      context.handle(
        _activityMultiplierMeta,
        activityMultiplier.isAcceptableOrUnknown(
          data['activity_multiplier']!,
          _activityMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('goal_delta_kcal')) {
      context.handle(
        _goalDeltaKcalMeta,
        goalDeltaKcal.isAcceptableOrUnknown(
          data['goal_delta_kcal']!,
          _goalDeltaKcalMeta,
        ),
      );
    }
    if (data.containsKey('daily_calorie_goal')) {
      context.handle(
        _dailyCalorieGoalMeta,
        dailyCalorieGoal.isAcceptableOrUnknown(
          data['daily_calorie_goal']!,
          _dailyCalorieGoalMeta,
        ),
      );
    }
    if (data.containsKey('protein_target_g')) {
      context.handle(
        _proteinTargetGMeta,
        proteinTargetG.isAcceptableOrUnknown(
          data['protein_target_g']!,
          _proteinTargetGMeta,
        ),
      );
    }
    if (data.containsKey('carbs_target_g')) {
      context.handle(
        _carbsTargetGMeta,
        carbsTargetG.isAcceptableOrUnknown(
          data['carbs_target_g']!,
          _carbsTargetGMeta,
        ),
      );
    }
    if (data.containsKey('fat_target_g')) {
      context.handle(
        _fatTargetGMeta,
        fatTargetG.isAcceptableOrUnknown(
          data['fat_target_g']!,
          _fatTargetGMeta,
        ),
      );
    }
    if (data.containsKey('fibre_target_g')) {
      context.handle(
        _fibreTargetGMeta,
        fibreTargetG.isAcceptableOrUnknown(
          data['fibre_target_g']!,
          _fibreTargetGMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserMetabolicProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserMetabolicProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      bodyFatPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat_pct'],
      ),
      bmrFormula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bmr_formula'],
      )!,
      activityMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}activity_multiplier'],
      )!,
      goalDeltaKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_delta_kcal'],
      )!,
      dailyCalorieGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_calorie_goal'],
      )!,
      proteinTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_target_g'],
      )!,
      carbsTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_target_g'],
      )!,
      fatTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_target_g'],
      )!,
      fibreTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fibre_target_g'],
      )!,
    );
  }

  @override
  $UserMetabolicProfilesTable createAlias(String alias) {
    return $UserMetabolicProfilesTable(attachedDatabase, alias);
  }
}

class UserMetabolicProfile extends DataClass
    implements Insertable<UserMetabolicProfile> {
  final int id;
  final String name;
  final int age;
  final String sex;
  final double heightCm;
  final double weightKg;
  final double? bodyFatPct;
  final String bmrFormula;
  final double activityMultiplier;
  final int goalDeltaKcal;
  final int dailyCalorieGoal;
  final double proteinTargetG;
  final double carbsTargetG;
  final double fatTargetG;
  final double fibreTargetG;
  const UserMetabolicProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.heightCm,
    required this.weightKg,
    this.bodyFatPct,
    required this.bmrFormula,
    required this.activityMultiplier,
    required this.goalDeltaKcal,
    required this.dailyCalorieGoal,
    required this.proteinTargetG,
    required this.carbsTargetG,
    required this.fatTargetG,
    required this.fibreTargetG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['age'] = Variable<int>(age);
    map['sex'] = Variable<String>(sex);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || bodyFatPct != null) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct);
    }
    map['bmr_formula'] = Variable<String>(bmrFormula);
    map['activity_multiplier'] = Variable<double>(activityMultiplier);
    map['goal_delta_kcal'] = Variable<int>(goalDeltaKcal);
    map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal);
    map['protein_target_g'] = Variable<double>(proteinTargetG);
    map['carbs_target_g'] = Variable<double>(carbsTargetG);
    map['fat_target_g'] = Variable<double>(fatTargetG);
    map['fibre_target_g'] = Variable<double>(fibreTargetG);
    return map;
  }

  UserMetabolicProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserMetabolicProfilesCompanion(
      id: Value(id),
      name: Value(name),
      age: Value(age),
      sex: Value(sex),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      bodyFatPct: bodyFatPct == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPct),
      bmrFormula: Value(bmrFormula),
      activityMultiplier: Value(activityMultiplier),
      goalDeltaKcal: Value(goalDeltaKcal),
      dailyCalorieGoal: Value(dailyCalorieGoal),
      proteinTargetG: Value(proteinTargetG),
      carbsTargetG: Value(carbsTargetG),
      fatTargetG: Value(fatTargetG),
      fibreTargetG: Value(fibreTargetG),
    );
  }

  factory UserMetabolicProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserMetabolicProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int>(json['age']),
      sex: serializer.fromJson<String>(json['sex']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      bodyFatPct: serializer.fromJson<double?>(json['bodyFatPct']),
      bmrFormula: serializer.fromJson<String>(json['bmrFormula']),
      activityMultiplier: serializer.fromJson<double>(
        json['activityMultiplier'],
      ),
      goalDeltaKcal: serializer.fromJson<int>(json['goalDeltaKcal']),
      dailyCalorieGoal: serializer.fromJson<int>(json['dailyCalorieGoal']),
      proteinTargetG: serializer.fromJson<double>(json['proteinTargetG']),
      carbsTargetG: serializer.fromJson<double>(json['carbsTargetG']),
      fatTargetG: serializer.fromJson<double>(json['fatTargetG']),
      fibreTargetG: serializer.fromJson<double>(json['fibreTargetG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int>(age),
      'sex': serializer.toJson<String>(sex),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'bodyFatPct': serializer.toJson<double?>(bodyFatPct),
      'bmrFormula': serializer.toJson<String>(bmrFormula),
      'activityMultiplier': serializer.toJson<double>(activityMultiplier),
      'goalDeltaKcal': serializer.toJson<int>(goalDeltaKcal),
      'dailyCalorieGoal': serializer.toJson<int>(dailyCalorieGoal),
      'proteinTargetG': serializer.toJson<double>(proteinTargetG),
      'carbsTargetG': serializer.toJson<double>(carbsTargetG),
      'fatTargetG': serializer.toJson<double>(fatTargetG),
      'fibreTargetG': serializer.toJson<double>(fibreTargetG),
    };
  }

  UserMetabolicProfile copyWith({
    int? id,
    String? name,
    int? age,
    String? sex,
    double? heightCm,
    double? weightKg,
    Value<double?> bodyFatPct = const Value.absent(),
    String? bmrFormula,
    double? activityMultiplier,
    int? goalDeltaKcal,
    int? dailyCalorieGoal,
    double? proteinTargetG,
    double? carbsTargetG,
    double? fatTargetG,
    double? fibreTargetG,
  }) => UserMetabolicProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    age: age ?? this.age,
    sex: sex ?? this.sex,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    bodyFatPct: bodyFatPct.present ? bodyFatPct.value : this.bodyFatPct,
    bmrFormula: bmrFormula ?? this.bmrFormula,
    activityMultiplier: activityMultiplier ?? this.activityMultiplier,
    goalDeltaKcal: goalDeltaKcal ?? this.goalDeltaKcal,
    dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
    proteinTargetG: proteinTargetG ?? this.proteinTargetG,
    carbsTargetG: carbsTargetG ?? this.carbsTargetG,
    fatTargetG: fatTargetG ?? this.fatTargetG,
    fibreTargetG: fibreTargetG ?? this.fibreTargetG,
  );
  UserMetabolicProfile copyWithCompanion(UserMetabolicProfilesCompanion data) {
    return UserMetabolicProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      sex: data.sex.present ? data.sex.value : this.sex,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      bodyFatPct: data.bodyFatPct.present
          ? data.bodyFatPct.value
          : this.bodyFatPct,
      bmrFormula: data.bmrFormula.present
          ? data.bmrFormula.value
          : this.bmrFormula,
      activityMultiplier: data.activityMultiplier.present
          ? data.activityMultiplier.value
          : this.activityMultiplier,
      goalDeltaKcal: data.goalDeltaKcal.present
          ? data.goalDeltaKcal.value
          : this.goalDeltaKcal,
      dailyCalorieGoal: data.dailyCalorieGoal.present
          ? data.dailyCalorieGoal.value
          : this.dailyCalorieGoal,
      proteinTargetG: data.proteinTargetG.present
          ? data.proteinTargetG.value
          : this.proteinTargetG,
      carbsTargetG: data.carbsTargetG.present
          ? data.carbsTargetG.value
          : this.carbsTargetG,
      fatTargetG: data.fatTargetG.present
          ? data.fatTargetG.value
          : this.fatTargetG,
      fibreTargetG: data.fibreTargetG.present
          ? data.fibreTargetG.value
          : this.fibreTargetG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserMetabolicProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('bmrFormula: $bmrFormula, ')
          ..write('activityMultiplier: $activityMultiplier, ')
          ..write('goalDeltaKcal: $goalDeltaKcal, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('proteinTargetG: $proteinTargetG, ')
          ..write('carbsTargetG: $carbsTargetG, ')
          ..write('fatTargetG: $fatTargetG, ')
          ..write('fibreTargetG: $fibreTargetG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    age,
    sex,
    heightCm,
    weightKg,
    bodyFatPct,
    bmrFormula,
    activityMultiplier,
    goalDeltaKcal,
    dailyCalorieGoal,
    proteinTargetG,
    carbsTargetG,
    fatTargetG,
    fibreTargetG,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserMetabolicProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age &&
          other.sex == this.sex &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.bodyFatPct == this.bodyFatPct &&
          other.bmrFormula == this.bmrFormula &&
          other.activityMultiplier == this.activityMultiplier &&
          other.goalDeltaKcal == this.goalDeltaKcal &&
          other.dailyCalorieGoal == this.dailyCalorieGoal &&
          other.proteinTargetG == this.proteinTargetG &&
          other.carbsTargetG == this.carbsTargetG &&
          other.fatTargetG == this.fatTargetG &&
          other.fibreTargetG == this.fibreTargetG);
}

class UserMetabolicProfilesCompanion
    extends UpdateCompanion<UserMetabolicProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> age;
  final Value<String> sex;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<double?> bodyFatPct;
  final Value<String> bmrFormula;
  final Value<double> activityMultiplier;
  final Value<int> goalDeltaKcal;
  final Value<int> dailyCalorieGoal;
  final Value<double> proteinTargetG;
  final Value<double> carbsTargetG;
  final Value<double> fatTargetG;
  final Value<double> fibreTargetG;
  const UserMetabolicProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
    this.bmrFormula = const Value.absent(),
    this.activityMultiplier = const Value.absent(),
    this.goalDeltaKcal = const Value.absent(),
    this.dailyCalorieGoal = const Value.absent(),
    this.proteinTargetG = const Value.absent(),
    this.carbsTargetG = const Value.absent(),
    this.fatTargetG = const Value.absent(),
    this.fibreTargetG = const Value.absent(),
  });
  UserMetabolicProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
    this.bmrFormula = const Value.absent(),
    this.activityMultiplier = const Value.absent(),
    this.goalDeltaKcal = const Value.absent(),
    this.dailyCalorieGoal = const Value.absent(),
    this.proteinTargetG = const Value.absent(),
    this.carbsTargetG = const Value.absent(),
    this.fatTargetG = const Value.absent(),
    this.fibreTargetG = const Value.absent(),
  });
  static Insertable<UserMetabolicProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? age,
    Expression<String>? sex,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<double>? bodyFatPct,
    Expression<String>? bmrFormula,
    Expression<double>? activityMultiplier,
    Expression<int>? goalDeltaKcal,
    Expression<int>? dailyCalorieGoal,
    Expression<double>? proteinTargetG,
    Expression<double>? carbsTargetG,
    Expression<double>? fatTargetG,
    Expression<double>? fibreTargetG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (sex != null) 'sex': sex,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (bodyFatPct != null) 'body_fat_pct': bodyFatPct,
      if (bmrFormula != null) 'bmr_formula': bmrFormula,
      if (activityMultiplier != null) 'activity_multiplier': activityMultiplier,
      if (goalDeltaKcal != null) 'goal_delta_kcal': goalDeltaKcal,
      if (dailyCalorieGoal != null) 'daily_calorie_goal': dailyCalorieGoal,
      if (proteinTargetG != null) 'protein_target_g': proteinTargetG,
      if (carbsTargetG != null) 'carbs_target_g': carbsTargetG,
      if (fatTargetG != null) 'fat_target_g': fatTargetG,
      if (fibreTargetG != null) 'fibre_target_g': fibreTargetG,
    });
  }

  UserMetabolicProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? age,
    Value<String>? sex,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<double?>? bodyFatPct,
    Value<String>? bmrFormula,
    Value<double>? activityMultiplier,
    Value<int>? goalDeltaKcal,
    Value<int>? dailyCalorieGoal,
    Value<double>? proteinTargetG,
    Value<double>? carbsTargetG,
    Value<double>? fatTargetG,
    Value<double>? fibreTargetG,
  }) {
    return UserMetabolicProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      bodyFatPct: bodyFatPct ?? this.bodyFatPct,
      bmrFormula: bmrFormula ?? this.bmrFormula,
      activityMultiplier: activityMultiplier ?? this.activityMultiplier,
      goalDeltaKcal: goalDeltaKcal ?? this.goalDeltaKcal,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      proteinTargetG: proteinTargetG ?? this.proteinTargetG,
      carbsTargetG: carbsTargetG ?? this.carbsTargetG,
      fatTargetG: fatTargetG ?? this.fatTargetG,
      fibreTargetG: fibreTargetG ?? this.fibreTargetG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (bodyFatPct.present) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct.value);
    }
    if (bmrFormula.present) {
      map['bmr_formula'] = Variable<String>(bmrFormula.value);
    }
    if (activityMultiplier.present) {
      map['activity_multiplier'] = Variable<double>(activityMultiplier.value);
    }
    if (goalDeltaKcal.present) {
      map['goal_delta_kcal'] = Variable<int>(goalDeltaKcal.value);
    }
    if (dailyCalorieGoal.present) {
      map['daily_calorie_goal'] = Variable<int>(dailyCalorieGoal.value);
    }
    if (proteinTargetG.present) {
      map['protein_target_g'] = Variable<double>(proteinTargetG.value);
    }
    if (carbsTargetG.present) {
      map['carbs_target_g'] = Variable<double>(carbsTargetG.value);
    }
    if (fatTargetG.present) {
      map['fat_target_g'] = Variable<double>(fatTargetG.value);
    }
    if (fibreTargetG.present) {
      map['fibre_target_g'] = Variable<double>(fibreTargetG.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserMetabolicProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('bmrFormula: $bmrFormula, ')
          ..write('activityMultiplier: $activityMultiplier, ')
          ..write('goalDeltaKcal: $goalDeltaKcal, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('proteinTargetG: $proteinTargetG, ')
          ..write('carbsTargetG: $carbsTargetG, ')
          ..write('fatTargetG: $fatTargetG, ')
          ..write('fibreTargetG: $fibreTargetG')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailySummariesTable dailySummaries = $DailySummariesTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $FoodCatalogTable foodCatalog = $FoodCatalogTable(this);
  late final $MealLogsTable mealLogs = $MealLogsTable(this);
  late final $UserMetabolicProfilesTable userMetabolicProfiles =
      $UserMetabolicProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailySummaries,
    workouts,
    foodCatalog,
    mealLogs,
    userMetabolicProfiles,
  ];
}

typedef $$DailySummariesTableCreateCompanionBuilder =
    DailySummariesCompanion Function({
      required String date,
      Value<int> steps,
      Value<int> activeCalories,
      Value<int> targetCalories,
      Value<int> consumedCalories,
      Value<int> waterMl,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$DailySummariesTableUpdateCompanionBuilder =
    DailySummariesCompanion Function({
      Value<String> date,
      Value<int> steps,
      Value<int> activeCalories,
      Value<int> targetCalories,
      Value<int> consumedCalories,
      Value<int> waterMl,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });

class $$DailySummariesTableFilterComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeCalories => $composableBuilder(
    column: $table.activeCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get consumedCalories => $composableBuilder(
    column: $table.consumedCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterMl => $composableBuilder(
    column: $table.waterMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailySummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeCalories => $composableBuilder(
    column: $table.activeCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get consumedCalories => $composableBuilder(
    column: $table.consumedCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterMl => $composableBuilder(
    column: $table.waterMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailySummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailySummariesTable> {
  $$DailySummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<int> get activeCalories => $composableBuilder(
    column: $table.activeCalories,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => column,
  );

  GeneratedColumn<int> get consumedCalories => $composableBuilder(
    column: $table.consumedCalories,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterMl =>
      $composableBuilder(column: $table.waterMl, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);
}

class $$DailySummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailySummariesTable,
          DailySummary,
          $$DailySummariesTableFilterComposer,
          $$DailySummariesTableOrderingComposer,
          $$DailySummariesTableAnnotationComposer,
          $$DailySummariesTableCreateCompanionBuilder,
          $$DailySummariesTableUpdateCompanionBuilder,
          (
            DailySummary,
            BaseReferences<_$AppDatabase, $DailySummariesTable, DailySummary>,
          ),
          DailySummary,
          PrefetchHooks Function()
        > {
  $$DailySummariesTableTableManager(
    _$AppDatabase db,
    $DailySummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailySummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailySummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailySummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<int> activeCalories = const Value.absent(),
                Value<int> targetCalories = const Value.absent(),
                Value<int> consumedCalories = const Value.absent(),
                Value<int> waterMl = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailySummariesCompanion(
                date: date,
                steps: steps,
                activeCalories: activeCalories,
                targetCalories: targetCalories,
                consumedCalories: consumedCalories,
                waterMl: waterMl,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                Value<int> steps = const Value.absent(),
                Value<int> activeCalories = const Value.absent(),
                Value<int> targetCalories = const Value.absent(),
                Value<int> consumedCalories = const Value.absent(),
                Value<int> waterMl = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailySummariesCompanion.insert(
                date: date,
                steps: steps,
                activeCalories: activeCalories,
                targetCalories: targetCalories,
                consumedCalories: consumedCalories,
                waterMl: waterMl,
                lastSync: lastSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailySummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailySummariesTable,
      DailySummary,
      $$DailySummariesTableFilterComposer,
      $$DailySummariesTableOrderingComposer,
      $$DailySummariesTableAnnotationComposer,
      $$DailySummariesTableCreateCompanionBuilder,
      $$DailySummariesTableUpdateCompanionBuilder,
      (
        DailySummary,
        BaseReferences<_$AppDatabase, $DailySummariesTable, DailySummary>,
      ),
      DailySummary,
      PrefetchHooks Function()
    >;
typedef $$WorkoutsTableCreateCompanionBuilder =
    WorkoutsCompanion Function({
      required String id,
      required String type,
      required int startEpochMs,
      Value<int> durationSec,
      Value<double> distanceM,
      Value<double> caloriesKcal,
      Value<String?> polylineJson,
      Value<int> rowid,
    });
typedef $$WorkoutsTableUpdateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<int> startEpochMs,
      Value<int> durationSec,
      Value<double> distanceM,
      Value<double> caloriesKcal,
      Value<String?> polylineJson,
      Value<int> rowid,
    });

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startEpochMs => $composableBuilder(
    column: $table.startEpochMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startEpochMs => $composableBuilder(
    column: $table.startEpochMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get startEpochMs => $composableBuilder(
    column: $table.startEpochMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => column,
  );
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutsTable,
          Workout,
          $$WorkoutsTableFilterComposer,
          $$WorkoutsTableOrderingComposer,
          $$WorkoutsTableAnnotationComposer,
          $$WorkoutsTableCreateCompanionBuilder,
          $$WorkoutsTableUpdateCompanionBuilder,
          (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
          Workout,
          PrefetchHooks Function()
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> startEpochMs = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<String?> polylineJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                type: type,
                startEpochMs: startEpochMs,
                durationSec: durationSec,
                distanceM: distanceM,
                caloriesKcal: caloriesKcal,
                polylineJson: polylineJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required int startEpochMs,
                Value<int> durationSec = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<String?> polylineJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                type: type,
                startEpochMs: startEpochMs,
                durationSec: durationSec,
                distanceM: distanceM,
                caloriesKcal: caloriesKcal,
                polylineJson: polylineJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutsTable,
      Workout,
      $$WorkoutsTableFilterComposer,
      $$WorkoutsTableOrderingComposer,
      $$WorkoutsTableAnnotationComposer,
      $$WorkoutsTableCreateCompanionBuilder,
      $$WorkoutsTableUpdateCompanionBuilder,
      (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
      Workout,
      PrefetchHooks Function()
    >;
typedef $$FoodCatalogTableCreateCompanionBuilder =
    FoodCatalogCompanion Function({
      required String id,
      required String name,
      Value<String> hindiName,
      Value<String> category,
      Value<String?> barcode,
      Value<String> source,
      Value<String> defaultBasis,
      Value<double> yieldFactor,
      required double kcalPer100g,
      required double proteinPer100g,
      required double carbsPer100g,
      required double fatPer100g,
      Value<double> fibrePer100g,
      Value<double?> saturatedFatPer100g,
      Value<double?> sugarPer100g,
      Value<double?> sodiumMgPer100g,
      Value<double> defaultServingG,
      Value<String> servingLabel,
      Value<int> rowid,
    });
typedef $$FoodCatalogTableUpdateCompanionBuilder =
    FoodCatalogCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> hindiName,
      Value<String> category,
      Value<String?> barcode,
      Value<String> source,
      Value<String> defaultBasis,
      Value<double> yieldFactor,
      Value<double> kcalPer100g,
      Value<double> proteinPer100g,
      Value<double> carbsPer100g,
      Value<double> fatPer100g,
      Value<double> fibrePer100g,
      Value<double?> saturatedFatPer100g,
      Value<double?> sugarPer100g,
      Value<double?> sodiumMgPer100g,
      Value<double> defaultServingG,
      Value<String> servingLabel,
      Value<int> rowid,
    });

class $$FoodCatalogTableFilterComposer
    extends Composer<_$AppDatabase, $FoodCatalogTable> {
  $$FoodCatalogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hindiName => $composableBuilder(
    column: $table.hindiName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultBasis => $composableBuilder(
    column: $table.defaultBasis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldFactor => $composableBuilder(
    column: $table.yieldFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fibrePer100g => $composableBuilder(
    column: $table.fibrePer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saturatedFatPer100g => $composableBuilder(
    column: $table.saturatedFatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sugarPer100g => $composableBuilder(
    column: $table.sugarPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodiumMgPer100g => $composableBuilder(
    column: $table.sodiumMgPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultServingG => $composableBuilder(
    column: $table.defaultServingG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get servingLabel => $composableBuilder(
    column: $table.servingLabel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodCatalogTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodCatalogTable> {
  $$FoodCatalogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hindiName => $composableBuilder(
    column: $table.hindiName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultBasis => $composableBuilder(
    column: $table.defaultBasis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldFactor => $composableBuilder(
    column: $table.yieldFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fibrePer100g => $composableBuilder(
    column: $table.fibrePer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saturatedFatPer100g => $composableBuilder(
    column: $table.saturatedFatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sugarPer100g => $composableBuilder(
    column: $table.sugarPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodiumMgPer100g => $composableBuilder(
    column: $table.sodiumMgPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultServingG => $composableBuilder(
    column: $table.defaultServingG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get servingLabel => $composableBuilder(
    column: $table.servingLabel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodCatalogTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodCatalogTable> {
  $$FoodCatalogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get hindiName =>
      $composableBuilder(column: $table.hindiName, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get defaultBasis => $composableBuilder(
    column: $table.defaultBasis,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yieldFactor => $composableBuilder(
    column: $table.yieldFactor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fibrePer100g => $composableBuilder(
    column: $table.fibrePer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get saturatedFatPer100g => $composableBuilder(
    column: $table.saturatedFatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sugarPer100g => $composableBuilder(
    column: $table.sugarPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sodiumMgPer100g => $composableBuilder(
    column: $table.sodiumMgPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultServingG => $composableBuilder(
    column: $table.defaultServingG,
    builder: (column) => column,
  );

  GeneratedColumn<String> get servingLabel => $composableBuilder(
    column: $table.servingLabel,
    builder: (column) => column,
  );
}

class $$FoodCatalogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodCatalogTable,
          FoodCatalogData,
          $$FoodCatalogTableFilterComposer,
          $$FoodCatalogTableOrderingComposer,
          $$FoodCatalogTableAnnotationComposer,
          $$FoodCatalogTableCreateCompanionBuilder,
          $$FoodCatalogTableUpdateCompanionBuilder,
          (
            FoodCatalogData,
            BaseReferences<_$AppDatabase, $FoodCatalogTable, FoodCatalogData>,
          ),
          FoodCatalogData,
          PrefetchHooks Function()
        > {
  $$FoodCatalogTableTableManager(_$AppDatabase db, $FoodCatalogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodCatalogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodCatalogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodCatalogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> hindiName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> defaultBasis = const Value.absent(),
                Value<double> yieldFactor = const Value.absent(),
                Value<double> kcalPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double> fibrePer100g = const Value.absent(),
                Value<double?> saturatedFatPer100g = const Value.absent(),
                Value<double?> sugarPer100g = const Value.absent(),
                Value<double?> sodiumMgPer100g = const Value.absent(),
                Value<double> defaultServingG = const Value.absent(),
                Value<String> servingLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodCatalogCompanion(
                id: id,
                name: name,
                hindiName: hindiName,
                category: category,
                barcode: barcode,
                source: source,
                defaultBasis: defaultBasis,
                yieldFactor: yieldFactor,
                kcalPer100g: kcalPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                fibrePer100g: fibrePer100g,
                saturatedFatPer100g: saturatedFatPer100g,
                sugarPer100g: sugarPer100g,
                sodiumMgPer100g: sodiumMgPer100g,
                defaultServingG: defaultServingG,
                servingLabel: servingLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> hindiName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> defaultBasis = const Value.absent(),
                Value<double> yieldFactor = const Value.absent(),
                required double kcalPer100g,
                required double proteinPer100g,
                required double carbsPer100g,
                required double fatPer100g,
                Value<double> fibrePer100g = const Value.absent(),
                Value<double?> saturatedFatPer100g = const Value.absent(),
                Value<double?> sugarPer100g = const Value.absent(),
                Value<double?> sodiumMgPer100g = const Value.absent(),
                Value<double> defaultServingG = const Value.absent(),
                Value<String> servingLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodCatalogCompanion.insert(
                id: id,
                name: name,
                hindiName: hindiName,
                category: category,
                barcode: barcode,
                source: source,
                defaultBasis: defaultBasis,
                yieldFactor: yieldFactor,
                kcalPer100g: kcalPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                fibrePer100g: fibrePer100g,
                saturatedFatPer100g: saturatedFatPer100g,
                sugarPer100g: sugarPer100g,
                sodiumMgPer100g: sodiumMgPer100g,
                defaultServingG: defaultServingG,
                servingLabel: servingLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodCatalogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodCatalogTable,
      FoodCatalogData,
      $$FoodCatalogTableFilterComposer,
      $$FoodCatalogTableOrderingComposer,
      $$FoodCatalogTableAnnotationComposer,
      $$FoodCatalogTableCreateCompanionBuilder,
      $$FoodCatalogTableUpdateCompanionBuilder,
      (
        FoodCatalogData,
        BaseReferences<_$AppDatabase, $FoodCatalogTable, FoodCatalogData>,
      ),
      FoodCatalogData,
      PrefetchHooks Function()
    >;
typedef $$MealLogsTableCreateCompanionBuilder =
    MealLogsCompanion Function({
      required String id,
      required String foodName,
      required String mealType,
      Value<double> cookedWeightG,
      Value<double> calculatedKcal,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatG,
      required DateTime timestamp,
      Value<String?> foodId,
      Value<String> basis,
      Value<double> rawEquivalentG,
      Value<double> extraOilTsp,
      Value<double> fibreG,
      Value<double?> saturatedFatG,
      Value<double?> sugarG,
      Value<double?> sodiumMg,
      Value<bool> isEstimate,
      Value<int> rowid,
    });
typedef $$MealLogsTableUpdateCompanionBuilder =
    MealLogsCompanion Function({
      Value<String> id,
      Value<String> foodName,
      Value<String> mealType,
      Value<double> cookedWeightG,
      Value<double> calculatedKcal,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatG,
      Value<DateTime> timestamp,
      Value<String?> foodId,
      Value<String> basis,
      Value<double> rawEquivalentG,
      Value<double> extraOilTsp,
      Value<double> fibreG,
      Value<double?> saturatedFatG,
      Value<double?> sugarG,
      Value<double?> sodiumMg,
      Value<bool> isEstimate,
      Value<int> rowid,
    });

class $$MealLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cookedWeightG => $composableBuilder(
    column: $table.cookedWeightG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calculatedKcal => $composableBuilder(
    column: $table.calculatedKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get basis => $composableBuilder(
    column: $table.basis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawEquivalentG => $composableBuilder(
    column: $table.rawEquivalentG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get extraOilTsp => $composableBuilder(
    column: $table.extraOilTsp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fibreG => $composableBuilder(
    column: $table.fibreG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saturatedFatG => $composableBuilder(
    column: $table.saturatedFatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sugarG => $composableBuilder(
    column: $table.sugarG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cookedWeightG => $composableBuilder(
    column: $table.cookedWeightG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calculatedKcal => $composableBuilder(
    column: $table.calculatedKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get basis => $composableBuilder(
    column: $table.basis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawEquivalentG => $composableBuilder(
    column: $table.rawEquivalentG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get extraOilTsp => $composableBuilder(
    column: $table.extraOilTsp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fibreG => $composableBuilder(
    column: $table.fibreG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saturatedFatG => $composableBuilder(
    column: $table.saturatedFatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sugarG => $composableBuilder(
    column: $table.sugarG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<double> get cookedWeightG => $composableBuilder(
    column: $table.cookedWeightG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get calculatedKcal => $composableBuilder(
    column: $table.calculatedKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get basis =>
      $composableBuilder(column: $table.basis, builder: (column) => column);

  GeneratedColumn<double> get rawEquivalentG => $composableBuilder(
    column: $table.rawEquivalentG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get extraOilTsp => $composableBuilder(
    column: $table.extraOilTsp,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fibreG =>
      $composableBuilder(column: $table.fibreG, builder: (column) => column);

  GeneratedColumn<double> get saturatedFatG => $composableBuilder(
    column: $table.saturatedFatG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sugarG =>
      $composableBuilder(column: $table.sugarG, builder: (column) => column);

  GeneratedColumn<double> get sodiumMg =>
      $composableBuilder(column: $table.sodiumMg, builder: (column) => column);

  GeneratedColumn<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => column,
  );
}

class $$MealLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealLogsTable,
          MealLog,
          $$MealLogsTableFilterComposer,
          $$MealLogsTableOrderingComposer,
          $$MealLogsTableAnnotationComposer,
          $$MealLogsTableCreateCompanionBuilder,
          $$MealLogsTableUpdateCompanionBuilder,
          (MealLog, BaseReferences<_$AppDatabase, $MealLogsTable, MealLog>),
          MealLog,
          PrefetchHooks Function()
        > {
  $$MealLogsTableTableManager(_$AppDatabase db, $MealLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodName = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<double> cookedWeightG = const Value.absent(),
                Value<double> calculatedKcal = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatG = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> foodId = const Value.absent(),
                Value<String> basis = const Value.absent(),
                Value<double> rawEquivalentG = const Value.absent(),
                Value<double> extraOilTsp = const Value.absent(),
                Value<double> fibreG = const Value.absent(),
                Value<double?> saturatedFatG = const Value.absent(),
                Value<double?> sugarG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<bool> isEstimate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealLogsCompanion(
                id: id,
                foodName: foodName,
                mealType: mealType,
                cookedWeightG: cookedWeightG,
                calculatedKcal: calculatedKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                timestamp: timestamp,
                foodId: foodId,
                basis: basis,
                rawEquivalentG: rawEquivalentG,
                extraOilTsp: extraOilTsp,
                fibreG: fibreG,
                saturatedFatG: saturatedFatG,
                sugarG: sugarG,
                sodiumMg: sodiumMg,
                isEstimate: isEstimate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodName,
                required String mealType,
                Value<double> cookedWeightG = const Value.absent(),
                Value<double> calculatedKcal = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatG = const Value.absent(),
                required DateTime timestamp,
                Value<String?> foodId = const Value.absent(),
                Value<String> basis = const Value.absent(),
                Value<double> rawEquivalentG = const Value.absent(),
                Value<double> extraOilTsp = const Value.absent(),
                Value<double> fibreG = const Value.absent(),
                Value<double?> saturatedFatG = const Value.absent(),
                Value<double?> sugarG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<bool> isEstimate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealLogsCompanion.insert(
                id: id,
                foodName: foodName,
                mealType: mealType,
                cookedWeightG: cookedWeightG,
                calculatedKcal: calculatedKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                timestamp: timestamp,
                foodId: foodId,
                basis: basis,
                rawEquivalentG: rawEquivalentG,
                extraOilTsp: extraOilTsp,
                fibreG: fibreG,
                saturatedFatG: saturatedFatG,
                sugarG: sugarG,
                sodiumMg: sodiumMg,
                isEstimate: isEstimate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealLogsTable,
      MealLog,
      $$MealLogsTableFilterComposer,
      $$MealLogsTableOrderingComposer,
      $$MealLogsTableAnnotationComposer,
      $$MealLogsTableCreateCompanionBuilder,
      $$MealLogsTableUpdateCompanionBuilder,
      (MealLog, BaseReferences<_$AppDatabase, $MealLogsTable, MealLog>),
      MealLog,
      PrefetchHooks Function()
    >;
typedef $$UserMetabolicProfilesTableCreateCompanionBuilder =
    UserMetabolicProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> age,
      Value<String> sex,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<double?> bodyFatPct,
      Value<String> bmrFormula,
      Value<double> activityMultiplier,
      Value<int> goalDeltaKcal,
      Value<int> dailyCalorieGoal,
      Value<double> proteinTargetG,
      Value<double> carbsTargetG,
      Value<double> fatTargetG,
      Value<double> fibreTargetG,
    });
typedef $$UserMetabolicProfilesTableUpdateCompanionBuilder =
    UserMetabolicProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> age,
      Value<String> sex,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<double?> bodyFatPct,
      Value<String> bmrFormula,
      Value<double> activityMultiplier,
      Value<int> goalDeltaKcal,
      Value<int> dailyCalorieGoal,
      Value<double> proteinTargetG,
      Value<double> carbsTargetG,
      Value<double> fatTargetG,
      Value<double> fibreTargetG,
    });

class $$UserMetabolicProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserMetabolicProfilesTable> {
  $$UserMetabolicProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bmrFormula => $composableBuilder(
    column: $table.bmrFormula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get activityMultiplier => $composableBuilder(
    column: $table.activityMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalDeltaKcal => $composableBuilder(
    column: $table.goalDeltaKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyCalorieGoal => $composableBuilder(
    column: $table.dailyCalorieGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fibreTargetG => $composableBuilder(
    column: $table.fibreTargetG,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserMetabolicProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserMetabolicProfilesTable> {
  $$UserMetabolicProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bmrFormula => $composableBuilder(
    column: $table.bmrFormula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get activityMultiplier => $composableBuilder(
    column: $table.activityMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalDeltaKcal => $composableBuilder(
    column: $table.goalDeltaKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyCalorieGoal => $composableBuilder(
    column: $table.dailyCalorieGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fibreTargetG => $composableBuilder(
    column: $table.fibreTargetG,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserMetabolicProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserMetabolicProfilesTable> {
  $$UserMetabolicProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bmrFormula => $composableBuilder(
    column: $table.bmrFormula,
    builder: (column) => column,
  );

  GeneratedColumn<double> get activityMultiplier => $composableBuilder(
    column: $table.activityMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalDeltaKcal => $composableBuilder(
    column: $table.goalDeltaKcal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyCalorieGoal => $composableBuilder(
    column: $table.dailyCalorieGoal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fibreTargetG => $composableBuilder(
    column: $table.fibreTargetG,
    builder: (column) => column,
  );
}

class $$UserMetabolicProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserMetabolicProfilesTable,
          UserMetabolicProfile,
          $$UserMetabolicProfilesTableFilterComposer,
          $$UserMetabolicProfilesTableOrderingComposer,
          $$UserMetabolicProfilesTableAnnotationComposer,
          $$UserMetabolicProfilesTableCreateCompanionBuilder,
          $$UserMetabolicProfilesTableUpdateCompanionBuilder,
          (
            UserMetabolicProfile,
            BaseReferences<
              _$AppDatabase,
              $UserMetabolicProfilesTable,
              UserMetabolicProfile
            >,
          ),
          UserMetabolicProfile,
          PrefetchHooks Function()
        > {
  $$UserMetabolicProfilesTableTableManager(
    _$AppDatabase db,
    $UserMetabolicProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserMetabolicProfilesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserMetabolicProfilesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserMetabolicProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<double?> bodyFatPct = const Value.absent(),
                Value<String> bmrFormula = const Value.absent(),
                Value<double> activityMultiplier = const Value.absent(),
                Value<int> goalDeltaKcal = const Value.absent(),
                Value<int> dailyCalorieGoal = const Value.absent(),
                Value<double> proteinTargetG = const Value.absent(),
                Value<double> carbsTargetG = const Value.absent(),
                Value<double> fatTargetG = const Value.absent(),
                Value<double> fibreTargetG = const Value.absent(),
              }) => UserMetabolicProfilesCompanion(
                id: id,
                name: name,
                age: age,
                sex: sex,
                heightCm: heightCm,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
                bmrFormula: bmrFormula,
                activityMultiplier: activityMultiplier,
                goalDeltaKcal: goalDeltaKcal,
                dailyCalorieGoal: dailyCalorieGoal,
                proteinTargetG: proteinTargetG,
                carbsTargetG: carbsTargetG,
                fatTargetG: fatTargetG,
                fibreTargetG: fibreTargetG,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<double?> bodyFatPct = const Value.absent(),
                Value<String> bmrFormula = const Value.absent(),
                Value<double> activityMultiplier = const Value.absent(),
                Value<int> goalDeltaKcal = const Value.absent(),
                Value<int> dailyCalorieGoal = const Value.absent(),
                Value<double> proteinTargetG = const Value.absent(),
                Value<double> carbsTargetG = const Value.absent(),
                Value<double> fatTargetG = const Value.absent(),
                Value<double> fibreTargetG = const Value.absent(),
              }) => UserMetabolicProfilesCompanion.insert(
                id: id,
                name: name,
                age: age,
                sex: sex,
                heightCm: heightCm,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
                bmrFormula: bmrFormula,
                activityMultiplier: activityMultiplier,
                goalDeltaKcal: goalDeltaKcal,
                dailyCalorieGoal: dailyCalorieGoal,
                proteinTargetG: proteinTargetG,
                carbsTargetG: carbsTargetG,
                fatTargetG: fatTargetG,
                fibreTargetG: fibreTargetG,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserMetabolicProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserMetabolicProfilesTable,
      UserMetabolicProfile,
      $$UserMetabolicProfilesTableFilterComposer,
      $$UserMetabolicProfilesTableOrderingComposer,
      $$UserMetabolicProfilesTableAnnotationComposer,
      $$UserMetabolicProfilesTableCreateCompanionBuilder,
      $$UserMetabolicProfilesTableUpdateCompanionBuilder,
      (
        UserMetabolicProfile,
        BaseReferences<
          _$AppDatabase,
          $UserMetabolicProfilesTable,
          UserMetabolicProfile
        >,
      ),
      UserMetabolicProfile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailySummariesTableTableManager get dailySummaries =>
      $$DailySummariesTableTableManager(_db, _db.dailySummaries);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$FoodCatalogTableTableManager get foodCatalog =>
      $$FoodCatalogTableTableManager(_db, _db.foodCatalog);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db, _db.mealLogs);
  $$UserMetabolicProfilesTableTableManager get userMetabolicProfiles =>
      $$UserMetabolicProfilesTableTableManager(_db, _db.userMetabolicProfiles);
}
