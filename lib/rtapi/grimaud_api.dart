import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rtt/rtapi/api.dart';
import 'package:rtt/rtt.dart';
import 'package:rtt/tools/datetime.dart';

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
    // M7
    'Villejuif-Louis Aragon': 'villejuif+louis+aragon',
    // B172
    'Villejuif - Louis Aragon': 'villejuif+++louis+aragon',
    'Bourg-La-Reine RER': 'bourg+la+reine+rer',
    // B286
    'Les Bons Enfants': 'les+bons+enfants',
    'Antony RER': 'antony+rer',
    // RERB
    'Bourg-la-Reine': 'bourg+la+reine',
    'Antony': 'antony',
    'Massy-Verrieres': 'massy+verrieres',
  };
  String get URL {
    final String? url = nameToSlug[this.name];
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
  Future<List<Schedule>> getScheduleNoCache(Transport transport, Station station, Direction direction) async {
    final http.Response resp = await callApi(['schedules', transport.URL, station.URL, direction.URL]);
    if (resp.statusCode != 200) throw ("Http error: Received status code ${resp.statusCode}");
    switch (transport.kind) {
      case TransportKind.RER:
        return parseRERResponse(resp.body).map((time) => Schedule(transport, station, direction, time)).toList();
      case TransportKind.METRO:
      case TransportKind.BUS:
        final List<DateTime> schedules = parseBusMetroResponse(resp.body);
        return schedules.map((time) => Schedule(transport, station, direction, time)).toList();
      default:
        throw "Can't get schedules for ${transport.kind}";
    }
  }

  @visibleForTesting
  List<DateTime> parseRERResponse(String body) {
    final b = jsonDecode(body);
    final rawSchedules = b['result']['schedules'];
    List<DateTime> times = [];
    for (final rawSchedule in rawSchedules) {
      DateTime? d = _parseRERSchedule(rawSchedule['message']);
      if (d != null) {
        times.add(d);
      }
    }
    return times;
  }

  DateTime? _parseRERSchedule(String msg) {
    if (msg.startsWith("Train à quai") || msg.startsWith('Train Ã  quai')) return DateTime.now();
    if (msg.startsWith("A l'approche") || msg.startsWith("Train à l'approche") || msg.startsWith("Train Ã  l'approche"))
      return DateTime.now().add(Duration(minutes: 1));

    Match? m = RegExp(r'^(\d+):(\d+)').matchAsPrefix(msg);
    if (m is Match) return todayWithTime(int.parse(m[1]!), int.parse(m[2]!));

    if (msg.startsWith('Train sans arrêt') || msg.startsWith('Sans voyageurs')) return null;
    print("Can't parse $msg");
  }

  @visibleForTesting
  List<DateTime> parseBusMetroResponse(String body) {
    final b = jsonDecode(body);
    final rawSchedules = b['result']['schedules'];
    List<DateTime> times = [];
    for (final rawSchedule in rawSchedules) {
      Duration? d = _parseBusMetroSchedule(rawSchedule['message']);
      if (d != null) {
        times.add(DateTime.now().add(d));
      }
    }
    return times;
  }

  Duration? _parseBusMetroSchedule(String msg) {
    if (msg == "A l'arret" || msg == "Train a quai") return Duration(minutes: 0);
    if (msg == "A l'approche" || msg == "Train a l'approche") return Duration(minutes: 1);

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
