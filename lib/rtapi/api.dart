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

abstract class RTAPI {
  Map<FindScheduleParam, List<Schedule>> scheduleCache = {};

  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) async {
    print("getSchedules. Looking in cache. length = ${scheduleCache.length}");
    print(scheduleCache);
    var findScheduleParams = FindScheduleParam(transport, station, direction);

    var findScheduleParams2 = FindScheduleParam(transport, station, direction);
    print(findScheduleParams == findScheduleParams2);
    print(findScheduleParams.hashCode == findScheduleParams2.hashCode);
    final cachedSchedules = scheduleCache[findScheduleParams];
    print("cache = $cachedSchedules");
    if (cachedSchedules != null) return Future(() => cachedSchedules);
    final schedules = await getScheduleNoCache(transport, station, direction);
    scheduleCache[findScheduleParams] = schedules;
    print('scheduleCache.length = ${scheduleCache.length}');
    return schedules;
  }

  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction);
}
