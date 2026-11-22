import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/ui/components/country_flag.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'shared.dart';

/// '21.3°N' / '157.9°W'
String _deg(num? v, String pos, String neg) =>
    v == null ? '' : '${formatDecimal(v.abs())}°${v >= 0 ? pos : neg}';

/// The farthest airports in each direction, plus the highest.
class ExtremesSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const ExtremesSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) {
    final x = s.extremes;
    return [x.north, x.south, x.east, x.west, x.highest].any((a) => a != null);
  }

  @override
  Widget build(BuildContext context) {
    final x = stats.extremes;
    final alt = context.watch<UnitsNotifier>().altitude;
    final rows = [
      (
        'Northernmost',
        x.north,
        (StatsAirportEntity a) => _deg(a.lat, 'N', 'S')
      ),
      (
        'Southernmost',
        x.south,
        (StatsAirportEntity a) => _deg(a.lat, 'N', 'S')
      ),
      ('Easternmost', x.east, (StatsAirportEntity a) => _deg(a.lon, 'E', 'W')),
      ('Westernmost', x.west, (StatsAirportEntity a) => _deg(a.lon, 'E', 'W')),
      (
        'Highest',
        x.highest,
        (StatsAirportEntity a) =>
            a.elevationFt == null ? '' : formatElevation(a.elevationFt!, alt)
      ),
    ].where((r) => r.$2 != null).toList();
    if (rows.isEmpty) return const SizedBox.shrink();
    return StatSection(
      title: 'Extremes',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const SizedBox(height: AeroSpace.lg),
            _row(rows[i].$1, rows[i].$2!, rows[i].$3(rows[i].$2!)),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, StatsAirportEntity a, String value) {
    final iso = a.isoCountry;
    final place = [a.city, if (iso != null) iso].join(', ');
    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: AeroText.label),
            Text(airportCodes(a),
                style:
                    AeroText.heading.copyWith(fontFeatures: AeroText.tabular)),
            Text(a.name,
                style: AeroText.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: AeroSpace.xs),
            Row(children: [
              if (iso != null && iso.length == 2) ...[
                CountryFlag(iso2: iso, size: 20),
                const SizedBox(width: AeroSpace.sm),
              ],
              Expanded(
                child: Text(place,
                    style: AeroText.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ],
        ),
      ),
      const SizedBox(width: AeroSpace.sm),
      UnitText.parse(value,
          unitScale: 0.85,
          style: AeroText.body.copyWith(
              color: AeroColors.ink,
              fontWeight: FontWeight.w600,
              fontFeatures: AeroText.tabular)),
    ]);
  }
}
