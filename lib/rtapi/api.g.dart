// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transport _$_$_TransportFromJson(Map<String, dynamic> json) {
  return _$_Transport(
    _$enumDecode(_$TransportKindEnumMap, json['kind']),
    json['line'] as String,
  );
}

Map<String, dynamic> _$_$_TransportToJson(_$_Transport instance) =>
    <String, dynamic>{
      'kind': _$TransportKindEnumMap[instance.kind],
      'line': instance.line,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TransportKindEnumMap = {
  TransportKind.RER: 'RER',
  TransportKind.METRO: 'METRO',
  TransportKind.TRAM: 'TRAM',
  TransportKind.BUS: 'BUS',
  TransportKind.WALK: 'WALK',
};

_$_Station _$_$_StationFromJson(Map<String, dynamic> json) {
  return _$_Station(
    json['name'] as String,
  );
}

Map<String, dynamic> _$_$_StationToJson(_$_Station instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$_Schedule _$_$_ScheduleFromJson(Map<String, dynamic> json) {
  return _$_Schedule(
    Transport.fromJson(json['transport'] as Map<String, dynamic>),
    Station.fromJson(json['station'] as Map<String, dynamic>),
    _$enumDecode(_$DirectionEnumMap, json['direction']),
    DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$_$_ScheduleToJson(_$_Schedule instance) =>
    <String, dynamic>{
      'transport': instance.transport,
      'station': instance.station,
      'direction': _$DirectionEnumMap[instance.direction],
      'time': instance.time.toIso8601String(),
    };

const _$DirectionEnumMap = {
  Direction.A: 'A',
  Direction.B: 'B',
};

_$RERSchedule _$_$RERScheduleFromJson(Map<String, dynamic> json) {
  return _$RERSchedule(
    Transport.fromJson(json['transport'] as Map<String, dynamic>),
    Station.fromJson(json['station'] as Map<String, dynamic>),
    _$enumDecode(_$DirectionEnumMap, json['direction']),
    DateTime.parse(json['time'] as String),
    json['mission'] as String,
  );
}

Map<String, dynamic> _$_$RERScheduleToJson(_$RERSchedule instance) =>
    <String, dynamic>{
      'transport': instance.transport,
      'station': instance.station,
      'direction': _$DirectionEnumMap[instance.direction],
      'time': instance.time.toIso8601String(),
      'mission': instance.mission,
    };

_$BUSSchedule _$_$BUSScheduleFromJson(Map<String, dynamic> json) {
  return _$BUSSchedule(
    Transport.fromJson(json['transport'] as Map<String, dynamic>),
    Station.fromJson(json['station'] as Map<String, dynamic>),
    _$enumDecode(_$DirectionEnumMap, json['direction']),
    DateTime.parse(json['time'] as String),
    Station.fromJson(json['terminus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$BUSScheduleToJson(_$BUSSchedule instance) =>
    <String, dynamic>{
      'transport': instance.transport,
      'station': instance.station,
      'direction': _$DirectionEnumMap[instance.direction],
      'time': instance.time.toIso8601String(),
      'terminus': instance.terminus,
    };
