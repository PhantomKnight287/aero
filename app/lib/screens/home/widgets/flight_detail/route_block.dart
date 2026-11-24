import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'flight_status.dart';

/// Colour for lateness text only; on time and early stay neutral.
Color? delayColor(SideTimes t) => switch (t.punctuality) {
      Punctuality.cancelled => AeroColors.danger,
      Punctuality.late => AeroColors.danger,
      Punctuality.early => AeroColors.success,
      _ => null,
    };

/// 'On time', '7m late', '3m early', 'Cancelled'.
String delayLabel(SideTimes t) {
  if (t.cancelled) return 'Cancelled';
  final d = t.delayMinutes;
  if (d == 0) return 'On time';
  final span = formatLongDuration(d.abs());
  return d > 0 ? '$span late' : '$span early';
}

/// Departure and arrival in one card, on the same grid: airport and time on
/// the left, gate / terminal / delay on the right, trip length between.
class RouteBlock extends StatelessWidget {
  final FlightResponseEntity info;
  final LiveStatus status;
  final ValueChanged<RouteAirportEntity>? onAirportTap;

  const RouteBlock({
    super.key,
    required this.info,
    required this.status,
    this.onAirportTap,
  });

  @override
  Widget build(BuildContext context) {
    final fa = info.flightAwareData;
    final km = double.tryParse(info.greatCircleDistance.km ?? '');
    final trip = status.arrival.best.difference(status.departure.best);
    return Container(
      padding: const EdgeInsets.all(AeroSpace.lg),
      decoration: const BoxDecoration(
          color: AeroColors.surfaceAlt, borderRadius: AeroRadius.mdAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Side(
            airport: info.departure.airport,
            times: status.departure,
            gate: fa?.gateOrigin ?? info.departure.gate,
            terminal: fa?.terminalOrigin ?? info.departure.terminal,
            onTap: onAirportTap,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
            child: Row(children: [
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
            airport: info.arrival.airport,
            divertedTo: status.divertedToIata,
            divertedName: fa?.destinationName,
            times: status.arrival,
            gate: fa?.gateDestination ?? info.arrival.gate,
            terminal: fa?.terminalDestination ?? info.arrival.terminal,
            belt: fa?.baggageClaim ?? info.arrival.baggageBelt,
            onTap: onAirportTap,
          ),
        ],
      ),
    );
  }
}

class _Side extends StatelessWidget {
  final RouteAirportEntity airport;
  final String? divertedTo;
  final String? divertedName;
  final SideTimes times;
  final String? gate;
  final String? terminal;
  final String? belt;
  final ValueChanged<RouteAirportEntity>? onTap;

  const _Side({
    required this.airport,
    required this.times,
    this.divertedTo,
    this.divertedName,
    this.gate,
    this.terminal,
    this.belt,
    this.onTap,
  });

  static bool _has(String? s) => s != null && s.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final codes = divertedTo != null
        ? divertedTo!
        : [airport.iata, airport.icao].where(_has).join(' · ');
    final name = divertedTo != null ? (divertedName ?? '') : airport.name;
    final delay = delayColor(times);

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(codes, style: AeroText.heading),
          if (onTap != null)
            const Icon(Icons.chevron_right, size: 18, color: AeroColors.muted),
        ]),
        if (_has(name))
          Text(name,
              style: AeroText.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        if (divertedTo != null)
          Text('planned ${_has(airport.iata) ? airport.iata : airport.icao}',
              style: AeroText.caption),
        const SizedBox(height: AeroSpace.xs),
        UnitCycle(
          dimension: UnitDimension.time,
          builder: (_, u) {
            String clock(DateTime t) => formatClock(t,
                airportTz: airport.timeZone, mode: u.time, use24: use24);
            final changed = times.best != times.scheduled;
            // Wraps the struck schedule under the time on narrow screens.
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: AeroSpace.sm,
              children: [
                Text(clock(times.best),
                    style: AeroText.figureLg.copyWith(
                        color: delay,
                        decoration: times.cancelled
                            ? TextDecoration.lineThrough
                            : null)),
                if (changed && !times.cancelled) ...[
                  Text(clock(times.scheduled),
                      style: AeroText.body.copyWith(
                          color: AeroColors.muted,
                          decoration: TextDecoration.lineThrough,
                          fontFeatures: AeroText.tabular)),
                ],
              ],
            );
          },
        ),
      ],
    );

    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Gate ${_has(gate) ? gate : '--'}',
            style: AeroText.heading.copyWith(fontFeatures: AeroText.tabular)),
        if (_has(terminal)) Text('Terminal $terminal', style: AeroText.caption),
        if (_has(belt)) Text('Belt $belt', style: AeroText.caption),
        const SizedBox(height: AeroSpace.xs),
        Text(delayLabel(times),
            style: AeroText.body.copyWith(
                color: delay ?? AeroColors.muted,
                fontWeight: delay == null ? null : FontWeight.w600,
                fontFeatures: AeroText.tabular)),
      ],
    );

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: AeroSpace.md),
        right,
      ],
    );
    if (onTap == null) return row;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap!(airport),
        child: AeroPressable(child: row),
      ),
    );
  }
}
