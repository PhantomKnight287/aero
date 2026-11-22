import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// Emoji, a thin progress track filled to [fraction] (clamped 0-1), label.
class ComparisonPill extends StatelessWidget {
  final String icon;
  final double fraction;
  final String label;

  const ComparisonPill({
    super.key,
    required this.icon,
    required this.fraction,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AeroSpace.md, vertical: AeroSpace.sm),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.pillAll,
      ),
      child: Row(children: [
        Text(icon, style: AeroText.body),
        const SizedBox(width: AeroSpace.sm),
        SizedBox(
          width: 48,
          child: ClipRRect(
            borderRadius: AeroRadius.pillAll,
            child: Stack(children: [
              const SizedBox(
                  height: 6,
                  width: double.infinity,
                  child: ColoredBox(color: AeroColors.line)),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: const SizedBox(
                    height: 6, child: ColoredBox(color: AeroAccent.passport)),
              ),
            ]),
          ),
        ),
        const SizedBox(width: AeroSpace.sm),
        Expanded(
          child: Text(label,
              style: AeroText.caption.copyWith(color: AeroColors.ink),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    );
  }
}
