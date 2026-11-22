import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/components/country_flag.dart';
import 'package:aero/ui/tokens.dart';
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

String _plural(num n, String one, String many) =>
    '${count(n)} ${n == 1 ? one : many}';

/// Countries & territories: top 3 rows (flag, name, flights), a sheet of
/// all, then the regions with flights in the same row style.
class CountriesSection extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const CountriesSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) => s.countries.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final countries = [...stats.countries]
      ..sort((a, b) => b.flightCount.compareTo(a.flightCount));
    if (!shows(stats)) return const SizedBox.shrink();
    final regions = [
      for (final c in stats.continents)
        if (c.flightCount > 0) c
    ]..sort((a, b) => b.flightCount.compareTo(a.flightCount));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatSection(
          title: 'Countries & territories',
          hero: count(stats.passport.totalCountries),
          heroUnit: 'total',
          onShowMore: countries.length > _top
              ? () => showListSheet(context, 'Countries & territories',
                  [for (final c in countries) _country(c)])
              : null,
          child: _rows([for (final c in countries.take(_top)) _country(c)]),
        ),
        if (regions.isNotEmpty) ...[
          const SizedBox(height: AeroSpace.xl),
          Text('REGIONS', style: AeroText.label),
          const SizedBox(height: AeroSpace.xs),
          _rows([
            for (final r in regions)
              _PlaceRow(
                name: _continent(r.bucket),
                value: '${_plural(r.countryCount, 'country', 'countries')}'
                    ' · ${_plural(r.flightCount, 'flight', 'flights')}',
              ),
          ]),
        ],
      ],
    );
  }

  Widget _country(CountryEntity c) => _PlaceRow(
        flag: c.isoCountry,
        name: c.name,
        value: _plural(c.flightCount, 'flight', 'flights'),
      );

  /// Rows separated by hairlines.
  Widget _rows(List<Widget> rows) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AeroColors.line),
            rows[i],
          ],
        ],
      );
}

/// Optional round flag, name (w600) and a muted count on the right.
class _PlaceRow extends StatelessWidget {
  final String? flag;
  final String name;
  final String value;

  const _PlaceRow({this.flag, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
      child: Row(children: [
        if (flag != null) ...[
          CountryFlag(iso2: flag!, size: 30),
          const SizedBox(width: AeroSpace.md),
        ],
        Expanded(
          child: Text(name,
              style: AeroText.heading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: AeroSpace.sm),
        // ponytail: fixed cap so a huge text scale ellipsizes instead of
        // overflowing; "36 countries · 1,234 flights" is ~180 dp in Inter.
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AeroText.body.copyWith(
                  color: AeroColors.muted, fontFeatures: AeroText.tabular)),
        ),
      ]),
    );
  }
}
