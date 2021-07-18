import 'package:flutter_test/flutter_test.dart';
import 'package:rtt/rtapi/api.dart';

final mockStations = ['A', 'B', 'C'].map((name) => Station(name)).toList();

class MockAPI extends RTAPI {
  @override
  Future<List<Schedule>> getSchedule(Transport transport, Station station, Direction direction) {
    // TODO: implement getSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<Station>> getStationsOfLine(Transport transport) async {
    print("Real execute");
    return mockStations;
  }

  @override
  Future<List<Station>> getStationsServedByMission(RERSchedule s) {
    // TODO: implement getStationsServedByMission
    throw UnimplementedError();
  }

  @override
  Future<DateTime> getCurrentTime() {
    // TODO: implement getCurrentTime
    throw UnimplementedError();
  }
}

void main() {
  test('Read write from LocalStorage', () async {
    final transport = Transport(TransportKind.BUS, '172');
    final api = MockAPI();
    {
      final stations = await api.getStationsOfLine(transport);
      expect(stations, mockStations);
    }
    {
      final stations = await api.getStationsOfLine(transport);
      expect(stations, mockStations);
    }
  });
}
