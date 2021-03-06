import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:quiver/core.dart';
import 'package:rtt/rtapi/api.dart';

enum TransportKind {
  RER,
  METRO,
  TRAM,
  BUS,
  WALK,
}

var transportKindNames = {
  TransportKind.RER: "RER",
  TransportKind.METRO: "Metro",
  TransportKind.TRAM: "Tram",
  TransportKind.BUS: "Bus",
  TransportKind.WALK: "Walk",
};

class Transport {
  TransportKind kind;
  String line;

  String get name => transportKindNames[kind]! + ' ' + line;

  Transport(this.kind, this.line);

  @override
  String toString() => name;

  bool operator ==(o) => o is Transport && kind == o.kind && line == o.line;
  int get hashCode => hash2(kind, line);
}

class TripRequest {
  List<LegRequest> legs;

  TripRequest({required this.legs});

  @override
  String toString() => "Trip :\n" + legs.join("\n");

  @visibleForTesting
  @override
  bool operator ==(Object o) => o is TripRequest && ListEquality().equals(legs, o.legs);
}

class SuggestedTrip {
  List<SuggestedLeg> legs;

  SuggestedTrip({required this.legs});

  Duration get duration => legs.last.endTime.difference(legs.first.startTime);

  @override
  String toString() => "Trip :\n" + legs.join("\n");

  @override
  bool operator ==(Object o) => o is SuggestedTrip && ListEquality().equals(legs, o.legs);
}

// TODO: create LegRequirements and SuggestedLeg
class LegRequest {
  Transport transport;
  Station from;
  Station to;
  Direction direction;
  Duration duration;

  LegRequest(this.transport, this.from, this.to, this.direction, {required this.duration});

  @override
  String toString() {
    String s = "";
    s += transport.name + ' from ' + from.name + ' to ' + to.name + '(dir: ' + direction.toString() + ')';
    return s;
  }

  @override
  bool operator ==(Object o) =>
      o is LegRequest &&
      transport == o.transport &&
      from == o.from &&
      to == o.to &&
      direction == o.direction &&
      duration == o.duration;
}

class SuggestedLeg extends LegRequest {
  Schedule schedule;

  SuggestedLeg(LegRequest l, {required this.schedule})
      : super(l.transport, l.from, l.to, l.direction, duration: l.duration);

  DateTime get startTime => schedule.time;
  DateTime get endTime => schedule.time.add(duration);

  @override
  String toString() {
    String s = "";
    s += transport.name + ' from ' + from.name + ' to ' + to.name + '(dir: ' + direction.toString() + ')';
    s += ", " + DateFormat('Hm').format(startTime) + " -> " + DateFormat('Hm').format(endTime);
    return s;
  }
}

final walk = (duration) =>
    LegRequest(Transport(TransportKind.WALK, ""), Station(''), Station(''), Direction.B, duration: duration);

final trip_172_rerb = TripRequest(legs: [
  LegRequest(Transport(TransportKind.BUS, "172"), Station('Villejuif - Louis Aragon'), Station("Opera"), Direction.B,
      duration: Duration(minutes: 20)),
  LegRequest(Transport(TransportKind.RER, "B"), Station('Bourg-la-Reine'), Station('Massy Verrieres'), Direction.B,
      duration: Duration(minutes: 10)),
  walk(Duration(minutes: 10)),
]);

final trip_286_rerb = TripRequest(legs: [
  LegRequest(Transport(TransportKind.BUS, "286"), Station('Les Bons Enfants'), Station('Antony RER'), Direction.A,
      duration: Duration(minutes: 30)),
  LegRequest(Transport(TransportKind.RER, "B"), Station('Antony'), Station('Massy Verrieres'), Direction.B,
      duration: Duration(minutes: 5)),
  walk(Duration(minutes: 10)),
]);

final trip_t7_tvm_rerb = TripRequest(legs: [
  LegRequest(Transport(TransportKind.TRAM, '7'), Station('Lamartine'),
      Station('Porte de Thiais (Marche International)'), Direction.A,
      duration: Duration(minutes: 7)),
  LegRequest(
      Transport(TransportKind.BUS, 'TVM'), Station('Porte de Thiais'), Station('La Croix de Berny-RER'), Direction.B,
      duration: Duration(minutes: 22)),
  LegRequest(Transport(TransportKind.RER, "B"), Station('Antony'), Station('Massy Verrieres'), Direction.B,
      duration: Duration(minutes: 5)),
  walk(Duration(minutes: 10)),
]);

/*final trip_m7_rera = TripRequest(legs: [
  LegRequest(Transport(TransportKind.METRO, "7"), Station('Villejuif-Louis Aragon'), Station('Opera'), Direction.A, duration: Duration(minutes: 25)),
  LegRequest(Transport(TransportKind.WALK, ""), "Opera", "Auber", Direction.A, duration: Duration(minutes: 5)),
  LegRequest(Transport(TransportKind.RER, "A"), "Auber", "Rueil", Direction.A, duration: Duration(minutes: 20)),
]);*/

final tripsRequest = [trip_172_rerb, trip_286_rerb, trip_t7_tvm_rerb];

class Station {
  String name;
  Station(this.name);

  @override
  String toString() => name;

  bool operator ==(o) => o is Station && name == o.name;
  int get hashCode => name.hashCode;

  Station.fromJson(Map<String, dynamic> json) : name = json['name'];
  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

enum Direction {
  A,
  B,
}

class Schedule {
  Transport transport;
  Station station;
  Direction direction;
  DateTime time;

  Schedule(this.transport, this.station, this.direction, this.time);

  @override
  String toString() => 'Schedule($transport from $station ($direction) at $time)';
}

class RERSchedule extends Schedule {
  String mission;

  RERSchedule(transport, station, direction, time, this.mission)
      : assert(transport.kind == TransportKind.RER),
        super(transport, station, direction, time);

  @override
  String toString() => 'Schedule($transport from $station ($direction) at $time, mission = $mission)';
}

class BUSSchedule extends Schedule {
  Station terminus;

  BUSSchedule(transport, station, direction, time, this.terminus)
      : assert(transport.kind == TransportKind.BUS),
        super(transport, station, direction, time);

  @override
  String toString() => 'Schedule($transport from $station ($direction) at $time, terminus = $terminus)';
}

class RTT {
  final RTAPI api;
  final margin;

  RTT(this.api, {this.margin = const Duration(minutes: 31)});

  Stream<SuggestedTrip> suggestTrips(List<TripRequest> requests, DateTime departure) async* {
    for (final request in requests) {
      await for (final suggestedTrip in suggestTrip(request, departure)) {
        yield suggestedTrip;
      }
    }
  }

  Stream<SuggestedTrip> suggestTrip(TripRequest request, DateTime departure) async* {
    List<LegRequest> rest = request.legs.length > 1 ? request.legs.sublist(1) : [];
    DateTime? best;
    await for (SuggestedLeg first in suggestLegs(request.legs.first, departure)) {
      if (best != null && first.endTime.isAfter(best.add(margin))) {
        break;
      }
      if (rest.isEmpty) {
        yield SuggestedTrip(legs: [first]);
        continue;
      }
      var suggestRests = suggestTrip(TripRequest(legs: rest), first.endTime);
      await for (SuggestedTrip suggestRest in suggestRests) {
        final endTime = suggestRest.legs.last.endTime;
        if (best == null || best.isAfter(endTime)) {
          best = endTime;
        } else if (endTime.isAfter(best.add(margin))) {
          break;
        }
        yield SuggestedTrip(legs: [first, ...suggestRest.legs]);
      }
    }
  }

  Stream<SuggestedLeg> suggestLegs(LegRequest request, DateTime departure) async* {
    await for (Schedule s in findSchedules(request.transport, request.from, request.to, request.direction, departure)) {
      yield SuggestedLeg(request, schedule: s);
    }
  }

  Future<bool> scheduleStopAt(Schedule s, Station to) async {
    switch (s.transport.kind) {
      case TransportKind.RER:
        return await api.doesMissionStopAt(s as RERSchedule, to);
      case TransportKind.BUS:
      /* TODO: Need an ordered list of station. Grimaud list is not in order
        List<Station> stations = await api.getStationsOfLine(s.transport, s.direction);
        return stations.indexOf(to) <= stations.indexOf((s as BUSSchedule).terminus);*/
      case TransportKind.METRO:
      case TransportKind.TRAM:
      case TransportKind.WALK:
        return true;
    }
  }

  Stream<Schedule> findSchedules(Transport t, Station from, Station to, Direction d, DateTime departure) async* {
    if (t.kind == TransportKind.WALK) {
      // TODO: Make Schedule more adapted to walking
      yield Schedule(Transport(TransportKind.WALK, ""), from, d, departure);
      return;
    }

    final schedules = await api.getSchedule(t, from, d);
    for (var s in schedules) {
      if (!await scheduleStopAt(s, to)) {
        print("Ignoring Schedule $s because it does not stop at $to");
        continue;
      }
      if (s.time.isAfter(departure)) {
        yield s;
      }
    }
  }
}
