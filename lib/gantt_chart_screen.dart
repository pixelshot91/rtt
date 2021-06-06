import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rtt/rtt.dart';
import 'package:rtt/ui.dart';
import 'package:tuple/tuple.dart';

extension myColor on Color {
  static Color fromRGB(int r, int g, int b) => Color.fromARGB(255, r, g, b);

  Color fade(double f) => Color.fromARGB(
        this.alpha,
        _helperFade(this.red, f),
        _helperFade(this.green, f),
        _helperFade(this.blue, f),
      );

  int _helperFade(int c, double f) => 255 - ((255 - c) * f).toInt();
}

class RATPColors {
  static final Coquelicot = myColor.fromRGB(255, 20, 0);
  static final Bleu_outremer = myColor.fromRGB(60, 145, 220);
  static final Vert_fonce = myColor.fromRGB(0, 100, 60);
  static final Rose = myColor.fromRGB(255, 130, 180);
}

class LineInfo {
  Color color;
  SvgPicture picto;

  LineInfo(this.color, String pictoId)
      : picto = SvgPicture.asset("picto/" + pictoIdToName[pictoId]!, height: legBarHeight);
}

final LineInfos = {
  Tuple2(TransportKind.RER, "A"): LineInfo(RATPColors.Coquelicot, "RER A"),
  Tuple2(TransportKind.RER, "B"): LineInfo(RATPColors.Bleu_outremer, "RER B"),
  Tuple2(TransportKind.METRO, "7"): LineInfo(RATPColors.Rose, "M7"),
  Tuple2(TransportKind.BUS, "172"): LineInfo(RATPColors.Vert_fonce, "172"),
};

extension UI on Transport {
  LineInfo? get lineInfo => LineInfos[Tuple2(kind, line)];

  Color get color => lineInfo?.color ?? Colors.grey;

  SvgPicture get picto => lineInfo?.picto ?? SvgPicture.asset("");
/*String get pictoPath => pictoIdToPath[id];
  String get id {
    switch (kind) {
      case TransportKind.RER:
        return "RER " + name;
      case TransportKind.METRO:
        return "M" + name;
      case TransportKind.BUS:
        return name;
    }
  }*/
}

const legBarHeight = 25.0;

class GanttChartScreen extends StatefulWidget {
  final Stream<Trip> trips;

  GanttChartScreen(this.trips);

  @override
  State<StatefulWidget> createState() {
    return new GanttChartScreenState(trips);
  }
}

class GanttChartScreenState extends State<GanttChartScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  final Stream<Trip> tripsStream;
  List<Trip> trips = [];
  bool streamDone = false;

  GanttChartScreenState(this.tripsStream);

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(duration: Duration(microseconds: 2000), vsync: this);
    animationController!.forward();

    tripsStream.listen((t) {
      setState(() {
        this.trips.add(t);
      });
    }, onDone: () => streamDone = true);
  }

  Widget buildAppBar() {
    List<Widget> widgets = [Text('Suggested Trips ')];
    if (!streamDone) widgets.add(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)));
    return AppBar(
      title: Row(children: widgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return Text("No trip found");
    }
    return Scaffold(
      appBar: buildAppBar() as PreferredSizeWidget?,
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
  final legendBackgroundColor = Colors.grey.shade400;

  final AnimationController? animationController;
  DateTime fromDate = DateTime.now();
  DateTime? toDate;
  final List<Trip> trips;

  late int viewRange;
  double minuteWidth = 15;
  Animation<double>? width;

  GanttChart({
    this.animationController,
    required this.trips,
  }) {
    assert(this.trips.isNotEmpty);

    trips.forEach((t) {
      final maybeEnd = t.legs.last.endTime;
      if (maybeEnd != null && (toDate == null || maybeEnd.isAfter(toDate!))) {
        toDate = maybeEnd;
      }
    });
    viewRange = calculateNumberOfMinutesBetween(fromDate, toDate!);
  }

  int calculateNumberOfMinutesBetween(DateTime from, DateTime to) => to.difference(from).inMinutes;

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else
      return calculateNumberOfMinutesBetween(fromDate, projectStartedAt);
  }

  int calculateRemainingWidth(DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength = calculateNumberOfMinutesBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.compareTo(fromDate) >= 0 && projectStartedAt.compareTo(toDate!) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange - calculateNumberOfMinutesBetween(fromDate, projectStartedAt);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(toDate!)) {
      return projectLength - calculateNumberOfMinutesBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isAfter(toDate!)) {
      return viewRange;
    }
    return 0;
  }

  List<Widget> buildChartBars(List<Leg> legs, double chartViewWidth) {
    List<Widget> chartBars = [];

    for (int i = 0; i < legs.length; i++) {
      var remainingWidth = calculateRemainingWidth(legs[i].startTime!, legs[i].endTime!);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
            color: legs[i].transport.color.fade(0.4),
            borderRadius: BorderRadius.circular(99.0),
          ),
          height: legBarHeight,
          width: remainingWidth * minuteWidth,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(legs[i].startTime!) * minuteWidth,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == legs.length - 1 ? 4.0 : 2.0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              legs[i].transport.picto,
              Text(
                ' ' + legs[i].transport.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.0),
              ),
            ],
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
      width: 3 * minuteWidth,
      child: new Text(
        ' ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
    ));
    int intervalMinutes = 5;
    for (int i = 0; i < viewRange / intervalMinutes; i++) {
      headerItems.add(Container(
        width: intervalMinutes * minuteWidth,
        child: new Text(
          DateFormat("Hm").format(tempDate),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: tempDate.minute == 0 ? FontWeight.bold : null,
          ),
        ),
      ));
      tempDate = tempDate.add(Duration(minutes: intervalMinutes));
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

    for (int i = 0; i <= viewRange + 1; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.withAlpha(100), width: 1.0))),
        width: minuteWidth,
        //height: 300.0,
      ));
    }

    return Row(
      children: gridColumns,
    );
  }

  Widget buildChartForAllTrips(List<Trip> trips, double chartViewWidth) {
    var tripsBar = trips.map((t) => buildChartForEachTrip(t, chartViewWidth)).toList();
    return Container(
      //height: trips.length * 29.0 + 25.0 + 4.0,
      child: ListView(
        physics: new ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(fit: StackFit.loose, children: <Widget>[
            buildGrid(chartViewWidth),
            buildHeader(chartViewWidth, legendBackgroundColor),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              child: Column(
                children: tripsBar,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget buildChartForEachTrip(Trip trip, double chartViewWidth) {
    var chartBars = buildChartBars(trip.legs, chartViewWidth);
    return Row(
      children: <Widget>[
        Container(
          width: 3 * minuteWidth,
          height: chartBars.length * 29.0 + 4.0,
          color: legendBackgroundColor,
          child: Center(
            child: Text(
              trip.duration!.inMinutes.toString() + " min",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: chartBars,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var chartViewWidth = MediaQuery.of(context).size.width;
    var screenOrientation = MediaQuery.of(context).orientation;

    /*screenOrientation == Orientation.landscape
        ? viewRangeToFitScreen = 12
        : viewRangeToFitScreen = 6;*/

    return Container(
      child: MediaQuery.removePadding(
        child: buildChartForAllTrips(trips, chartViewWidth),
        removeTop: true,
        context: context,
      ),
    );
    /*return Container(
      child: MediaQuery.removePadding(child: ListView(
          children: buildChartContent(chartViewWidth)
      ), removeTop: true, context: context,),
    );*/
  }
}
