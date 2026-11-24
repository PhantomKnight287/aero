import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/screens/home/widgets/aircraft_section.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

/// The user's other flights on this directed route. Hidden while loading,
/// on error, and when there are none.
class RouteHistorySection extends StatefulWidget {
  final String route;
  final Future<RouteHistoryEntity?> Function() load;
  final OpenFlight? onOpenFlight;

  const RouteHistorySection({
    super.key,
    required this.route,
    required this.load,
    this.onOpenFlight,
  });

  @override
  State<RouteHistorySection> createState() => _RouteHistorySectionState();
}

class _RouteHistorySectionState extends State<RouteHistorySection> {
  late final Future<RouteHistoryEntity?> _future =
      widget.load().catchError((_) => null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RouteHistoryEntity?>(
      future: _future,
      builder: (context, snap) {
        final h = snap.data;
        if (h == null || h.flightCount <= 0) return const SizedBox.shrink();
        final n = h.flightCount.toInt();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('My history on this route', style: AeroText.sectionTitle),
            Text(widget.route, style: AeroText.caption),
            const SizedBox(height: AeroSpace.md),
            Row(children: [
              Expanded(
                  child: _Figure(
                      'Flights',
                      Text('${formatCount(n)} ${n == 1 ? 'flight' : 'flights'}',
                          style: _value))),
              Expanded(
                child: _Figure(
                  'Distance',
                  UnitCycle(
                    dimension: UnitDimension.distance,
                    builder: (_, u) => Text(
                        formatDistance(h.distanceKm, u.distance),
                        style: _value),
                  ),
                ),
              ),
              Expanded(
                  child: _Figure(
                      'Time',
                      Text(formatLongDuration(h.blockMinutes.toInt()),
                          style: _value))),
            ]),
            const SizedBox(height: AeroSpace.md),
            for (final f in h.recent) ...[
              const Divider(height: 1, color: AeroColors.line),
              PastFlightRow(
                flight: f,
                onTap: () {
                  final day = flightDay(f);
                  if (day == null) return;
                  widget.onOpenFlight
                      ?.call(f.flightNo, day, faFlightId: f.faFlightId);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}

final _value = AeroText.heading.copyWith(fontFeatures: AeroText.tabular);

class _Figure extends StatelessWidget {
  final String label;
  final Widget value;

  const _Figure(this.label, this.value);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AeroText.label),
          const SizedBox(height: 2),
          value,
        ],
      );
}
