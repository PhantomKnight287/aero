import 'package:aero/formatters/units.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flight_timing.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:openapi/openapi.dart';

/// "Clocks go forward 4 h" with the offset as it is on the flight date,
/// what the arrival time reads at the origin, and a summer-time note.
/// Hidden when either zone is unknown.
class TimezoneShift extends StatelessWidget {
  final RouteInfoEntity departure;
  final RouteInfoEntity arrival;

  /// Row only, for use inside a grouped card.
  final bool bare;

  const TimezoneShift({
    super.key,
    required this.departure,
    required this.arrival,
    this.bare = false,
  });

  static String _city(RouteAirportEntity a) => a.municipalityName.isNotEmpty
      ? a.municipalityName
      : a.shortName ?? a.name;

  static String _label(RouteAirportEntity a) {
    final code = a.iata.isNotEmpty ? a.iata : a.icao;
    return code.isEmpty ? a.name : '${_city(a)} ($code)';
  }

  @override
  Widget build(BuildContext context) {
    final at = DateTime.tryParse(departure.scheduledTime.utc);
    final arrivalAt = DateTime.tryParse(
        (arrival.revisedTime ?? arrival.predictedTime ?? arrival.scheduledTime)
            .utc);
    if (at == null || arrivalAt == null) return const SizedBox.shrink();
    final depTz = departure.airport.timeZone;
    final arrTz = arrival.airport.timeZone;
    final shift = zoneShift(at, depTz, arrTz);
    if (shift == null) return const SizedBox.shrink();

    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    String clock(String tz) => formatClock(arrivalAt,
        airportTz: tz, mode: TimeMode.airport, use24: use24);
    final arrLocal = clock(arrTz);
    final subtitle = shift.change == Duration.zero
        ? '$arrLocal arrival in ${_label(arrival.airport)} reads the same in ${_city(departure.airport)}'
        : '$arrLocal arrival in ${_label(arrival.airport)} is ${clock(depTz)} ${_city(departure.airport)} time';
    final dst = [
      if (shift.originDst) _city(departure.airport),
      if (shift.destinationDst) _city(arrival.airport),
    ];

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Symbols.schedule, size: 20, color: AeroColors.ink),
        const SizedBox(width: AeroSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(describeShift(shift.change),
                  style: AeroText.body.copyWith(
                      color: AeroColors.ink, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: AeroText.caption),
              if (dst.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text('Summer time in effect in ${dst.join(' and ')}',
                    style: AeroText.micro),
              ],
            ],
          ),
        ),
      ],
    );
    if (bare) return row;
    return Container(
      padding: const EdgeInsets.all(AeroSpace.md),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: row,
    );
  }
}
