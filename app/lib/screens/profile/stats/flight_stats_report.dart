import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/report_scaffold.dart';
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
class FlightStatsReport extends StatelessWidget {
  final int? year;
  final StatsController? controller;

  const FlightStatsReport({super.key, this.year, this.controller});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      title: 'Flight stats',
      year: year,
      controller: controller,
      build: (s) => [
        PassportHeader(stats: s),
        if (FlightsSection.shows(s)) FlightsSection(stats: s),
        if (DistanceSection.shows(s)) DistanceSection(stats: s),
        if (TimeSection.shows(s)) TimeSection(stats: s),
        if (TopAirportsSection.shows(s)) TopAirportsSection(stats: s),
        if (TopAirlinesSection.shows(s)) TopAirlinesSection(stats: s),
        if (TopRoutesSection.shows(s)) TopRoutesSection(stats: s),
        if (RunwaysSection.shows(s)) RunwaysSection(stats: s),
        if (TaxiSection.shows(s)) TaxiSection(stats: s),
        if (ExtremesSection.shows(s)) ExtremesSection(stats: s),
        if (CountriesSection.shows(s)) CountriesSection(stats: s),
      ],
    );
  }
}
