import 'package:rtt/rtt.dart';

abstract class RTAPI {
  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction);
}
