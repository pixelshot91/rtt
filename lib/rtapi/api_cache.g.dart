// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FindScheduleParam _$_$_FindScheduleParamFromJson(Map<String, dynamic> json) {
  return _$_FindScheduleParam(
    Transport.fromJson(json['transport'] as Map<String, dynamic>),
    Station.fromJson(json['station'] as Map<String, dynamic>),
    _$enumDecode(_$DirectionEnumMap, json['direction']),
  );
}

Map<String, dynamic> _$_$_FindScheduleParamToJson(
        _$_FindScheduleParam instance) =>
    <String, dynamic>{
      'transport': instance.transport,
      'station': instance.station,
      'direction': _$DirectionEnumMap[instance.direction],
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

const _$DirectionEnumMap = {
  Direction.A: 'A',
  Direction.B: 'B',
};

_$_CachedSchedules _$_$_CachedSchedulesFromJson(Map<String, dynamic> json) {
  return _$_CachedSchedules(
    DateTime.parse(json['lastUpdateAt'] as String),
    (json['schedules'] as List<dynamic>)
        .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_CachedSchedulesToJson(_$_CachedSchedules instance) =>
    <String, dynamic>{
      'lastUpdateAt': instance.lastUpdateAt.toIso8601String(),
      'schedules': instance.schedules,
    };
