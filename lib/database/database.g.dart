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
          ..write('timestamp: $timestamp')
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
          other.timestamp == this.timestamp);
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailySummariesTable dailySummaries = $DailySummariesTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $MealLogsTable mealLogs = $MealLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailySummaries,
    workouts,
    mealLogs,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailySummariesTableTableManager get dailySummaries =>
      $$DailySummariesTableTableManager(_db, _db.dailySummaries);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db, _db.mealLogs);
}
