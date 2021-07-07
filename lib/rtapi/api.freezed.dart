// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transport _$TransportFromJson(Map<String, dynamic> json) {
  return _Transport.fromJson(json);
}

/// @nodoc
class _$TransportTearOff {
  const _$TransportTearOff();

  _Transport call(TransportKind kind, String line) {
    return _Transport(
      kind,
      line,
    );
  }

  Transport fromJson(Map<String, Object> json) {
    return Transport.fromJson(json);
  }
}

/// @nodoc
const $Transport = _$TransportTearOff();

/// @nodoc
mixin _$Transport {
  TransportKind get kind => throw _privateConstructorUsedError;
  String get line => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransportCopyWith<Transport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransportCopyWith<$Res> {
  factory $TransportCopyWith(Transport value, $Res Function(Transport) then) =
      _$TransportCopyWithImpl<$Res>;
  $Res call({TransportKind kind, String line});
}

/// @nodoc
class _$TransportCopyWithImpl<$Res> implements $TransportCopyWith<$Res> {
  _$TransportCopyWithImpl(this._value, this._then);

  final Transport _value;
  // ignore: unused_field
  final $Res Function(Transport) _then;

  @override
  $Res call({
    Object? kind = freezed,
    Object? line = freezed,
  }) {
    return _then(_value.copyWith(
      kind: kind == freezed
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TransportKind,
      line: line == freezed
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TransportCopyWith<$Res> implements $TransportCopyWith<$Res> {
  factory _$TransportCopyWith(
          _Transport value, $Res Function(_Transport) then) =
      __$TransportCopyWithImpl<$Res>;
  @override
  $Res call({TransportKind kind, String line});
}

/// @nodoc
class __$TransportCopyWithImpl<$Res> extends _$TransportCopyWithImpl<$Res>
    implements _$TransportCopyWith<$Res> {
  __$TransportCopyWithImpl(_Transport _value, $Res Function(_Transport) _then)
      : super(_value, (v) => _then(v as _Transport));

  @override
  _Transport get _value => super._value as _Transport;

  @override
  $Res call({
    Object? kind = freezed,
    Object? line = freezed,
  }) {
    return _then(_Transport(
      kind == freezed
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TransportKind,
      line == freezed
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transport extends _Transport {
  _$_Transport(this.kind, this.line) : super._();

  factory _$_Transport.fromJson(Map<String, dynamic> json) =>
      _$_$_TransportFromJson(json);

  @override
  final TransportKind kind;
  @override
  final String line;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Transport &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.line, line) ||
                const DeepCollectionEquality().equals(other.line, line)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(line);

  @JsonKey(ignore: true)
  @override
  _$TransportCopyWith<_Transport> get copyWith =>
      __$TransportCopyWithImpl<_Transport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TransportToJson(this);
  }
}

abstract class _Transport extends Transport {
  factory _Transport(TransportKind kind, String line) = _$_Transport;
  _Transport._() : super._();

  factory _Transport.fromJson(Map<String, dynamic> json) =
      _$_Transport.fromJson;

  @override
  TransportKind get kind => throw _privateConstructorUsedError;
  @override
  String get line => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransportCopyWith<_Transport> get copyWith =>
      throw _privateConstructorUsedError;
}

Station _$StationFromJson(Map<String, dynamic> json) {
  return _Station.fromJson(json);
}

/// @nodoc
class _$StationTearOff {
  const _$StationTearOff();

  _Station call(String name) {
    return _Station(
      name,
    );
  }

  Station fromJson(Map<String, Object> json) {
    return Station.fromJson(json);
  }
}

/// @nodoc
const $Station = _$StationTearOff();

/// @nodoc
mixin _$Station {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StationCopyWith<Station> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationCopyWith<$Res> {
  factory $StationCopyWith(Station value, $Res Function(Station) then) =
      _$StationCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$StationCopyWithImpl<$Res> implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._value, this._then);

  final Station _value;
  // ignore: unused_field
  final $Res Function(Station) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$StationCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$StationCopyWith(_Station value, $Res Function(_Station) then) =
      __$StationCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$StationCopyWithImpl<$Res> extends _$StationCopyWithImpl<$Res>
    implements _$StationCopyWith<$Res> {
  __$StationCopyWithImpl(_Station _value, $Res Function(_Station) _then)
      : super(_value, (v) => _then(v as _Station));

  @override
  _Station get _value => super._value as _Station;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_Station(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Station extends _Station {
  _$_Station(this.name) : super._();

  factory _$_Station.fromJson(Map<String, dynamic> json) =>
      _$_$_StationFromJson(json);

  @override
  final String name;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Station &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$StationCopyWith<_Station> get copyWith =>
      __$StationCopyWithImpl<_Station>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_StationToJson(this);
  }
}

abstract class _Station extends Station {
  factory _Station(String name) = _$_Station;
  _Station._() : super._();

  factory _Station.fromJson(Map<String, dynamic> json) = _$_Station.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StationCopyWith<_Station> get copyWith =>
      throw _privateConstructorUsedError;
}

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'default':
      return _Schedule.fromJson(json);
    case 'RER':
      return RERSchedule.fromJson(json);
    case 'BUS':
      return BUSSchedule.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$ScheduleTearOff {
  const _$ScheduleTearOff();

  _Schedule call(Transport transport, Station station, Direction direction,
      DateTime time) {
    return _Schedule(
      transport,
      station,
      direction,
      time,
    );
  }

  RERSchedule RER(Transport transport, Station station, Direction direction,
      DateTime time, String mission) {
    return RERSchedule(
      transport,
      station,
      direction,
      time,
      mission,
    );
  }

  BUSSchedule BUS(Transport transport, Station station, Direction direction,
      DateTime time, Station terminus) {
    return BUSSchedule(
      transport,
      station,
      direction,
      time,
      terminus,
    );
  }

  Schedule fromJson(Map<String, Object> json) {
    return Schedule.fromJson(json);
  }
}

/// @nodoc
const $Schedule = _$ScheduleTearOff();

/// @nodoc
mixin _$Schedule {
  Transport get transport => throw _privateConstructorUsedError;
  Station get station => throw _privateConstructorUsedError;
  Direction get direction => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)
        $default, {
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, String mission)
        RER,
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, Station terminus)
        BUS,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)?
        $default, {
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, String mission)?
        RER,
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, Station terminus)?
        BUS,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Schedule value) $default, {
    required TResult Function(RERSchedule value) RER,
    required TResult Function(BUSSchedule value) BUS,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Schedule value)? $default, {
    TResult Function(RERSchedule value)? RER,
    TResult Function(BUSSchedule value)? BUS,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res>;
  $Res call(
      {Transport transport,
      Station station,
      Direction direction,
      DateTime time});

  $TransportCopyWith<$Res> get transport;
  $StationCopyWith<$Res> get station;
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res> implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  final Schedule _value;
  // ignore: unused_field
  final $Res Function(Schedule) _then;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
    Object? time = freezed,
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
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) then) =
      __$ScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Transport transport,
      Station station,
      Direction direction,
      DateTime time});

  @override
  $TransportCopyWith<$Res> get transport;
  @override
  $StationCopyWith<$Res> get station;
}

/// @nodoc
class __$ScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(_Schedule _value, $Res Function(_Schedule) _then)
      : super(_value, (v) => _then(v as _Schedule));

  @override
  _Schedule get _value => super._value as _Schedule;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
    Object? time = freezed,
  }) {
    return _then(_Schedule(
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
      time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Schedule extends _Schedule {
  _$_Schedule(this.transport, this.station, this.direction, this.time)
      : super._();

  factory _$_Schedule.fromJson(Map<String, dynamic> json) =>
      _$_$_ScheduleFromJson(json);

  @override
  final Transport transport;
  @override
  final Station station;
  @override
  final Direction direction;
  @override
  final DateTime time;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Schedule &&
            (identical(other.transport, transport) ||
                const DeepCollectionEquality()
                    .equals(other.transport, transport)) &&
            (identical(other.station, station) ||
                const DeepCollectionEquality()
                    .equals(other.station, station)) &&
            (identical(other.direction, direction) ||
                const DeepCollectionEquality()
                    .equals(other.direction, direction)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transport) ^
      const DeepCollectionEquality().hash(station) ^
      const DeepCollectionEquality().hash(direction) ^
      const DeepCollectionEquality().hash(time);

  @JsonKey(ignore: true)
  @override
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)
        $default, {
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, String mission)
        RER,
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, Station terminus)
        BUS,
  }) {
    return $default(transport, station, direction, time);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)?
        $default, {
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, String mission)?
        RER,
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, Station terminus)?
        BUS,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(transport, station, direction, time);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Schedule value) $default, {
    required TResult Function(RERSchedule value) RER,
    required TResult Function(BUSSchedule value) BUS,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Schedule value)? $default, {
    TResult Function(RERSchedule value)? RER,
    TResult Function(BUSSchedule value)? BUS,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ScheduleToJson(this)..['runtimeType'] = 'default';
  }
}

abstract class _Schedule extends Schedule {
  factory _Schedule(Transport transport, Station station, Direction direction,
      DateTime time) = _$_Schedule;
  _Schedule._() : super._();

  factory _Schedule.fromJson(Map<String, dynamic> json) = _$_Schedule.fromJson;

  @override
  Transport get transport => throw _privateConstructorUsedError;
  @override
  Station get station => throw _privateConstructorUsedError;
  @override
  Direction get direction => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RERScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory $RERScheduleCopyWith(
          RERSchedule value, $Res Function(RERSchedule) then) =
      _$RERScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Transport transport,
      Station station,
      Direction direction,
      DateTime time,
      String mission});

  @override
  $TransportCopyWith<$Res> get transport;
  @override
  $StationCopyWith<$Res> get station;
}

/// @nodoc
class _$RERScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements $RERScheduleCopyWith<$Res> {
  _$RERScheduleCopyWithImpl(
      RERSchedule _value, $Res Function(RERSchedule) _then)
      : super(_value, (v) => _then(v as RERSchedule));

  @override
  RERSchedule get _value => super._value as RERSchedule;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
    Object? time = freezed,
    Object? mission = freezed,
  }) {
    return _then(RERSchedule(
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
      time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mission == freezed
          ? _value.mission
          : mission // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RERSchedule extends RERSchedule {
  _$RERSchedule(
      this.transport, this.station, this.direction, this.time, this.mission)
      : super._();

  factory _$RERSchedule.fromJson(Map<String, dynamic> json) =>
      _$_$RERScheduleFromJson(json);

  @override
  final Transport transport;
  @override
  final Station station;
  @override
  final Direction direction;
  @override
  final DateTime time;
  @override
  final String mission;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RERSchedule &&
            (identical(other.transport, transport) ||
                const DeepCollectionEquality()
                    .equals(other.transport, transport)) &&
            (identical(other.station, station) ||
                const DeepCollectionEquality()
                    .equals(other.station, station)) &&
            (identical(other.direction, direction) ||
                const DeepCollectionEquality()
                    .equals(other.direction, direction)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.mission, mission) ||
                const DeepCollectionEquality().equals(other.mission, mission)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transport) ^
      const DeepCollectionEquality().hash(station) ^
      const DeepCollectionEquality().hash(direction) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(mission);

  @JsonKey(ignore: true)
  @override
  $RERScheduleCopyWith<RERSchedule> get copyWith =>
      _$RERScheduleCopyWithImpl<RERSchedule>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)
        $default, {
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, String mission)
        RER,
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, Station terminus)
        BUS,
  }) {
    return RER(transport, station, direction, time, mission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)?
        $default, {
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, String mission)?
        RER,
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, Station terminus)?
        BUS,
    required TResult orElse(),
  }) {
    if (RER != null) {
      return RER(transport, station, direction, time, mission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Schedule value) $default, {
    required TResult Function(RERSchedule value) RER,
    required TResult Function(BUSSchedule value) BUS,
  }) {
    return RER(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Schedule value)? $default, {
    TResult Function(RERSchedule value)? RER,
    TResult Function(BUSSchedule value)? BUS,
    required TResult orElse(),
  }) {
    if (RER != null) {
      return RER(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$RERScheduleToJson(this)..['runtimeType'] = 'RER';
  }
}

abstract class RERSchedule extends Schedule {
  factory RERSchedule(Transport transport, Station station, Direction direction,
      DateTime time, String mission) = _$RERSchedule;
  RERSchedule._() : super._();

  factory RERSchedule.fromJson(Map<String, dynamic> json) =
      _$RERSchedule.fromJson;

  @override
  Transport get transport => throw _privateConstructorUsedError;
  @override
  Station get station => throw _privateConstructorUsedError;
  @override
  Direction get direction => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  String get mission => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $RERScheduleCopyWith<RERSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BUSScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory $BUSScheduleCopyWith(
          BUSSchedule value, $Res Function(BUSSchedule) then) =
      _$BUSScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Transport transport,
      Station station,
      Direction direction,
      DateTime time,
      Station terminus});

  @override
  $TransportCopyWith<$Res> get transport;
  @override
  $StationCopyWith<$Res> get station;
  $StationCopyWith<$Res> get terminus;
}

/// @nodoc
class _$BUSScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements $BUSScheduleCopyWith<$Res> {
  _$BUSScheduleCopyWithImpl(
      BUSSchedule _value, $Res Function(BUSSchedule) _then)
      : super(_value, (v) => _then(v as BUSSchedule));

  @override
  BUSSchedule get _value => super._value as BUSSchedule;

  @override
  $Res call({
    Object? transport = freezed,
    Object? station = freezed,
    Object? direction = freezed,
    Object? time = freezed,
    Object? terminus = freezed,
  }) {
    return _then(BUSSchedule(
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
      time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      terminus == freezed
          ? _value.terminus
          : terminus // ignore: cast_nullable_to_non_nullable
              as Station,
    ));
  }

  @override
  $StationCopyWith<$Res> get terminus {
    return $StationCopyWith<$Res>(_value.terminus, (value) {
      return _then(_value.copyWith(terminus: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$BUSSchedule extends BUSSchedule {
  _$BUSSchedule(
      this.transport, this.station, this.direction, this.time, this.terminus)
      : super._();

  factory _$BUSSchedule.fromJson(Map<String, dynamic> json) =>
      _$_$BUSScheduleFromJson(json);

  @override
  final Transport transport;
  @override
  final Station station;
  @override
  final Direction direction;
  @override
  final DateTime time;
  @override
  final Station terminus;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BUSSchedule &&
            (identical(other.transport, transport) ||
                const DeepCollectionEquality()
                    .equals(other.transport, transport)) &&
            (identical(other.station, station) ||
                const DeepCollectionEquality()
                    .equals(other.station, station)) &&
            (identical(other.direction, direction) ||
                const DeepCollectionEquality()
                    .equals(other.direction, direction)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.terminus, terminus) ||
                const DeepCollectionEquality()
                    .equals(other.terminus, terminus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transport) ^
      const DeepCollectionEquality().hash(station) ^
      const DeepCollectionEquality().hash(direction) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(terminus);

  @JsonKey(ignore: true)
  @override
  $BUSScheduleCopyWith<BUSSchedule> get copyWith =>
      _$BUSScheduleCopyWithImpl<BUSSchedule>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)
        $default, {
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, String mission)
        RER,
    required TResult Function(Transport transport, Station station,
            Direction direction, DateTime time, Station terminus)
        BUS,
  }) {
    return BUS(transport, station, direction, time, terminus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time)?
        $default, {
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, String mission)?
        RER,
    TResult Function(Transport transport, Station station, Direction direction,
            DateTime time, Station terminus)?
        BUS,
    required TResult orElse(),
  }) {
    if (BUS != null) {
      return BUS(transport, station, direction, time, terminus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Schedule value) $default, {
    required TResult Function(RERSchedule value) RER,
    required TResult Function(BUSSchedule value) BUS,
  }) {
    return BUS(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Schedule value)? $default, {
    TResult Function(RERSchedule value)? RER,
    TResult Function(BUSSchedule value)? BUS,
    required TResult orElse(),
  }) {
    if (BUS != null) {
      return BUS(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$BUSScheduleToJson(this)..['runtimeType'] = 'BUS';
  }
}

abstract class BUSSchedule extends Schedule {
  factory BUSSchedule(Transport transport, Station station, Direction direction,
      DateTime time, Station terminus) = _$BUSSchedule;
  BUSSchedule._() : super._();

  factory BUSSchedule.fromJson(Map<String, dynamic> json) =
      _$BUSSchedule.fromJson;

  @override
  Transport get transport => throw _privateConstructorUsedError;
  @override
  Station get station => throw _privateConstructorUsedError;
  @override
  Direction get direction => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  Station get terminus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $BUSScheduleCopyWith<BUSSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

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
