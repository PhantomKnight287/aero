import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// Painted globe, moon and sun circles.
enum ComparisonIcon {
  earth(AeroAccent.earthGradient, [0, .6, 1], Alignment(-.3, -.3)),
  moon(AeroAccent.moonGradient, [0, .7], Alignment(-.3, -.3)),
  sun(AeroAccent.sunGradient, [0, .7], Alignment.center);

  final List<Color> colors;
  final List<double> stops;
  final Alignment center;

  const ComparisonIcon(this.colors, this.stops, this.center);
}

/// Full-width rounded bar filled to [fraction] (capped at 1), a painted
/// icon at the left and '12.4× Around Earth' inside on the right.
class ComparisonPill extends StatelessWidget {
  static const fillKey = ValueKey('comparison-fill');
  static const _height = 48.0;
  static const _icon = 40.0;

  final ComparisonIcon icon;
  final double fraction;
  final String value;
  final String label;

  const ComparisonPill({
    super.key,
    required this.icon,
    required this.fraction,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final f = fraction.clamp(0.0, 1.0);
    return Semantics(
      label: '$value $label',
      excludeSemantics: true,
      child: Container(
        height: _height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            color: AeroAccent.passportTint, borderRadius: AeroRadius.pillAll),
        child: LayoutBuilder(
          builder: (context, c) {
            final fill = (c.maxWidth * f).clamp(_height, c.maxWidth);
            // The text is right-aligned: white only when the fill runs
            // under all of it, ink otherwise.
            TextSpan text(Color color) {
              final style = AeroText.body
                  .copyWith(color: color, fontFeatures: AeroText.tabular);
              return TextSpan(children: [
                TextSpan(
                    text: value,
                    style: style.copyWith(fontWeight: FontWeight.w700)),
                TextSpan(
                    text: ' $label',
                    style: style.copyWith(fontWeight: FontWeight.w500)),
              ]);
            }

            final onFill = fill >= c.maxWidth - AeroSpace.lg;
            return Stack(children: [
              // Never narrower than the icon's circle, so it always sits on
              // the fill.
              Container(
                key: fillKey,
                width: fill,
                decoration: const BoxDecoration(
                    color: AeroAccent.passport,
                    borderRadius: AeroRadius.pillAll),
              ),
              Positioned(
                left: (_height - _icon) / 2,
                top: (_height - _icon) / 2,
                child: Container(
                  width: _icon,
                  height: _icon,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                        center: icon.center,
                        colors: icon.colors,
                        stops: icon.stops),
                  ),
                ),
              ),
              Positioned.fill(
                left: _height + AeroSpace.sm,
                right: AeroSpace.lg,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    text(onFill ? AeroColors.onInk : AeroColors.ink),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
