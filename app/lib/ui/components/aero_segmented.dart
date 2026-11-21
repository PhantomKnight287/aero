import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens.dart';
import 'aero_pressable.dart';

/// Segmented control: soft track with a sliding white thumb. Use instead of
/// Material's SegmentedButton.
class AeroSegmented<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final String Function(T value) label;
  final ValueChanged<T> onChanged;

  const AeroSegmented({
    super.key,
    required this.values,
    required this.selected,
    required this.label,
    required this.onChanged,
  });

  static const _height = 36.0;
  static const _inset = 3.0;

  @override
  Widget build(BuildContext context) {
    final index = values.indexOf(selected);
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return Container(
      height: _height,
      padding: const EdgeInsets.all(_inset),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: LayoutBuilder(builder: (context, c) {
        final segment = c.maxWidth / values.length;
        return Stack(children: [
          AnimatedPositioned(
            duration: reduceMotion ? Duration.zero : AeroMotion.move,
            curve: AeroMotion.easeInOut,
            left: segment * index,
            top: 0,
            bottom: 0,
            width: segment,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: AeroColors.surface,
                borderRadius: AeroRadius.smAll,
                boxShadow: [
                  BoxShadow(
                      color: AeroColors.shadow,
                      blurRadius: 4,
                      offset: Offset(0, 1)),
                ],
              ),
            ),
          ),
          Row(children: [
            for (final v in values)
              Expanded(
                child: Semantics(
                  button: true,
                  selected: v == selected,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (v == selected) return;
                      HapticFeedback.selectionClick();
                      onChanged(v);
                    },
                    child: AeroPressable(
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: AeroMotion.press,
                          style: v == selected
                              ? AeroText.caption.copyWith(
                                  color: AeroColors.ink,
                                  fontWeight: FontWeight.w600)
                              : AeroText.caption,
                          child: Text(label(v), maxLines: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ]),
        ]);
      }),
    );
  }
}
