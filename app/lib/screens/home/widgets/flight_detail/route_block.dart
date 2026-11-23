import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'flight_status.dart';
import 'status_band.dart';

/// Flighty-style departure and arrival: airport row, big gate time with the
/// schedule struck through, a status line, gate/terminal chips, and the
/// trip length between them.
class RouteBlock extends StatelessWidget {
  final FlightResponseEntity info;
  final LiveStatus status;
  final DateTime now;
  final ValueChanged<RouteAirportEntity>? onAirportTap;

  const RouteBlock({
    super.key,
    required this.info,
    required this.status,
    required this.now,
    this.onAirportTap,
  });

  @override
  Widget build(BuildContext context) {
    final fa = info.flightAwareData;
    final km = double.tryParse(info.greatCircleDistance.km ?? '');
    final trip = status.arrival.best.difference(status.departure.best);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Side(
          departure: true,
          airport: info.departure.airport,
          times: status.departure,
          line: status.sideLine(true, now),
          gate: fa?.gateOrigin ?? info.departure.gate,
          terminal: fa?.terminalOrigin ?? info.departure.terminal,
          onTap: onAirportTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
          child: Row(children: [
            const Icon(Icons.schedule, size: 16, color: AeroColors.muted),
            const SizedBox(width: AeroSpace.xs),
            UnitCycle(
              dimension: UnitDimension.distance,
              builder: (_, u) => Text(
                [
                  if (!trip.isNegative) formatLongDuration(trip.inMinutes),
                  if (km != null) formatDistance(km, u.distance),
                ].join(' · '),
                style:
                    AeroText.caption.copyWith(fontFeatures: AeroText.tabular),
              ),
            ),
            const SizedBox(width: AeroSpace.md),
            const Expanded(child: Divider(height: 1, color: AeroColors.line)),
          ]),
        ),
        _Side(
          departure: false,
          airport: info.arrival.airport,
          divertedTo: status.divertedToIata,
          divertedName: fa?.destinationName,
          times: status.arrival,
          line: status.sideLine(false, now),
          gate: fa?.gateDestination ?? info.arrival.gate,
          terminal: fa?.terminalDestination ?? info.arrival.terminal,
          belt: fa?.baggageClaim ?? info.arrival.baggageBelt,
          onTap: onAirportTap,
        ),
      ],
    );
  }
}

class _Side extends StatelessWidget {
  final bool departure;
  final RouteAirportEntity airport;
  final String? divertedTo;
  final String? divertedName;
  final SideTimes times;
  final String line;
  final String? gate;
  final String? terminal;
  final String? belt;
  final ValueChanged<RouteAirportEntity>? onTap;

  const _Side({
    required this.departure,
    required this.airport,
    required this.times,
    required this.line,
    this.divertedTo,
    this.divertedName,
    this.gate,
    this.terminal,
    this.belt,
    this.onTap,
  });

  String get _airportLine {
    if (divertedTo != null) {
      return [divertedTo!, if (divertedName != null) divertedName!].join(' · ');
    }
    return [airport.iata, airport.icao, airport.name]
        .where((s) => s.isNotEmpty)
        .join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final (ink, _) = punctualityColors(times.punctuality);
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final changed = times.best != times.scheduled;
    final airportRow = Row(children: [
      Icon(departure ? Icons.north_east : Icons.south_east,
          size: 16, color: AeroColors.ink),
      const SizedBox(width: AeroSpace.xs),
      Flexible(
        child: Text(_airportLine,
            style: AeroText.heading,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
      if (onTap != null)
        const Icon(Icons.chevron_right, size: 20, color: AeroColors.muted),
    ]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        onTap == null
            ? airportRow
            : Semantics(
                button: true,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap!(airport),
                  child: AeroPressable(child: airportRow),
                ),
              ),
        if (divertedTo != null)
          Text(
              'planned ${airport.iata.isNotEmpty ? airport.iata : airport.icao}',
              style: AeroText.caption),
        const SizedBox(height: AeroSpace.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: UnitCycle(
                dimension: UnitDimension.time,
                builder: (_, u) {
                  (String, String) clock(DateTime t) {
                    final s = formatClock(t,
                        airportTz: airport.timeZone,
                        mode: u.time,
                        use24: use24);
                    final i = s.indexOf(' ');
                    return i < 0
                        ? (s, '')
                        : (s.substring(0, i), s.substring(i));
                  }

                  final (big, meridiem) = clock(times.best);
                  final (sched, _) = clock(times.scheduled);
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: AeroSpace.sm,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(big,
                              style: AeroText.clock.copyWith(
                                  color: ink,
                                  decoration: times.cancelled
                                      ? TextDecoration.lineThrough
                                      : null)),
                          if (meridiem.isNotEmpty)
                            Text(meridiem,
                                style: AeroText.heading.copyWith(color: ink)),
                        ],
                      ),
                      if (changed && !times.cancelled)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AeroSpace.xs),
                          child: Text(sched,
                              style: AeroText.body.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontFeatures: AeroText.tabular)),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: AeroSpace.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  if (!departure && belt != null && belt!.isNotEmpty) ...[
                    _Chip(icon: Icons.luggage_outlined, text: belt!),
                    const SizedBox(width: AeroSpace.xs),
                  ],
                  _Chip(
                      icon: departure ? Icons.north_east : Icons.south_east,
                      text: gate == null || gate!.isEmpty ? '--' : gate!),
                ]),
                if (terminal != null && terminal!.isNotEmpty) ...[
                  const SizedBox(height: AeroSpace.xs),
                  Text('Terminal $terminal', style: AeroText.caption),
                ],
              ],
            ),
          ],
        ),
        Text(line,
            style: AeroText.body.copyWith(
                color: ink,
                fontWeight: FontWeight.w600,
                fontFeatures: AeroText.tabular)),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Chip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AeroSpace.sm, vertical: AeroSpace.xs),
      decoration: const BoxDecoration(
          color: AeroColors.gate, borderRadius: AeroRadius.smAll),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 18, color: AeroColors.ink),
        const SizedBox(width: 2),
        Text(text,
            style: AeroText.figure.copyWith(fontWeight: FontWeight.w800)),
      ]),
    );
  }
}
