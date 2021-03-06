import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtt.dart';
import 'package:rtt/tools/datetime.dart';

// This API use the RATP API and expose the data as REST resources.
// Git repo: https://github.com/pgrimaud/ratp-api-rest/

extension GrimaudTransportKind on TransportKind {
  String get URL {
    switch (this) {
      case TransportKind.RER:
        return "rers";
      case TransportKind.METRO:
        return "metros";
      case TransportKind.TRAM:
        return "tramways";
      case TransportKind.BUS:
        return "buses";
      default:
        throw "Can't get schedules for $this";
    }
  }
}

extension GrimaudTransport on Transport {
  String get URL => this.kind.URL + '/${this.line}';
}

extension GrimaudDirection on Direction {
  String get URL {
    switch (this) {
      case Direction.A:
        return 'A';
      case Direction.B:
        return 'R';
    }
  }
}

extension GrimaudStation on Station {
  // From src/Utils/NameHelper:slugify
  String getSlug() => name.replaceAll(RegExp('[ -]'), '+').toLowerCase();
  String get URL {
    final String? url = getSlug();
    if (url is String) return url;
    throw Exception("Unknown station name = ${this.name}");
  }
}

class GrimaudAPI extends RTAPI {
  final http.Client client;
  GrimaudAPI({Duration? maxCacheLife})
      : client = http.Client(),
        super(maxCacheLife: maxCacheLife);
  GrimaudAPI.withClient(this.client, {Duration? maxCacheLife}) : super(maxCacheLife: maxCacheLife);

  @override
  Future<List<Station>> getStationsServedByMissionNoCache(RERSchedule s) async {
    final http.Response resp = await callApi(['missions', s.transport.URL, s.mission]);
    if (resp.statusCode != 200) throw ("Http error: Received status code ${resp.statusCode}");

    return parseStationsFromBody(resp.body);
  }

  @visibleForTesting
  List<Station> parseStationsFromBody(String body) {
    final b = jsonDecode(body);
    final rawStations = b['result']['stations'];

    List<Station> stations = [];
    for (final rawStation in rawStations) {
      stations.add(Station(rawStation['name']));
    }
    return stations;
  }

  @override
  Future<List<Station>> getStationsOfLineNoCache(Transport transport) async {
    final http.Response resp = await callApi(['stations', transport.URL]);
    if (resp.statusCode != 200) throw ("Http error: Received status code ${resp.statusCode}");

    final stations = parseStationsFromBody(resp.body);
    bool shouldReverse = false;
    if (transport.kind == TransportKind.RER || transport.kind == TransportKind.TRAM) {
      shouldReverse = !shouldReverse;
    }
    return shouldReverse ? stations.reversed.toList() : stations;
  }

  @visibleForTesting
  @override
  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction) async {
    final http.Response resp = await callApi(['schedules', transport.URL, station.URL, direction.URL]);
    if (resp.statusCode != 200) throw ("Http error: Received status code ${resp.statusCode}");

    return parseSchedulesFromBody(resp.body, transport, station, direction);
  }

  List<Schedule> parseSchedulesFromBody(String body, Transport transport, Station station, Direction direction) {
    final b = jsonDecode(body);
    final rawSchedules = b['result']['schedules'];

    List<Schedule> schedules = [];
    for (final rawSchedule in rawSchedules) {
      Schedule? s = parseScheduleFromRawMessage(rawSchedule, transport, station, direction);
      if (s != null) schedules.add(s);
    }
    return schedules;
  }

  @visibleForTesting
  Schedule? parseScheduleFromRawMessage(rawSchedule, Transport transport, Station station, Direction direction) {
    DateTime? time = parseTimeMsg(rawSchedule['message']);

    if (time == null) return null;

    switch (transport.kind) {
      case TransportKind.RER:
        return RERSchedule(transport, station, direction, time, rawSchedule['code']);
      case TransportKind.BUS:
        return BUSSchedule(transport, station, direction, time, Station(rawSchedule['destination']));
      case TransportKind.TRAM:
      case TransportKind.METRO:
        return Schedule(transport, station, direction, time);
    }
  }

  @visibleForTesting
  DateTime? parseTimeMsg(String msg) {
    if (msg.startsWith("Train ?? quai") ||
        msg.startsWith('Train ???? quai') ||
        msg == "A l'arret" ||
        msg == "Train a quai" ||
        msg.startsWith('Voie ') ||
        msg.startsWith('Stationne')) return DateTime.now();

    if (RegExp(r"l'approche").hasMatch(msg)) return DateTime.now().add(Duration(minutes: 1));

    // Relative time
    {
      Match? m = RegExp(r'^(\d+) mn$').matchAsPrefix(msg);
      if (m is Match) return DateTime.now().add(Duration(minutes: int.parse(m[1]!)));
    }

    // Absolute time
    // TODO: handle time after midnight
    {
      Match? m = RegExp(r'^(\d+):(\d+)').matchAsPrefix(msg);
      if (m is Match) return todayWithTime(int.parse(m[1]!), int.parse(m[2]!));
    }

    // Know message that shoud be ignored
    if (RegExp(r'^Train sans arr.*t').hasMatch(msg) ||
        RegExp(r'^Sans arr.*t').hasMatch(msg) ||
        msg.startsWith('Sans voyageurs') ||
        msg == 'PAS DE SERVICE' ||
        msg == '..................' ||
        msg.startsWith('Train retard') ||
        msg.startsWith('Supprim') ||
        msg == "DERNIER PASSAGE" ||
        RegExp(r'^D.*part Retard.*').hasMatch(msg)) return null;

    // TODO: Should be treated as an error ?
    if (msg == "Schedules unavailable") {
      return null;
    }

    print("Can't parse $msg");
    throw "Can't parse $msg";
  }

  @visibleForTesting
  Future<http.Response> callApi(List<dynamic> args) async {
    const baseUrl = 'https://api-ratp.pierre-grimaud.fr/v4/';
    final url = baseUrl + args.join('/');
    print("GET on $url");
    final response = await client.get(Uri.parse(url));
    print("Response (${response.statusCode}):\n ${response.body}");
    return response;
  }
}
