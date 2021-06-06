import 'package:flutter/material.dart';
import 'package:rtt/rtt.dart';

import 'gantt_chart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class _MyHomePageState extends State<MyHomePage> {
  late Stream<Trip> suggestedTrips;

  @override
  void initState() {
    super.initState();
    final rtt = RTT();
    suggestedTrips = rtt.suggestTrip(tripRequest, DateTime.now());
    print("suggestedTrips = $suggestedTrips");
  }

  @override
  Widget build(BuildContext context) {
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
