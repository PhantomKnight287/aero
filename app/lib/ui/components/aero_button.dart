import 'package:flutter/material.dart';

import '../tokens.dart';

enum AeroButtonKind { primary, secondary, destructive }

/// Full-width-capable button. Use instead of Text/Elevated/OutlinedButton in
/// new code.
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

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (kind) {
      AeroButtonKind.primary => (AeroColors.ink, AeroColors.onInk, null),
      AeroButtonKind.destructive => (AeroColors.danger, AeroColors.onInk, null),
      AeroButtonKind.secondary => (
          AeroColors.surface,
          AeroColors.ink,
          const BorderSide(color: AeroColors.line),
        ),
    };
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: loading ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg.withValues(alpha: .5),
          disabledForegroundColor: fg,
          side: border,
          shape: const RoundedRectangleBorder(borderRadius: AeroRadius.mdAll),
          textStyle: AeroText.heading,
        ),
        child: loading
            ? SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg),
              )
            : Text(label),
      ),
    );
  }
}
