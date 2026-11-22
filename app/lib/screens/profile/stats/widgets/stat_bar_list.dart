import 'package:aero/ui/components/aero_segmented.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

class StatBar {
  final Widget label;
  final num value;
  final String valueLabel;

  const StatBar({
    required this.label,
    required this.value,
    required this.valueLabel,
  });
}

/// Ranked rows: a fixed label column, then a bar scaled to the largest
/// value with its count right at the bar's end. No track: a ranking, not
/// a progress meter.
class StatBarList extends StatefulWidget {
  final List<StatBar> rows;
  final List<StatBar>? _byDistance;
  final Color color;

  /// Leading label column; 44 fits a 3-letter code.
  final double labelWidth;

  const StatBarList({
    super.key,
    required this.rows,
    required this.color,
    this.labelWidth = 44,
  }) : _byDistance = null;

  /// Flights / Distance toggle over two orderings of the same data.
  const StatBarList.switchable({
    super.key,
    required List<StatBar> byFlights,
    required List<StatBar> byDistance,
    required this.color,
    this.labelWidth = 44,
  })  : rows = byFlights,
        _byDistance = byDistance;

  @override
  State<StatBarList> createState() => _StatBarListState();
}

const _barHeight = 22.0;

final _countStyle = AeroText.body.copyWith(
    color: AeroColors.muted,
    fontWeight: FontWeight.w600,
    fontFeatures: AeroText.tabular);

class _StatBarListState extends State<StatBarList> {
  bool _distance = false;

  @override
  Widget build(BuildContext context) {
    final byDistance = widget._byDistance;
    final rows = _distance && byDistance != null ? byDistance : widget.rows;
    final max = rows.fold<num>(0, (m, r) => r.value > m ? r.value : m);
    // The widest count is reserved so every bar shares one scale.
    final scaler = MediaQuery.textScalerOf(context);
    final countWidth = rows.fold<double>(0, (w, r) {
      final tp = TextPainter(
          text: TextSpan(text: r.valueLabel, style: _countStyle),
          textDirection: TextDirection.ltr,
          textScaler: scaler)
        ..layout();
      final width = tp.width.ceilToDouble() + 1;
      tp.dispose();
      return width > w ? width : w;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (byDistance != null) ...[
          AeroSegmented<bool>(
            values: const [false, true],
            selected: _distance,
            label: (v) => v ? 'Distance' : 'Flights',
            onChanged: (v) => setState(() => _distance = v),
          ),
          const SizedBox(height: AeroSpace.md),
        ],
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: AeroSpace.sm),
          Row(children: [
            SizedBox(
              width: widget.labelWidth,
              // One line: a long label ellipsizes instead of wrapping.
              child: DefaultTextStyle.merge(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                child: rows[i].label,
              ),
            ),
            const SizedBox(width: AeroSpace.sm),
            Expanded(
              child: LayoutBuilder(builder: (context, c) {
                final room = c.maxWidth - countWidth - AeroSpace.sm;
                final f = max <= 0 ? 0.0 : (rows[i].value / max).clamp(0, 1);
                return Row(children: [
                  Container(
                    width: room > 0 ? room * f : 0,
                    height: _barHeight,
                    decoration: BoxDecoration(
                        color: widget.color, borderRadius: AeroRadius.smAll),
                  ),
                  const SizedBox(width: AeroSpace.sm),
                  Flexible(
                    child: Text(rows[i].valueLabel,
                        style: _countStyle, maxLines: 1, softWrap: false),
                  ),
                ]);
              }),
            ),
          ]),
        ],
      ],
    );
  }
}
