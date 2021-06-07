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
  test('Find trips', () async {
    final now = DateTime(2000, 1, 1);
    final nextSchedules = [Duration(minutes: 4), Duration(minutes: 10)];

    final leg = LegRequest(
        Transport(TransportKind.BUS, "172"), Station('Villejuif - Louis Aragon'), Station("Opera"), Direction.A,
        duration: Duration(minutes: 5));

    when(api.getSchedule(leg.transport, leg.from, leg.direction)).thenAnswer(
        (_) async => nextSchedules.map((d) => Schedule(leg.transport, leg.from, leg.direction, now.add(d))).toList());
    final trips = await rtt.suggestTrip(TripRequest(legs: [leg]), now).toList();
    expect(trips.length, 2);
    final List<SuggestedTrip> expectedTrips = [
      SuggestedTrip(legs: [SuggestedLeg(leg, startTime: now.add(nextSchedules[0]))]),
      SuggestedTrip(legs: [SuggestedLeg(leg, startTime: now.add(nextSchedules[1]))]),
    ];
    expect(trips, expectedTrips);
  });
}
