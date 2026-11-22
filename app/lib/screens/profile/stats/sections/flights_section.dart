import 'package:aero/screens/profile/stats/widgets/bar_chart.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/components/aero_segmented.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

enum _Per { year, month, weekday }

const _months = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

/// Totals split domestic/international/long haul, plus flights per
/// year, month or weekday. Year is hidden when a year is selected.
class FlightsSection extends StatefulWidget {
  final ProfileStatsResponseEntity stats;

  const FlightsSection({super.key, required this.stats});

  static bool shows(ProfileStatsResponseEntity s) =>
      s.passport.totalFlights > 0;

  @override
  State<FlightsSection> createState() => _FlightsSectionState();
}

class _FlightsSectionState extends State<FlightsSection> {
  _Per? _per;

  @override
  Widget build(BuildContext context) {
    final s = widget.stats;
    final p = s.passport;
    if (!FlightsSection.shows(s)) return const SizedBox.shrink();
    final options = [if (s.year == null) _Per.year, _Per.month, _Per.weekday];
    final per = options.contains(_per) ? _per! : options.first;
    final (values, labels) = switch (per) {
      _Per.year => (
          [for (final y in s.flightsPer.year) y.count.toInt()],
          [for (final y in s.flightsPer.year) "'${y.year.toInt() % 100}"],
        ),
      _Per.month => ([for (final v in s.flightsPer.month) v.toInt()], _months),
      _Per.weekday => (
          [for (final v in s.flightsPer.weekday) v.toInt()],
          _weekdays
        ),
    };
    return StatSection(
      title: 'Flights',
      hero: count(p.totalFlights),
      heroUnit: p.totalFlights == 1 ? 'flight' : 'flights',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              '${count(p.domestic)} domestic · ${count(p.international)} '
              'international · ${count(p.longHaul)} long haul',
              style: tabularBody),
          const SizedBox(height: AeroSpace.lg),
          Text('FLIGHTS PER', style: AeroText.label),
          const SizedBox(height: AeroSpace.sm),
          AeroSegmented<_Per>(
            values: options,
            selected: per,
            label: (v) => switch (v) {
              _Per.year => 'Year',
              _Per.month => 'Month',
              _Per.weekday => 'Weekday',
            },
            onChanged: (v) => setState(() => _per = v),
          ),
          const SizedBox(height: AeroSpace.md),
          BarChart(values: values, labels: labels, color: AeroAccent.passport),
        ],
      ),
    );
  }
}
