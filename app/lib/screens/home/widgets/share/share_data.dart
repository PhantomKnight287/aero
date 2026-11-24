import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';

import '../flight_detail/flight_status.dart';
import '../flight_detail/route_block.dart' show delayColor, delayLabel;

/// Everything a share card prints, resolved once from the flight and the
/// user's units, so the cards stay dumb and the goldens need no network.
/// Times and delays come from [LiveStatus], the same as the detail screen.
class ShareData {
  final String airline;
  final String? airlineSvg;
  final String? airlineIcao;

  /// 'UA1581', 'UAL1581' (ICAO only when FlightAware has it).
  final String ident;
  final String? identIcao;

  /// 'MON 23 NOV' at the departure airport.
  final String date;
  final ShareSide dep;
  final ShareSide arr;
  final FlightPhase phase;

  /// 0..1 gate to gate; null when cancelled or diverted.
  final double? progress;
  final String duration;
  final String distance;
  final String? aircraft;
  final String? registration;
  final String? seat;
  final String? cabin;

  /// Photo for the card and story; null shows no photo block.
  final ImageProvider? photo;

  const ShareData({
    required this.airline,
    this.airlineSvg,
    this.airlineIcao,
    required this.ident,
    this.identIcao,
    required this.date,
    required this.dep,
    required this.arr,
    required this.phase,
    required this.progress,
    required this.duration,
    required this.distance,
    this.aircraft,
    this.registration,
    this.seat,
    this.cabin,
    this.photo,
  });

  /// 'UA1581 · UAL1581'
  String get idents => [ident, if (identIcao != null) identIcao!].join(' · ');

  /// Board remark and its chip colour: the flight's phase, not its
  /// punctuality (the times carry that). Only a late departure that hasn't
  /// left yet says DELAYED, as a real board would.
  (String, Color) get remark {
    final delayed = dep.color == AeroColors.danger;
    return switch (phase) {
      FlightPhase.scheduled || FlightPhase.boardingSoon when delayed => (
          'DELAYED',
          AeroColors.warn
        ),
      FlightPhase.scheduled => ('SCHEDULED', AeroColors.success),
      FlightPhase.boardingSoon => ('DEPARTS SOON', AeroColors.success),
      FlightPhase.taxiingOut => ('TAXIING', AeroColors.success),
      FlightPhase.inFlight => ('IN FLIGHT', AeroColors.success),
      FlightPhase.landed => ('LANDED', AeroColors.success),
      FlightPhase.arrived => ('ARRIVED', AeroColors.success),
      FlightPhase.cancelled => ('CANCELLED', AeroColors.danger),
      FlightPhase.diverted => ('DIVERTED', AeroColors.warn),
    };
  }

  /// Landed flights read as arrivals at the destination; the rest as
  /// departures from the origin.
  bool get arriving =>
      phase == FlightPhase.landed || phase == FlightPhase.arrived;

  factory ShareData.from(
    FlightResponseEntity f,
    DateTime now, {
    required DistanceUnit distanceUnit,
    required TimeMode timeMode,
    required bool use24,
    ImageProvider? photo,
  }) {
    final s = flightStatus(f, now);
    final fa = f.flightAwareData;
    final booking = f.bookings?.isNotEmpty == true ? f.bookings!.first : null;
    String? text(Object? v) {
      final t = v?.toString().trim();
      return t == null || t.isEmpty || t == 'null' ? null : t;
    }

    ShareSide side(RouteInfoEntity r, SideTimes t,
        {String? gate, String? runway, String? belt}) {
      final a = r.airport;
      String clock(DateTime d) =>
          formatClock(d, airportTz: a.timeZone, mode: timeMode, use24: use24);
      return ShareSide(
        code: a.iata.isNotEmpty ? a.iata : a.icao,
        icao: a.icao.isNotEmpty && a.icao != a.iata ? a.icao : null,
        city: a.municipalityName.isNotEmpty ? a.municipalityName : a.name,
        clock: clock(t.best),
        scheduled:
            t.best != t.scheduled && !t.cancelled ? clock(t.scheduled) : null,
        delay: delayLabel(t),
        color: delayColor(t),
        terminal: text(r.terminal),
        gate: text(gate ?? r.gate),
        belt: text(belt),
        runway: text(runway),
        at: LatLng(a.location.lat.toDouble(), a.location.lon.toDouble()),
      );
    }

    final depUtc = s.departure.scheduled;
    final cancelled = s.phase == FlightPhase.cancelled;
    return ShareData(
      airline: f.airline.name,
      airlineSvg: f.airline.image,
      airlineIcao: f.airline.icao,
      ident: fa?.identIata ?? f.flightNo,
      identIcao: text(fa?.identIcao),
      date: DateFormat('EEE d MMM')
          .format(airportTime(depUtc, f.departure.airport.timeZone))
          .toUpperCase(),
      dep: side(f.departure, s.departure,
          gate: fa?.gateOrigin, runway: fa?.actualRunwayOff),
      arr: side(f.arrival, s.arrival,
          gate: fa?.gateDestination,
          runway: fa?.actualRunwayOn,
          belt: fa?.baggageClaim ?? f.arrival.baggageBelt),
      phase: s.phase,
      progress: s.progress(now),
      duration: cancelled
          ? '—'
          : formatLongDuration(
              s.arrival.best.difference(s.departure.best).inMinutes),
      distance: formatDistance(
          num.tryParse(f.greatCircleDistance.km ?? '') ?? 0, distanceUnit),
      aircraft: text(f.aircraftTypeName ?? f.aircraft?.model),
      registration: text(f.aircraft?.registration),
      seat: text(booking?.seatNumber?.value) ??
          _sentence(booking?.seatType?.name),
      cabin: _sentence(booking?.seatingClass?.name),
      photo: photo,
    );
  }
}

class ShareSide {
  final String code;
  final String? icao;
  final String city;
  final String clock;

  /// Struck-through schedule when the time moved.
  final String? scheduled;
  final String delay;

  /// Red late, green early, null on time (ink).
  final Color? color;
  final String? terminal;
  final String? gate;
  final String? belt;
  final String? runway;
  final LatLng at;

  const ShareSide({
    required this.code,
    this.icao,
    required this.city,
    required this.clock,
    this.scheduled,
    required this.delay,
    this.color,
    this.terminal,
    this.gate,
    this.belt,
    this.runway,
    required this.at,
  });
}

String? _sentence(String? s) {
  if (s == null || s.isEmpty) return null;
  final spaced = s.replaceAllMapped(RegExp('[A-Z]'), (m) => ' ${m[0]}');
  final lower = spaced.toLowerCase().trim();
  return '${lower[0].toUpperCase()}${lower.substring(1)}';
}
