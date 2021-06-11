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
    final nextRemainingDurations = [Duration(minutes: 4), Duration(minutes: 10)];

    final leg = LegRequest(
        Transport(TransportKind.BUS, "172"), Station('Villejuif - Louis Aragon'), Station("Opera"), Direction.A,
        duration: Duration(minutes: 5));

    final nextSchedules =
        nextRemainingDurations.map((d) => Schedule(leg.transport, leg.from, leg.direction, now.add(d))).toList();
    when(api.getSchedule(leg.transport, leg.from, leg.direction)).thenAnswer((_) async => nextSchedules);
    final trips = await rtt.suggestTrip(TripRequest(legs: [leg]), now).toList();

    expect(trips.length, 2);
    final List<SuggestedTrip> expectedTrips =
        nextSchedules.map((s) => SuggestedTrip(legs: [SuggestedLeg(leg, schedule: s)])).toList();
    expect(trips, expectedTrips);
  });
}
