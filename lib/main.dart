import 'package:flutter/material.dart';
import 'package:rtt/rtapi/grimaud_api.dart';
import 'package:rtt/rtt.dart';

import 'gantt_chart_screen.dart';

void main() {
  runApp(MyApp());
}

class EnvironmentConfig {
  static const VERSION = String.fromEnvironment('VERSION');
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
  late Stream<SuggestedTrip> suggestedTrips;

  @override
  void initState() {
    super.initState();
    final rtt = RTT(GrimaudAPI());
    suggestedTrips = rtt.suggestTrips(tripsRequest, DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
            Text(
              ' ' + EnvironmentConfig.VERSION,
              style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      body: Center(
        child: GanttChartScreen(suggestedTrips),
      ),
    );
  }
}
