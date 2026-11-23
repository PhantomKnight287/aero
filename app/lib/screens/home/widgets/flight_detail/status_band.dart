import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

import 'flight_status.dart';

(Color, Color) punctualityColors(Punctuality p) => switch (p) {
      Punctuality.early || Punctuality.onTime => (
          AeroColors.success,
          AeroColors.successTint
        ),
      Punctuality.late => (AeroColors.warn, AeroColors.warnTint),
      Punctuality.cancelled => (AeroColors.danger, AeroColors.dangerTint),
    };

/// One tinted line: 'In flight · lands in 40m'.
class StatusBand extends StatelessWidget {
  final LiveStatus status;
  final DateTime now;

  /// Shown under the band for lookups more than a week old.
  final bool stale;

  const StatusBand(
      {super.key, required this.status, required this.now, this.stale = false});

  @override
  Widget build(BuildContext context) {
    final p = status.phase == FlightPhase.diverted
        ? Punctuality.cancelled
        : status.overall;
    final (ink, tint) = punctualityColors(p);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AeroSpace.lg, vertical: AeroSpace.md),
          decoration:
              BoxDecoration(color: tint, borderRadius: AeroRadius.mdAll),
          child: Text(status.bandText(now),
              style: AeroText.heading
                  .copyWith(color: ink, fontFeatures: AeroText.tabular)),
        ),
        if (stale) ...[
          const SizedBox(height: AeroSpace.xs),
          Text('Older than 7 days — times may no longer update.',
              style: AeroText.caption),
        ],
      ],
    );
  }
}
