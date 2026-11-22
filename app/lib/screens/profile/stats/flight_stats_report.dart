import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/year_filter.dart';
import 'package:aero/services/profile.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

import 'passport_header.dart';
import 'sections/countries_section.dart';
import 'sections/distance_section.dart';
import 'sections/extremes_section.dart';
import 'sections/flights_section.dart';
import 'sections/runways_section.dart';
import 'sections/taxi_section.dart';
import 'sections/time_section.dart';
import 'sections/top_lists_section.dart';

/// Full flight stats for one year (or all-time). Record rows pop an
/// OpenFlightRequest back to the hub.
class FlightStatsReport extends StatefulWidget {
  final int? year;
  final StatsController? controller;

  const FlightStatsReport({super.key, this.year, this.controller});

  @override
  State<FlightStatsReport> createState() => _FlightStatsReportState();
}

class _FlightStatsReportState extends State<FlightStatsReport> {
  late final StatsController _c;

  @override
  void initState() {
    super.initState();
    final service = ProfileService();
    _c = widget.controller ??
        StatsController(
          fetchStats: (y) => service.getProfileStats(year: y),
          // The report only needs stats.
          fetchHistory: (_, __) async => null,
        );
    _c.year = widget.year;
    _c.load();
  }

  @override
  void dispose() {
    if (widget.controller == null) _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroColors.surface,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _c,
          builder: (context, _) {
            final s = _c.stats;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  AeroSpace.lg, AeroSpace.sm, AeroSpace.lg, AeroSpace.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon:
                          const Icon(Icons.chevron_left, color: AeroColors.ink),
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: Text('Flight stats',
                          style: AeroText.display,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                  const SizedBox(height: AeroSpace.md),
                  if (s != null && s.availableYears.isNotEmpty) ...[
                    YearFilter(
                      years: [for (final y in s.availableYears) y.toInt()],
                      selected: _c.year,
                      onChanged: _c.setYear,
                    ),
                    const SizedBox(height: AeroSpace.lg),
                  ],
                  if (s == null && _c.error != null)
                    Text(_c.error!, style: AeroText.body)
                  else if (s == null)
                    const Padding(
                      padding: EdgeInsets.all(AeroSpace.xxl),
                      child: Center(
                          child:
                              CircularProgressIndicator(color: AeroColors.ink)),
                    )
                  else
                    // Only sections with data, so hidden ones leave no gap.
                    for (final w in [
                      PassportHeader(stats: s),
                      if (FlightsSection.shows(s)) FlightsSection(stats: s),
                      if (DistanceSection.shows(s)) DistanceSection(stats: s),
                      if (TimeSection.shows(s)) TimeSection(stats: s),
                      if (TopAirportsSection.shows(s))
                        TopAirportsSection(stats: s),
                      if (TopAirlinesSection.shows(s))
                        TopAirlinesSection(stats: s),
                      if (TopRoutesSection.shows(s)) TopRoutesSection(stats: s),
                      if (RunwaysSection.shows(s)) RunwaysSection(stats: s),
                      if (TaxiSection.shows(s)) TaxiSection(stats: s),
                      if (ExtremesSection.shows(s)) ExtremesSection(stats: s),
                      if (CountriesSection.shows(s)) CountriesSection(stats: s),
                    ]) ...[
                      w,
                      const SizedBox(height: AeroSpace.xxl),
                    ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
