import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtt.dart';

extension GrimaudTransportKind on TransportKind {
  String get URL {
    switch (this) {
      case TransportKind.RER:
        return "rers";
      case TransportKind.METRO:
        return "metros";
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
  static const nameToSlug = {
    'Villejuif-Louis Aragon': 'villejuif+louis+aragon',
    'Villejuif - Louis Aragon': 'villejuif+++louis+aragon',
  };
  String get URL {
    final String? url = nameToSlug[this.name];
    if (url is String) return url;
    throw Exception("Unknown station name = ${this.name}");
  }
}

class GrimaudAPI extends RTAPI {
  final http.Client client;
  GrimaudAPI() : client = http.Client();
  GrimaudAPI.withClient(this.client);

  @override
  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction) async {
    final http.Response resp = await callApi(['schedules', transport.URL, station.URL, direction.URL]);
    if (resp.statusCode != 200) throw ("Http error: Received status code ${resp.statusCode}");
    switch (transport.kind) {
      /*case TransportKind.RER:
        return _parseRERResponse(resp.body);
      case TransportKind.METRO:
        return _parseMETROResponse(resp.body);*/
      case TransportKind.BUS:
        final List<DateTime> schedules = parseBusResponse(resp.body);
        return schedules.map((time) => Schedule(transport, station, direction, time)).toList();
      default:
        throw "Can't get schedules for ${transport.kind}";
    }
  }

  @visibleForTesting
  List<DateTime> parseBusResponse(String body) {
    final b = jsonDecode(body);
    final rawSchedules = b['result']['schedules'];
    List<DateTime> times = [];
    for (final rawSchedule in rawSchedules) {
      Duration? d = _parseBusSchedule(rawSchedule['message']);
      if (d != null) {
        times.add(DateTime.now().add(d));
      }
    }
    return times;
  }

  Duration? _parseBusSchedule(String msg) {
    if (msg == "A l'arret") return Duration(minutes: 0);
    if (msg == "A l'approche") return Duration(minutes: 1);

    Match? m = RegExp(r'^(\d+) mn$').matchAsPrefix(msg);
    if (m is Match) return Duration(minutes: int.parse(m[1]!));
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
