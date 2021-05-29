import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'dart:math';

//import 'models.dart';

class Trip {
  int id;
  String name;
  List<Leg> legs;

  Trip({this.id, this.name, this.legs});
}

class Leg {
  int id;
  String name;
  DateTime startTime;
  DateTime endTime;

  Leg({this.id, this.name, this.startTime, this.endTime});
}

class GranttChartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GranttChartScreenState();
  }
}

class GranttChartScreenState extends State<GranttChartScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  DateTime fromDate = DateTime(2020, 1, 1, 10);
  DateTime toDate = DateTime(2020, 1, 1, 11);

  List<Trip> trips = [
    Trip(name: 'Trip 1', legs: [
      Leg(id: 1, name: 'Basetax', startTime: DateTime(2020, 1, 1, 10, 0), endTime: DateTime(2020, 1, 1, 10, 25)),
      Leg(id: 3, name: 'Uber', startTime: DateTime(2020, 1, 1, 10, 30), endTime: DateTime(2020, 1, 1, 10, 40)),
    ]),
  ];

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
                fromDate: fromDate,
                toDate: toDate,
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
  final DateTime fromDate;
  final DateTime toDate;
  final List<Trip> trips;

  int viewRange;
  int viewRangeToFitScreen = 60;
  Animation<double> width;

  GanttChart({
    this.animationController,
    this.fromDate,
    this.toDate,
    @required this.trips,
  }) {
    assert(this.trips != null);
    viewRange = calculateNumberOfMinutesBetween(fromDate, toDate);
  }

  DateTime nextMonth(DateTime dt) {
    var year = dt.year;
    var month = dt.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  Color randomColorGenerator() {
    var r = new Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateNumberOfMinutesBetween(DateTime from, DateTime to) {
    //return to.month - from.month + 12 * (to.year - from.year) + 1;
    return to.difference(from).inMinutes;
  }

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
      List<Leg> data, double chartViewWidth, Color color) {
    List<Widget> chartBars = [];

    for(int i = 0; i < data.length; i++) {
      var remainingWidth =
      calculateRemainingWidth(data[i].startTime, data[i].endTime);
      print(remainingWidth);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: color.withAlpha(100),
              borderRadius: BorderRadius.circular(10.0)),
          height: 25.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(data[i].startTime) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == data.length - 1 ? 4.0 : 2.0
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              data[i].name,
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
      width: chartViewWidth / viewRangeToFitScreen,
      child: new Text(
        'NAME',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
    ));

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(Container(
        width: chartViewWidth / viewRangeToFitScreen,
        child: new Text(
          " ", //tempDate.month.toString() + '/' + tempDate.year.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
      ));
      tempDate = nextMonth(tempDate);
    }

    return Container(
      height: 25.0,
      color: color.withAlpha(100),
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
    Color color = randomColorGenerator();
    var chartBars = buildChartBars(trip.legs, chartViewWidth, color);
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
                                      trip.name,
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


/*var projects = [
  Leg(id: 1, name: 'Basetax', startTime: DateTime(2020, 1, 1, 10, 0), endTime: DateTime(2020, 1, 1, 10, 25)
  ),
  /*Project(id: 2, name: 'CENTTO', startTime: DateTime(2018, 4, 1), endTime: DateTime(2018, 6, 1),
      participants: [2, 3]
  ),*/
  Leg(id: 3, name: 'Uber', startTime: DateTime(2020, 1, 1, 10, 30), endTime: DateTime(2020, 1, 1, 10, 40)
  ),
  /*Project(id: 4, name: 'Grab', startTime: DateTime(2018, 6, 1), endTime: DateTime(2018, 10, 1),
      participants: [1, 4, 3]
  ),
  Project(id: 5, name: 'GO-JEK', startTime: DateTime(2017, 3, 1), endTime: DateTime(2018, 11, 1),
      participants: [4, 2, 3]
  ),
  Project(id: 6, name: 'Lyft', startTime: DateTime(2018, 4, 1), endTime: DateTime(2018, 7, 1),
      participants: [4, 2, 3]
  ),
  Project(id: 7, name: 'San Jose', startTime: DateTime(2018, 5, 1), endTime: DateTime(2018, 12, 1),
      participants: [1, 2, 4]
  ),*/
];*/
