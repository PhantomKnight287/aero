import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/extensions/datetime.dart';
import 'package:aero/extensions/duration.dart';
import 'package:intl/intl.dart';

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
      padding: const EdgeInsets.all(
        8.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
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
    final Color timeColor =
        hasDelay ? (isEarly ? Colors.green : Colors.red) : Colors.black;
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Time row with original time if delayed
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    time.toTimezoneString(
                      timezone,
                      use24Hrs: use24Hrs,
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      color: (flightAwareDataEntity?.cancelled == true)
                          ? Colors.red
                          : timeColor,
                      fontWeight: FontWeight.bold,
                      decoration: (flightAwareDataEntity?.cancelled == true)
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: (flightAwareDataEntity?.cancelled == true)
                          ? Colors.red
                          : null,
                    ),
                  ),
                  if (originalTime != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        originalTime.toTimezoneString(
                          timezone,
                          use24Hrs: use24Hrs,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              // Status text
              if (flightAwareDataEntity?.cancelled == true)
                Text(
                  'Cancelled',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else if (hasDelay)
                Text(
                  isEarly
                      ? "${_formatMinutesOnly(d.abs())} Early"
                      : "${_formatMinutesOnly(d)} Late",
                  style: TextStyle(
                    fontSize: 13,
                    color: timeColor,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                Text(
                  'On Time',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
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
            const SizedBox(height: 4),
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
    final String durationText = totalDuration.toHumanReadable();
    String centerText = durationText;
    if (distanceKm != null) {
      final numberFormatter = NumberFormat.decimalPattern();
      final String kmFormatted = numberFormatter.format(distanceKm.round());
      centerText = "$durationText • $kmFormatted km";
    }

    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ),
          child: Text(
            centerText,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
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
        Icon(icon, size: 16, color: Colors.grey.shade700),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
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
