import 'package:flutter/material.dart';

import '../tokens.dart';
import 'aero_button.dart';

/// Standard bottom sheet: drag handle, title block, content — one surface,
/// no dividers (grouping comes from spacing, not lines).
class AeroSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  /// Hide when the sheet already has an explicit cancel action.
  final bool showClose;

  const AeroSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.showClose = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AeroSpace.lg, 0, AeroSpace.lg, AeroSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: AeroSpace.md),
                width: 36,
                height: 4,
                decoration: const BoxDecoration(
                  color: AeroColors.handle,
                  borderRadius: AeroRadius.pillAll,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AeroText.title),
                      if (subtitle != null) ...[
                        const SizedBox(height: AeroSpace.xs),
                        Text(subtitle!, style: AeroText.body),
                      ],
                    ],
                  ),
                ),
                if (showClose)
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AeroColors.ink),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: AeroSpace.lg),
            child,
          ],
        ),
      ),
    );
  }
}

Future<T?> showAeroSheet<T>(BuildContext context, Widget sheet) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    sheetAnimationStyle: const AnimationStyle(
      curve: AeroMotion.sheet,
      reverseCurve: AeroMotion.easeOut,
      duration: AeroMotion.sheetIn,
      reverseDuration: AeroMotion.sheetOut,
    ),
    builder: (_) => sheet,
  );
}

/// Confirmation as a bottom sheet. Returns true only when confirmed.
/// See [AeroConfirmSheet] for the parameters.
Future<bool> showAeroConfirm(
  BuildContext context, {
  required String title,
  String? message,
  Widget? details,
  String? warning,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final result = await showAeroSheet<bool>(
    context,
    AeroConfirmSheet(
      title: title,
      message: message,
      details: details,
      warning: warning,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      destructive: destructive,
    ),
  );
  return result == true;
}

/// Body of [showAeroConfirm]; pops true/false.
/// [details] shows what is being acted on (e.g. a flight summary) directly
/// under the title so the question and its subject read as one group.
/// [warning] adds a tinted callout for side effects (e.g. linked data).
class AeroConfirmSheet extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? details;
  final String? warning;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;

  const AeroConfirmSheet({
    super.key,
    required this.title,
    this.message,
    this.details,
    this.warning,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AeroSheet(
      title: title,
      subtitle: message,
      showClose: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (details != null) details!,
          if (warning != null) ...[
            const SizedBox(height: AeroSpace.sm),
            Container(
              padding: const EdgeInsets.all(AeroSpace.md),
              decoration: const BoxDecoration(
                color: AeroColors.dangerTint,
                borderRadius: AeroRadius.mdAll,
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: AeroColors.danger),
                  const SizedBox(width: AeroSpace.sm),
                  Expanded(
                    child: Text(
                      warning!,
                      style: AeroText.body.copyWith(color: AeroColors.danger),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AeroSpace.xl),
          AeroButton(
            label: confirmLabel,
            kind: destructive
                ? AeroButtonKind.destructive
                : AeroButtonKind.primary,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: AeroSpace.sm),
          AeroButton.secondary(
            label: cancelLabel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
