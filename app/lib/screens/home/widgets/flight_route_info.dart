import 'package:flutter/material.dart';
import 'package:plane_pal/extensions/datetime.dart';
import 'package:plane_pal/extensions/duration.dart';

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

  const FlightRouteInfo({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildRouteDot(
                  color: statusColor ??
                      (departureDelay != null ? Colors.red : Colors.green),
                ),
                Container(
                  width: 2,
                  height: 110,
                  color: Colors.grey.shade300,
                ),
                _buildRouteDot(
                  color: statusColor ??
                      (arrivalDelay != null ? Colors.red : Colors.green),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRouteStop(
                    code: departureCode,
                    name: departureName,
                    terminal: departureTerminal,
                    gate: departureGate,
                    time: departureTime,
                    delay: departureDelay,
                    subtitle: departureSubtitle,
                    timezone: departureTimezone,
                    color: statusColor ??
                        (departureDelay != null ? Colors.red : Colors.green),
                      
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    child: const SizedBox(height: 8),
                  ),
                  _buildRouteStop(
                    code: arrivalCode,
                    name: arrivalName,
                    terminal: arrivalTerminal,
                    gate: arrivalGate,
                    time: arrivalTime,
                    delay: arrivalDelay,
                    subtitle: arrivalSubtitle,
                    timezone: arrivalTimezone,
                    color: statusColor ??
                        (arrivalDelay != null ? Colors.red : Colors.green),
                    baggage: arrivalBaggage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteDot({required Color color}) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildRouteStop({
    required String code,
    required String name,
    required String? terminal,
    String? gate,
    required DateTime time,
    required Duration? delay,
    required String subtitle,
    required String timezone,
    required Color color,
    String? baggage,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left column: Airport information
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
              if (terminal != null && terminal.isNotEmpty)
                Text(
                  "Terminal: $terminal",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              if (gate != null && gate.isNotEmpty)
                Text(
                  "Gate: $gate",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              if (baggage != null && baggage.isNotEmpty)
                Text(
                  "Baggage: $baggage",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
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
            ],
          ),
        ),
        const SizedBox(width: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Builder(builder: (context) {
              final Color timeColor = delay == null || delay == Duration.zero
                  ? Colors.black
                  : (delay.isNegative ? Colors.green : Colors.red);
              return Text(
                time.toTimezoneString(
                  timezone,
                  use24Hrs: use24Hrs,
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: timeColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            if (delay != null) _buildDelayPill(delay: delay, color: color),
          ],
        ),
      ],
    );
  }

  Widget _buildDelayPill({required Duration delay, required Color color}) {
    // Don't show anything if there's no delay
    if (delay == Duration.zero) {
      return const SizedBox.shrink();
    }

    final bool isEarly = delay.isNegative;
    final String status = isEarly ? "Early" : "Delayed";
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: (isEarly ? Colors.green : Colors.red).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isEarly ? Colors.green : Colors.red).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 12,
            color: (isEarly ? Colors.green : Colors.red).withValues(alpha: 0.9),
          ),
          const SizedBox(width: 4),
          Text(
            "$status ${delay.toHumanReadable()}",
            style: TextStyle(
              fontSize: 12,
              color:
                  (isEarly ? Colors.green : Colors.red).withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
