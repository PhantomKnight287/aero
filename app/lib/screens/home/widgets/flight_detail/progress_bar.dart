import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// ━━━━✈──── ink for the flown part, a plane at the position.
/// Full width so its ends line up with the route card below.
class RouteProgressBar extends StatelessWidget {
  final String from;
  final String to;
  final double progress;

  const RouteProgressBar(
      {super.key,
      required this.from,
      required this.to,
      required this.progress});

  static const _plane = 24.0;
  static const _track = 3.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${(progress * 100).round()}% of the way from $from to $to',
      excludeSemantics: true,
      child: SizedBox(
        height: _plane,
        child: LayoutBuilder(builder: (_, box) {
          final x = (box.maxWidth - _plane) * progress;
          const bar = BorderRadius.all(Radius.circular(_track));
          return Stack(alignment: Alignment.centerLeft, children: [
            Container(
                height: _track,
                decoration: const BoxDecoration(
                    color: AeroColors.line, borderRadius: bar)),
            Container(
                width: x + _plane / 2,
                height: _track,
                decoration: const BoxDecoration(
                    color: AeroColors.ink, borderRadius: bar)),
            // White plane on an ink disc: reads against the ink track.
            Positioned(
              left: x,
              child: Container(
                width: _plane,
                height: _plane,
                decoration: const BoxDecoration(
                    color: AeroColors.ink, shape: BoxShape.circle),
                child: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.flight, size: 14, color: AeroColors.onInk),
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
