import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// Gradient report card. The CTA row shows only when [onCta] is set.
class SummaryCard extends StatelessWidget {
  final List<Color> gradient;
  final Widget child;
  final String? ctaLabel;
  final VoidCallback? onCta;

  const SummaryCard({
    super.key,
    required this.gradient,
    required this.child,
    this.ctaLabel,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AeroSpace.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,
          if (onCta != null && ctaLabel != null) ...[
            const SizedBox(height: AeroSpace.md),
            SummaryCta(label: ctaLabel!, onTap: onCta!),
          ],
        ],
      ),
    );
  }
}

/// 'All … stats  ›' row at the foot of a gradient card.
class SummaryCta extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SummaryCta({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(
          child: Row(children: [
            Text(label,
                style: AeroText.body.copyWith(
                    color: AeroColors.onInk, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 20, color: AeroColors.onInk),
          ]),
        ),
      ),
    );
  }
}
