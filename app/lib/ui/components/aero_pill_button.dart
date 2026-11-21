import 'package:flutter/material.dart';

import '../tokens.dart';
import 'aero_pressable.dart';

/// Compact secondary action inside a panel: white pill on the grey surface
/// with an icon, so it reads as a button before it is touched.
class AeroPillButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final IconData? trailing;
  final VoidCallback? onTap;

  const AeroPillButton({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(
          enabled: onTap != null,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AeroSpace.md, vertical: AeroSpace.sm),
            decoration: const BoxDecoration(
              color: AeroColors.surface,
              borderRadius: AeroRadius.pillAll,
              boxShadow: [
                BoxShadow(
                    color: AeroColors.shadow,
                    blurRadius: 4,
                    offset: Offset(0, 1)),
              ],
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 16, color: AeroColors.ink),
              const SizedBox(width: AeroSpace.sm),
              Text(label,
                  style: AeroText.caption.copyWith(
                      color: AeroColors.ink, fontWeight: FontWeight.w600)),
              if (trailing != null) ...[
                const SizedBox(width: AeroSpace.xs),
                Icon(trailing, size: 16, color: AeroColors.ink),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}
