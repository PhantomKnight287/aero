import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/widgets/stat_bar_list.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'shared.dart';

const _top = 8;

/// Top-N bars with a Flights / Distance switch; 'Show more' lists [items]
/// in full.
class _TopSection<T> extends StatelessWidget {
  final String title;
  final String hero;
  final String heroUnit;
  final List<T> items;
  final num Function(T) flights;
  final num Function(T) distanceKm;
  final Widget Function(T) label;
  final Widget Function(T) sheetRow;

  const _TopSection({
    super.key,
    required this.title,
    required this.hero,
    required this.heroUnit,
    required this.items,
    required this.flights,
    required this.distanceKm,
    required this.label,
    required this.sheetRow,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final unit = context.watch<UnitsNotifier>().distance;
    List<StatBar> bars(num Function(T) by, String Function(T) text) =>
        ([...items]..sort((a, b) => by(b).compareTo(by(a))))
            .take(_top)
            .map((e) =>
                StatBar(label: label(e), value: by(e), valueLabel: text(e)))
            .toList();
    return StatSection(
      title: title,
      hero: hero,
      heroUnit: heroUnit,
      onShowMore: items.length > _top
          ? () => showListSheet(
              context, title, [for (final e in items) sheetRow(e)])
          : null,
      child: StatBarList.switchable(
        byFlights: bars(flights, (e) => count(flights(e))),
        byDistance:
            bars(distanceKm, (e) => formatDistance(distanceKm(e), unit)),
        color: AeroAccent.passport,
      ),
    );
  }
}

Text _code(String s) =>
    Text(s, style: AeroText.heading.copyWith(fontFeatures: AeroText.tabular));

String _flights(num n) => '${count(n)} ${n == 1 ? 'flight' : 'flights'}';

class TopAirportsSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const TopAirportsSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) => s.topAirports.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return _TopSection<TopAirportEntity>(
      title: 'Top airports',
      hero: count(stats.passport.totalAirports),
      heroUnit: 'total airports',
      items: stats.topAirports.toList(),
      flights: (e) => e.flightCount,
      distanceKm: (e) => e.distanceKm,
      label: (e) => _code(airportCode(e.airport)),
      sheetRow: (e) => SheetRow(
        title: airportCodes(e.airport),
        lines: [
          e.airport.name,
          e.airport.city,
          '${count(e.departures)} dep · ${count(e.arrivals)} arr',
        ],
        value: _flights(e.flightCount),
      ),
    );
  }
}

class TopAirlinesSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const TopAirlinesSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) => s.topAirlines.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<UnitsNotifier>().distance;
    return _TopSection<TopAirlineEntity>(
      title: 'Top airlines',
      hero: count(stats.passport.totalAirlines),
      heroUnit: 'total airlines',
      items: stats.topAirlines.toList(),
      flights: (e) => e.flightCount,
      distanceKm: (e) => e.distanceKm,
      label: (e) => Row(children: [
        AirlineLogo(svgUrl: e.airline.image, icao: e.airline.icao, size: 20),
        const SizedBox(width: AeroSpace.sm),
        Expanded(
          child: Text(e.airline.name,
              style: AeroText.heading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ]),
      sheetRow: (e) => SheetRow(
        leading: AirlineLogo(svgUrl: e.airline.image, icao: e.airline.icao),
        title: e.airline.name,
        lines: [
          [e.airline.iata, e.airline.icao].whereType<String>().join(' · '),
          formatDistance(e.distanceKm, unit),
        ],
        value: _flights(e.flightCount),
      ),
    );
  }
}

class TopRoutesSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const TopRoutesSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) => s.topRoutes.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<UnitsNotifier>().distance;
    String route(TopRouteEntity e) =>
        '${airportCode(e.from)}-${airportCode(e.to)}';
    return _TopSection<TopRouteEntity>(
      title: 'Top routes',
      hero: count(stats.topRoutes.length),
      heroUnit: stats.topRoutes.length == 1 ? 'route' : 'routes',
      items: stats.topRoutes.toList(),
      flights: (e) => e.flightCount,
      distanceKm: (e) => e.distanceKm,
      label: (e) => _code(route(e)),
      sheetRow: (e) => SheetRow(
        title: route(e),
        lines: [
          '${e.from.city} → ${e.to.city}',
          formatDistance(e.distanceKm, unit),
        ],
        value: _flights(e.flightCount),
      ),
    );
  }
}
