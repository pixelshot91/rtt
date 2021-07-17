import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtt.dart';
import 'package:rtt/ui.dart';
import 'package:timer_builder/timer_builder.dart';
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
  static final Azur = myColor.fromRGB(0, 85, 200);
  static final Bleu_outremer = myColor.fromRGB(60, 145, 220);
  static final Coquelicot = myColor.fromRGB(255, 20, 0);
  static final Lilas = myColor.fromRGB(210, 130, 190);
  static final Marron = myColor.fromRGB(90, 35, 10);
  static final Rose = myColor.fromRGB(255, 130, 180);
  static final Vert_fonce = myColor.fromRGB(0, 100, 60);
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
  Tuple2(TransportKind.TRAM, "7"): LineInfo(RATPColors.Marron, "T7"),
  Tuple2(TransportKind.BUS, "172"): LineInfo(RATPColors.Vert_fonce, "172"),
  Tuple2(TransportKind.BUS, "286"): LineInfo(RATPColors.Lilas, "286"),
  Tuple2(TransportKind.BUS, "TVM"): LineInfo(RATPColors.Azur, "TVM"),
};

extension UI on Transport {
  LineInfo? get lineInfo => LineInfos[Tuple2(kind, line)];

  Color get color => lineInfo?.color ?? Colors.grey;

  Widget get picto {
    switch (kind) {
      case TransportKind.WALK:
        return Icon(Icons.directions_walk);
      default:
        return lineInfo?.picto ?? Text('');
    }
  }
}

extension GantLeg on SuggestedLeg {
  String getLabel() {
    var label = transport.name;
    if (transport.kind == TransportKind.RER) {
      label += ' ' + (schedule as RERSchedule).mission;
    }
    if (transport.kind == TransportKind.BUS) {
      label += ' - ' + (schedule as BUSSchedule).terminus.name;
    }
    return label;
  }
}

const legBarHeight = 25.0;

// From https://github.com/beesightsoft/bss_flutter_open/blob/master/lib/calendar_demo/gantt_chart/gantt_chart_screen.dart
class GanttChartScreen extends StatefulWidget {
  final Stream<SuggestedTrip> trips;

  GanttChartScreen(this.trips);

  @override
  State<StatefulWidget> createState() {
    return GanttChartScreenState(trips);
  }
}

class GanttChartScreenState extends State<GanttChartScreen> with TickerProviderStateMixin {
  final Stream<SuggestedTrip> tripsStream;
  List<SuggestedTrip> trips = [];
  bool streamDone = false;

  GanttChartScreenState(this.tripsStream);

  @override
  void initState() {
    super.initState();

    tripsStream.listen(
      (t) => setState(() => this.trips.add(t)),
      onDone: () => setState(() => this.streamDone = true),
    );
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
    if (trips.isEmpty) return Text("No trip found");
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

  final DateTime fromDate = DateTime.now();
  final DateTime toDate;
  final List<SuggestedTrip> trips;

  final double minuteWidth = 20;

  GanttChart({required this.trips})
      : toDate = trips.fold(trips.first.legs.last.endTime,
            (oldMax, t) => t.legs.last.endTime.isAfter(oldMax) ? t.legs.last.endTime : oldMax);

  int get viewRange => toDate.difference(fromDate).inMinutes;
  static int calculateNumberOfMinutesBetween(DateTime from, DateTime to) => to.difference(from).inMinutes;

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else
      return calculateNumberOfMinutesBetween(fromDate, projectStartedAt);
  }

  int calculateRemainingWidth(DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength = calculateNumberOfMinutesBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.compareTo(fromDate) >= 0 && projectStartedAt.compareTo(toDate) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange - calculateNumberOfMinutesBetween(fromDate, projectStartedAt);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(toDate)) {
      return projectLength - calculateNumberOfMinutesBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isAfter(toDate)) {
      return viewRange;
    }
    return 0;
  }

  List<Widget> buildChartBars(List<SuggestedLeg> legs, double chartViewWidth) {
    List<Widget> chartBars = [];

    for (int i = 0; i < legs.length; i++) {
      var remainingWidth = calculateRemainingWidth(legs[i].startTime, legs[i].endTime);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
            color: legs[i].transport.color.fade(0.4),
            borderRadius: BorderRadius.circular(99.0),
          ),
          height: legBarHeight,
          width: remainingWidth * minuteWidth,
          margin: EdgeInsets.only(left: calculateDistanceToLeftBorder(legs[i].startTime) * minuteWidth),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              legs[i].transport.picto,
              Text(
                ' ' + legs[i].getLabel(),
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

    final int intervalMinutes = 5;
    DateTime tempDate = alignDateTime(fromDate, Duration(minutes: 5), true);
    headerItems.add(Container(
      width: 3 * minuteWidth,
    ));

    // Initial container is smaller to align to intervalMinutes
    headerItems.add(Container(
      width: tempDate.difference(fromDate).inMinutes * minuteWidth,
    ));

    // TODO: center time on line
    for (int i = 0; i < viewRange / intervalMinutes; i++) {
      headerItems.add(Container(
        width: intervalMinutes * minuteWidth,
        child: new Text(
          DateFormat("Hm").format(tempDate),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: tempDate.minute == 0 ? 12.0 : 10.0,
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

  Widget buildChartForAllTrips(List<SuggestedTrip> trips, double chartViewWidth) {
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

  Widget buildChartForEachTrip(SuggestedTrip trip, double chartViewWidth) {
    var chartBars = buildChartBars(trip.legs, chartViewWidth);
    return Row(
      children: <Widget>[
        Container(
          width: 3 * minuteWidth,
          height: legBarHeight + 10,
          color: legendBackgroundColor,
          child: Center(
            child: Text(
              trip.duration.inMinutes.toString() + " min",
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
