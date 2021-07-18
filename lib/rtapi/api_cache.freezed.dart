// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'api_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FindScheduleParam _$FindScheduleParamFromJson(Map<String, dynamic> json) {
  return _FindScheduleParam.fromJson(json);
}

/// @nodoc
class _$FindScheduleParamTearOff {
  const _$FindScheduleParamTearOff();

  _FindScheduleParam call(
      Transport transport, Station station, Direction direction) {
    return _FindScheduleParam(
      transport,
      station,
      direction,
    );
  }

  FindScheduleParam fromJson(Map<String, Object> json) {
    return FindScheduleParam.fromJson(json);
  }
}

/// @nodoc
const $FindScheduleParam = _$FindScheduleParamTearOff();

/// @nodoc
mixin _$FindScheduleParam {
  Transport get transport => throw _privateConstructorUsedError;
  Station get station => throw _privateConstructorUsedError;
  Direction get direction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FindScheduleParamCopyWith<FindScheduleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindScheduleParamCopyWith<$Res> {
  factory $FindScheduleParamCopyWith(
          FindScheduleParam value, $Res Function(FindScheduleParam) then) =
      _$FindScheduleParamCopyWithImpl<$Res>;
  $Res call({Transport transport, Station station, Direction direction});

  $TransportCopyWith<$Res> get transport;
  $StationCopyWith<$Res> get station;
}

/// @nodoc
class _$FindScheduleParamCopyWithImpl<$Res>
    implements $FindScheduleParamCopyWith<$Res> {
  _$FindScheduleParamCopyWithImpl(this._value, this._then);

  final FindScheduleParam _value;
  // ignore: unused_field
  final $Res Function(FindScheduleParam) _then;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
  }) {
    return _then(_value.copyWith(
      transport: transport == freezed
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as Transport,
      station: station == freezed
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as Station,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
    ));
  }

  @override
  $TransportCopyWith<$Res> get transport {
    return $TransportCopyWith<$Res>(_value.transport, (value) {
      return _then(_value.copyWith(transport: value));
    });
  }

  @override
  $StationCopyWith<$Res> get station {
    return $StationCopyWith<$Res>(_value.station, (value) {
      return _then(_value.copyWith(station: value));
    });
  }
}

/// @nodoc
abstract class _$FindScheduleParamCopyWith<$Res>
    implements $FindScheduleParamCopyWith<$Res> {
  factory _$FindScheduleParamCopyWith(
          _FindScheduleParam value, $Res Function(_FindScheduleParam) then) =
      __$FindScheduleParamCopyWithImpl<$Res>;
  @override
  $Res call({Transport transport, Station station, Direction direction});

  @override
  $TransportCopyWith<$Res> get transport;
  @override
  $StationCopyWith<$Res> get station;
}

/// @nodoc
class __$FindScheduleParamCopyWithImpl<$Res>
    extends _$FindScheduleParamCopyWithImpl<$Res>
    implements _$FindScheduleParamCopyWith<$Res> {
  __$FindScheduleParamCopyWithImpl(
      _FindScheduleParam _value, $Res Function(_FindScheduleParam) _then)
      : super(_value, (v) => _then(v as _FindScheduleParam));

  @override
  _FindScheduleParam get _value => super._value as _FindScheduleParam;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
  }) {
    return _then(_FindScheduleParam(
      transport == freezed
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as Transport,
      station == freezed
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as Station,
      direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FindScheduleParam implements _FindScheduleParam {
  _$_FindScheduleParam(this.transport, this.station, this.direction);

  factory _$_FindScheduleParam.fromJson(Map<String, dynamic> json) =>
      _$_$_FindScheduleParamFromJson(json);

  @override
  final Transport transport;
  @override
  final Station station;
  @override
  final Direction direction;

  @override
  String toString() {
    return 'FindScheduleParam(transport: $transport, station: $station, direction: $direction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FindScheduleParam &&
            (identical(other.transport, transport) ||
                const DeepCollectionEquality()
                    .equals(other.transport, transport)) &&
            (identical(other.station, station) ||
                const DeepCollectionEquality()
                    .equals(other.station, station)) &&
            (identical(other.direction, direction) ||
                const DeepCollectionEquality()
                    .equals(other.direction, direction)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transport) ^
      const DeepCollectionEquality().hash(station) ^
      const DeepCollectionEquality().hash(direction);

  @JsonKey(ignore: true)
  @override
  _$FindScheduleParamCopyWith<_FindScheduleParam> get copyWith =>
      __$FindScheduleParamCopyWithImpl<_FindScheduleParam>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FindScheduleParamToJson(this);
  }
}

abstract class _FindScheduleParam implements FindScheduleParam {
  factory _FindScheduleParam(
          Transport transport, Station station, Direction direction) =
      _$_FindScheduleParam;

  factory _FindScheduleParam.fromJson(Map<String, dynamic> json) =
      _$_FindScheduleParam.fromJson;

  @override
  Transport get transport => throw _privateConstructorUsedError;
  @override
  Station get station => throw _privateConstructorUsedError;
  @override
  Direction get direction => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FindScheduleParamCopyWith<_FindScheduleParam> get copyWith =>
      throw _privateConstructorUsedError;
}

CachedSchedules _$CachedSchedulesFromJson(Map<String, dynamic> json) {
  return _CachedSchedules.fromJson(json);
}

/// @nodoc
class _$CachedSchedulesTearOff {
  const _$CachedSchedulesTearOff();

  _CachedSchedules call(DateTime lastUpdateAt, List<Schedule> schedules) {
    return _CachedSchedules(
      lastUpdateAt,
      schedules,
    );
  }

  CachedSchedules fromJson(Map<String, Object> json) {
    return CachedSchedules.fromJson(json);
  }
}

/// @nodoc
const $CachedSchedules = _$CachedSchedulesTearOff();

/// @nodoc
mixin _$CachedSchedules {
  DateTime get lastUpdateAt => throw _privateConstructorUsedError;
  List<Schedule> get schedules => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CachedSchedulesCopyWith<CachedSchedules> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedSchedulesCopyWith<$Res> {
  factory $CachedSchedulesCopyWith(
          CachedSchedules value, $Res Function(CachedSchedules) then) =
      _$CachedSchedulesCopyWithImpl<$Res>;
  $Res call({DateTime lastUpdateAt, List<Schedule> schedules});
}

/// @nodoc
class _$CachedSchedulesCopyWithImpl<$Res>
    implements $CachedSchedulesCopyWith<$Res> {
  _$CachedSchedulesCopyWithImpl(this._value, this._then);

  final CachedSchedules _value;
  // ignore: unused_field
  final $Res Function(CachedSchedules) _then;

  @override
  $Res call({
    Object? lastUpdateAt = freezed,
    Object? schedules = freezed,
  }) {
    return _then(_value.copyWith(
      lastUpdateAt: lastUpdateAt == freezed
          ? _value.lastUpdateAt
          : lastUpdateAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      schedules: schedules == freezed
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Schedule>,
    ));
  }
}

/// @nodoc
abstract class _$CachedSchedulesCopyWith<$Res>
    implements $CachedSchedulesCopyWith<$Res> {
  factory _$CachedSchedulesCopyWith(
          _CachedSchedules value, $Res Function(_CachedSchedules) then) =
      __$CachedSchedulesCopyWithImpl<$Res>;
  @override
  $Res call({DateTime lastUpdateAt, List<Schedule> schedules});
}

/// @nodoc
class __$CachedSchedulesCopyWithImpl<$Res>
    extends _$CachedSchedulesCopyWithImpl<$Res>
    implements _$CachedSchedulesCopyWith<$Res> {
  __$CachedSchedulesCopyWithImpl(
      _CachedSchedules _value, $Res Function(_CachedSchedules) _then)
      : super(_value, (v) => _then(v as _CachedSchedules));

  @override
  _CachedSchedules get _value => super._value as _CachedSchedules;

  @override
  $Res call({
    Object? lastUpdateAt = freezed,
    Object? schedules = freezed,
  }) {
    return _then(_CachedSchedules(
      lastUpdateAt == freezed
          ? _value.lastUpdateAt
          : lastUpdateAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      schedules == freezed
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Schedule>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CachedSchedules implements _CachedSchedules {
  _$_CachedSchedules(this.lastUpdateAt, this.schedules);

  factory _$_CachedSchedules.fromJson(Map<String, dynamic> json) =>
      _$_$_CachedSchedulesFromJson(json);

  @override
  final DateTime lastUpdateAt;
  @override
  final List<Schedule> schedules;

  @override
  String toString() {
    return 'CachedSchedules(lastUpdateAt: $lastUpdateAt, schedules: $schedules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CachedSchedules &&
            (identical(other.lastUpdateAt, lastUpdateAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdateAt, lastUpdateAt)) &&
            (identical(other.schedules, schedules) ||
                const DeepCollectionEquality()
                    .equals(other.schedules, schedules)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lastUpdateAt) ^
      const DeepCollectionEquality().hash(schedules);

  @JsonKey(ignore: true)
  @override
  _$CachedSchedulesCopyWith<_CachedSchedules> get copyWith =>
      __$CachedSchedulesCopyWithImpl<_CachedSchedules>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CachedSchedulesToJson(this);
  }
}

abstract class _CachedSchedules implements CachedSchedules {
  factory _CachedSchedules(DateTime lastUpdateAt, List<Schedule> schedules) =
      _$_CachedSchedules;

  factory _CachedSchedules.fromJson(Map<String, dynamic> json) =
      _$_CachedSchedules.fromJson;

  @override
  DateTime get lastUpdateAt => throw _privateConstructorUsedError;
  @override
  List<Schedule> get schedules => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CachedSchedulesCopyWith<_CachedSchedules> get copyWith =>
      throw _privateConstructorUsedError;
}
