import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

const _top = 8;

/// Average taxi-out/in per airport (actual times only) and the longest
/// single taxi.
class TaxiSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const TaxiSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = stats.taxiByAirport;
    if (t.items.isEmpty && t.longest == null) return const SizedBox.shrink();
    num samples(TaxiAirportEntity e) => e.taxiOutCount + e.taxiInCount;
    final sorted = [...t.items]
      ..sort((a, b) => samples(b).compareTo(samples(a)));
    // Overall average taxi-out = sample-weighted mean of the airport averages.
    num outMin = 0, outN = 0;
    for (final e in t.items) {
      if (e.avgTaxiOutMin == null) continue;
      outMin += e.avgTaxiOutMin! * e.taxiOutCount;
      outN += e.taxiOutCount;
    }
    return StatSection(
      title: 'Taxi by airport',
      hero: outN > 0 ? '${(outMin / outN).round()}m' : null,
      heroUnit: outN > 0 ? 'avg taxi-out' : null,
      onShowMore: sorted.length > _top
          ? () => showListSheet(
              context, 'Taxi by airport', [for (final e in sorted) _row(e)])
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          basedOn(t.basedOn),
          for (final e in sorted.take(_top)) ...[
            const SizedBox(height: AeroSpace.md),
            _row(e),
          ],
          recordRow(context, 'Longest taxi', t.longest, (v) => '${v.round()}m'),
        ],
      ),
    );
  }

  /// 'DEL · taxi-out 22m avg (9 flights)', then taxi-in on its own line.
  Widget _row(TaxiAirportEntity e) {
    String line(String kind, num? avg, num n) =>
        '$kind ${avg!.round()}m avg (${count(n)} ${n == 1 ? 'flight' : 'flights'})';
    final code = airportCode(e.airport);
    final lines = [
      if (e.avgTaxiOutMin != null && e.taxiOutCount > 0)
        line('taxi-out', e.avgTaxiOutMin, e.taxiOutCount),
      if (e.avgTaxiInMin != null && e.taxiInCount > 0)
        line('taxi-in', e.avgTaxiInMin, e.taxiInCount),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final l in lines)
          Text('$code · $l',
              style: AeroText.body.copyWith(
                  color: AeroColors.ink, fontFeatures: AeroText.tabular)),
        Text(e.airport.name,
            style: AeroText.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
