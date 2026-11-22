import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// A stats block: title, optional big hero number (+ unit), content, and an
/// optional 'Show more' link row.
class StatSection extends StatelessWidget {
  final String title;
  final String? hero;
  final String? heroUnit;
  final Widget child;
  final VoidCallback? onShowMore;
  final String showMoreLabel;

  const StatSection({
    super.key,
    required this.title,
    this.hero,
    this.heroUnit,
    required this.child,
    this.onShowMore,
    this.showMoreLabel = 'Show more',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AeroText.sectionTitle),
        if (hero != null) ...[
          const SizedBox(height: AeroSpace.sm),
          // Wrap so a long unit drops below the number instead of overflowing.
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: AeroSpace.xs,
            children: [
              Text(hero!, style: AeroText.hero),
              if (heroUnit != null) Text(heroUnit!, style: AeroText.heroUnit),
            ],
          ),
        ],
        const SizedBox(height: AeroSpace.lg),
        child,
        if (onShowMore != null) ...[
          const SizedBox(height: AeroSpace.md),
          Semantics(
            button: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onShowMore,
              child: AeroPressable(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(showMoreLabel,
                      style: AeroText.body.copyWith(
                          color: AeroAccent.passport,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: AeroSpace.xs),
                  const Icon(Icons.chevron_right,
                      size: 18, color: AeroAccent.passport),
                ]),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
