import 'package:aero/extensions/duration.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

class FlightRouteInfo extends StatelessWidget {
  final String departureCode;
  final String departureName;
  final String? departureTerminal;
  final String? departureGate;
  final DateTime departureTime;
  final Duration? departureDelay;
  final String departureSubtitle;
  final String departureTimezone;

  final String arrivalCode;
  final String arrivalName;
  final String? arrivalTerminal;
  final String? arrivalGate;
  final DateTime arrivalTime;
  final Duration? arrivalDelay;
  final String arrivalSubtitle;
  final String arrivalTimezone;
  final String? arrivalBaggage;

  final Color? statusColor;
  final bool use24Hrs;
  final double? distanceKm;
  final FlightAwareDataEntity? flightAwareDataEntity;

  const FlightRouteInfo(
      {super.key,
      required this.departureCode,
      required this.departureName,
      this.departureTerminal,
      this.departureGate,
      required this.departureTime,
      this.departureDelay,
      required this.departureSubtitle,
      required this.arrivalCode,
      required this.arrivalName,
      this.arrivalTerminal,
      this.arrivalGate,
      required this.arrivalTime,
      this.arrivalDelay,
      required this.arrivalSubtitle,
      this.statusColor,
      required this.arrivalTimezone,
      required this.departureTimezone,
      required this.use24Hrs,
      this.arrivalBaggage,
      this.distanceKm,
      this.flightAwareDataEntity = null});

  @override
  Widget build(BuildContext context) {
    final Duration totalDuration = arrivalTime.difference(departureTime);

    return Container(
      padding: const EdgeInsets.all(AeroSpace.sm),
      decoration: BoxDecoration(
        border: Border.all(color: AeroColors.line),
        borderRadius: AeroRadius.mdAll,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AeroSpace.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStopRow(
              code: departureCode,
              name: departureName,
              terminal: departureTerminal,
              gate: departureGate,
              time: departureTime,
              delay: departureDelay,
              subtitle: departureSubtitle,
              timezone: departureTimezone,
              isDeparture: true,
            ),
            _buildMidDivider(
              totalDuration: totalDuration,
              distanceKm: distanceKm,
            ),
            _buildStopRow(
              code: arrivalCode,
              name: arrivalName,
              terminal: arrivalTerminal,
              gate: arrivalGate,
              time: arrivalTime,
              delay: arrivalDelay,
              subtitle: arrivalSubtitle,
              timezone: arrivalTimezone,
              baggage: arrivalBaggage,
              isDeparture: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStopRow({
    required String code,
    required String name,
    required String? terminal,
    String? gate,
    required DateTime time,
    required Duration? delay,
    required String subtitle,
    required String timezone,
    String? baggage,
    required bool isDeparture,
  }) {
    final Duration? d = delay;
    final bool hasDelay = d != null && d != Duration.zero;
    final bool isEarly = hasDelay && d.isNegative;
    final Color timeColor = hasDelay
        ? (isEarly ? AeroColors.success : AeroColors.danger)
        : AeroColors.ink;
    final cancelled = flightAwareDataEntity?.cancelled == true;
    final DateTime? originalTime = hasDelay ? time.subtract(d) : null;

    // Prefer props, fallback to FlightAware
    final String? faTerminal = isDeparture
        ? flightAwareDataEntity?.terminalOrigin
        : flightAwareDataEntity?.terminalDestination;
    final String? faGate = isDeparture
        ? flightAwareDataEntity?.gateOrigin
        : flightAwareDataEntity?.gateDestination;
    final String? faBaggage = flightAwareDataEntity?.baggageClaim;

    final String? effTerminal =
        (terminal != null && terminal.isNotEmpty) ? terminal : faTerminal;
    final String? effGate = (gate != null && gate.isNotEmpty) ? gate : faGate;
    final String? effBaggage =
        (baggage != null && baggage.isNotEmpty) ? baggage : faBaggage;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airport code and name on same line with reduced opacity
              Text(
                '$code • $name',
                style: AeroText.heading.copyWith(color: AeroColors.muted),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: AeroSpace.xs),
                Text(subtitle, style: AeroText.caption),
              ],
              const SizedBox(height: AeroSpace.sm),
              // Time row with original time if delayed
              UnitCycle(
                dimension: UnitDimension.time,
                builder: (context, units) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      formatClock(time.toUtc(),
                          airportTz: timezone,
                          mode: units.time,
                          use24: use24Hrs),
                      style: AeroText.figure.copyWith(
                        color: cancelled ? AeroColors.danger : timeColor,
                        decoration:
                            cancelled ? TextDecoration.lineThrough : null,
                        decorationColor: cancelled ? AeroColors.danger : null,
                      ),
                    ),
                    if (originalTime != null)
                      Padding(
                        padding: const EdgeInsets.only(left: AeroSpace.sm),
                        child: Text(
                          formatClock(originalTime.toUtc(),
                              airportTz: timezone,
                              mode: units.time,
                              use24: use24Hrs),
                          style: AeroText.heading.copyWith(
                              color: AeroColors.muted,
                              fontWeight: FontWeight.w400,
                              fontFeatures: AeroText.tabular),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              // Status text
              if (cancelled)
                Text(
                  'Cancelled',
                  style: AeroText.caption.copyWith(
                      color: AeroColors.danger, fontWeight: FontWeight.w700),
                )
              else if (hasDelay)
                Text(
                  isEarly
                      ? "${_formatMinutesOnly(d.abs())} Early"
                      : "${_formatMinutesOnly(d)} Late",
                  style: AeroText.caption
                      .copyWith(color: timeColor, fontWeight: FontWeight.w700),
                )
              else
                Text(
                  'On Time',
                  style: AeroText.caption.copyWith(
                      color: AeroColors.success, fontWeight: FontWeight.w700),
                ),
            ],
          ),
        ),
        const SizedBox(width: AeroSpace.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Baggage belt (for arrivals) or Gate (for departures)
            if (!isDeparture)
              _buildInfoBadge(
                icon: Icons.luggage,
                label: effBaggage ?? '--',
              )
            else
              _buildInfoBadge(
                icon: Icons.door_front_door,
                label: effGate ?? '--',
              ),
            const SizedBox(height: AeroSpace.xs),
            // Terminal
            _buildInfoBadge(
              icon: Icons.title_rounded,
              label: effTerminal ?? '--',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMidDivider(
      {required Duration totalDuration, double? distanceKm}) {
    final style = AeroText.caption.copyWith(
        color: AeroColors.inkSoft,
        fontWeight: FontWeight.w600,
        fontFeatures: AeroText.tabular);
    return Row(
      children: [
        const Expanded(child: Divider(color: AeroColors.line)),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AeroSpace.md, vertical: AeroSpace.sm),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(totalDuration.toHumanReadable(), style: style),
            if (distanceKm != null) ...[
              Text(' • ', style: style),
              UnitCycle(
                dimension: UnitDimension.distance,
                builder: (_, units) => Text(
                    formatDistance(distanceKm, units.distance),
                    style: style),
              ),
            ],
          ]),
        ),
        const Expanded(child: Divider(color: AeroColors.line)),
      ],
    );
  }

  Widget _buildInfoBadge({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AeroColors.muted),
        const SizedBox(width: 6),
        Text(
          label,
          style: AeroText.caption
              .copyWith(color: AeroColors.inkSoft, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String _formatMinutesOnly(Duration d) {
    final Duration abs = d.abs();
    final int hours = abs.inHours;
    final int minutes = abs.inMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return "$hours ${hours == 1 ? 'hr' : 'hrs'} $minutes mins";
    } else if (hours > 0) {
      return "$hours ${hours == 1 ? 'hr' : 'hrs'}";
    } else if (minutes > 0) {
      return "$minutes mins";
    } else {
      return "just now";
    }
  }
}
