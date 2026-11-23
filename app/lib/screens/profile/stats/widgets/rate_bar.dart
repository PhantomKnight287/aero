import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// '48%' for 0.48.
String percent(num fraction) => '${(fraction * 100).round()}%';

/// A share of a whole: rounded track with a fill. Unlike [StatBarList]'s
/// ranking bars, the scale is always 0–100%.
class RateBar extends StatelessWidget {
  final double fraction;
  final Color color;
  final double height;

  const RateBar(
      {super.key,
      required this.fraction,
      required this.color,
      this.height = 10});

  @override
  Widget build(BuildContext context) {
    final f = fraction.isFinite ? fraction.clamp(0.0, 1.0) : 0.0;
    final radius = BorderRadius.circular(height / 2);
    return Container(
      height: height,
      decoration:
          BoxDecoration(color: AeroColors.surfaceAlt, borderRadius: radius),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: f,
        heightFactor: 1,
        // A non-zero share stays visible as a dot.
        child: f == 0
            ? null
            : Container(
                constraints: BoxConstraints(minWidth: height),
                decoration: BoxDecoration(color: color, borderRadius: radius),
              ),
      ),
    );
  }
}

final _pctStyle = AeroText.body.copyWith(
    color: AeroColors.ink,
    fontWeight: FontWeight.w600,
    fontFeatures: AeroText.tabular);

/// One rate line. [RateRow.inline]: label | bar | %. [RateRow.stacked]:
/// leading, label, note … '% (late/total)' with the bar underneath.
class RateRow extends StatelessWidget {
  final Widget? leading;
  final String label;
  final String? note;
  final double fraction;
  final String? detail;
  final Color color;
  final bool _stacked;

  const RateRow.inline({
    super.key,
    required this.label,
    required this.fraction,
    required this.color,
  })  : leading = null,
        note = null,
        detail = null,
        _stacked = false;

  const RateRow.stacked({
    super.key,
    this.leading,
    required this.label,
    this.note,
    required this.fraction,
    this.detail,
    required this.color,
  }) : _stacked = true;

  @override
  Widget build(BuildContext context) {
    final pct = percent(fraction);
    if (!_stacked) {
      return Row(children: [
        SizedBox(
          width: 96,
          child: Text(label,
              style: AeroText.heading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
        Expanded(child: RateBar(fraction: fraction, color: color, height: 22)),
        SizedBox(
          width: 52,
          child: Text(pct,
              textAlign: TextAlign.right,
              style: _pctStyle.copyWith(color: AeroColors.muted)),
        ),
      ]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AeroSpace.sm)
          ],
          Expanded(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: label, style: AeroText.heading),
                if (note != null && note!.isNotEmpty)
                  TextSpan(text: '  $note', style: AeroText.caption),
              ]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AeroSpace.sm),
          Text(pct, style: _pctStyle),
          if (detail != null)
            Text(' $detail',
                style: _pctStyle.copyWith(
                    color: AeroColors.muted, fontWeight: FontWeight.w400)),
        ]),
        const SizedBox(height: AeroSpace.sm),
        RateBar(fraction: fraction, color: color),
      ],
    );
  }
}
