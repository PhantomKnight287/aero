import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/report_scaffold.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

import 'sections/delay_sections.dart';

/// Delay stats for one year (or all-time). Flight rows pop an
/// OpenFlightRequest back to the hub.
class DelayReport extends StatelessWidget {
  final int? year;
  final StatsController? controller;

  const DelayReport({super.key, this.year, this.controller});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      title: 'Delay report',
      year: year,
      controller: controller,
      build: (s) {
        final d = s.delays;
        if (d.buckets.total == 0) {
          return [
            Text('No FlightAware times for this period yet.',
                style: AeroText.caption),
          ];
        }
        return [
          DelayHeroCard(d: d),
          DelayBreakdownSection(d: d),
          if (WorstAirlinesSection.shows(d)) WorstAirlinesSection(d: d),
          if (AirlinePerformanceSection.shows(d))
            AirlinePerformanceSection(d: d),
          if (AirportPerformanceSection.shows(d))
            AirportPerformanceSection(d: d),
          if (DelayedFlightsSection.shows(d)) DelayedFlightsSection(d: d),
        ];
      },
    );
  }
}
