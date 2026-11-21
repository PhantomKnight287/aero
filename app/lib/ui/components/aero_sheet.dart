import 'package:flutter/material.dart';

import '../tokens.dart';
import 'aero_button.dart';

/// Standard bottom sheet chrome: drag handle, title row with close button,
/// divider, then [child]. Shown via [showAeroSheet].
class AeroSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const AeroSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AeroSpace.md),
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                color: AeroColors.handle,
                borderRadius: AeroRadius.pillAll,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AeroSpace.lg, AeroSpace.md, AeroSpace.xs, AeroSpace.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AeroText.title),
                      if (subtitle != null) ...[
                        const SizedBox(height: AeroSpace.xs),
                        Text(subtitle!, style: AeroText.caption),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: AeroColors.ink),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(AeroSpace.lg),
            child: child,
          ),
        ],
      ),
    );
  }
}

Future<T?> showAeroSheet<T>(BuildContext context, Widget sheet) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => sheet,
  );
}

/// Confirmation as a bottom sheet. Returns true only when confirmed.
/// [warning] shows a tinted callout above the buttons (e.g. data that will
/// also be deleted).
Future<bool> showAeroConfirm(
  BuildContext context, {
  required String title,
  String? subtitle,
  required String message,
  String? warning,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final result = await showAeroSheet<bool>(
    context,
    AeroSheet(
      title: title,
      subtitle: subtitle,
      child: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(message, style: AeroText.body),
            if (warning != null) ...[
              const SizedBox(height: AeroSpace.md),
              Container(
                padding: const EdgeInsets.all(AeroSpace.md),
                decoration: const BoxDecoration(
                  color: AeroColors.dangerTint,
                  borderRadius: AeroRadius.mdAll,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 18, color: AeroColors.danger),
                    const SizedBox(width: AeroSpace.sm),
                    Expanded(
                      child: Text(
                        warning,
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
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    ),
  );
  return result == true;
}
