import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiver/iterables.dart';
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtapi/grimaud_api.dart';
import 'package:rtt/rtt.dart';

import 'grimaud_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const busScheduleBody = '''
    {
      "result": {
          "schedules": [
              {
                  "message": "PAS DE SERVICE",
                  "destination": "Bourg la Reine RER"
              },
              {
                  "message": "..................",
                  "destination": "Bourg la Reine RER"
              },
              {
                  "message": "7 mn",
                  "destination": "Bourg-La-Reine RER"
              },
              {
                  "message": "15 mn",
                  "destination": "Bourg-La-Reine RER"
              }
          ]
      },
      "_metadata": {
          "call": "GET /schedules/buses/172/villejuif%2B%2B%2Blouis%2Baragon/R",
          "date": "2021-06-05T17:20:45+02:00",
          "version": 4
      }
  }''';

  bool almostEqual(DateTime d1, DateTime d2) => d1.difference(d2).abs() < Duration(seconds: 1);

  late http.Client client;
  late GrimaudAPI api;

  setUp(() {
    client = MockClient();
    api = GrimaudAPI.withClient(client, maxCacheLife: Duration(seconds: 2));
  });

  test('Get BUS schedule', () async {
    when(client.get(
            Uri.parse('https://api-ratp.pierre-grimaud.fr/v4/schedules/buses/172/villejuif%2B%2B%2Blouis%2Baragon/R')))
        .thenAnswer((_) async => http.Response(busScheduleBody, 200));
    http.Response r = await api.callApi(
        ['schedules', Transport(TransportKind.BUS, '172').URL, 'villejuif%2B%2B%2Blouis%2Baragon', Direction.B.URL]);
    expect(r.statusCode, 200);
    expect(r.body, busScheduleBody);
  });

  test('Get BUS schedule twice. API should be called once', () async {
    var counter = 0;
    when(client.get(Uri.parse('https://api-ratp.pierre-grimaud.fr/v4/schedules/buses/172/villejuif+++louis+aragon/R')))
        .thenAnswer((_) async {
      counter += 1;
      return http.Response(busScheduleBody, 200);
    });
    var schedules_1 =
        await api.getSchedule(Transport(TransportKind.BUS, '172'), Station('Villejuif - Louis Aragon'), Direction.B);
    var schedules_2 =
        await api.getSchedule(Transport(TransportKind.BUS, '172'), Station('Villejuif - Louis Aragon'), Direction.B);

    expect(schedules_1, schedules_2);
    expect(counter, 1);
  });

  test('Get BUS schedule with big pause between. API should be called twice', () async {
    var counter = 0;
    when(client.get(Uri.parse('https://api-ratp.pierre-grimaud.fr/v4/schedules/buses/172/villejuif+++louis+aragon/R')))
        .thenAnswer((_) async {
      counter += 1;
      return http.Response(busScheduleBody, 200);
    });
    var schedules_1 =
        await api.getSchedule(Transport(TransportKind.BUS, '172'), Station('Villejuif - Louis Aragon'), Direction.B);
    sleep(Duration(seconds: 2));
    var schedules_2 =
        await api.getSchedule(Transport(TransportKind.BUS, '172'), Station('Villejuif - Louis Aragon'), Direction.B);

    expect(counter, 2);
  });

  test('Map test FindScheduleParam', () {
    final p1 = FindScheduleParam(Transport(TransportKind.RER, 'B'), Station('s'), Direction.A);
    final p2 = FindScheduleParam(Transport(TransportKind.RER, 'B'), Station('s'), Direction.A);

    Map<FindScheduleParam, String> m = {p1: 'Hello'};
    expect(m[p2], 'Hello');
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

  test('Map test String', () {
    final p1 = 'B';
    final p2 = 'B';

    Map<String, String> m = {p1: 'Hello'};
    expect(m[p2], 'Hello');
  });

  test('Parse BUS schedule response', () {
    List<DateTime> times = api.parseBusResponse(busScheduleBody);
    final expectedTimes = [Duration(minutes: 7), Duration(minutes: 15)].map((d) => DateTime.now().add(d));

    expect(times.length, expectedTimes.length);
    assert(zip([times, expectedTimes]).every((pair) => almostEqual(pair[0], pair[1])));
    verifyZeroInteractions(client);
  });
}
