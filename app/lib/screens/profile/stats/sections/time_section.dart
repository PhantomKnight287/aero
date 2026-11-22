import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

// Grid values: figure weight at the hero unit's size (26).
final _cellValue =
    AeroText.figure.copyWith(fontSize: AeroText.heroUnit.fontSize);

/// Block time total, a 2-column grid (days, average, air, taxi), and the
/// shortest and longest flights by duration.
class TimeSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const TimeSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) =>
      s.passport.blockMinutes > 0;

  @override
  Widget build(BuildContext context) {
    final p = stats.passport;
    if (!shows(stats)) return const SizedBox.shrink();
    final block = p.blockMinutes;
    String dur(num m) => formatLongDuration(m.round());
    UnitText minutes(num m) => UnitText.duration(m.round(), style: _cellValue);
    final cells = [
      _cell('Days',
          UnitText([(formatDecimal(block / 1440), false)], style: _cellValue)),
      if (p.totalFlights > 0)
        _cell('Avg flight', minutes(block / p.totalFlights)),
      if (p.airBasedOn > 0)
        _cell('In the air', minutes(p.airMinutes), p.airBasedOn),
      if (p.taxiBasedOn > 0)
        _cell('Taxiing', minutes(p.taxiMinutes), p.taxiBasedOn),
    ];
    return StatSection(
      title: 'Flight time',
      heroWidget: UnitText.duration(block.round(), style: AeroText.hero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cells.length; i += 2) ...[
            if (i > 0) const SizedBox(height: AeroSpace.lg),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: cells[i]),
              const SizedBox(width: AeroSpace.md),
              Expanded(
                  child: i + 1 < cells.length
                      ? cells[i + 1]
                      : const SizedBox.shrink()),
            ]),
          ],
          const SizedBox(height: AeroSpace.sm),
          recordRow(
              context, 'Shortest flight', stats.records.shortestDuration, dur),
          recordRow(
              context, 'Longest flight', stats.records.longestDuration, dur),
        ],
      ),
    );
  }

  /// Grey label, the value scaled down to fit, and an optional
  /// "N flights with data" note.
  Widget _cell(String label, Widget value, [num? basedOn]) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AeroText.body.copyWith(color: AeroColors.muted)),
          FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: value),
          if (basedOn != null)
            Text(
                '${count(basedOn)} ${basedOn == 1 ? 'flight' : 'flights'} '
                'with data',
                style: tabularCaption),
        ],
      );
}
