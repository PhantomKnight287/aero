import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/extensions/datetime.dart';
import 'package:plane_pal/extensions/duration.dart';
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
                totalDuration: totalDuration, distanceKm: distanceKm),
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
    final String? faRunway = isDeparture
        ? flightAwareDataEntity?.actualRunwayOff
        : flightAwareDataEntity?.actualRunwayOn;

    final String? effTerminal =
        (terminal != null && terminal.isNotEmpty) ? terminal : faTerminal;
    final String? effGate = (gate != null && gate.isNotEmpty) ? gate : faGate;
    final String? effBaggage =
        (baggage != null && baggage.isNotEmpty) ? baggage : faBaggage;
    final String? effRunway =
        (faRunway != null && faRunway.isNotEmpty) ? faRunway : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                code,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 6),
              _buildInfoPills(
                terminal: effTerminal,
                gate: effGate,
                baggage: effBaggage,
                runway: effRunway,
                isDeparture: isDeparture,
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
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right: time block
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (originalTime != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      originalTime.toTimezoneString(
                        timezone,
                        use24Hrs: use24Hrs,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                Text(
                  time.toTimezoneString(
                    timezone,
                    use24Hrs: use24Hrs,
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    color: timeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (hasDelay)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  isEarly
                      ? "${_formatMinutesOnly(d.abs())} early"
                      : "${_formatMinutesOnly(d)} late",
                  style: TextStyle(
                    fontSize: 12,
                    color: timeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (hasDelay)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  _timeAgo(time),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
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
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
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

  Widget _buildInfoPills(
      {String? terminal,
      String? gate,
      String? baggage,
      String? runway,
      required bool isDeparture}) {
    final List<Widget> children = [];
    if (terminal != null && terminal.isNotEmpty) {
      children.add(_pill(
        icon: Icons.title_rounded,
        label: terminal,
      ));
    }
    if (gate != null && gate.isNotEmpty) {
      children.add(_pill(
        icon: Icons.door_front_door,
        label: gate,
      ));
    }
    if (baggage != null && baggage.isNotEmpty) {
      children.add(_pill(
        icon: Icons.luggage,
        label: baggage,
      ));
    }
    if (runway != null && runway.isNotEmpty) {
      children.add(_pill(
        icon: isDeparture ? Icons.flight_takeoff : Icons.flight_land,
        label: runway,
      ));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: children,
    );
  }

  Widget _pill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
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

  String _timeAgo(DateTime time) {
    final Duration diff = DateTime.now().difference(time);
    if (diff.inMinutes.abs() < 1) {
      return "just now";
    }
    final String base = _formatMinutesOnly(diff);
    if (diff.isNegative) {
      return "in $base";
    }
    return "$base ago";
  }
}
