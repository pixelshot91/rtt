import 'package:flutter_test/flutter_test.dart';
import 'package:quiver/iterables.dart';
import 'package:rtt/rtapi/grimaud_api.dart';

void main() {
  bool almostEqual(DateTime d1, DateTime d2) => d1.difference(d2).abs() < Duration(seconds: 1);

  /*test('Get BUS schedule', () async {
    print("Call API");
    final api = GrimaudAPI();
    http.Response r = await api.callApi(
        ['schedules', Transport(TransportKind.BUS, '172').URL, 'villejuif%2B%2B%2Blouis%2Baragon', Direction.B.URL]);
    print(r.body);
  });*/

  test('Parse BUS schedule response', () {
    const String r = '''
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
    var api = GrimaudAPI();
    List<DateTime> times = api.parseBusResponse(r);
    final expectedTimes = [Duration(minutes: 7), Duration(minutes: 15)].map((d) => DateTime.now().add(d));

    expect(times.length, expectedTimes.length);
    assert(zip([times, expectedTimes]).every((pair) => almostEqual(pair[0], pair[1])));
  });
}
