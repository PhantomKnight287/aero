import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/widgets/comparison_pill.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'shared.dart';

const _earthKm = 40075;
const _moonKm = 384400;
// The Sun's circumference, rounded (Flighty's "Around the Sun").
const _sunKm = 4370000;

/// '12.4' from 1 up, '0.11' below.
String _times(double v) => formatDecimal(v, digits: v >= 1 ? 1 : 2);

/// Total distance in the user's unit, the other unit, the average, Earth,
/// Moon and Sun comparisons, and the shortest/longest flights.
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
    String dist(num v) => formatDistance(v, unit);
    Widget pill(ComparisonIcon icon, int ref, String label) {
      final f = km / ref;
      return Padding(
        padding: const EdgeInsets.only(bottom: AeroSpace.sm),
        child: ComparisonPill(
            icon: icon, fraction: f, value: '${_times(f)}×', label: label),
      );
    }

    return StatSection(
      title: 'Distance',
      heroWidget: UnitText.distance(km, unit, style: AeroText.hero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(formatDistance(km, other),
              style: AeroText.heroUnit.copyWith(
                  fontSize: AeroText.title.fontSize! - 2,
                  fontFeatures: AeroText.tabular)),
          if (p.totalFlights > 0)
            Text('Average distance: ${dist(km / p.totalFlights)}',
                style: tabularBody),
          const SizedBox(height: AeroSpace.lg),
          pill(ComparisonIcon.earth, _earthKm, 'Around Earth'),
          pill(ComparisonIcon.moon, _moonKm, 'To the Moon'),
          pill(ComparisonIcon.sun, _sunKm, 'Around the Sun'),
          recordRow(
              context, 'Shortest flight', stats.records.shortestDistance, dist),
          recordRow(
              context, 'Longest flight', stats.records.longestDistance, dist),
        ],
      ),
    );
  }
}
