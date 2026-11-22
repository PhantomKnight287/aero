import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 'All-time' plus one chip per year, horizontally scrollable. [selected]
/// null means all-time.
class YearFilter extends StatelessWidget {
  final List<int> years;
  final int? selected;
  final ValueChanged<int?> onChanged;

  const YearFilter({
    super.key,
    required this.years,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        _chip('All-time', null),
        for (final y in years) ...[
          const SizedBox(width: AeroSpace.sm),
          _chip('$y', y),
        ],
      ]),
    );
  }

  Widget _chip(String label, int? year) {
    final on = year == selected;
    return Semantics(
      button: true,
      selected: on,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (on) return;
          HapticFeedback.selectionClick();
          onChanged(year);
        },
        child: AeroPressable(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AeroSpace.lg, vertical: AeroSpace.sm),
            decoration: BoxDecoration(
              color: on ? AeroColors.ink : AeroColors.surfaceAlt,
              borderRadius: AeroRadius.pillAll,
            ),
            child: Text(
              label,
              style: AeroText.caption.copyWith(
                color: on ? AeroColors.onInk : AeroColors.ink,
                fontWeight: FontWeight.w600,
                fontFeatures: AeroText.tabular,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
