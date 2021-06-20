import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtt.dart';

import 'algo_test.mocks.dart';

@GenerateMocks([RTAPI])
void main() {
  late RTAPI api;
  late RTT rtt;
  setUp(() {
    api = MockRTAPI();
    rtt = RTT(api);
  });

  final b172_stations = ['A', 'B', 'C'].map((name) => Station(name)).toList();

  test('Find trips', () async {
    final now = DateTime(2000, 1, 1);

    final leg = LegRequest(Transport(TransportKind.BUS, "172"), Station('A'), Station('C'), Direction.A,
        duration: Duration(minutes: 5));

    final nextSchedules = [
      BUSSchedule(leg.transport, leg.from, leg.direction, now.add(Duration(minutes: 4)), Station('C')),
      BUSSchedule(leg.transport, leg.from, leg.direction, now.add(Duration(minutes: 10)), Station('C')),
    ];
    when(api.getSchedule(leg.transport, leg.from, leg.direction)).thenAnswer((_) async => nextSchedules);
    when(api.getStationsOfLine(leg.transport, leg.direction)).thenAnswer((_) async => b172_stations);
    final trips = await rtt.suggestTrip(TripRequest(legs: [leg]), now).toList();

    expect(trips.length, 2);
    final List<SuggestedTrip> expectedTrips =
        nextSchedules.map((s) => SuggestedTrip(legs: [SuggestedLeg(leg, schedule: s)])).toList();
    expect(trips, expectedTrips);
  });

  test('Find trips with bus partial service', () async {
    final now = DateTime(2000, 1, 1);

    final leg = LegRequest(Transport(TransportKind.BUS, "172"), Station('A'), Station('C'), Direction.A,
        duration: Duration(minutes: 5));

    final nextSchedules = [
      BUSSchedule(leg.transport, leg.from, leg.direction, now.add(Duration(minutes: 4)), Station('B')),
      BUSSchedule(leg.transport, leg.from, leg.direction, now.add(Duration(minutes: 10)), Station('C')),
    ];
    when(api.getSchedule(leg.transport, leg.from, leg.direction)).thenAnswer((_) async => nextSchedules);
    when(api.getStationsOfLine(leg.transport, leg.direction)).thenAnswer((_) async => b172_stations);
    final trips = await rtt.suggestTrip(TripRequest(legs: [leg]), now).toList();

    expect(trips.length, 1);
    final List<SuggestedTrip> expectedTrips = [
      SuggestedTrip(legs: [SuggestedLeg(leg, schedule: nextSchedules[1])])
    ];
    expect(trips, expectedTrips);
  });
}
