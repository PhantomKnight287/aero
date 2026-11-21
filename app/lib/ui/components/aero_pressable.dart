import 'package:flutter/widgets.dart';

import '../tokens.dart';

/// Scales its child down on pointer-down (not on release) so a press feels
/// heard instantly. Wrap any custom tappable surface with it.
class AeroPressable extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const AeroPressable({super.key, required this.child, this.enabled = true});

  @override
  State<AeroPressable> createState() => _AeroPressableState();
}

class _AeroPressableState extends State<AeroPressable> {
  bool _pressed = false;

  void _set(bool v) {
    if (widget.enabled && _pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _pressed && !reduceMotion ? AeroMotion.pressedScale : 1,
        duration: AeroMotion.press,
        curve: AeroMotion.easeOut,
        child: widget.child,
      ),
    );
  }
}
