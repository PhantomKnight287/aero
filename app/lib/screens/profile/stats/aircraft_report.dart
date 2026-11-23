import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/report_scaffold.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

import 'sections/aircraft_sections.dart';
import 'sections/shared.dart';

/// Aircraft types, family collection and airframe ages for one year (or
/// all-time). Flight rows pop an OpenFlightRequest back to the hub.
class AircraftReport extends StatelessWidget {
  final int? year;
  final StatsController? controller;

  const AircraftReport({super.key, this.year, this.controller});

  @override
  Widget build(BuildContext context) {
    return ReportScaffold(
      title: 'Aircraft',
      year: year,
      controller: controller,
      build: (s) {
        final a = s.aircraft;
        if (a.types.isEmpty && a.airframes.oldest == null) {
          return [
            Text('No aircraft data for this period yet.',
                style: AeroText.caption),
          ];
        }
        return [
          if (AircraftTypesSection.shows(a)) AircraftTypesSection(a: a),
          if (TypeCollectionSection.shows(a)) TypeCollectionSection(a: a),
          if (AirframesSection.shows(a)) AirframesSection(a: a),
          basedOn(a.basedOn, suffix: ' with aircraft data'),
        ];
      },
    );
  }
}
