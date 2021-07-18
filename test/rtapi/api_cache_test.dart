import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtapi/api_cache.dart';

import 'api_cache_test.mocks.dart';

@GenerateMocks([RTAPI])
void main() {
  late RTAPI realAPI;
  late APICache api;

  final transport = Transport(TransportKind.BUS, '172');
  final station = Station("s");
  final direction = Direction.A;
  final time = DateTime(2010);
  final expectedSchedules = [Schedule(transport, station, direction, time)];

  setUp(() {
    realAPI = MockRTAPI();
    api = APICache(realAPI, maxCacheLife: Duration(seconds: 2));
  });

  test('Get BUS schedule', () async {
    when(realAPI.getSchedule(transport, station, direction)).thenAnswer((_) async => expectedSchedules);
    final schedules = await api.getSchedule(transport, station, direction);
    expect(expectedSchedules, schedules);
  });

  test('Get BUS schedule twice. API should be called once', () async {
    var counter = 0;
    when(realAPI.getSchedule(transport, station, direction)).thenAnswer((_) async {
      counter += 1;
      return expectedSchedules;
    });
    final schedules_1 = await api.getSchedule(transport, station, direction);
    final schedules_2 = await api.getSchedule(transport, station, direction);
    expect(expectedSchedules, schedules_1);
    expect(expectedSchedules, schedules_2);
    expect(counter, 1);
  });

  test('Get BUS schedule with big pause between. API should be called twice', () async {
    var counter = 0;
    when(realAPI.getSchedule(transport, station, direction)).thenAnswer((_) async {
      counter += 1;
      return expectedSchedules;
    });
    final schedules_1 = await api.getSchedule(transport, station, direction);
    sleep(Duration(seconds: 2));
    final schedules_2 = await api.getSchedule(transport, station, direction);
    expect(expectedSchedules, schedules_1);
    expect(expectedSchedules, schedules_2);
    expect(counter, 2);
  });

  test('Map test Transport', () {
    final p1 = Transport(TransportKind.RER, 'B');
    final p2 = Transport(TransportKind.RER, 'B');

    Map<Transport, String> m = {p1: 'Hello'};
    expect(m[p2], 'Hello');
  });

  test('Map test Station', () {
    final p1 = Station('B');
    final p2 = Station('B');

    Map<Station, String> m = {p1: 'Hello'};
    expect(m[p2], 'Hello');
  });
}
