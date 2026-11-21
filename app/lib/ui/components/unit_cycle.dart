import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/utils/error.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../tokens.dart';
import 'aero_pressable.dart';

/// Wraps a unit-bearing value. Tapping it cycles that dimension's unit
/// globally (every surface updates), with press feedback, a selection tick
/// and a short crossfade. The first cycle ever explains what happened.
class UnitCycle extends StatelessWidget {
  final UnitDimension dimension;
  final Widget Function(BuildContext context, UnitsNotifier units) builder;

  const UnitCycle({super.key, required this.dimension, required this.builder});

  Future<void> _cycle(BuildContext context) async {
    final units = context.read<UnitsNotifier>();
    HapticFeedback.selectionClick();
    final next = await units.cycle(dimension);
    if (!units.hintShown) {
      await units.markHintShown();
      showInfoToast(
        title:
            '${dimensionLabel(dimension)} now in ${unitLabel(next)} everywhere',
        description: 'Change anytime in Profile → Units',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final label = dimension == UnitDimension.time
        ? 'Change time zone'
        : 'Change ${dimensionLabel(dimension).toLowerCase()} unit';
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _cycle(context),
        child: AeroPressable(
          child: AnimatedSwitcher(
            duration: reduceMotion ? Duration.zero : AeroMotion.press,
            switchInCurve: AeroMotion.easeOut,
            switchOutCurve: AeroMotion.easeOut,
            child: KeyedSubtree(
              key: ValueKey(units.unitOf(dimension)),
              child: builder(context, units),
            ),
          ),
        ),
      ),
    );
  }
}
