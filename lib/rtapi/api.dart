import 'package:quiver/core.dart';
import 'package:rtt/rtt.dart';

class FindScheduleParam {
  Transport transport;
  Station station;
  Direction direction;

  FindScheduleParam(this.transport, this.station, this.direction);

  /*int get hashCode {
    return hashObjects([product, model, element, locationName, locationSuffix]);
  }

  bool operator ==(other) {
    if (other is! TimeseriesNode) return false;
    TimeseriesNode key = other;
    return (key.element == element &&
        key.locationName == locationName &&
        key.locationSuffix == locationSuffix &&
        key.model == model &&
        key.product == product);
  }*/
  bool operator ==(o) {
    final res = o is FindScheduleParam && transport == o.transport && station == o.station && direction == o.direction;
    print('== $res');
    return res;
  }

  int get hashCode {
    final h = hash3(transport, station, direction);
    print("hash = $h");
    return h;
  }

  @override
  String toString() => transport.toString() + station.toString() + direction.toString();
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
