import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flag.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

const _top = 3;

String _continent(ContinentBucket b) => switch (b) {
      ContinentBucket.asia => 'Asia',
      ContinentBucket.europe => 'Europe',
      ContinentBucket.northAmerica => 'N. America',
      ContinentBucket.middleEast => 'Middle East',
      ContinentBucket.oceania => 'Oceania',
      ContinentBucket.africa => 'Africa',
      ContinentBucket.centralAmerica => 'C. America',
      ContinentBucket.caribbean => 'Caribbean',
      ContinentBucket.southAmerica => 'S. America',
      _ => b.name,
    };

/// Countries & territories: top 3 with flight counts, a sheet of all, and
/// a 3-column continent grid (country count + share of flights).
class CountriesSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const CountriesSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final countries = [...stats.countries]
      ..sort((a, b) => b.flightCount.compareTo(a.flightCount));
    if (countries.isEmpty) return const SizedBox.shrink();
    final continents = stats.continents.toList();
    return StatSection(
      title: 'Countries & territories',
      hero: count(stats.passport.totalCountries),
      heroUnit: 'total',
      onShowMore: countries.length > _top
          ? () => showListSheet(context, 'Countries & territories',
              [for (final c in countries) _row(c)])
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final c in countries.take(_top)) ...[
            _row(c),
            const SizedBox(height: AeroSpace.md),
          ],
          for (var i = 0; i < continents.length; i += 3) ...[
            if (i > 0) const SizedBox(height: AeroSpace.sm),
            Row(children: [
              for (var j = i; j < i + 3; j++) ...[
                if (j > i) const SizedBox(width: AeroSpace.sm),
                Expanded(
                  child: j < continents.length
                      ? _tile(continents[j])
                      : const SizedBox.shrink(),
                ),
              ],
            ]),
          ],
        ],
      ),
    );
  }

  Widget _row(CountryEntity c) => SheetRow(
        leading: c.isoCountry.length == 2
            ? Text(flagEmoji(c.isoCountry), style: AeroText.title)
            : null,
        title: c.name,
        value: '${count(c.flightCount)} '
            '${c.flightCount == 1 ? 'flight' : 'flights'}',
      );

  Widget _tile(ContinentEntity c) => Container(
        padding: const EdgeInsets.all(AeroSpace.md),
        decoration: const BoxDecoration(
          color: AeroColors.surfaceAlt,
          borderRadius: AeroRadius.mdAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_continent(c.bucket).toUpperCase(),
                style: AeroText.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(count(c.countryCount),
                style:
                    AeroText.heading.copyWith(fontFeatures: AeroText.tabular)),
            Text('${(c.flightShare * 100).round()}%', style: tabularCaption),
          ],
        ),
      );
}
