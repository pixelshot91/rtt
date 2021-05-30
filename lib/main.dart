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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final tripRequest = Trip(legs: [
  Leg(Transport(TransportKind.RER, "A"), "Reuil", "Denfert", startTime: DateTime(2020, 1, 1, 10, 0), duration: Duration(minutes: 25)),
  Leg(Transport(TransportKind.RER, "B"), "Denfert", "Bourg-la-Reine", startTime: DateTime(2020, 1, 1, 10, 30), duration: Duration(minutes: 10)),
]);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final trips = suggestTrip(tripRequest, todayWithTime(19, 30));
    print(trips);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(""), //GranttChartScreen()
      ),
    );
  }
}

DateTime todayWithTime(int hour, int minute) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, hour, minute);
}

class Station {
  String name;
  String slug;
}

final SCHEDULES = {
  TransportKind.METRO: Tuple3(todayWithTime(19, 05), Duration(minutes: 10), todayWithTime(23, 30)),
  TransportKind.RER  : Tuple3(todayWithTime(19, 10), Duration(minutes: 30), todayWithTime(23, 50)),
  //TransportKind.WALK  : Tuple3(todayWithTime(19, 00), Duration(minutes: 01), todayWithTime(23, 50)), // not meaningful
};
final margin = Duration(minutes: 10);

Iterable<Trip> suggestTrip(Trip request, DateTime departure) sync* {
  print("rest = ${request}");
  var rest = request.legs.length > 1 ? request.legs.sublist(1) : null;
  DateTime best = null;
  for (Leg first in suggestLegs(request.legs.first, departure)) {
    if (best != null && first.endTime.isAfter(best.add(margin))) {
      break;
    }
    if (rest != null) {
      yield Trip(legs: [first]);
    }
    var suggestRests = suggestTrip(Trip(legs: rest), departure);
    for (Trip suggestRest in suggestRests) {
      final endTime = suggestRest.legs.last.endTime;
      if (best == null || best.isAfter(endTime)) {
        best = endTime;
      } else if (endTime.isAfter(best.add(margin))) {
        break;
      }
      yield Trip(legs: [first, ...suggestRest.legs]);
    }
  }
}

Iterable<Leg> suggestLegs(Leg request, DateTime departure) =>
  findSchedules(request.transport, request.locFrom, departure).map((t) =>
    request.copyWith(startTime: departure)
  );

Iterable<DateTime> findSchedules(Transport t, String from, DateTime departure) sync* {
  final first = SCHEDULES[t.kind].item1, freq = SCHEDULES[t.kind].item2, last = SCHEDULES[t.kind].item3;
  var s = first;
  while (s.isBefore(last)) {
    yield s;
    s = s.add(freq);
  }
}