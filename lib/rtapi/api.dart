import 'package:localstorage/localstorage.dart';
import 'package:quiver/core.dart';
import 'package:rtt/rtt.dart';

extension JSONList on List {
  List<Map<String, dynamic>> toJson() => map<Map<String, dynamic>>((e) => e.toJson()).toList();
}

class FindScheduleParam {
  Transport transport;
  Station station;
  Direction direction;

  FindScheduleParam(this.transport, this.station, this.direction);

  bool operator ==(o) =>
      o is FindScheduleParam && transport == o.transport && station == o.station && direction == o.direction;
  int get hashCode => hash3(transport, station, direction);
}

class CachedSchedules {
  DateTime lastUpdateAt;
  List<Schedule> schedules;

  CachedSchedules(this.lastUpdateAt, this.schedules);
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
}
