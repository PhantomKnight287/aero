import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

/// Compact, info-dense summary of one flight: airline, both flight numbers
/// (IATA + ICAO), route with IATA/ICAO codes, cities, scheduled local times,
/// aircraft and distance. Used where a flight must be recognisable at a
/// glance (e.g. the delete confirmation).
class FlightSummaryCard extends StatelessWidget {
  final FlightResponseEntity flight;

  const FlightSummaryCard({super.key, required this.flight});

  /// Distinct identifiers, IATA first: "EK380 · UAE380".
  static String identifiers(FlightResponseEntity f) {
    final fa = f.flightAwareData;
    final ids = <String>[
      fa?.identIata ?? f.flightNo,
      fa?.identIcao ?? f.callSign,
    ].where((s) => s.trim().isNotEmpty).toSet();
    return ids.join(' · ');
  }

  /// Scheduled block time, e.g. "7h 35m".
  String? _duration() {
    try {
      final d = DateTime.parse(flight.arrival.scheduledTime.utc)
          .difference(DateTime.parse(flight.departure.scheduledTime.utc));
      if (d.isNegative) return null;
      return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fa = flight.flightAwareData;
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final aircraft = <String?>[
      flight.aircraft?.model ?? fa?.aircraftType,
      flight.aircraft?.registration ?? fa?.registration,
    ].whereType<String>().where((s) => s.isNotEmpty).join(' · ');
    final km = num.tryParse(flight.greatCircleDistance.km ?? '');
    final duration = _duration();
    final legStyle = AeroText.micro.copyWith(fontFeatures: AeroText.tabular);

    return Container(
      padding: const EdgeInsets.all(AeroSpace.lg),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AirlineLogo(
                svgUrl: flight.airline.image,
                icao: flight.airline.icao,
                size: 28,
              ),
              const SizedBox(width: AeroSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight.airline.name,
                      style: AeroText.caption,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      identifiers(flight),
                      style: AeroText.heading
                          .copyWith(fontFeatures: AeroText.tabular),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('EEE, d MMM yyyy').format(flight.date.toLocal()),
                style: AeroText.caption,
              ),
            ],
          ),
          const SizedBox(height: AeroSpace.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _Endpoint(
                  segment: flight.departure,
                  use24: use24,
                  alignEnd: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AeroSpace.xs),
                child: Column(
                  children: [
                    const Icon(Icons.flight, size: 18, color: AeroColors.muted),
                    if (duration != null) Text(duration, style: legStyle),
                    if (km != null)
                      UnitCycle(
                        dimension: UnitDimension.distance,
                        builder: (_, u) => Text(formatDistance(km, u.distance),
                            style: legStyle),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: _Endpoint(
                  segment: flight.arrival,
                  use24: use24,
                  alignEnd: true,
                ),
              ),
            ],
          ),
          if (aircraft.isNotEmpty) ...[
            const SizedBox(height: AeroSpace.md),
            Text(aircraft, style: AeroText.caption),
          ],
        ],
      ),
    );
  }
}

class _Endpoint extends StatelessWidget {
  final RouteInfoEntity segment;
  final bool use24;
  final bool alignEnd;

  const _Endpoint({
    required this.segment,
    required this.use24,
    required this.alignEnd,
  });

  DateTime? _time() => DateTime.tryParse(segment.scheduledTime.utc);

  @override
  Widget build(BuildContext context) {
    final airport = segment.airport;
    final align = alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textAlign = alignEnd ? TextAlign.end : TextAlign.start;
    final time = _time();
    return Column(
      crossAxisAlignment: align,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(text: airport.iata, style: AeroText.title),
            TextSpan(text: '  ${airport.icao}', style: AeroText.micro),
          ]),
          textAlign: textAlign,
        ),
        const SizedBox(height: AeroSpace.xs),
        Text(
          airport.municipalityName,
          style: AeroText.caption,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
        ),
        if (time != null) ...[
          const SizedBox(height: AeroSpace.xs),
          UnitCycle(
            dimension: UnitDimension.time,
            builder: (_, u) => Text(
              formatClock(time,
                  airportTz: segment.airport.timeZone,
                  mode: u.time,
                  use24: use24),
              style: AeroText.heading.copyWith(fontFeatures: AeroText.tabular),
            ),
          ),
        ],
      ],
    );
  }
}
