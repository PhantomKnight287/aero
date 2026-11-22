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

/// Ranked rows: label + value, with a bar scaled to the largest value.
class StatBarList extends StatefulWidget {
  final List<StatBar> rows;
  final List<StatBar>? _byDistance;
  final Color color;

  const StatBarList({super.key, required this.rows, required this.color})
      : _byDistance = null;

  /// Flights / Distance toggle over two orderings of the same data.
  const StatBarList.switchable({
    super.key,
    required List<StatBar> byFlights,
    required List<StatBar> byDistance,
    required this.color,
  })  : rows = byFlights,
        _byDistance = byDistance;

  @override
  State<StatBarList> createState() => _StatBarListState();
}

class _StatBarListState extends State<StatBarList> {
  bool _distance = false;

  @override
  Widget build(BuildContext context) {
    final byDistance = widget._byDistance;
    final rows = _distance && byDistance != null ? byDistance : widget.rows;
    final max = rows.fold<num>(0, (m, r) => r.value > m ? r.value : m);
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
          if (i > 0) const SizedBox(height: AeroSpace.md),
          _Row(bar: rows[i], max: max, color: widget.color),
        ],
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final StatBar bar;
  final num max;
  final Color color;

  const _Row({required this.bar, required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    final fraction = max <= 0 ? 0.0 : (bar.value / max).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(child: bar.label),
          const SizedBox(width: AeroSpace.sm),
          Text(bar.valueLabel,
              style: AeroText.body.copyWith(
                  color: AeroColors.ink,
                  fontWeight: FontWeight.w600,
                  fontFeatures: AeroText.tabular)),
        ]),
        const SizedBox(height: AeroSpace.xs),
        ClipRRect(
          borderRadius: AeroRadius.pillAll,
          child: Stack(children: [
            const SizedBox(
                height: 6,
                width: double.infinity,
                child: ColoredBox(color: AeroColors.surfaceAlt)),
            FractionallySizedBox(
              widthFactor: fraction,
              child: SizedBox(height: 6, child: ColoredBox(color: color)),
            ),
          ]),
        ),
      ],
    );
  }
}
