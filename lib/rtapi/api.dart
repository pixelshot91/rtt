import 'package:quiver/core.dart';
import 'package:rtt/rtt.dart';

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

  RTAPI({this.maxCacheLife = const Duration(minutes: 1)});

  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) async {
    var findScheduleParams = FindScheduleParam(transport, station, direction);
    final cachedSchedules = scheduleCache[findScheduleParams];

    print("cache = $cachedSchedules");
    if (cachedSchedules != null && DateTime.now().difference(cachedSchedules.lastUpdateAt) < maxCacheLife) {
      return Future(() => cachedSchedules.schedules);
    }
    final schedules = await getScheduleNoCache(transport, station, direction);
    scheduleCache[findScheduleParams] = CachedSchedules(DateTime.now(), schedules);
    print('scheduleCache.length = ${scheduleCache.length}');
    return schedules;
  }

  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction);
}
