import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'api.dart';

class APICache extends RTAPI {
  Duration maxCacheLife;
  Map<FindScheduleParam, CachedSchedules> scheduleCache = {};
  RTAPI realAPI;

  APICache(this.realAPI, {Duration? maxCacheLife}) : this.maxCacheLife = maxCacheLife ?? Duration(minutes: 1);

  final LocalStorage storage = LocalStorage('api.json');

  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) async {
    var findScheduleParams = FindScheduleParam(transport, station, direction);
    final cachedSchedules = scheduleCache[findScheduleParams];

    if (cachedSchedules != null && DateTime.now().difference(cachedSchedules.lastUpdateAt) < maxCacheLife) {
      return Future(() => cachedSchedules.schedules);
    }
    final schedules = await realAPI.getSchedule(transport, station, direction);
    scheduleCache[findScheduleParams] = CachedSchedules(DateTime.now(), schedules);
    return schedules;
  }

  Future<List<Station>> getStationsOfLine(Transport transport) async {
    final key = 'stations_' + transport.name;
    final storedValue = storage.getItem(key);
    List<Station> stations;
    if (storedValue == null) {
      stations = await realAPI.getStationsOfLine(transport);
      storage.setItem(key, stations.toJson());
    } else {
      stations = List<Station>.from((storedValue as List).map((json) => (Station.fromJson(json))));
    }

    return stations;
  }

  Future<bool> doesMissionStopAt(RERSchedule s, Station to) async {
    return (await getStationsServedByMission(s)).contains(to);
  }

  Future<List<Station>> getStationsServedByMission(RERSchedule s) async {
    var storedValue = storage.getItem(s.mission);
    if (storedValue == null) {
      final stations = await realAPI.getStationsServedByMission(s);
      storage.setItem(s.mission, stations.toJson());
      return stations;
    }
    return List<Station>.from((storedValue as List).map((json) => (Station.fromJson(json))));
  }

  Future<DateTime> getCurrentTime() => realAPI.getCurrentTime();

  String cacheToFile() => jsonEncode(scheduleCache);
}
