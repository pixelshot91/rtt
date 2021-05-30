import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'dart:math';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

class Trip {
  List<Leg> legs;

  Trip({this.legs});

  @override
  String toString() => "Trip :\n" + legs.join("\n");
}

// TODO: create LegRequirements and SuggestedLeg
class Leg {
  Transport transport;
  String locFrom;
  String locTo;
  Duration duration;
  DateTime startTime;

  Leg(this.transport, this.locFrom, this.locTo, {this.duration, this.startTime});

  DateTime get endTime => startTime.add(duration);

  Leg copyWith({DateTime startTime, DateTime endTime}) => Leg(
    this.transport,
    this.locFrom,
    this.locTo,
    duration: duration ?? this.duration,
    startTime: startTime ?? this.startTime,
  );

  @override
  String toString() {
    String s = "";
    s += transport.name;
    s += ", " + (startTime == null ? "?" : DateFormat('Hm').format(startTime));
    return s;
  }
}

enum TransportKind {
  RER,
  METRO,
  BUS,
}
//Map colorMap = <Pair<TransportKind, line>, Color>();

Color ColorRGB(int r, int g, int b) => Color.fromARGB(255, r, g, b);

class RATPColors {
  static final Coquelicot = ColorRGB(255, 20, 0);
  static final Bleu_outremer = ColorRGB(60, 145, 220);
  static final Vert_fonce = ColorRGB(0, 100, 60);
  static final Rose = ColorRGB(255, 130, 180);
}
var colorMap = {
  Tuple2(TransportKind.RER, "A"): RATPColors.Coquelicot,
  Tuple2(TransportKind.RER, "B"): RATPColors.Bleu_outremer,

  Tuple2(TransportKind.METRO, "7"): RATPColors.Rose,

  Tuple2(TransportKind.BUS, "172"): RATPColors.Vert_fonce,
};
var transportKindNames = {
  TransportKind.RER: "RER",
  TransportKind.METRO: "Metro",
  TransportKind.BUS: "Bus",
};
class Transport {
  TransportKind kind;
  String line;
  Color get color => colorMap[Tuple2(kind, line)] ?? Colors.grey;
  String get name => transportKindNames[kind] + ' ' + line;
  Transport(this.kind, this.line);
}

class GanttChartScreen extends StatefulWidget {
  List<Trip> trips;
  GanttChartScreen(this.trips);
  @override
  State<StatefulWidget> createState() {
    return new GanttChartScreenState(trips);
  }
}

class GanttChartScreenState extends State<GanttChartScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<Trip> trips; /* = [
    Trip(legs: [
      Leg(Transport(TransportKind.RER, "A"), "Reuil", "Denfert", startTime: DateTime(2020, 1, 1, 10, 0), duration: Duration(minutes: 25)),
      Leg(Transport(TransportKind.RER, "B"), "Denfert", "Bourg-la-Reine", startTime: DateTime(2020, 1, 1, 10, 30), duration: Duration(minutes: 10)),
    ]),
    /*Trip(name: 'Trip 2', legs: [
      Leg(Transport(TransportKind.BUS, "172"), startTime: DateTime(2020, 1, 1, 10, 11), endTime: DateTime(2020, 1, 1, 10, 32)),
      Leg(Transport(TransportKind.RER, "B"), startTime: DateTime(2020, 1, 1, 10, 40), endTime: DateTime(2020, 1, 1, 10, 50)),
    ]),*/
  ];*/

  GanttChartScreenState(this.trips);

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: Duration(microseconds: 2000), vsync: this);
    animationController.forward();
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('Suggested Trips'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: GanttChart(
                animationController: animationController,
                trips: trips,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GanttChart extends StatelessWidget {
  final AnimationController animationController;
  DateTime fromDate;
  DateTime toDate;
  final List<Trip> trips;

  int viewRange;
  int viewRangeToFitScreen = 60;
  Animation<double> width;

  GanttChart({
    this.animationController,
    @required this.trips,
  }) {
    assert(this.trips != null);

    trips.forEach((t) {
      final maybeStart = t.legs.first.startTime;
      //print("maybeStart = $maybeStart, fromDate = $fromDate");
      if (fromDate == null || maybeStart.isBefore(fromDate)) {
        fromDate = maybeStart;
      }

      final maybeEnd = t.legs.last.endTime;
      //print("maybeEnd = $maybeEnd, toDate = $toDate");
      if (toDate == null || maybeEnd.isAfter(toDate)) {
        toDate = maybeEnd;
      }
    });
    viewRange = calculateNumberOfMinutesBetween(fromDate, toDate);
  }

  int calculateNumberOfMinutesBetween(DateTime from, DateTime to) => to.difference(from).inMinutes;

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else
      return calculateNumberOfMinutesBetween(fromDate, projectStartedAt) - 1;
  }

  int calculateRemainingWidth(
      DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength =
    calculateNumberOfMinutesBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.compareTo(fromDate) >= 0 &&
        projectStartedAt.compareTo(toDate) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange -
            calculateNumberOfMinutesBetween(fromDate, projectStartedAt);
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(toDate)) {
      return projectLength -
          calculateNumberOfMinutesBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isAfter(toDate)) {
      return viewRange;
    }
    return 0;
  }

  List<Widget> buildChartBars(
      List<Leg> legs, double chartViewWidth) {
    List<Widget> chartBars = [];

    for(int i = 0; i < legs.length; i++) {
      var remainingWidth =
      calculateRemainingWidth(legs[i].startTime, legs[i].endTime);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: legs[i].transport.color,
              borderRadius: BorderRadius.circular(10.0)),
          height: 25.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(legs[i].startTime) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == legs.length - 1 ? 4.0 : 2.0
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              legs[i].transport.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ));
      }
    }

    return chartBars;
  }

  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = [];

    DateTime tempDate = fromDate;

    headerItems.add(Container(
      width: 3*chartViewWidth / viewRangeToFitScreen,
      child: new Text(
        ' ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
    ));

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(Container(
        width: 5 * chartViewWidth / viewRangeToFitScreen,
        child: new Text(
          tempDate.hour.toString() + ':' + tempDate.minute.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
      ));
      tempDate = tempDate.add(Duration(minutes: 5));
    }

    return Container(
      height: 25.0,
      color: color,
      child: Row(
        children: headerItems,
      ),
    );
  }

  Widget buildGrid(double chartViewWidth) {
    List<Widget> gridColumns = [];

    for (int i = 0; i <= viewRange; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(
            border: Border(
                right:
                BorderSide(color: Colors.grey.withAlpha(100), width: 1.0))),
        width: chartViewWidth / viewRangeToFitScreen,
        //height: 300.0,
      ));
    }

    return Row(
      children: gridColumns,
    );
  }

  Widget buildChartForEachTrip(Trip trip, double chartViewWidth) {
    final color = ColorRGB(200, 200, 200);
    var chartBars = buildChartBars(trip.legs, chartViewWidth);
    return Container(
      height: chartBars.length * 29.0 + 25.0 + 4.0,
      child: ListView(
        physics: new ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(fit: StackFit.loose, children: <Widget>[
            buildGrid(chartViewWidth),
            buildHeader(chartViewWidth, color),
            Container(
                margin: EdgeInsets.only(top: 25.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 3 * chartViewWidth / viewRangeToFitScreen,
                                height: chartBars.length * 29.0 + 4.0,
                                color: color.withAlpha(100),
                                child: Center(
                                  child: new RotatedBox(
                                    quarterTurns: chartBars.length * 29.0 + 4.0 > 50 ? 0 : 0,
                                    child: new Text(
                                      "trip.name",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: chartBars,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ],
      ),
    );
  }

  List<Widget> buildChartContent(double chartViewWidth) {
    List<Widget> chartContent = [];

    trips.forEach((trip) {
      chartContent.add(buildChartForEachTrip(trip, chartViewWidth));
    });

    return chartContent;
  }

  @override
  Widget build(BuildContext context) {
    var chartViewWidth = MediaQuery.of(context).size.width;
    var screenOrientation = MediaQuery.of(context).orientation;

    /*screenOrientation == Orientation.landscape
        ? viewRangeToFitScreen = 12
        : viewRangeToFitScreen = 6;*/

    return Container(
      child: MediaQuery.removePadding(child: ListView(children: buildChartContent(chartViewWidth)), removeTop: true, context: context,),
    );
  }
}