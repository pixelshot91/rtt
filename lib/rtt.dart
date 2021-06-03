import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

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
}

class Trip {
  List<Leg> legs;

  Trip({required this.legs});

  Duration? get duration => legs.last.endTime?.difference(legs.first.startTime!);

  @override
  String toString() => "Trip :\n" + legs.join("\n");
}

// TODO: create LegRequirements and SuggestedLeg
class Leg {
  Transport transport;
  String locFrom;
  String locTo;
  Duration? duration;
  DateTime? startTime;

  Leg(this.transport, this.locFrom, this.locTo, {this.duration, this.startTime});

  DateTime? get endTime => startTime?.add(duration!);

  Leg copyWith({DateTime? startTime}) => Leg(
    this.transport,
    this.locFrom,
    this.locTo,
    duration: this.duration,
    startTime: startTime ?? this.startTime,
  );

  @override
  String toString() {
    String s = "";
    s += transport.name;
    s += ", " + (startTime == null ? "?" : DateFormat('Hm').format(startTime!));
    s += " -> " + (endTime == null ? "?" : DateFormat('Hm').format(endTime!));
    return s;
  }
}


final tripRequest = Trip(legs: [
  Leg(Transport(TransportKind.METRO, "7"), "VJ", "Opera", duration: Duration(minutes: 25)),
  Leg(Transport(TransportKind.WALK, ""), "Opera", "Auber", duration: Duration(minutes: 5)),
  Leg(Transport(TransportKind.RER, "A"), "Auber", "Rueil", duration: Duration(minutes: 20)),
]);


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