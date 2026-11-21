import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens.dart';
import 'aero_pressable.dart';

enum AeroButtonKind { primary, secondary, destructive }

/// Use instead of Text/Elevated/OutlinedButton in new code.
class AeroButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AeroButtonKind kind;
  final bool loading;

  const AeroButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.kind = AeroButtonKind.primary,
    this.loading = false,
  });

  const AeroButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  }) : kind = AeroButtonKind.secondary;

  const AeroButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  }) : kind = AeroButtonKind.destructive;

  void _handlePress() {
    // Haptics only where they earn it: committing a destructive action.
    if (kind == AeroButtonKind.destructive) HapticFeedback.mediumImpact();
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (kind) {
      AeroButtonKind.primary => (AeroColors.ink, AeroColors.onInk),
      AeroButtonKind.destructive => (AeroColors.danger, AeroColors.onInk),
      AeroButtonKind.secondary => (AeroColors.surfaceAlt, AeroColors.ink),
    };
    final enabled = onPressed != null && !loading;
    return AeroPressable(
      enabled: enabled,
      child: SizedBox(
        height: 52,
        child: TextButton(
          onPressed: enabled ? _handlePress : null,
          style: TextButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            disabledBackgroundColor: bg.withValues(alpha: .5),
            disabledForegroundColor: fg,
            overlayColor: fg,
            shape: const RoundedRectangleBorder(borderRadius: AeroRadius.mdAll),
            // Full style incl. fontFamily: styleFrom replaces, not merges.
            textStyle: AeroText.heading,
          ),
          child: loading
              ? SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              : Text(label, style: AeroText.heading.copyWith(color: fg)),
        ),
      ),
    );
  }
}
