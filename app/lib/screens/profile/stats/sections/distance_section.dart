import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/widgets/comparison_pill.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'shared.dart';

const _earthKm = 40075;
const _moonKm = 384400;

/// Total distance in the user's unit, the other unit, the average, Earth
/// and Moon comparisons, and the shortest/longest flights.
class DistanceSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const DistanceSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) =>
      s.passport.totalDistanceKm > 0;

  @override
  Widget build(BuildContext context) {
    final p = stats.passport;
    if (!shows(stats)) return const SizedBox.shrink();
    final unit = context.watch<UnitsNotifier>().distance;
    final other = unit == DistanceUnit.km ? DistanceUnit.mi : DistanceUnit.km;
    final km = p.totalDistanceKm;
    final earth = km / _earthKm, moon = km / _moonKm;
    String dist(num v) => formatDistance(v, unit);
    return StatSection(
      title: 'Distance',
      hero: count(convertDistance(km, unit)),
      heroUnit: unitLabel(unit),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              [
                formatDistance(km, other),
                if (p.totalFlights > 0) 'avg ${dist(km / p.totalFlights)}',
              ].join(' · '),
              style: tabularBody),
          const SizedBox(height: AeroSpace.lg),
          ComparisonPill(
              icon: '🌍',
              fraction: earth,
              label: '${earth.toStringAsFixed(1)}× around Earth'),
          const SizedBox(height: AeroSpace.sm),
          ComparisonPill(
              icon: '🌕',
              fraction: moon,
              label: '${moon.toStringAsFixed(1)}× to the Moon'),
          const SizedBox(height: AeroSpace.sm),
          recordRow(
              context, 'Shortest flight', stats.records.shortestDistance, dist),
          recordRow(
              context, 'Longest flight', stats.records.longestDistance, dist),
        ],
      ),
    );
  }
}
