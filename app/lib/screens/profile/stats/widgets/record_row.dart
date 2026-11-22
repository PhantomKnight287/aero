import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'past_flight_row.dart';

/// A record line: caption ('Longest flight'), the flight, and its value.
class RecordRow extends StatelessWidget {
  final String caption;
  final StatsFlightSummaryEntity flight;
  final String value;
  final VoidCallback? onTap;

  const RecordRow({
    super.key,
    required this.caption,
    required this.flight,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
      child: Row(children: [
        AirlineLogo(svgUrl: flight.airline.image, icao: flight.airline.icao),
        const SizedBox(width: AeroSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(caption.toUpperCase(), style: AeroText.label),
              Text(flightAirports(flight), style: AeroText.heading),
              Text('${flightIdents(flight)} · ${flightDate(flight)}',
                  style: AeroText.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(width: AeroSpace.sm),
        Text(value,
            style: AeroText.body.copyWith(
                color: AeroColors.ink,
                fontWeight: FontWeight.w600,
                fontFeatures: AeroText.tabular)),
        if (onTap != null)
          const Icon(Icons.chevron_right, size: 20, color: AeroColors.muted),
      ]),
    );
    if (onTap == null) return row;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(child: row),
      ),
    );
  }
}
