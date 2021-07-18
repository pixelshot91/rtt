import 'package:freezed_annotation/freezed_annotation.dart';

part 'api.freezed.dart';
part 'api.g.dart';

extension JSONList on List {
  List<Map<String, dynamic>> toJson() => map<Map<String, dynamic>>((e) => e.toJson()).toList();
}

enum TransportKind {
  RER,
  METRO,
  TRAM,
  BUS,
  WALK,
}

const transportKindNames = {
  TransportKind.RER: "RER",
  TransportKind.METRO: "Metro",
  TransportKind.TRAM: "Tram",
  TransportKind.BUS: "Bus",
  TransportKind.WALK: "Walk",
};

@freezed
class Transport with _$Transport {
  Transport._();
  factory Transport(TransportKind kind, String line) = _Transport;
  factory Transport.fromJson(Map<String, dynamic> json) => _$TransportFromJson(json);
  String get name => transportKindNames[kind]! + ' ' + line;
  @override
  String toString() => name;
}

@freezed
class Station with _$Station {
  Station._();
  factory Station(String name) = _Station;
  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  @override
  String toString() => name;
}

enum Direction {
  A,
  B,
}

@freezed
class Schedule with _$Schedule {
  Schedule._();
  factory Schedule(Transport transport, Station station, Direction direction, DateTime time) = _Schedule;
  factory Schedule.RER(Transport transport, Station station, Direction direction, DateTime time, String mission) =
      RERSchedule;
  factory Schedule.BUS(Transport transport, Station station, Direction direction, DateTime time, Station terminus) =
      BUSSchedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  @override
  String toString() => map(
        (_) => 'Schedule($transport from $station ($direction) at $time)',
        RER: (s) => 'Schedule($transport from $station ($direction, mission: ${s.mission}) at $time)',
        BUS: (s) => 'Schedule($transport from $station ($direction, terminus: ${s.terminus}) at $time)',
      );
}

@freezed
class FindScheduleParam with _$FindScheduleParam {
  factory FindScheduleParam(Transport transport, Station station, Direction direction) = _FindScheduleParam;
  factory FindScheduleParam.fromJson(Map<String, dynamic> json) => _$FindScheduleParamFromJson(json);
}

@freezed
class CachedSchedules with _$CachedSchedules {
  factory CachedSchedules(DateTime lastUpdateAt, List<Schedule> schedules) = _CachedSchedules;
  factory CachedSchedules.fromJson(Map<String, dynamic> json) => _$CachedSchedulesFromJson(json);
}

abstract class RTAPI {
  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction);

  Future<List<Station>> getStationsOfLine(Transport transport);

  Future<List<Station>> getStationsServedByMission(RERSchedule s);

  Future<DateTime> getCurrentTime();

  Future<bool> doesMissionStopAt(RERSchedule s, Station to) async {
    return (await getStationsServedByMission(s)).contains(to);
  }
}
