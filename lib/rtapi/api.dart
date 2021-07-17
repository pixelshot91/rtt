import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localstorage/localstorage.dart';

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
  String toString() => 'Schedule($transport from $station ($direction) at $time)';
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
  Duration maxCacheLife;
  Map<FindScheduleParam, CachedSchedules> scheduleCache = {};

  RTAPI({Duration? maxCacheLife}) : this.maxCacheLife = maxCacheLife ?? Duration(minutes: 1);

  final LocalStorage storage = LocalStorage('api.json');

  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) async {
    var findScheduleParams = FindScheduleParam(transport, station, direction);
    final cachedSchedules = scheduleCache[findScheduleParams];

    if (cachedSchedules != null && DateTime.now().difference(cachedSchedules.lastUpdateAt) < maxCacheLife) {
      return Future(() => cachedSchedules.schedules);
    }
    final schedules = await getScheduleNoCache(transport, station, direction);
    scheduleCache[findScheduleParams] = CachedSchedules(DateTime.now(), schedules);
    return schedules;
  }

  Future<List<Station>> getStationsOfLine(Transport transport, Direction direction) async {
    final key = 'stations_' + transport.name;
    final storedValue = storage.getItem(key);
    List<Station> stations;
    if (storedValue == null) {
      stations = await getStationsOfLineNoCache(transport);
      storage.setItem(key, stations.toJson());
    } else {
      stations = List<Station>.from((storedValue as List).map((json) => (Station.fromJson(json))));
    }

    return direction == Direction.A ? stations : stations.reversed.toList();
  }

  Future<List<Station>> getStationsOfLineNoCache(Transport transport);

  Future<bool> doesMissionStopAt(RERSchedule s, Station to) async {
    return (await getStationsServedByMission(s)).contains(to);
  }

  Future<List<Station>> getStationsServedByMission(RERSchedule s) async {
    var storedValue = storage.getItem(s.mission);
    if (storedValue == null) {
      final stations = await getStationsServedByMissionNoCache(s);
      storage.setItem(s.mission, stations.toJson());
      return stations;
    }
    return List<Station>.from((storedValue as List).map((json) => (Station.fromJson(json))));
  }

  Future<List<Station>> getStationsServedByMissionNoCache(RERSchedule s);

  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction);

  Future<DateTime> getCurrentTime();
}
