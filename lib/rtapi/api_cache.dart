import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localstorage/localstorage.dart';

import 'api.dart';

part 'api_cache.freezed.dart';
part 'api_cache.g.dart';

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
}
