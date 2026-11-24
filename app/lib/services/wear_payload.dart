import 'dart:convert';

import 'package:aero/formatters/units.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/widgets/flight_detail/flight_status.dart';

/// What the watch gets for one flight. Raw facts, not formatted text: the
/// watch works out phase, progress and countdowns itself so they stay live
/// away from the phone. Times are UTC ISO strings; zones go with them.
///
/// v1 keys (`id`, `flightNo`, `identIata`, `departureAirportIata`, ...) are
/// kept so an older watch build still files the flight.
Map<String, Object?> wearPayload(
  FlightResponseEntity f, {
  AircraftHistoryEntity? history,
  required DistanceUnit distanceUnit,
}) {
  final fa = f.flightAwareData;
  final airline = f.airline;
  final status = flightStatus(f, DateTime.now());
  final flightNo = f.flightNo;

  String? ident(String? primary, String? carrier) {
    if (primary != null && primary.isNotEmpty) return primary;
    if (carrier == null || carrier.isEmpty) return null;
    final stripped = flightNo.replaceFirst(carrier, '');
    return '$carrier${stripped.isNotEmpty ? stripped : flightNo}';
  }

  String? text(Object? v) {
    final s = v?.toString().trim();
    return s == null || s.isEmpty || s == 'null' ? null : s;
  }

  String? iso(DateTime? d) => d?.toUtc().toIso8601String();
  String code(RouteAirportEntity a) => a.iata.isNotEmpty ? a.iata : a.icao;
  String city(RouteAirportEntity a) =>
      a.municipalityName.isNotEmpty ? a.municipalityName : a.name;

  Map<String, Object?> side(RouteInfoEntity r, SideTimes t,
          {String? gate, String? runway, String? belt}) =>
      {
        'code': code(r.airport),
        'icao': text(r.airport.icao),
        'city': city(r.airport),
        'tz': text(r.airport.timeZone),
        'sched': iso(t.scheduled),
        'best': iso(t.best),
        'gate': text(gate ?? r.gate),
        'terminal': text(r.terminal),
        'belt': text(belt),
        'runway': text(runway),
      };

  final inbound = history?.inbound;
  final inboundArrival = inbound == null
      ? null
      : DateTime.tryParse(
          inbound.actualIn ?? inbound.estimatedIn ?? inbound.scheduledIn ?? '');

  return {
    'v': 2,
    'flight': {
      'id': f.id,
      'flightNo': flightNo,
      'identIata': ident(fa?.identIata, airline.iata),
      'identIcao': ident(fa?.identIcao, airline.icao),
      'date': iso(status.departure.best),
      'departureAirportIata': code(f.departure.airport),
      'departureCity': city(f.departure.airport),
      'arrivalAirportIata': code(f.arrival.airport),
      'arrivalCity': city(f.arrival.airport),
      'dep': side(f.departure, status.departure,
          gate: fa?.gateOrigin, runway: fa?.actualRunwayOff),
      'arr': side(f.arrival, status.arrival,
          gate: fa?.gateDestination,
          runway: fa?.actualRunwayOn,
          belt: fa?.baggageClaim ?? f.arrival.baggageBelt),
      // Gate out, wheels off, wheels on, gate in: what the phase is built on.
      'out': iso(fa?.actualOut),
      'off': iso(fa?.actualOff),
      'on': iso(fa?.actualOn),
      'in': iso(fa?.actualIn),
      'cancelled': fa?.cancelled ?? false,
      'diverted': fa?.diverted ?? false,
      'divertedTo': status.divertedToIata,
      'distance': formatDistance(
          num.tryParse(f.greatCircleDistance.km ?? '') ?? 0, distanceUnit),
      'aircraft': text(f.aircraftTypeName ?? f.aircraft?.model),
      'aircraftCode': text(fa?.aircraftType),
      'registration': text(f.aircraft?.registration),
      if (inbound != null)
        'inbound': {
          'ident': inbound.identIata ?? inbound.ident,
          'from': inbound.originIata ?? inbound.originIcao,
          'to': inbound.destinationIata ?? inbound.destinationIcao,
          'tz': inbound.destinationTimezone,
          'arrival': iso(inboundArrival),
          'arrived': inbound.actualIn != null,
          'delayMin': ((inbound.arrivalDelay ?? 0) / 60).round(),
          'cancelled': inbound.cancelled,
        },
    },
    'airline': {
      'name': airline.name,
      'iata': airline.iata,
      'icao': airline.icao,
      'image': airline.image,
    },
  };
}

/// Flights the user has sent to the watch, with what's needed to re-fetch
/// them in the background. Stored as JSON under one prefs key.
class WearSent {
  static const _key = 'wear.sent.v2';

  static Future<Map<String, Map<String, Object?>>> all() async {
    final raw = (await SharedPreferences.getInstance()).getString(_key);
    if (raw == null) return {};
    return (jsonDecode(raw) as Map)
        .map((k, v) => MapEntry(k as String, Map<String, Object?>.from(v)));
  }

  static Future<void> _save(Map<String, Map<String, Object?>> m) async =>
      (await SharedPreferences.getInstance()).setString(_key, jsonEncode(m));

  static Future<bool> has(String id) async => (await all()).containsKey(id);

  static Future<void> add(FlightResponseEntity f) async {
    final fa = f.flightAwareData;
    final m = await all();
    m[f.id] = {
      'iata': fa?.identIata ?? f.flightNo,
      'icao': fa?.identIcao ?? f.flightNo,
      // Lookup date for the API (a calendar day, midnight).
      'date': f.date.toIso8601String(),
      // Real departure time: what the job's limits are measured from.
      'dep': flightStatus(f, DateTime.now()).departure.best.toIso8601String(),
      'faId': fa?.id,
    };
    await _save(m);
  }

  static Future<void> remove(String id) async {
    final m = await all();
    if (m.remove(id) != null) await _save(m);
  }
}

/// Phases after which nothing about a flight changes: once sent in one of
/// these, the flight leaves [WearSent] and is never fetched again.
const _settled = {
  FlightPhase.landed,
  FlightPhase.arrived,
  FlightPhase.cancelled,
  FlightPhase.diverted,
};

/// Background refresh for flights on the watch (workmanager, every 15 min).
/// Constrained so it costs little:
/// - a flight that has landed (or was cancelled or diverted) is sent one
///   last time and dropped, so it never hits the API again;
/// - a flight more than [_quietBefore] from departure isn't fetched yet
///   (the watch counts down on its own);
/// - nothing runs without a connected watch.
class WearSync {
  static const _quietBefore = Duration(hours: 12);

  static Future<void> run({
    required Future<FlightResponseEntity?> Function(Map<String, Object?> key)
        fetch,
    required Future<int> Function(Map<String, Object?> payload) send,
    required DistanceUnit distanceUnit,
    DateTime? now,
  }) async {
    final at = now ?? DateTime.now();
    for (final MapEntry(key: id, value: key)
        in (await WearSent.all()).entries) {
      final dep = DateTime.tryParse(key['dep'] as String? ?? '');
      if (dep == null || at.difference(dep) > const Duration(days: 2)) {
        await WearSent.remove(id); // stale entry: never fetch it
        continue;
      }
      if (dep.difference(at) > _quietBefore) continue;

      final f = await fetch(key);
      if (f == null) continue;
      final sent = await send(wearPayload(f, distanceUnit: distanceUnit));
      if (sent == 0) return; // no watch in reach: stop, try next run
      if (_settled.contains(flightStatus(f, at).phase)) {
        await WearSent.remove(id);
      }
    }
  }
}
