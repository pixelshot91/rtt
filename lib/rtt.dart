import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:quiver/core.dart';
import 'package:rtt/rtapi/api.dart';

enum TransportKind {
  RER,
  METRO,
  BUS,
  WALK,
}

var transportKindNames = {
  TransportKind.RER: "RER",
  TransportKind.METRO: "Metro",
  TransportKind.BUS: "Bus",
  TransportKind.WALK: "Walk",
};

class Transport {
  TransportKind kind;
  String line;

  String get name => transportKindNames[kind]! + ' ' + line;

  Transport(this.kind, this.line);

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

final trip_172_rerb = TripRequest(legs: [
  LegRequest(Transport(TransportKind.BUS, "172"), Station('Villejuif - Louis Aragon'), Station("Opera"), Direction.B,
      duration: Duration(minutes: 20)),
  LegRequest(Transport(TransportKind.RER, "B"), Station('Bourg-la-Reine'), Station('Massy-Verrieres'), Direction.B,
      duration: Duration(minutes: 10)),
]);

final trip_286_antony = TripRequest(legs: [
  LegRequest(Transport(TransportKind.BUS, "286"), Station('Les Bons Enfants'), Station('Antony RER'), Direction.A,
      duration: Duration(minutes: 30)),
  LegRequest(Transport(TransportKind.RER, "B"), Station('Antony RER'), Station('Massy-Verrieres'), Direction.B,
      duration: Duration(minutes: 5)),
]);

/*final trip_m7_rera = TripRequest(legs: [
  LegRequest(Transport(TransportKind.METRO, "7"), Station('Villejuif-Louis Aragon'), Station('Opera'), Direction.A, duration: Duration(minutes: 25)),
  LegRequest(Transport(TransportKind.WALK, ""), "Opera", "Auber", Direction.A, duration: Duration(minutes: 5)),
  LegRequest(Transport(TransportKind.RER, "A"), "Auber", "Rueil", Direction.A, duration: Duration(minutes: 20)),
]);*/

final tripsRequest = [trip_172_rerb, trip_286_antony];

class Station {
  String name;
  Station(this.name);

  bool operator ==(o) => o is Station && name == o.name;
  int get hashCode => name.hashCode;
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
  String? mission;

  Schedule(this.transport, this.station, this.direction, this.time, [this.mission]);

  @override
  String toString() => 'Schedule(transport: $transport, station: $station, direction: $direction, time: $time)';
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
    await for (Schedule s in findSchedules(request.transport, request.from, request.direction, departure)) {
      yield SuggestedLeg(request, schedule: s);
    }
  }

  Stream<Schedule> findSchedules(Transport t, Station from, Direction d, DateTime departure) async* {
    if (t.kind == TransportKind.WALK) {
      // TODO: Make Schedule more adapted to walking
      yield Schedule(Transport(TransportKind.WALK, ""), from, d, departure);
      return;
    }

    final schedules = await api.getSchedule(t, from, d);
    for (var s in schedules) {
      // TODO: Ignore if schedule.mission doesn't go to Station to
      if (s.time.isAfter(departure)) {
        yield s;
      }
    }
  }
}
