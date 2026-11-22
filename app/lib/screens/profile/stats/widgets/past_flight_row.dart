import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

/// 'EK 215 · UAE215'. Space goes after the airline code; either ident alone
/// when the other is missing.
String flightIdents(StatsFlightSummaryEntity f) {
  final iata = f.identIata;
  final code = f.airline.iata;
  final spaced = iata == null
      ? null
      : code != null && iata.startsWith(code) && iata.length > code.length
          ? '$code ${iata.substring(code.length)}'
          : iata;
  return [spaced, f.identIcao].whereType<String>().join(' · ');
}

String _code(StatsAirportEntity a) => a.iata ?? a.icao ?? '';

/// 'DXB → LAX'
String flightAirports(StatsFlightSummaryEntity f) =>
    '${_code(f.departure)} → ${_code(f.arrival)}';

/// '14 Mar 2026' (UTC date: the entity has no local date).
String flightDate(StatsFlightSummaryEntity f) {
  final d = DateTime.tryParse(f.date)?.toUtc();
  return d == null ? '' : DateFormat('d MMM y').format(d);
}

/// One flight in the history list: logo, idents, route, cities, date.
class PastFlightRow extends StatelessWidget {
  final StatsFlightSummaryEntity flight;
  final VoidCallback onTap;

  const PastFlightRow({super.key, required this.flight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
            child: Row(children: [
              AirlineLogo(
                  svgUrl: flight.airline.image, icao: flight.airline.icao),
              const SizedBox(width: AeroSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(flightIdents(flight), style: AeroText.heading),
                    Text(flightAirports(flight),
                        style: AeroText.body
                            .copyWith(fontFeatures: AeroText.tabular)),
                    Text('${flight.departure.city} to ${flight.arrival.city}',
                        style: AeroText.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: AeroSpace.sm),
              Text(flightDate(flight),
                  style: AeroText.caption
                      .copyWith(fontFeatures: AeroText.tabular)),
              const Icon(Icons.chevron_right,
                  size: 20, color: AeroColors.muted),
            ]),
          ),
        ),
      ),
    );
  }
}
