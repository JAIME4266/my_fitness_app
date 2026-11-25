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

class $RoutePointsTable extends RoutePoints
    with TableInfo<$RoutePointsTable, RoutePoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutePointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<double> altitudeM = GeneratedColumn<double>(
    'altitude_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _speedMpsMeta = const VerificationMeta(
    'speedMps',
  );
  @override
  late final GeneratedColumn<double> speedMps = GeneratedColumn<double>(
    'speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _timestampEpochMsMeta = const VerificationMeta(
    'timestampEpochMs',
  );
  @override
  late final GeneratedColumn<int> timestampEpochMs = GeneratedColumn<int>(
    'timestamp_epoch_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutId,
    lat,
    lng,
    altitudeM,
    accuracyM,
    speedMps,
    timestampEpochMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'route_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutePoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    if (data.containsKey('speed_mps')) {
      context.handle(
        _speedMpsMeta,
        speedMps.isAcceptableOrUnknown(data['speed_mps']!, _speedMpsMeta),
      );
    }
    if (data.containsKey('timestamp_epoch_ms')) {
      context.handle(
        _timestampEpochMsMeta,
        timestampEpochMs.isAcceptableOrUnknown(
          data['timestamp_epoch_ms']!,
          _timestampEpochMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampEpochMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutePoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutePoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_m'],
      )!,
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      )!,
      speedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_mps'],
      )!,
      timestampEpochMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_epoch_ms'],
      )!,
    );
  }

  @override
  $RoutePointsTable createAlias(String alias) {
    return $RoutePointsTable(attachedDatabase, alias);
  }
}

class RoutePoint extends DataClass implements Insertable<RoutePoint> {
  final int id;
  final String workoutId;
  final double lat;
  final double lng;
  final double altitudeM;
  final double accuracyM;
  final double speedMps;
  final int timestampEpochMs;
  const RoutePoint({
    required this.id,
    required this.workoutId,
    required this.lat,
    required this.lng,
    required this.altitudeM,
    required this.accuracyM,
    required this.speedMps,
    required this.timestampEpochMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_id'] = Variable<String>(workoutId);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    map['altitude_m'] = Variable<double>(altitudeM);
    map['accuracy_m'] = Variable<double>(accuracyM);
    map['speed_mps'] = Variable<double>(speedMps);
    map['timestamp_epoch_ms'] = Variable<int>(timestampEpochMs);
    return map;
  }

  RoutePointsCompanion toCompanion(bool nullToAbsent) {
    return RoutePointsCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      lat: Value(lat),
      lng: Value(lng),
      altitudeM: Value(altitudeM),
      accuracyM: Value(accuracyM),
      speedMps: Value(speedMps),
      timestampEpochMs: Value(timestampEpochMs),
    );
  }

  factory RoutePoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutePoint(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      altitudeM: serializer.fromJson<double>(json['altitudeM']),
      accuracyM: serializer.fromJson<double>(json['accuracyM']),
      speedMps: serializer.fromJson<double>(json['speedMps']),
      timestampEpochMs: serializer.fromJson<int>(json['timestampEpochMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutId': serializer.toJson<String>(workoutId),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'altitudeM': serializer.toJson<double>(altitudeM),
      'accuracyM': serializer.toJson<double>(accuracyM),
      'speedMps': serializer.toJson<double>(speedMps),
      'timestampEpochMs': serializer.toJson<int>(timestampEpochMs),
    };
  }

  RoutePoint copyWith({
    int? id,
    String? workoutId,
    double? lat,
    double? lng,
    double? altitudeM,
    double? accuracyM,
    double? speedMps,
    int? timestampEpochMs,
  }) => RoutePoint(
    id: id ?? this.id,
    workoutId: workoutId ?? this.workoutId,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    altitudeM: altitudeM ?? this.altitudeM,
    accuracyM: accuracyM ?? this.accuracyM,
    speedMps: speedMps ?? this.speedMps,
    timestampEpochMs: timestampEpochMs ?? this.timestampEpochMs,
  );
  RoutePoint copyWithCompanion(RoutePointsCompanion data) {
    return RoutePoint(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
      speedMps: data.speedMps.present ? data.speedMps.value : this.speedMps,
      timestampEpochMs: data.timestampEpochMs.present
          ? data.timestampEpochMs.value
          : this.timestampEpochMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutePoint(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('speedMps: $speedMps, ')
          ..write('timestampEpochMs: $timestampEpochMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workoutId,
    lat,
    lng,
    altitudeM,
    accuracyM,
    speedMps,
    timestampEpochMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutePoint &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.altitudeM == this.altitudeM &&
          other.accuracyM == this.accuracyM &&
          other.speedMps == this.speedMps &&
          other.timestampEpochMs == this.timestampEpochMs);
}

class RoutePointsCompanion extends UpdateCompanion<RoutePoint> {
  final Value<int> id;
  final Value<String> workoutId;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double> altitudeM;
  final Value<double> accuracyM;
  final Value<double> speedMps;
  final Value<int> timestampEpochMs;
  const RoutePointsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.speedMps = const Value.absent(),
    this.timestampEpochMs = const Value.absent(),
  });
  RoutePointsCompanion.insert({
    this.id = const Value.absent(),
    required String workoutId,
    required double lat,
    required double lng,
    this.altitudeM = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.speedMps = const Value.absent(),
    required int timestampEpochMs,
  }) : workoutId = Value(workoutId),
       lat = Value(lat),
       lng = Value(lng),
       timestampEpochMs = Value(timestampEpochMs);
  static Insertable<RoutePoint> custom({
    Expression<int>? id,
    Expression<String>? workoutId,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double>? altitudeM,
    Expression<double>? accuracyM,
    Expression<double>? speedMps,
    Expression<int>? timestampEpochMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (speedMps != null) 'speed_mps': speedMps,
      if (timestampEpochMs != null) 'timestamp_epoch_ms': timestampEpochMs,
    });
  }

  RoutePointsCompanion copyWith({
    Value<int>? id,
    Value<String>? workoutId,
    Value<double>? lat,
    Value<double>? lng,
    Value<double>? altitudeM,
    Value<double>? accuracyM,
    Value<double>? speedMps,
    Value<int>? timestampEpochMs,
  }) {
    return RoutePointsCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      altitudeM: altitudeM ?? this.altitudeM,
      accuracyM: accuracyM ?? this.accuracyM,
      speedMps: speedMps ?? this.speedMps,
      timestampEpochMs: timestampEpochMs ?? this.timestampEpochMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<double>(altitudeM.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (speedMps.present) {
      map['speed_mps'] = Variable<double>(speedMps.value);
    }
    if (timestampEpochMs.present) {
      map['timestamp_epoch_ms'] = Variable<int>(timestampEpochMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutePointsCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('speedMps: $speedMps, ')
          ..write('timestampEpochMs: $timestampEpochMs')
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

class $CommunityProfilesTable extends CommunityProfiles
    with TableInfo<$CommunityProfilesTable, CommunityProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyGoalKmMeta = const VerificationMeta(
    'dailyGoalKm',
  );
  @override
  late final GeneratedColumn<double> dailyGoalKm = GeneratedColumn<double>(
    'daily_goal_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(5.0),
  );
  static const VerificationMeta _todayDistanceKmMeta = const VerificationMeta(
    'todayDistanceKm',
  );
  @override
  late final GeneratedColumn<double> todayDistanceKm = GeneratedColumn<double>(
    'today_distance_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFollowingMeta = const VerificationMeta(
    'isFollowing',
  );
  @override
  late final GeneratedColumn<bool> isFollowing = GeneratedColumn<bool>(
    'is_following',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_following" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    displayName,
    dailyGoalKm,
    todayDistanceKm,
    isPrivate,
    isFollowing,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('daily_goal_km')) {
      context.handle(
        _dailyGoalKmMeta,
        dailyGoalKm.isAcceptableOrUnknown(
          data['daily_goal_km']!,
          _dailyGoalKmMeta,
        ),
      );
    }
    if (data.containsKey('today_distance_km')) {
      context.handle(
        _todayDistanceKmMeta,
        todayDistanceKm.isAcceptableOrUnknown(
          data['today_distance_km']!,
          _todayDistanceKmMeta,
        ),
      );
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('is_following')) {
      context.handle(
        _isFollowingMeta,
        isFollowing.isAcceptableOrUnknown(
          data['is_following']!,
          _isFollowingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      dailyGoalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_goal_km'],
      )!,
      todayDistanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}today_distance_km'],
      )!,
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      isFollowing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_following'],
      )!,
    );
  }

  @override
  $CommunityProfilesTable createAlias(String alias) {
    return $CommunityProfilesTable(attachedDatabase, alias);
  }
}

class CommunityProfile extends DataClass
    implements Insertable<CommunityProfile> {
  final String id;
  final String username;
  final String displayName;
  final double dailyGoalKm;
  final double todayDistanceKm;
  final bool isPrivate;
  final bool isFollowing;
  const CommunityProfile({
    required this.id,
    required this.username,
    required this.displayName,
    required this.dailyGoalKm,
    required this.todayDistanceKm,
    required this.isPrivate,
    required this.isFollowing,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['display_name'] = Variable<String>(displayName);
    map['daily_goal_km'] = Variable<double>(dailyGoalKm);
    map['today_distance_km'] = Variable<double>(todayDistanceKm);
    map['is_private'] = Variable<bool>(isPrivate);
    map['is_following'] = Variable<bool>(isFollowing);
    return map;
  }

  CommunityProfilesCompanion toCompanion(bool nullToAbsent) {
    return CommunityProfilesCompanion(
      id: Value(id),
      username: Value(username),
      displayName: Value(displayName),
      dailyGoalKm: Value(dailyGoalKm),
      todayDistanceKm: Value(todayDistanceKm),
      isPrivate: Value(isPrivate),
      isFollowing: Value(isFollowing),
    );
  }

  factory CommunityProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityProfile(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      displayName: serializer.fromJson<String>(json['displayName']),
      dailyGoalKm: serializer.fromJson<double>(json['dailyGoalKm']),
      todayDistanceKm: serializer.fromJson<double>(json['todayDistanceKm']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      isFollowing: serializer.fromJson<bool>(json['isFollowing']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'displayName': serializer.toJson<String>(displayName),
      'dailyGoalKm': serializer.toJson<double>(dailyGoalKm),
      'todayDistanceKm': serializer.toJson<double>(todayDistanceKm),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'isFollowing': serializer.toJson<bool>(isFollowing),
    };
  }

  CommunityProfile copyWith({
    String? id,
    String? username,
    String? displayName,
    double? dailyGoalKm,
    double? todayDistanceKm,
    bool? isPrivate,
    bool? isFollowing,
  }) => CommunityProfile(
    id: id ?? this.id,
    username: username ?? this.username,
    displayName: displayName ?? this.displayName,
    dailyGoalKm: dailyGoalKm ?? this.dailyGoalKm,
    todayDistanceKm: todayDistanceKm ?? this.todayDistanceKm,
    isPrivate: isPrivate ?? this.isPrivate,
    isFollowing: isFollowing ?? this.isFollowing,
  );
  CommunityProfile copyWithCompanion(CommunityProfilesCompanion data) {
    return CommunityProfile(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      dailyGoalKm: data.dailyGoalKm.present
          ? data.dailyGoalKm.value
          : this.dailyGoalKm,
      todayDistanceKm: data.todayDistanceKm.present
          ? data.todayDistanceKm.value
          : this.todayDistanceKm,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      isFollowing: data.isFollowing.present
          ? data.isFollowing.value
          : this.isFollowing,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityProfile(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('dailyGoalKm: $dailyGoalKm, ')
          ..write('todayDistanceKm: $todayDistanceKm, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('isFollowing: $isFollowing')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    displayName,
    dailyGoalKm,
    todayDistanceKm,
    isPrivate,
    isFollowing,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityProfile &&
          other.id == this.id &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.dailyGoalKm == this.dailyGoalKm &&
          other.todayDistanceKm == this.todayDistanceKm &&
          other.isPrivate == this.isPrivate &&
          other.isFollowing == this.isFollowing);
}

class CommunityProfilesCompanion extends UpdateCompanion<CommunityProfile> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> displayName;
  final Value<double> dailyGoalKm;
  final Value<double> todayDistanceKm;
  final Value<bool> isPrivate;
  final Value<bool> isFollowing;
  final Value<int> rowid;
  const CommunityProfilesCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.dailyGoalKm = const Value.absent(),
    this.todayDistanceKm = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.isFollowing = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityProfilesCompanion.insert({
    required String id,
    required String username,
    required String displayName,
    this.dailyGoalKm = const Value.absent(),
    this.todayDistanceKm = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.isFollowing = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       username = Value(username),
       displayName = Value(displayName);
  static Insertable<CommunityProfile> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<double>? dailyGoalKm,
    Expression<double>? todayDistanceKm,
    Expression<bool>? isPrivate,
    Expression<bool>? isFollowing,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (dailyGoalKm != null) 'daily_goal_km': dailyGoalKm,
      if (todayDistanceKm != null) 'today_distance_km': todayDistanceKm,
      if (isPrivate != null) 'is_private': isPrivate,
      if (isFollowing != null) 'is_following': isFollowing,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? username,
    Value<String>? displayName,
    Value<double>? dailyGoalKm,
    Value<double>? todayDistanceKm,
    Value<bool>? isPrivate,
    Value<bool>? isFollowing,
    Value<int>? rowid,
  }) {
    return CommunityProfilesCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      dailyGoalKm: dailyGoalKm ?? this.dailyGoalKm,
      todayDistanceKm: todayDistanceKm ?? this.todayDistanceKm,
      isPrivate: isPrivate ?? this.isPrivate,
      isFollowing: isFollowing ?? this.isFollowing,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (dailyGoalKm.present) {
      map['daily_goal_km'] = Variable<double>(dailyGoalKm.value);
    }
    if (todayDistanceKm.present) {
      map['today_distance_km'] = Variable<double>(todayDistanceKm.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (isFollowing.present) {
      map['is_following'] = Variable<bool>(isFollowing.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityProfilesCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('dailyGoalKm: $dailyGoalKm, ')
          ..write('todayDistanceKm: $todayDistanceKm, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('isFollowing: $isFollowing, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityPostsTable extends CommunityPosts
    with TableInfo<$CommunityPostsTable, CommunityPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paceLabelMeta = const VerificationMeta(
    'paceLabel',
  );
  @override
  late final GeneratedColumn<String> paceLabel = GeneratedColumn<String>(
    'pace_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _workoutBadgeMeta = const VerificationMeta(
    'workoutBadge',
  );
  @override
  late final GeneratedColumn<String> workoutBadge = GeneratedColumn<String>(
    'workout_badge',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('public'),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    authorName,
    title,
    distanceKm,
    durationSec,
    paceLabel,
    polylineJson,
    workoutBadge,
    visibility,
    createdAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_posts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityPost> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceKmMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecMeta);
    }
    if (data.containsKey('pace_label')) {
      context.handle(
        _paceLabelMeta,
        paceLabel.isAcceptableOrUnknown(data['pace_label']!, _paceLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_paceLabelMeta);
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
    if (data.containsKey('workout_badge')) {
      context.handle(
        _workoutBadgeMeta,
        workoutBadge.isAcceptableOrUnknown(
          data['workout_badge']!,
          _workoutBadgeMeta,
        ),
      );
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityPost(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      )!,
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      paceLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pace_label'],
      )!,
      polylineJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}polyline_json'],
      ),
      workoutBadge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_badge'],
      ),
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $CommunityPostsTable createAlias(String alias) {
    return $CommunityPostsTable(attachedDatabase, alias);
  }
}

class CommunityPost extends DataClass implements Insertable<CommunityPost> {
  final String id;
  final String userId;
  final String authorName;
  final String title;
  final double distanceKm;
  final int durationSec;
  final String paceLabel;
  final String? polylineJson;
  final String? workoutBadge;
  final String visibility;
  final int createdAtMs;
  const CommunityPost({
    required this.id,
    required this.userId,
    required this.authorName,
    required this.title,
    required this.distanceKm,
    required this.durationSec,
    required this.paceLabel,
    this.polylineJson,
    this.workoutBadge,
    required this.visibility,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['author_name'] = Variable<String>(authorName);
    map['title'] = Variable<String>(title);
    map['distance_km'] = Variable<double>(distanceKm);
    map['duration_sec'] = Variable<int>(durationSec);
    map['pace_label'] = Variable<String>(paceLabel);
    if (!nullToAbsent || polylineJson != null) {
      map['polyline_json'] = Variable<String>(polylineJson);
    }
    if (!nullToAbsent || workoutBadge != null) {
      map['workout_badge'] = Variable<String>(workoutBadge);
    }
    map['visibility'] = Variable<String>(visibility);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  CommunityPostsCompanion toCompanion(bool nullToAbsent) {
    return CommunityPostsCompanion(
      id: Value(id),
      userId: Value(userId),
      authorName: Value(authorName),
      title: Value(title),
      distanceKm: Value(distanceKm),
      durationSec: Value(durationSec),
      paceLabel: Value(paceLabel),
      polylineJson: polylineJson == null && nullToAbsent
          ? const Value.absent()
          : Value(polylineJson),
      workoutBadge: workoutBadge == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutBadge),
      visibility: Value(visibility),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory CommunityPost.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityPost(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      title: serializer.fromJson<String>(json['title']),
      distanceKm: serializer.fromJson<double>(json['distanceKm']),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      paceLabel: serializer.fromJson<String>(json['paceLabel']),
      polylineJson: serializer.fromJson<String?>(json['polylineJson']),
      workoutBadge: serializer.fromJson<String?>(json['workoutBadge']),
      visibility: serializer.fromJson<String>(json['visibility']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'authorName': serializer.toJson<String>(authorName),
      'title': serializer.toJson<String>(title),
      'distanceKm': serializer.toJson<double>(distanceKm),
      'durationSec': serializer.toJson<int>(durationSec),
      'paceLabel': serializer.toJson<String>(paceLabel),
      'polylineJson': serializer.toJson<String?>(polylineJson),
      'workoutBadge': serializer.toJson<String?>(workoutBadge),
      'visibility': serializer.toJson<String>(visibility),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  CommunityPost copyWith({
    String? id,
    String? userId,
    String? authorName,
    String? title,
    double? distanceKm,
    int? durationSec,
    String? paceLabel,
    Value<String?> polylineJson = const Value.absent(),
    Value<String?> workoutBadge = const Value.absent(),
    String? visibility,
    int? createdAtMs,
  }) => CommunityPost(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    authorName: authorName ?? this.authorName,
    title: title ?? this.title,
    distanceKm: distanceKm ?? this.distanceKm,
    durationSec: durationSec ?? this.durationSec,
    paceLabel: paceLabel ?? this.paceLabel,
    polylineJson: polylineJson.present ? polylineJson.value : this.polylineJson,
    workoutBadge: workoutBadge.present ? workoutBadge.value : this.workoutBadge,
    visibility: visibility ?? this.visibility,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  CommunityPost copyWithCompanion(CommunityPostsCompanion data) {
    return CommunityPost(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      title: data.title.present ? data.title.value : this.title,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      paceLabel: data.paceLabel.present ? data.paceLabel.value : this.paceLabel,
      polylineJson: data.polylineJson.present
          ? data.polylineJson.value
          : this.polylineJson,
      workoutBadge: data.workoutBadge.present
          ? data.workoutBadge.value
          : this.workoutBadge,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityPost(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('durationSec: $durationSec, ')
          ..write('paceLabel: $paceLabel, ')
          ..write('polylineJson: $polylineJson, ')
          ..write('workoutBadge: $workoutBadge, ')
          ..write('visibility: $visibility, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    authorName,
    title,
    distanceKm,
    durationSec,
    paceLabel,
    polylineJson,
    workoutBadge,
    visibility,
    createdAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityPost &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.authorName == this.authorName &&
          other.title == this.title &&
          other.distanceKm == this.distanceKm &&
          other.durationSec == this.durationSec &&
          other.paceLabel == this.paceLabel &&
          other.polylineJson == this.polylineJson &&
          other.workoutBadge == this.workoutBadge &&
          other.visibility == this.visibility &&
          other.createdAtMs == this.createdAtMs);
}

class CommunityPostsCompanion extends UpdateCompanion<CommunityPost> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> authorName;
  final Value<String> title;
  final Value<double> distanceKm;
  final Value<int> durationSec;
  final Value<String> paceLabel;
  final Value<String?> polylineJson;
  final Value<String?> workoutBadge;
  final Value<String> visibility;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const CommunityPostsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.title = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.paceLabel = const Value.absent(),
    this.polylineJson = const Value.absent(),
    this.workoutBadge = const Value.absent(),
    this.visibility = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityPostsCompanion.insert({
    required String id,
    required String userId,
    required String authorName,
    required String title,
    required double distanceKm,
    required int durationSec,
    required String paceLabel,
    this.polylineJson = const Value.absent(),
    this.workoutBadge = const Value.absent(),
    this.visibility = const Value.absent(),
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       authorName = Value(authorName),
       title = Value(title),
       distanceKm = Value(distanceKm),
       durationSec = Value(durationSec),
       paceLabel = Value(paceLabel),
       createdAtMs = Value(createdAtMs);
  static Insertable<CommunityPost> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? authorName,
    Expression<String>? title,
    Expression<double>? distanceKm,
    Expression<int>? durationSec,
    Expression<String>? paceLabel,
    Expression<String>? polylineJson,
    Expression<String>? workoutBadge,
    Expression<String>? visibility,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (authorName != null) 'author_name': authorName,
      if (title != null) 'title': title,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (durationSec != null) 'duration_sec': durationSec,
      if (paceLabel != null) 'pace_label': paceLabel,
      if (polylineJson != null) 'polyline_json': polylineJson,
      if (workoutBadge != null) 'workout_badge': workoutBadge,
      if (visibility != null) 'visibility': visibility,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityPostsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? authorName,
    Value<String>? title,
    Value<double>? distanceKm,
    Value<int>? durationSec,
    Value<String>? paceLabel,
    Value<String?>? polylineJson,
    Value<String?>? workoutBadge,
    Value<String>? visibility,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return CommunityPostsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      distanceKm: distanceKm ?? this.distanceKm,
      durationSec: durationSec ?? this.durationSec,
      paceLabel: paceLabel ?? this.paceLabel,
      polylineJson: polylineJson ?? this.polylineJson,
      workoutBadge: workoutBadge ?? this.workoutBadge,
      visibility: visibility ?? this.visibility,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (paceLabel.present) {
      map['pace_label'] = Variable<String>(paceLabel.value);
    }
    if (polylineJson.present) {
      map['polyline_json'] = Variable<String>(polylineJson.value);
    }
    if (workoutBadge.present) {
      map['workout_badge'] = Variable<String>(workoutBadge.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityPostsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('durationSec: $durationSec, ')
          ..write('paceLabel: $paceLabel, ')
          ..write('polylineJson: $polylineJson, ')
          ..write('workoutBadge: $workoutBadge, ')
          ..write('visibility: $visibility, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityPostLikesTable extends CommunityPostLikes
    with TableInfo<$CommunityPostLikesTable, CommunityPostLike> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityPostLikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
    'post_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [postId, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_post_likes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityPostLike> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('post_id')) {
      context.handle(
        _postIdMeta,
        postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta),
      );
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId, userId};
  @override
  CommunityPostLike map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityPostLike(
      postId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
    );
  }

  @override
  $CommunityPostLikesTable createAlias(String alias) {
    return $CommunityPostLikesTable(attachedDatabase, alias);
  }
}

class CommunityPostLike extends DataClass
    implements Insertable<CommunityPostLike> {
  final String postId;
  final String userId;
  const CommunityPostLike({required this.postId, required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['post_id'] = Variable<String>(postId);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  CommunityPostLikesCompanion toCompanion(bool nullToAbsent) {
    return CommunityPostLikesCompanion(
      postId: Value(postId),
      userId: Value(userId),
    );
  }

  factory CommunityPostLike.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityPostLike(
      postId: serializer.fromJson<String>(json['postId']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'postId': serializer.toJson<String>(postId),
      'userId': serializer.toJson<String>(userId),
    };
  }

  CommunityPostLike copyWith({String? postId, String? userId}) =>
      CommunityPostLike(
        postId: postId ?? this.postId,
        userId: userId ?? this.userId,
      );
  CommunityPostLike copyWithCompanion(CommunityPostLikesCompanion data) {
    return CommunityPostLike(
      postId: data.postId.present ? data.postId.value : this.postId,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityPostLike(')
          ..write('postId: $postId, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(postId, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityPostLike &&
          other.postId == this.postId &&
          other.userId == this.userId);
}

class CommunityPostLikesCompanion extends UpdateCompanion<CommunityPostLike> {
  final Value<String> postId;
  final Value<String> userId;
  final Value<int> rowid;
  const CommunityPostLikesCompanion({
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityPostLikesCompanion.insert({
    required String postId,
    required String userId,
    this.rowid = const Value.absent(),
  }) : postId = Value(postId),
       userId = Value(userId);
  static Insertable<CommunityPostLike> custom({
    Expression<String>? postId,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (postId != null) 'post_id': postId,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityPostLikesCompanion copyWith({
    Value<String>? postId,
    Value<String>? userId,
    Value<int>? rowid,
  }) {
    return CommunityPostLikesCompanion(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityPostLikesCompanion(')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityCommentsTable extends CommunityComments
    with TableInfo<$CommunityCommentsTable, CommunityComment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityCommentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
    'post_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    postId,
    userId,
    authorName,
    body,
    createdAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_comments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityComment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(
        _postIdMeta,
        postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta),
      );
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityComment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityComment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      postId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $CommunityCommentsTable createAlias(String alias) {
    return $CommunityCommentsTable(attachedDatabase, alias);
  }
}

class CommunityComment extends DataClass
    implements Insertable<CommunityComment> {
  final String id;
  final String postId;
  final String userId;
  final String authorName;
  final String body;
  final int createdAtMs;
  const CommunityComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.authorName,
    required this.body,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['post_id'] = Variable<String>(postId);
    map['user_id'] = Variable<String>(userId);
    map['author_name'] = Variable<String>(authorName);
    map['body'] = Variable<String>(body);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  CommunityCommentsCompanion toCompanion(bool nullToAbsent) {
    return CommunityCommentsCompanion(
      id: Value(id),
      postId: Value(postId),
      userId: Value(userId),
      authorName: Value(authorName),
      body: Value(body),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory CommunityComment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityComment(
      id: serializer.fromJson<String>(json['id']),
      postId: serializer.fromJson<String>(json['postId']),
      userId: serializer.fromJson<String>(json['userId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      body: serializer.fromJson<String>(json['body']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'postId': serializer.toJson<String>(postId),
      'userId': serializer.toJson<String>(userId),
      'authorName': serializer.toJson<String>(authorName),
      'body': serializer.toJson<String>(body),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  CommunityComment copyWith({
    String? id,
    String? postId,
    String? userId,
    String? authorName,
    String? body,
    int? createdAtMs,
  }) => CommunityComment(
    id: id ?? this.id,
    postId: postId ?? this.postId,
    userId: userId ?? this.userId,
    authorName: authorName ?? this.authorName,
    body: body ?? this.body,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  CommunityComment copyWithCompanion(CommunityCommentsCompanion data) {
    return CommunityComment(
      id: data.id.present ? data.id.value : this.id,
      postId: data.postId.present ? data.postId.value : this.postId,
      userId: data.userId.present ? data.userId.value : this.userId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      body: data.body.present ? data.body.value : this.body,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityComment(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, postId, userId, authorName, body, createdAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityComment &&
          other.id == this.id &&
          other.postId == this.postId &&
          other.userId == this.userId &&
          other.authorName == this.authorName &&
          other.body == this.body &&
          other.createdAtMs == this.createdAtMs);
}

class CommunityCommentsCompanion extends UpdateCompanion<CommunityComment> {
  final Value<String> id;
  final Value<String> postId;
  final Value<String> userId;
  final Value<String> authorName;
  final Value<String> body;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const CommunityCommentsCompanion({
    this.id = const Value.absent(),
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityCommentsCompanion.insert({
    required String id,
    required String postId,
    required String userId,
    required String authorName,
    required String body,
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       postId = Value(postId),
       userId = Value(userId),
       authorName = Value(authorName),
       body = Value(body),
       createdAtMs = Value(createdAtMs);
  static Insertable<CommunityComment> custom({
    Expression<String>? id,
    Expression<String>? postId,
    Expression<String>? userId,
    Expression<String>? authorName,
    Expression<String>? body,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postId != null) 'post_id': postId,
      if (userId != null) 'user_id': userId,
      if (authorName != null) 'author_name': authorName,
      if (body != null) 'body': body,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityCommentsCompanion copyWith({
    Value<String>? id,
    Value<String>? postId,
    Value<String>? userId,
    Value<String>? authorName,
    Value<String>? body,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return CommunityCommentsCompanion(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      authorName: authorName ?? this.authorName,
      body: body ?? this.body,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityCommentsCompanion(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityGroupsTable extends CommunityGroups
    with TableInfo<$CommunityGroupsTable, CommunityGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberCountMeta = const VerificationMeta(
    'memberCount',
  );
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
    'member_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isJoinedMeta = const VerificationMeta(
    'isJoined',
  );
  @override
  late final GeneratedColumn<bool> isJoined = GeneratedColumn<bool>(
    'is_joined',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_joined" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    isPrivate,
    ownerId,
    memberCount,
    isJoined,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityGroup> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('member_count')) {
      context.handle(
        _memberCountMeta,
        memberCount.isAcceptableOrUnknown(
          data['member_count']!,
          _memberCountMeta,
        ),
      );
    }
    if (data.containsKey('is_joined')) {
      context.handle(
        _isJoinedMeta,
        isJoined.isAcceptableOrUnknown(data['is_joined']!, _isJoinedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      memberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_count'],
      )!,
      isJoined: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_joined'],
      )!,
    );
  }

  @override
  $CommunityGroupsTable createAlias(String alias) {
    return $CommunityGroupsTable(attachedDatabase, alias);
  }
}

class CommunityGroup extends DataClass implements Insertable<CommunityGroup> {
  final String id;
  final String name;
  final String description;
  final bool isPrivate;
  final String ownerId;
  final int memberCount;
  final bool isJoined;
  const CommunityGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.ownerId,
    required this.memberCount,
    required this.isJoined,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['is_private'] = Variable<bool>(isPrivate);
    map['owner_id'] = Variable<String>(ownerId);
    map['member_count'] = Variable<int>(memberCount);
    map['is_joined'] = Variable<bool>(isJoined);
    return map;
  }

  CommunityGroupsCompanion toCompanion(bool nullToAbsent) {
    return CommunityGroupsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      isPrivate: Value(isPrivate),
      ownerId: Value(ownerId),
      memberCount: Value(memberCount),
      isJoined: Value(isJoined),
    );
  }

  factory CommunityGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityGroup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      memberCount: serializer.fromJson<int>(json['memberCount']),
      isJoined: serializer.fromJson<bool>(json['isJoined']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'ownerId': serializer.toJson<String>(ownerId),
      'memberCount': serializer.toJson<int>(memberCount),
      'isJoined': serializer.toJson<bool>(isJoined),
    };
  }

  CommunityGroup copyWith({
    String? id,
    String? name,
    String? description,
    bool? isPrivate,
    String? ownerId,
    int? memberCount,
    bool? isJoined,
  }) => CommunityGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    isPrivate: isPrivate ?? this.isPrivate,
    ownerId: ownerId ?? this.ownerId,
    memberCount: memberCount ?? this.memberCount,
    isJoined: isJoined ?? this.isJoined,
  );
  CommunityGroup copyWithCompanion(CommunityGroupsCompanion data) {
    return CommunityGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      memberCount: data.memberCount.present
          ? data.memberCount.value
          : this.memberCount,
      isJoined: data.isJoined.present ? data.isJoined.value : this.isJoined,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('ownerId: $ownerId, ')
          ..write('memberCount: $memberCount, ')
          ..write('isJoined: $isJoined')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    isPrivate,
    ownerId,
    memberCount,
    isJoined,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isPrivate == this.isPrivate &&
          other.ownerId == this.ownerId &&
          other.memberCount == this.memberCount &&
          other.isJoined == this.isJoined);
}

class CommunityGroupsCompanion extends UpdateCompanion<CommunityGroup> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<bool> isPrivate;
  final Value<String> ownerId;
  final Value<int> memberCount;
  final Value<bool> isJoined;
  final Value<int> rowid;
  const CommunityGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityGroupsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isPrivate = const Value.absent(),
    required String ownerId,
    this.memberCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       ownerId = Value(ownerId);
  static Insertable<CommunityGroup> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isPrivate,
    Expression<String>? ownerId,
    Expression<int>? memberCount,
    Expression<bool>? isJoined,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isPrivate != null) 'is_private': isPrivate,
      if (ownerId != null) 'owner_id': ownerId,
      if (memberCount != null) 'member_count': memberCount,
      if (isJoined != null) 'is_joined': isJoined,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<bool>? isPrivate,
    Value<String>? ownerId,
    Value<int>? memberCount,
    Value<bool>? isJoined,
    Value<int>? rowid,
  }) {
    return CommunityGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isPrivate: isPrivate ?? this.isPrivate,
      ownerId: ownerId ?? this.ownerId,
      memberCount: memberCount ?? this.memberCount,
      isJoined: isJoined ?? this.isJoined,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
    }
    if (isJoined.present) {
      map['is_joined'] = Variable<bool>(isJoined.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('ownerId: $ownerId, ')
          ..write('memberCount: $memberCount, ')
          ..write('isJoined: $isJoined, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityChallengesTable extends CommunityChallenges
    with TableInfo<$CommunityChallengesTable, CommunityChallenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetKmMeta = const VerificationMeta(
    'targetKm',
  );
  @override
  late final GeneratedColumn<double> targetKm = GeneratedColumn<double>(
    'target_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationDaysMeta = const VerificationMeta(
    'durationDays',
  );
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
    'duration_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _challengeTypeMeta = const VerificationMeta(
    'challengeType',
  );
  @override
  late final GeneratedColumn<String> challengeType = GeneratedColumn<String>(
    'challenge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participantCountMeta = const VerificationMeta(
    'participantCount',
  );
  @override
  late final GeneratedColumn<int> participantCount = GeneratedColumn<int>(
    'participant_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isJoinedMeta = const VerificationMeta(
    'isJoined',
  );
  @override
  late final GeneratedColumn<bool> isJoined = GeneratedColumn<bool>(
    'is_joined',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_joined" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    targetKm,
    durationDays,
    challengeType,
    participantCount,
    isJoined,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityChallenge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_km')) {
      context.handle(
        _targetKmMeta,
        targetKm.isAcceptableOrUnknown(data['target_km']!, _targetKmMeta),
      );
    } else if (isInserting) {
      context.missing(_targetKmMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
        _durationDaysMeta,
        durationDays.isAcceptableOrUnknown(
          data['duration_days']!,
          _durationDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationDaysMeta);
    }
    if (data.containsKey('challenge_type')) {
      context.handle(
        _challengeTypeMeta,
        challengeType.isAcceptableOrUnknown(
          data['challenge_type']!,
          _challengeTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_challengeTypeMeta);
    }
    if (data.containsKey('participant_count')) {
      context.handle(
        _participantCountMeta,
        participantCount.isAcceptableOrUnknown(
          data['participant_count']!,
          _participantCountMeta,
        ),
      );
    }
    if (data.containsKey('is_joined')) {
      context.handle(
        _isJoinedMeta,
        isJoined.isAcceptableOrUnknown(data['is_joined']!, _isJoinedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityChallenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityChallenge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_km'],
      )!,
      durationDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days'],
      )!,
      challengeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_type'],
      )!,
      participantCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant_count'],
      )!,
      isJoined: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_joined'],
      )!,
    );
  }

  @override
  $CommunityChallengesTable createAlias(String alias) {
    return $CommunityChallengesTable(attachedDatabase, alias);
  }
}

class CommunityChallenge extends DataClass
    implements Insertable<CommunityChallenge> {
  final String id;
  final String title;
  final double targetKm;
  final int durationDays;
  final String challengeType;
  final int participantCount;
  final bool isJoined;
  const CommunityChallenge({
    required this.id,
    required this.title,
    required this.targetKm,
    required this.durationDays,
    required this.challengeType,
    required this.participantCount,
    required this.isJoined,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['target_km'] = Variable<double>(targetKm);
    map['duration_days'] = Variable<int>(durationDays);
    map['challenge_type'] = Variable<String>(challengeType);
    map['participant_count'] = Variable<int>(participantCount);
    map['is_joined'] = Variable<bool>(isJoined);
    return map;
  }

  CommunityChallengesCompanion toCompanion(bool nullToAbsent) {
    return CommunityChallengesCompanion(
      id: Value(id),
      title: Value(title),
      targetKm: Value(targetKm),
      durationDays: Value(durationDays),
      challengeType: Value(challengeType),
      participantCount: Value(participantCount),
      isJoined: Value(isJoined),
    );
  }

  factory CommunityChallenge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityChallenge(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetKm: serializer.fromJson<double>(json['targetKm']),
      durationDays: serializer.fromJson<int>(json['durationDays']),
      challengeType: serializer.fromJson<String>(json['challengeType']),
      participantCount: serializer.fromJson<int>(json['participantCount']),
      isJoined: serializer.fromJson<bool>(json['isJoined']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'targetKm': serializer.toJson<double>(targetKm),
      'durationDays': serializer.toJson<int>(durationDays),
      'challengeType': serializer.toJson<String>(challengeType),
      'participantCount': serializer.toJson<int>(participantCount),
      'isJoined': serializer.toJson<bool>(isJoined),
    };
  }

  CommunityChallenge copyWith({
    String? id,
    String? title,
    double? targetKm,
    int? durationDays,
    String? challengeType,
    int? participantCount,
    bool? isJoined,
  }) => CommunityChallenge(
    id: id ?? this.id,
    title: title ?? this.title,
    targetKm: targetKm ?? this.targetKm,
    durationDays: durationDays ?? this.durationDays,
    challengeType: challengeType ?? this.challengeType,
    participantCount: participantCount ?? this.participantCount,
    isJoined: isJoined ?? this.isJoined,
  );
  CommunityChallenge copyWithCompanion(CommunityChallengesCompanion data) {
    return CommunityChallenge(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetKm: data.targetKm.present ? data.targetKm.value : this.targetKm,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      challengeType: data.challengeType.present
          ? data.challengeType.value
          : this.challengeType,
      participantCount: data.participantCount.present
          ? data.participantCount.value
          : this.participantCount,
      isJoined: data.isJoined.present ? data.isJoined.value : this.isJoined,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityChallenge(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetKm: $targetKm, ')
          ..write('durationDays: $durationDays, ')
          ..write('challengeType: $challengeType, ')
          ..write('participantCount: $participantCount, ')
          ..write('isJoined: $isJoined')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    targetKm,
    durationDays,
    challengeType,
    participantCount,
    isJoined,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityChallenge &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetKm == this.targetKm &&
          other.durationDays == this.durationDays &&
          other.challengeType == this.challengeType &&
          other.participantCount == this.participantCount &&
          other.isJoined == this.isJoined);
}

class CommunityChallengesCompanion extends UpdateCompanion<CommunityChallenge> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> targetKm;
  final Value<int> durationDays;
  final Value<String> challengeType;
  final Value<int> participantCount;
  final Value<bool> isJoined;
  final Value<int> rowid;
  const CommunityChallengesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetKm = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.challengeType = const Value.absent(),
    this.participantCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityChallengesCompanion.insert({
    required String id,
    required String title,
    required double targetKm,
    required int durationDays,
    required String challengeType,
    this.participantCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       targetKm = Value(targetKm),
       durationDays = Value(durationDays),
       challengeType = Value(challengeType);
  static Insertable<CommunityChallenge> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? targetKm,
    Expression<int>? durationDays,
    Expression<String>? challengeType,
    Expression<int>? participantCount,
    Expression<bool>? isJoined,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetKm != null) 'target_km': targetKm,
      if (durationDays != null) 'duration_days': durationDays,
      if (challengeType != null) 'challenge_type': challengeType,
      if (participantCount != null) 'participant_count': participantCount,
      if (isJoined != null) 'is_joined': isJoined,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<double>? targetKm,
    Value<int>? durationDays,
    Value<String>? challengeType,
    Value<int>? participantCount,
    Value<bool>? isJoined,
    Value<int>? rowid,
  }) {
    return CommunityChallengesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetKm: targetKm ?? this.targetKm,
      durationDays: durationDays ?? this.durationDays,
      challengeType: challengeType ?? this.challengeType,
      participantCount: participantCount ?? this.participantCount,
      isJoined: isJoined ?? this.isJoined,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetKm.present) {
      map['target_km'] = Variable<double>(targetKm.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (challengeType.present) {
      map['challenge_type'] = Variable<String>(challengeType.value);
    }
    if (participantCount.present) {
      map['participant_count'] = Variable<int>(participantCount.value);
    }
    if (isJoined.present) {
      map['is_joined'] = Variable<bool>(isJoined.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityChallengesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetKm: $targetKm, ')
          ..write('durationDays: $durationDays, ')
          ..write('challengeType: $challengeType, ')
          ..write('participantCount: $participantCount, ')
          ..write('isJoined: $isJoined, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityNotificationsTable extends CommunityNotifications
    with TableInfo<$CommunityNotificationsTable, CommunityNotification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, body, isRead, createdAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommunityNotification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityNotification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $CommunityNotificationsTable createAlias(String alias) {
    return $CommunityNotificationsTable(attachedDatabase, alias);
  }
}

class CommunityNotification extends DataClass
    implements Insertable<CommunityNotification> {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final int createdAtMs;
  const CommunityNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  CommunityNotificationsCompanion toCompanion(bool nullToAbsent) {
    return CommunityNotificationsCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      isRead: Value(isRead),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory CommunityNotification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityNotification(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  CommunityNotification copyWith({
    String? id,
    String? title,
    String? body,
    bool? isRead,
    int? createdAtMs,
  }) => CommunityNotification(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    isRead: isRead ?? this.isRead,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  CommunityNotification copyWithCompanion(
    CommunityNotificationsCompanion data,
  ) {
    return CommunityNotification(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityNotification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, body, isRead, createdAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityNotification &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.isRead == this.isRead &&
          other.createdAtMs == this.createdAtMs);
}

class CommunityNotificationsCompanion
    extends UpdateCompanion<CommunityNotification> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<bool> isRead;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const CommunityNotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityNotificationsCompanion.insert({
    required String id,
    required String title,
    required String body,
    this.isRead = const Value.absent(),
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       body = Value(body),
       createdAtMs = Value(createdAtMs);
  static Insertable<CommunityNotification> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<bool>? isRead,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (isRead != null) 'is_read': isRead,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityNotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? body,
    Value<bool>? isRead,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return CommunityNotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlockedUsersTable extends BlockedUsers
    with TableInfo<$BlockedUsersTable, BlockedUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockedUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _blockerIdMeta = const VerificationMeta(
    'blockerId',
  );
  @override
  late final GeneratedColumn<String> blockerId = GeneratedColumn<String>(
    'blocker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blockedIdMeta = const VerificationMeta(
    'blockedId',
  );
  @override
  late final GeneratedColumn<String> blockedId = GeneratedColumn<String>(
    'blocked_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [blockerId, blockedId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocked_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlockedUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('blocker_id')) {
      context.handle(
        _blockerIdMeta,
        blockerId.isAcceptableOrUnknown(data['blocker_id']!, _blockerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockerIdMeta);
    }
    if (data.containsKey('blocked_id')) {
      context.handle(
        _blockedIdMeta,
        blockedId.isAcceptableOrUnknown(data['blocked_id']!, _blockedIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blockedIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {blockerId, blockedId};
  @override
  BlockedUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockedUser(
      blockerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blocker_id'],
      )!,
      blockedId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blocked_id'],
      )!,
    );
  }

  @override
  $BlockedUsersTable createAlias(String alias) {
    return $BlockedUsersTable(attachedDatabase, alias);
  }
}

class BlockedUser extends DataClass implements Insertable<BlockedUser> {
  final String blockerId;
  final String blockedId;
  const BlockedUser({required this.blockerId, required this.blockedId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['blocker_id'] = Variable<String>(blockerId);
    map['blocked_id'] = Variable<String>(blockedId);
    return map;
  }

  BlockedUsersCompanion toCompanion(bool nullToAbsent) {
    return BlockedUsersCompanion(
      blockerId: Value(blockerId),
      blockedId: Value(blockedId),
    );
  }

  factory BlockedUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockedUser(
      blockerId: serializer.fromJson<String>(json['blockerId']),
      blockedId: serializer.fromJson<String>(json['blockedId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'blockerId': serializer.toJson<String>(blockerId),
      'blockedId': serializer.toJson<String>(blockedId),
    };
  }

  BlockedUser copyWith({String? blockerId, String? blockedId}) => BlockedUser(
    blockerId: blockerId ?? this.blockerId,
    blockedId: blockedId ?? this.blockedId,
  );
  BlockedUser copyWithCompanion(BlockedUsersCompanion data) {
    return BlockedUser(
      blockerId: data.blockerId.present ? data.blockerId.value : this.blockerId,
      blockedId: data.blockedId.present ? data.blockedId.value : this.blockedId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockedUser(')
          ..write('blockerId: $blockerId, ')
          ..write('blockedId: $blockedId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(blockerId, blockedId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockedUser &&
          other.blockerId == this.blockerId &&
          other.blockedId == this.blockedId);
}

class BlockedUsersCompanion extends UpdateCompanion<BlockedUser> {
  final Value<String> blockerId;
  final Value<String> blockedId;
  final Value<int> rowid;
  const BlockedUsersCompanion({
    this.blockerId = const Value.absent(),
    this.blockedId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlockedUsersCompanion.insert({
    required String blockerId,
    required String blockedId,
    this.rowid = const Value.absent(),
  }) : blockerId = Value(blockerId),
       blockedId = Value(blockedId);
  static Insertable<BlockedUser> custom({
    Expression<String>? blockerId,
    Expression<String>? blockedId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (blockerId != null) 'blocker_id': blockerId,
      if (blockedId != null) 'blocked_id': blockedId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlockedUsersCompanion copyWith({
    Value<String>? blockerId,
    Value<String>? blockedId,
    Value<int>? rowid,
  }) {
    return BlockedUsersCompanion(
      blockerId: blockerId ?? this.blockerId,
      blockedId: blockedId ?? this.blockedId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (blockerId.present) {
      map['blocker_id'] = Variable<String>(blockerId.value);
    }
    if (blockedId.present) {
      map['blocked_id'] = Variable<String>(blockedId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockedUsersCompanion(')
          ..write('blockerId: $blockerId, ')
          ..write('blockedId: $blockedId, ')
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
  late final $RoutePointsTable routePoints = $RoutePointsTable(this);
  late final $FoodCatalogTable foodCatalog = $FoodCatalogTable(this);
  late final $MealLogsTable mealLogs = $MealLogsTable(this);
  late final $UserMetabolicProfilesTable userMetabolicProfiles =
      $UserMetabolicProfilesTable(this);
  late final $CommunityProfilesTable communityProfiles =
      $CommunityProfilesTable(this);
  late final $CommunityPostsTable communityPosts = $CommunityPostsTable(this);
  late final $CommunityPostLikesTable communityPostLikes =
      $CommunityPostLikesTable(this);
  late final $CommunityCommentsTable communityComments =
      $CommunityCommentsTable(this);
  late final $CommunityGroupsTable communityGroups = $CommunityGroupsTable(
    this,
  );
  late final $CommunityChallengesTable communityChallenges =
      $CommunityChallengesTable(this);
  late final $CommunityNotificationsTable communityNotifications =
      $CommunityNotificationsTable(this);
  late final $BlockedUsersTable blockedUsers = $BlockedUsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailySummaries,
    workouts,
    routePoints,
    foodCatalog,
    mealLogs,
    userMetabolicProfiles,
    communityProfiles,
    communityPosts,
    communityPostLikes,
    communityComments,
    communityGroups,
    communityChallenges,
    communityNotifications,
    blockedUsers,
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
typedef $$RoutePointsTableCreateCompanionBuilder =
    RoutePointsCompanion Function({
      Value<int> id,
      required String workoutId,
      required double lat,
      required double lng,
      Value<double> altitudeM,
      Value<double> accuracyM,
      Value<double> speedMps,
      required int timestampEpochMs,
    });
typedef $$RoutePointsTableUpdateCompanionBuilder =
    RoutePointsCompanion Function({
      Value<int> id,
      Value<String> workoutId,
      Value<double> lat,
      Value<double> lng,
      Value<double> altitudeM,
      Value<double> accuracyM,
      Value<double> speedMps,
      Value<int> timestampEpochMs,
    });

class $$RoutePointsTableFilterComposer
    extends Composer<_$AppDatabase, $RoutePointsTable> {
  $$RoutePointsTableFilterComposer({
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

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampEpochMs => $composableBuilder(
    column: $table.timestampEpochMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutePointsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutePointsTable> {
  $$RoutePointsTableOrderingComposer({
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

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampEpochMs => $composableBuilder(
    column: $table.timestampEpochMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutePointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutePointsTable> {
  $$RoutePointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<double> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  GeneratedColumn<double> get speedMps =>
      $composableBuilder(column: $table.speedMps, builder: (column) => column);

  GeneratedColumn<int> get timestampEpochMs => $composableBuilder(
    column: $table.timestampEpochMs,
    builder: (column) => column,
  );
}

class $$RoutePointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutePointsTable,
          RoutePoint,
          $$RoutePointsTableFilterComposer,
          $$RoutePointsTableOrderingComposer,
          $$RoutePointsTableAnnotationComposer,
          $$RoutePointsTableCreateCompanionBuilder,
          $$RoutePointsTableUpdateCompanionBuilder,
          (
            RoutePoint,
            BaseReferences<_$AppDatabase, $RoutePointsTable, RoutePoint>,
          ),
          RoutePoint,
          PrefetchHooks Function()
        > {
  $$RoutePointsTableTableManager(_$AppDatabase db, $RoutePointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutePointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutePointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutePointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<double> altitudeM = const Value.absent(),
                Value<double> accuracyM = const Value.absent(),
                Value<double> speedMps = const Value.absent(),
                Value<int> timestampEpochMs = const Value.absent(),
              }) => RoutePointsCompanion(
                id: id,
                workoutId: workoutId,
                lat: lat,
                lng: lng,
                altitudeM: altitudeM,
                accuracyM: accuracyM,
                speedMps: speedMps,
                timestampEpochMs: timestampEpochMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String workoutId,
                required double lat,
                required double lng,
                Value<double> altitudeM = const Value.absent(),
                Value<double> accuracyM = const Value.absent(),
                Value<double> speedMps = const Value.absent(),
                required int timestampEpochMs,
              }) => RoutePointsCompanion.insert(
                id: id,
                workoutId: workoutId,
                lat: lat,
                lng: lng,
                altitudeM: altitudeM,
                accuracyM: accuracyM,
                speedMps: speedMps,
                timestampEpochMs: timestampEpochMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutePointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutePointsTable,
      RoutePoint,
      $$RoutePointsTableFilterComposer,
      $$RoutePointsTableOrderingComposer,
      $$RoutePointsTableAnnotationComposer,
      $$RoutePointsTableCreateCompanionBuilder,
      $$RoutePointsTableUpdateCompanionBuilder,
      (
        RoutePoint,
        BaseReferences<_$AppDatabase, $RoutePointsTable, RoutePoint>,
      ),
      RoutePoint,
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
typedef $$CommunityProfilesTableCreateCompanionBuilder =
    CommunityProfilesCompanion Function({
      required String id,
      required String username,
      required String displayName,
      Value<double> dailyGoalKm,
      Value<double> todayDistanceKm,
      Value<bool> isPrivate,
      Value<bool> isFollowing,
      Value<int> rowid,
    });
typedef $$CommunityProfilesTableUpdateCompanionBuilder =
    CommunityProfilesCompanion Function({
      Value<String> id,
      Value<String> username,
      Value<String> displayName,
      Value<double> dailyGoalKm,
      Value<double> todayDistanceKm,
      Value<bool> isPrivate,
      Value<bool> isFollowing,
      Value<int> rowid,
    });

class $$CommunityProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityProfilesTable> {
  $$CommunityProfilesTableFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyGoalKm => $composableBuilder(
    column: $table.dailyGoalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get todayDistanceKm => $composableBuilder(
    column: $table.todayDistanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFollowing => $composableBuilder(
    column: $table.isFollowing,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityProfilesTable> {
  $$CommunityProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyGoalKm => $composableBuilder(
    column: $table.dailyGoalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get todayDistanceKm => $composableBuilder(
    column: $table.todayDistanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFollowing => $composableBuilder(
    column: $table.isFollowing,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityProfilesTable> {
  $$CommunityProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyGoalKm => $composableBuilder(
    column: $table.dailyGoalKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get todayDistanceKm => $composableBuilder(
    column: $table.todayDistanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<bool> get isFollowing => $composableBuilder(
    column: $table.isFollowing,
    builder: (column) => column,
  );
}

class $$CommunityProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityProfilesTable,
          CommunityProfile,
          $$CommunityProfilesTableFilterComposer,
          $$CommunityProfilesTableOrderingComposer,
          $$CommunityProfilesTableAnnotationComposer,
          $$CommunityProfilesTableCreateCompanionBuilder,
          $$CommunityProfilesTableUpdateCompanionBuilder,
          (
            CommunityProfile,
            BaseReferences<
              _$AppDatabase,
              $CommunityProfilesTable,
              CommunityProfile
            >,
          ),
          CommunityProfile,
          PrefetchHooks Function()
        > {
  $$CommunityProfilesTableTableManager(
    _$AppDatabase db,
    $CommunityProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<double> dailyGoalKm = const Value.absent(),
                Value<double> todayDistanceKm = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<bool> isFollowing = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityProfilesCompanion(
                id: id,
                username: username,
                displayName: displayName,
                dailyGoalKm: dailyGoalKm,
                todayDistanceKm: todayDistanceKm,
                isPrivate: isPrivate,
                isFollowing: isFollowing,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String username,
                required String displayName,
                Value<double> dailyGoalKm = const Value.absent(),
                Value<double> todayDistanceKm = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<bool> isFollowing = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityProfilesCompanion.insert(
                id: id,
                username: username,
                displayName: displayName,
                dailyGoalKm: dailyGoalKm,
                todayDistanceKm: todayDistanceKm,
                isPrivate: isPrivate,
                isFollowing: isFollowing,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityProfilesTable,
      CommunityProfile,
      $$CommunityProfilesTableFilterComposer,
      $$CommunityProfilesTableOrderingComposer,
      $$CommunityProfilesTableAnnotationComposer,
      $$CommunityProfilesTableCreateCompanionBuilder,
      $$CommunityProfilesTableUpdateCompanionBuilder,
      (
        CommunityProfile,
        BaseReferences<
          _$AppDatabase,
          $CommunityProfilesTable,
          CommunityProfile
        >,
      ),
      CommunityProfile,
      PrefetchHooks Function()
    >;
typedef $$CommunityPostsTableCreateCompanionBuilder =
    CommunityPostsCompanion Function({
      required String id,
      required String userId,
      required String authorName,
      required String title,
      required double distanceKm,
      required int durationSec,
      required String paceLabel,
      Value<String?> polylineJson,
      Value<String?> workoutBadge,
      Value<String> visibility,
      required int createdAtMs,
      Value<int> rowid,
    });
typedef $$CommunityPostsTableUpdateCompanionBuilder =
    CommunityPostsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> authorName,
      Value<String> title,
      Value<double> distanceKm,
      Value<int> durationSec,
      Value<String> paceLabel,
      Value<String?> polylineJson,
      Value<String?> workoutBadge,
      Value<String> visibility,
      Value<int> createdAtMs,
      Value<int> rowid,
    });

class $$CommunityPostsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityPostsTable> {
  $$CommunityPostsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paceLabel => $composableBuilder(
    column: $table.paceLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutBadge => $composableBuilder(
    column: $table.workoutBadge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityPostsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityPostsTable> {
  $$CommunityPostsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paceLabel => $composableBuilder(
    column: $table.paceLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutBadge => $composableBuilder(
    column: $table.workoutBadge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityPostsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityPostsTable> {
  $$CommunityPostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paceLabel =>
      $composableBuilder(column: $table.paceLabel, builder: (column) => column);

  GeneratedColumn<String> get polylineJson => $composableBuilder(
    column: $table.polylineJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workoutBadge => $composableBuilder(
    column: $table.workoutBadge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );
}

class $$CommunityPostsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityPostsTable,
          CommunityPost,
          $$CommunityPostsTableFilterComposer,
          $$CommunityPostsTableOrderingComposer,
          $$CommunityPostsTableAnnotationComposer,
          $$CommunityPostsTableCreateCompanionBuilder,
          $$CommunityPostsTableUpdateCompanionBuilder,
          (
            CommunityPost,
            BaseReferences<_$AppDatabase, $CommunityPostsTable, CommunityPost>,
          ),
          CommunityPost,
          PrefetchHooks Function()
        > {
  $$CommunityPostsTableTableManager(
    _$AppDatabase db,
    $CommunityPostsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityPostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityPostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityPostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> distanceKm = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<String> paceLabel = const Value.absent(),
                Value<String?> polylineJson = const Value.absent(),
                Value<String?> workoutBadge = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityPostsCompanion(
                id: id,
                userId: userId,
                authorName: authorName,
                title: title,
                distanceKm: distanceKm,
                durationSec: durationSec,
                paceLabel: paceLabel,
                polylineJson: polylineJson,
                workoutBadge: workoutBadge,
                visibility: visibility,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String authorName,
                required String title,
                required double distanceKm,
                required int durationSec,
                required String paceLabel,
                Value<String?> polylineJson = const Value.absent(),
                Value<String?> workoutBadge = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => CommunityPostsCompanion.insert(
                id: id,
                userId: userId,
                authorName: authorName,
                title: title,
                distanceKm: distanceKm,
                durationSec: durationSec,
                paceLabel: paceLabel,
                polylineJson: polylineJson,
                workoutBadge: workoutBadge,
                visibility: visibility,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityPostsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityPostsTable,
      CommunityPost,
      $$CommunityPostsTableFilterComposer,
      $$CommunityPostsTableOrderingComposer,
      $$CommunityPostsTableAnnotationComposer,
      $$CommunityPostsTableCreateCompanionBuilder,
      $$CommunityPostsTableUpdateCompanionBuilder,
      (
        CommunityPost,
        BaseReferences<_$AppDatabase, $CommunityPostsTable, CommunityPost>,
      ),
      CommunityPost,
      PrefetchHooks Function()
    >;
typedef $$CommunityPostLikesTableCreateCompanionBuilder =
    CommunityPostLikesCompanion Function({
      required String postId,
      required String userId,
      Value<int> rowid,
    });
typedef $$CommunityPostLikesTableUpdateCompanionBuilder =
    CommunityPostLikesCompanion Function({
      Value<String> postId,
      Value<String> userId,
      Value<int> rowid,
    });

class $$CommunityPostLikesTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityPostLikesTable> {
  $$CommunityPostLikesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get postId => $composableBuilder(
    column: $table.postId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityPostLikesTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityPostLikesTable> {
  $$CommunityPostLikesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get postId => $composableBuilder(
    column: $table.postId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityPostLikesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityPostLikesTable> {
  $$CommunityPostLikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get postId =>
      $composableBuilder(column: $table.postId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$CommunityPostLikesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityPostLikesTable,
          CommunityPostLike,
          $$CommunityPostLikesTableFilterComposer,
          $$CommunityPostLikesTableOrderingComposer,
          $$CommunityPostLikesTableAnnotationComposer,
          $$CommunityPostLikesTableCreateCompanionBuilder,
          $$CommunityPostLikesTableUpdateCompanionBuilder,
          (
            CommunityPostLike,
            BaseReferences<
              _$AppDatabase,
              $CommunityPostLikesTable,
              CommunityPostLike
            >,
          ),
          CommunityPostLike,
          PrefetchHooks Function()
        > {
  $$CommunityPostLikesTableTableManager(
    _$AppDatabase db,
    $CommunityPostLikesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityPostLikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityPostLikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityPostLikesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> postId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityPostLikesCompanion(
                postId: postId,
                userId: userId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String postId,
                required String userId,
                Value<int> rowid = const Value.absent(),
              }) => CommunityPostLikesCompanion.insert(
                postId: postId,
                userId: userId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityPostLikesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityPostLikesTable,
      CommunityPostLike,
      $$CommunityPostLikesTableFilterComposer,
      $$CommunityPostLikesTableOrderingComposer,
      $$CommunityPostLikesTableAnnotationComposer,
      $$CommunityPostLikesTableCreateCompanionBuilder,
      $$CommunityPostLikesTableUpdateCompanionBuilder,
      (
        CommunityPostLike,
        BaseReferences<
          _$AppDatabase,
          $CommunityPostLikesTable,
          CommunityPostLike
        >,
      ),
      CommunityPostLike,
      PrefetchHooks Function()
    >;
typedef $$CommunityCommentsTableCreateCompanionBuilder =
    CommunityCommentsCompanion Function({
      required String id,
      required String postId,
      required String userId,
      required String authorName,
      required String body,
      required int createdAtMs,
      Value<int> rowid,
    });
typedef $$CommunityCommentsTableUpdateCompanionBuilder =
    CommunityCommentsCompanion Function({
      Value<String> id,
      Value<String> postId,
      Value<String> userId,
      Value<String> authorName,
      Value<String> body,
      Value<int> createdAtMs,
      Value<int> rowid,
    });

class $$CommunityCommentsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityCommentsTable> {
  $$CommunityCommentsTableFilterComposer({
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

  ColumnFilters<String> get postId => $composableBuilder(
    column: $table.postId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityCommentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityCommentsTable> {
  $$CommunityCommentsTableOrderingComposer({
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

  ColumnOrderings<String> get postId => $composableBuilder(
    column: $table.postId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityCommentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityCommentsTable> {
  $$CommunityCommentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get postId =>
      $composableBuilder(column: $table.postId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );
}

class $$CommunityCommentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityCommentsTable,
          CommunityComment,
          $$CommunityCommentsTableFilterComposer,
          $$CommunityCommentsTableOrderingComposer,
          $$CommunityCommentsTableAnnotationComposer,
          $$CommunityCommentsTableCreateCompanionBuilder,
          $$CommunityCommentsTableUpdateCompanionBuilder,
          (
            CommunityComment,
            BaseReferences<
              _$AppDatabase,
              $CommunityCommentsTable,
              CommunityComment
            >,
          ),
          CommunityComment,
          PrefetchHooks Function()
        > {
  $$CommunityCommentsTableTableManager(
    _$AppDatabase db,
    $CommunityCommentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityCommentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityCommentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityCommentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> postId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityCommentsCompanion(
                id: id,
                postId: postId,
                userId: userId,
                authorName: authorName,
                body: body,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String postId,
                required String userId,
                required String authorName,
                required String body,
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => CommunityCommentsCompanion.insert(
                id: id,
                postId: postId,
                userId: userId,
                authorName: authorName,
                body: body,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityCommentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityCommentsTable,
      CommunityComment,
      $$CommunityCommentsTableFilterComposer,
      $$CommunityCommentsTableOrderingComposer,
      $$CommunityCommentsTableAnnotationComposer,
      $$CommunityCommentsTableCreateCompanionBuilder,
      $$CommunityCommentsTableUpdateCompanionBuilder,
      (
        CommunityComment,
        BaseReferences<
          _$AppDatabase,
          $CommunityCommentsTable,
          CommunityComment
        >,
      ),
      CommunityComment,
      PrefetchHooks Function()
    >;
typedef $$CommunityGroupsTableCreateCompanionBuilder =
    CommunityGroupsCompanion Function({
      required String id,
      required String name,
      Value<String> description,
      Value<bool> isPrivate,
      required String ownerId,
      Value<int> memberCount,
      Value<bool> isJoined,
      Value<int> rowid,
    });
typedef $$CommunityGroupsTableUpdateCompanionBuilder =
    CommunityGroupsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<bool> isPrivate,
      Value<String> ownerId,
      Value<int> memberCount,
      Value<bool> isJoined,
      Value<int> rowid,
    });

class $$CommunityGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isJoined =>
      $composableBuilder(column: $table.isJoined, builder: (column) => column);
}

class $$CommunityGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityGroupsTable,
          CommunityGroup,
          $$CommunityGroupsTableFilterComposer,
          $$CommunityGroupsTableOrderingComposer,
          $$CommunityGroupsTableAnnotationComposer,
          $$CommunityGroupsTableCreateCompanionBuilder,
          $$CommunityGroupsTableUpdateCompanionBuilder,
          (
            CommunityGroup,
            BaseReferences<
              _$AppDatabase,
              $CommunityGroupsTable,
              CommunityGroup
            >,
          ),
          CommunityGroup,
          PrefetchHooks Function()
        > {
  $$CommunityGroupsTableTableManager(
    _$AppDatabase db,
    $CommunityGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int> memberCount = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityGroupsCompanion(
                id: id,
                name: name,
                description: description,
                isPrivate: isPrivate,
                ownerId: ownerId,
                memberCount: memberCount,
                isJoined: isJoined,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> description = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                required String ownerId,
                Value<int> memberCount = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityGroupsCompanion.insert(
                id: id,
                name: name,
                description: description,
                isPrivate: isPrivate,
                ownerId: ownerId,
                memberCount: memberCount,
                isJoined: isJoined,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityGroupsTable,
      CommunityGroup,
      $$CommunityGroupsTableFilterComposer,
      $$CommunityGroupsTableOrderingComposer,
      $$CommunityGroupsTableAnnotationComposer,
      $$CommunityGroupsTableCreateCompanionBuilder,
      $$CommunityGroupsTableUpdateCompanionBuilder,
      (
        CommunityGroup,
        BaseReferences<_$AppDatabase, $CommunityGroupsTable, CommunityGroup>,
      ),
      CommunityGroup,
      PrefetchHooks Function()
    >;
typedef $$CommunityChallengesTableCreateCompanionBuilder =
    CommunityChallengesCompanion Function({
      required String id,
      required String title,
      required double targetKm,
      required int durationDays,
      required String challengeType,
      Value<int> participantCount,
      Value<bool> isJoined,
      Value<int> rowid,
    });
typedef $$CommunityChallengesTableUpdateCompanionBuilder =
    CommunityChallengesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<double> targetKm,
      Value<int> durationDays,
      Value<String> challengeType,
      Value<int> participantCount,
      Value<bool> isJoined,
      Value<int> rowid,
    });

class $$CommunityChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityChallengesTable> {
  $$CommunityChallengesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetKm => $composableBuilder(
    column: $table.targetKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challengeType => $composableBuilder(
    column: $table.challengeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get participantCount => $composableBuilder(
    column: $table.participantCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityChallengesTable> {
  $$CommunityChallengesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetKm => $composableBuilder(
    column: $table.targetKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challengeType => $composableBuilder(
    column: $table.challengeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get participantCount => $composableBuilder(
    column: $table.participantCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isJoined => $composableBuilder(
    column: $table.isJoined,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityChallengesTable> {
  $$CommunityChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get targetKm =>
      $composableBuilder(column: $table.targetKm, builder: (column) => column);

  GeneratedColumn<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get challengeType => $composableBuilder(
    column: $table.challengeType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get participantCount => $composableBuilder(
    column: $table.participantCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isJoined =>
      $composableBuilder(column: $table.isJoined, builder: (column) => column);
}

class $$CommunityChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityChallengesTable,
          CommunityChallenge,
          $$CommunityChallengesTableFilterComposer,
          $$CommunityChallengesTableOrderingComposer,
          $$CommunityChallengesTableAnnotationComposer,
          $$CommunityChallengesTableCreateCompanionBuilder,
          $$CommunityChallengesTableUpdateCompanionBuilder,
          (
            CommunityChallenge,
            BaseReferences<
              _$AppDatabase,
              $CommunityChallengesTable,
              CommunityChallenge
            >,
          ),
          CommunityChallenge,
          PrefetchHooks Function()
        > {
  $$CommunityChallengesTableTableManager(
    _$AppDatabase db,
    $CommunityChallengesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityChallengesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CommunityChallengesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> targetKm = const Value.absent(),
                Value<int> durationDays = const Value.absent(),
                Value<String> challengeType = const Value.absent(),
                Value<int> participantCount = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityChallengesCompanion(
                id: id,
                title: title,
                targetKm: targetKm,
                durationDays: durationDays,
                challengeType: challengeType,
                participantCount: participantCount,
                isJoined: isJoined,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required double targetKm,
                required int durationDays,
                required String challengeType,
                Value<int> participantCount = const Value.absent(),
                Value<bool> isJoined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityChallengesCompanion.insert(
                id: id,
                title: title,
                targetKm: targetKm,
                durationDays: durationDays,
                challengeType: challengeType,
                participantCount: participantCount,
                isJoined: isJoined,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityChallengesTable,
      CommunityChallenge,
      $$CommunityChallengesTableFilterComposer,
      $$CommunityChallengesTableOrderingComposer,
      $$CommunityChallengesTableAnnotationComposer,
      $$CommunityChallengesTableCreateCompanionBuilder,
      $$CommunityChallengesTableUpdateCompanionBuilder,
      (
        CommunityChallenge,
        BaseReferences<
          _$AppDatabase,
          $CommunityChallengesTable,
          CommunityChallenge
        >,
      ),
      CommunityChallenge,
      PrefetchHooks Function()
    >;
typedef $$CommunityNotificationsTableCreateCompanionBuilder =
    CommunityNotificationsCompanion Function({
      required String id,
      required String title,
      required String body,
      Value<bool> isRead,
      required int createdAtMs,
      Value<int> rowid,
    });
typedef $$CommunityNotificationsTableUpdateCompanionBuilder =
    CommunityNotificationsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> body,
      Value<bool> isRead,
      Value<int> createdAtMs,
      Value<int> rowid,
    });

class $$CommunityNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityNotificationsTable> {
  $$CommunityNotificationsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommunityNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityNotificationsTable> {
  $$CommunityNotificationsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommunityNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityNotificationsTable> {
  $$CommunityNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );
}

class $$CommunityNotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunityNotificationsTable,
          CommunityNotification,
          $$CommunityNotificationsTableFilterComposer,
          $$CommunityNotificationsTableOrderingComposer,
          $$CommunityNotificationsTableAnnotationComposer,
          $$CommunityNotificationsTableCreateCompanionBuilder,
          $$CommunityNotificationsTableUpdateCompanionBuilder,
          (
            CommunityNotification,
            BaseReferences<
              _$AppDatabase,
              $CommunityNotificationsTable,
              CommunityNotification
            >,
          ),
          CommunityNotification,
          PrefetchHooks Function()
        > {
  $$CommunityNotificationsTableTableManager(
    _$AppDatabase db,
    $CommunityNotificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityNotificationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CommunityNotificationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CommunityNotificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunityNotificationsCompanion(
                id: id,
                title: title,
                body: body,
                isRead: isRead,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String body,
                Value<bool> isRead = const Value.absent(),
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => CommunityNotificationsCompanion.insert(
                id: id,
                title: title,
                body: body,
                isRead: isRead,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommunityNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunityNotificationsTable,
      CommunityNotification,
      $$CommunityNotificationsTableFilterComposer,
      $$CommunityNotificationsTableOrderingComposer,
      $$CommunityNotificationsTableAnnotationComposer,
      $$CommunityNotificationsTableCreateCompanionBuilder,
      $$CommunityNotificationsTableUpdateCompanionBuilder,
      (
        CommunityNotification,
        BaseReferences<
          _$AppDatabase,
          $CommunityNotificationsTable,
          CommunityNotification
        >,
      ),
      CommunityNotification,
      PrefetchHooks Function()
    >;
typedef $$BlockedUsersTableCreateCompanionBuilder =
    BlockedUsersCompanion Function({
      required String blockerId,
      required String blockedId,
      Value<int> rowid,
    });
typedef $$BlockedUsersTableUpdateCompanionBuilder =
    BlockedUsersCompanion Function({
      Value<String> blockerId,
      Value<String> blockedId,
      Value<int> rowid,
    });

class $$BlockedUsersTableFilterComposer
    extends Composer<_$AppDatabase, $BlockedUsersTable> {
  $$BlockedUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get blockerId => $composableBuilder(
    column: $table.blockerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockedId => $composableBuilder(
    column: $table.blockedId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BlockedUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockedUsersTable> {
  $$BlockedUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get blockerId => $composableBuilder(
    column: $table.blockerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockedId => $composableBuilder(
    column: $table.blockedId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BlockedUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockedUsersTable> {
  $$BlockedUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get blockerId =>
      $composableBuilder(column: $table.blockerId, builder: (column) => column);

  GeneratedColumn<String> get blockedId =>
      $composableBuilder(column: $table.blockedId, builder: (column) => column);
}

class $$BlockedUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlockedUsersTable,
          BlockedUser,
          $$BlockedUsersTableFilterComposer,
          $$BlockedUsersTableOrderingComposer,
          $$BlockedUsersTableAnnotationComposer,
          $$BlockedUsersTableCreateCompanionBuilder,
          $$BlockedUsersTableUpdateCompanionBuilder,
          (
            BlockedUser,
            BaseReferences<_$AppDatabase, $BlockedUsersTable, BlockedUser>,
          ),
          BlockedUser,
          PrefetchHooks Function()
        > {
  $$BlockedUsersTableTableManager(_$AppDatabase db, $BlockedUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockedUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockedUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockedUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> blockerId = const Value.absent(),
                Value<String> blockedId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlockedUsersCompanion(
                blockerId: blockerId,
                blockedId: blockedId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String blockerId,
                required String blockedId,
                Value<int> rowid = const Value.absent(),
              }) => BlockedUsersCompanion.insert(
                blockerId: blockerId,
                blockedId: blockedId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BlockedUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlockedUsersTable,
      BlockedUser,
      $$BlockedUsersTableFilterComposer,
      $$BlockedUsersTableOrderingComposer,
      $$BlockedUsersTableAnnotationComposer,
      $$BlockedUsersTableCreateCompanionBuilder,
      $$BlockedUsersTableUpdateCompanionBuilder,
      (
        BlockedUser,
        BaseReferences<_$AppDatabase, $BlockedUsersTable, BlockedUser>,
      ),
      BlockedUser,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailySummariesTableTableManager get dailySummaries =>
      $$DailySummariesTableTableManager(_db, _db.dailySummaries);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$RoutePointsTableTableManager get routePoints =>
      $$RoutePointsTableTableManager(_db, _db.routePoints);
  $$FoodCatalogTableTableManager get foodCatalog =>
      $$FoodCatalogTableTableManager(_db, _db.foodCatalog);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db, _db.mealLogs);
  $$UserMetabolicProfilesTableTableManager get userMetabolicProfiles =>
      $$UserMetabolicProfilesTableTableManager(_db, _db.userMetabolicProfiles);
  $$CommunityProfilesTableTableManager get communityProfiles =>
      $$CommunityProfilesTableTableManager(_db, _db.communityProfiles);
  $$CommunityPostsTableTableManager get communityPosts =>
      $$CommunityPostsTableTableManager(_db, _db.communityPosts);
  $$CommunityPostLikesTableTableManager get communityPostLikes =>
      $$CommunityPostLikesTableTableManager(_db, _db.communityPostLikes);
  $$CommunityCommentsTableTableManager get communityComments =>
      $$CommunityCommentsTableTableManager(_db, _db.communityComments);
  $$CommunityGroupsTableTableManager get communityGroups =>
      $$CommunityGroupsTableTableManager(_db, _db.communityGroups);
  $$CommunityChallengesTableTableManager get communityChallenges =>
      $$CommunityChallengesTableTableManager(_db, _db.communityChallenges);
  $$CommunityNotificationsTableTableManager get communityNotifications =>
      $$CommunityNotificationsTableTableManager(
        _db,
        _db.communityNotifications,
      );
  $$BlockedUsersTableTableManager get blockedUsers =>
      $$BlockedUsersTableTableManager(_db, _db.blockedUsers);
}
