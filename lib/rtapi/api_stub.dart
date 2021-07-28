import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'api.dart';

class APIStub extends RTAPI {
  Cache cache;

  APIStub(this.cache);

  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) async {
    var findScheduleParams = FindScheduleParam(transport, station, direction);
    final cachedSchedules = cache.schedules[findScheduleParams];

    if (cachedSchedules != null) {
      return Future(() => cachedSchedules.schedules);
    }
    print('NOT in CACHE');
    throw 'NOT in CACHE';
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

  String cacheToFile() => jsonEncode(cache);
}
