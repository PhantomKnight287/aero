import 'package:aero/screens/profile/stats/widgets/stat_bar_list.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

const _top = 8;

/// Runways used (FlightAware actualRunwayOff/On): top bars, and a sheet of
/// every runway grouped by airport.
class RunwaysSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const RunwaysSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) => s.runways.items.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final r = stats.runways;
    if (!shows(stats)) return const SizedBox.shrink();
    num uses(RunwayUseEntity u) => u.departures + u.arrivals;
    final sorted = [...r.items]..sort((a, b) => uses(b).compareTo(uses(a)));
    return StatSection(
      title: 'Runway log',
      hero: count(r.items.length),
      heroUnit: 'runways used',
      onShowMore: () => _showAll(context, sorted),
      showMoreLabel: 'Show all runways',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          basedOn(r.basedOn),
          const SizedBox(height: AeroSpace.md),
          StatBarList(
            color: AeroAccent.passport,
            labelWidth: 84,
            rows: [
              for (final u in sorted.take(_top))
                StatBar(
                  label: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '${airportCode(u.airport)} ${u.runway}',
                          style: AeroText.heading),
                      TextSpan(text: '  ${_offOn(u)}', style: AeroText.caption),
                    ]),
                    style: const TextStyle(fontFeatures: AeroText.tabular),
                  ),
                  value: uses(u),
                  valueLabel: count(uses(u)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _offOn(RunwayUseEntity u) =>
      '${count(u.departures)} off · ${count(u.arrivals)} on';

  void _showAll(BuildContext context, List<RunwayUseEntity> sorted) {
    // Group by airport, keeping the busiest airport (and runway) first.
    final groups = <String, List<RunwayUseEntity>>{};
    for (final u in sorted) {
      groups
          .putIfAbsent(u.airport.icao ?? airportCode(u.airport), () => [])
          .add(u);
    }
    showListSheet(context, 'Runway log', [
      for (final g in groups.values)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${airportCodes(g.first.airport)} · ${g.first.airport.name}',
                style: AeroText.heading),
            for (final u in g)
              Padding(
                padding: const EdgeInsets.only(top: AeroSpace.xs),
                child: Text('Runway ${u.runway} · ${_offOn(u)}',
                    style: tabularBody),
              ),
          ],
        ),
    ]);
  }
}
