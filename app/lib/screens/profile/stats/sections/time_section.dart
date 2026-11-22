import 'package:aero/formatters/time.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

/// Block time total, days/weeks/average, air vs taxi, and the shortest and
/// longest flights by duration.
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
    return StatSection(
      title: 'Flight time',
      hero: hoursMinutes(block),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            _tile((block / 1440).toStringAsFixed(1), 'days'),
            const SizedBox(width: AeroSpace.sm),
            _tile((block / 10080).toStringAsFixed(1), 'weeks'),
            const SizedBox(width: AeroSpace.sm),
            _tile(p.totalFlights > 0 ? dur(block / p.totalFlights) : '-',
                'avg flight'),
          ]),
          if (p.airBasedOn > 0) ...[
            const SizedBox(height: AeroSpace.lg),
            _split('In the air', dur(p.airMinutes), p.airBasedOn),
          ],
          if (p.taxiBasedOn > 0) ...[
            const SizedBox(height: AeroSpace.md),
            _split('Taxiing', dur(p.taxiMinutes), p.taxiBasedOn),
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

  Widget _tile(String value, String label) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(AeroSpace.md),
          decoration: const BoxDecoration(
            color: AeroColors.surfaceAlt,
            borderRadius: AeroRadius.mdAll,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: AeroText.heading
                      .copyWith(fontFeatures: AeroText.tabular)),
              Text(label.toUpperCase(), style: AeroText.label),
            ],
          ),
        ),
      );

  Widget _split(String label, String value, num n) => Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AeroText.heading),
              basedOn(n),
            ],
          ),
        ),
        Text(value,
            style: AeroText.body.copyWith(
                color: AeroColors.ink,
                fontWeight: FontWeight.w600,
                fontFeatures: AeroText.tabular)),
      ]);
}
