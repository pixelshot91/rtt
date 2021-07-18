import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiver/iterables.dart';
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtapi/grimaud_api.dart';
import 'package:rtt/tools/datetime.dart';

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
                "message": "A l'arret",
                "destination": "Bourg-La-Reine RER"
              },
              {
                "message": "A l'approche",
                "destination": "Bourg-La-Reine RER"
              },
              {
                  "message": "7 mn",
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

  const metroScheduleBody = '''
  {
    "result": {
      "schedules": [
        {
          "message": "Train a quai",
          "destination": "La Courneuve-8-Mai-1945"
        },
        {
          "message": "Train a l'approche",
          "destination": "La Courneuve-8-Mai-1945"
        },
        {
          "message": "7 mn",
          "destination": "La Courneuve-8-Mai-1945"
        }
      ]
    },
    "_metadata": {
      "call": "GET /schedules/metros/7/opera/R",
      "date": "2021-06-07T21:54:14+02:00",
      "version": 4
    }
  }''';

  const RERScheduleBody = '''
  {
    "result": {
      "schedules": [
        {
          "code": "EPOU",
          "message": "Train à quai V.2",
          "destination": "Aeroport Charles de Gaulle 2 TGV"
        },
        {
          "code": "LEVI",
          "message": "Train Ã  quai",
          "destination": "Orsay-Ville"
        },
        {
          "code": "GSZZ",
          "message": "A l'approche Voie 2B",
          "destination": "Aulnay-sous-Bois"
        },
        {
          "code": "WKWI",
          "message": "Train sans arrÃªt",
          "destination": "Robinson. Saint-RÃ©my-lÃ¨s-Chevreuse."
        },
        {
          "code": "ERBE",
          "message": "17:47 Voie 2",
          "destination": "Aeroport Charles de Gaulle 2 TGV"
        },
        {
          "code": "ERTE",
          "message": "17:49",
          "destination": "Aeroport Charles de Gaulle 2 TGV"
        },
        {
          "code": "ERTE",
          "message": "DÃ©part RetardÃ© V.1",
          "destination": "Aeroport Charles de Gaulle 2 TGV"
        }
      ]
    },
    "_metadata": {
      "call": "GET /schedules/rers/b/bourg%2Bla%2Breine/A%2BR",
      "date": "2021-05-16T17:41:03+02:00",
      "version": 4
    }
  }
  ''';

  bool almostEqual(DateTime d1, DateTime d2) => d1.difference(d2).abs() < Duration(seconds: 1);

  bool almostEqualSchedule(Schedule s1, Schedule s2) =>
      s1.transport == s2.transport &&
      s1.station == s2.station &&
      s1.direction == s2.direction &&
      almostEqual(s1.time, s2.time);

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

  test('Parse Bus schedule response', () {
    Transport t = Transport(TransportKind.BUS, '172');
    final s = Station('Villejuif - Louis Aragon');
    final d = Direction.B;

    List<Schedule> schedules = api.parseSchedulesFromBody(busScheduleBody, t, s, d);

    final expectedTimes =
        [Duration(minutes: 0), Duration(minutes: 1), Duration(minutes: 7)].map((d) => DateTime.now().add(d));
    final expectedSchedules = expectedTimes.map((time) => Schedule(t, s, d, time)).toList();

    expect(schedules.length, expectedSchedules.length);
    assert(zip([schedules, expectedSchedules]).every((pair) => almostEqualSchedule(pair[0], pair[1])));
    verifyZeroInteractions(client);
  });

  test('Parse Metro schedule response', () {
    Transport t = Transport(TransportKind.METRO, '7');
    final s = Station('Villejuif - Louis Aragon');
    final d = Direction.B;

    List<Schedule> schedules = api.parseSchedulesFromBody(metroScheduleBody, t, s, d);
    final expectedTimes =
        [Duration(minutes: 0), Duration(minutes: 1), Duration(minutes: 7)].map((d) => DateTime.now().add(d));
    final expectedSchedules = expectedTimes.map((time) => Schedule(t, s, d, time)).toList();

    expect(schedules.length, expectedSchedules.length);
    assert(zip([schedules, expectedSchedules]).every((pair) => almostEqualSchedule(pair[0], pair[1])));
    verifyZeroInteractions(client);
  });

  test('Parse RER schedule response', () {
    Transport t = Transport(TransportKind.RER, 'B');
    final s = Station('Bourg la Reine');
    final d = Direction.B;

    List<Schedule> schedules = api.parseSchedulesFromBody(RERScheduleBody, t, s, d);

    final expectedTimes =
        [Duration(minutes: 0), Duration(minutes: 0), Duration(minutes: 1)].map((d) => DateTime.now().add(d)).toList();
    expectedTimes.add(todayWithTime(17, 47));
    expectedTimes.add(todayWithTime(17, 49));

    final expectedSchedules = expectedTimes.map((time) => Schedule(t, s, d, time)).toList();

    expect(schedules.length, expectedSchedules.length);
    assert(zip([schedules, expectedSchedules]).every((pair) => almostEqualSchedule(pair[0], pair[1])));
    verifyZeroInteractions(client);
  });

  test('slugify', () {
    const nameToSlug = {
      // M7
      'Villejuif-Louis Aragon': 'villejuif+louis+aragon',
      // B172
      'Villejuif - Louis Aragon': 'villejuif+++louis+aragon',
      'Bourg-La-Reine RER': 'bourg+la+reine+rer',
      // B286
      'Les Bons Enfants': 'les+bons+enfants',
      'Antony RER': 'antony+rer',
      // RERB
      'Bourg-la-Reine': 'bourg+la+reine',
      'Antony': 'antony',
      'Massy-Verrieres': 'massy+verrieres',
    };

    nameToSlug.forEach((name, expectedSlug) {
      expect(Station(name).getSlug(), expectedSlug);
    });
  });

  test('Parse time from response', () {
    expect(api.parseTimeFromBody(busScheduleBody), DateTime(2021, 6, 5, 17, 20, 45));
  });
}
