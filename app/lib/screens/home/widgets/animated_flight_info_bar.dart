import 'dart:ui';

import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

/// Live altitude · speed · heading pill over the map. Altitude and speed
/// are tap-to-cycle unit values.
class AnimatedFlightInfoBar extends StatelessWidget {
  /// Feet.
  final int altitude;

  /// Knots.
  final int speed;
  final int? heading;

  const AnimatedFlightInfoBar({
    super.key,
    required this.altitude,
    required this.speed,
    this.heading,
  });

  static final _style = AeroText.caption.copyWith(
    color: AeroColors.onInk,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    fontFeatures: AeroText.tabular,
  );

  static const _flip = Duration(milliseconds: 500);

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AeroSpace.sm),
        child: Text('•', style: _style.copyWith(color: AeroColors.onInkMuted)),
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AeroRadius.pillAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AeroSpace.lg, vertical: AeroSpace.sm),
          decoration: BoxDecoration(
            color: AeroColors.glass,
            borderRadius: AeroRadius.pillAll,
            border: Border.all(color: AeroColors.glassEdge),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UnitCycle(
                dimension: UnitDimension.altitude,
                builder: (_, u) {
                  final fl = showsFlightLevel(altitude, u.altitude);
                  // FL below 1,000 ft falls back to feet.
                  final unit = fl
                      ? AltitudeUnit.fl
                      : u.altitude == AltitudeUnit.fl
                          ? AltitudeUnit.ft
                          : u.altitude;
                  return AnimatedFlipCounter(
                    value: convertAltitude(altitude, unit).round(),
                    duration: _flip,
                    prefix: fl ? 'FL' : null,
                    wholeDigits: fl ? 3 : 1,
                    suffix: fl ? null : ' ${unitLabel(unit)}',
                    thousandSeparator: ',',
                    textStyle: _style,
                  );
                },
              ),
              _dot(),
              UnitCycle(
                dimension: UnitDimension.speed,
                builder: (_, u) => AnimatedFlipCounter(
                  value: convertSpeed(speed, u.speed).round(),
                  duration: _flip,
                  suffix: ' ${unitLabel(u.speed)}',
                  thousandSeparator: ',',
                  textStyle: _style,
                ),
              ),
              if (heading != null) ...[
                _dot(),
                AnimatedFlipCounter(
                  value: heading!,
                  duration: _flip,
                  suffix: '°',
                  textStyle: _style,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
