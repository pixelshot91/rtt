import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'gantt_chart_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RTT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Real-time Trip'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final tripRequest = Trip(legs: [
  Leg(Transport(TransportKind.METRO, "7"), "VJ", "Opera", duration: Duration(minutes: 25)),
  Leg(Transport(TransportKind.WALK, ""), "Opera", "Auber", duration: Duration(minutes: 5)),
  Leg(Transport(TransportKind.RER, "A"), "Auber", "Rueil", duration: Duration(minutes: 20)),
]);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Trip> suggestedTrips = suggestTrip(tripRequest, todayWithTime(19, 30)).toList();
    print("suggestedTrips = $suggestedTrips");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GanttChartScreen(suggestedTrips),
      ),
    );
  }
}

DateTime todayWithTime(int hour, int minute) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, hour, minute);
}

/*class Station {
  String name;
  String slug;
}*/

final SCHEDULES = {
  TransportKind.METRO: Tuple3(todayWithTime(19, 05), Duration(minutes: 10), todayWithTime(23, 30)),
  TransportKind.RER  : Tuple3(todayWithTime(19, 10), Duration(minutes: 30), todayWithTime(23, 50)),
};
final margin = Duration(minutes: 31);

Iterable<Trip> suggestTrip(Trip request, DateTime departure) sync* {
  print("rest = $request");
  List<Leg> rest = request.legs.length > 1 ? request.legs.sublist(1) : [];
  DateTime? best;
  print("arg = ${request.legs.first}");
  for (Leg first in suggestLegs(request.legs.first, departure)) {
    print("Leg = $first");
    if (best != null && first.endTime!.isAfter(best.add(margin))) {
      break;
    }
    if (rest.isEmpty) {
      yield Trip(legs: [first]);
      continue;
    }
    var suggestRests = suggestTrip(Trip(legs: rest), first.endTime!);
    print("For suggestRest");
    for (Trip suggestRest in suggestRests) {
      print("For iter suggestRest");
      final endTime = suggestRest.legs.last.endTime!;
      if (best == null || best.isAfter(endTime)) {
        best = endTime;
      } else if (endTime.isAfter(best.add(margin))) {
        break;
      }
      print("Yield Trip with first and tail");
      yield Trip(legs: [first, ...suggestRest.legs]);
    }
  }
}

Iterable<Leg> suggestLegs(Leg request, DateTime departure) sync*{
  /*findSchedules(request.transport, request.locFrom, departure).map((t) =>
    request.copyWith(startTime: t)
  );*/
  print("SuggestedLegs start");
  for (DateTime d in findSchedules(request.transport, request.locFrom, departure)) {
    print("Yield SuggestedLeg");
    yield request.copyWith(startTime: d);
  }
}

Iterable<DateTime> findSchedules(Transport t, String from, DateTime departure) sync* {
  if (t.kind == TransportKind.WALK) {
    yield departure;
    return;
  }
  final first = SCHEDULES[t.kind]!.item1;
  final freq = SCHEDULES[t.kind]!.item2;
  final last = SCHEDULES[t.kind]!.item3;
  var s = first;
  while (s.isBefore(last)) {
    if (s.isAfter(departure)) {
      print("t.kind = ${t.kind} Yield schedule at time = $s");
      yield s;
    }
    s = s.add(freq);
  }
}