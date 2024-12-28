import 'package:flutter/material.dart';
import 'package:plane_pal/extensions/datetime.dart';
import 'package:plane_pal/extensions/duration.dart';

class FlightRouteInfo extends StatelessWidget {
  final String departureCode;
  final String departureName;
  final String? departureTerminal;
  final DateTime departureTime;
  final Duration? departureDelay;
  final String departureSubtitle;
  final String departureTimezone;

  final String arrivalCode;
  final String arrivalName;
  final String? arrivalTerminal;
  final DateTime arrivalTime;
  final Duration? arrivalDelay;
  final String arrivalSubtitle;
  final String arrivalTimezone;

  final Color? statusColor;
  final bool use24Hrs;

  const FlightRouteInfo({
    super.key,
    required this.departureCode,
    required this.departureName,
    this.departureTerminal,
    required this.departureTime,
    this.departureDelay,
    required this.departureSubtitle,
    required this.arrivalCode,
    required this.arrivalName,
    this.arrivalTerminal,
    required this.arrivalTime,
    this.arrivalDelay,
    required this.arrivalSubtitle,
    this.statusColor,
    required this.arrivalTimezone,
    required this.departureTimezone,
    required this.use24Hrs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildRouteDot(
                color: statusColor ?? (departureDelay != null ? Colors.red : Colors.green),
              ),
              Container(
                width: 2,
                height: 80,
                color: Colors.grey.shade300,
              ),
              _buildRouteDot(
                color: statusColor ?? (arrivalDelay != null ? Colors.red : Colors.green),
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
                  time: departureTime,
                  delay: departureDelay,
                  subtitle: departureSubtitle,
                  timezone: departureTimezone,
                  color: statusColor ?? (departureDelay != null ? Colors.red : Colors.green),
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
                  time: arrivalTime,
                  delay: arrivalDelay,
                  subtitle: arrivalSubtitle,
                  timezone: arrivalTimezone,
                  color: statusColor ?? (arrivalDelay != null ? Colors.red : Colors.green),
                ),
              ],
            ),
          ),
        ],
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
    required DateTime time,
    required Duration? delay,
    required String subtitle,
    required String timezone,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              code,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time.toTimezoneString(
                    timezone,
                    use24Hrs: use24Hrs,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (delay != null)
                  Text(
                    delay.toHumanReadable(),
                    style: TextStyle(
                      fontSize: 12,
                      color: color.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        if (terminal != null)
          Text(
            terminal,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        if (subtitle.isNotEmpty) const SizedBox(height: 4),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
      ],
    );
  }
}
