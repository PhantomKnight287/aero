import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';

/// Vertical bars, one per value. The plot is a painter with no text; the
/// [labels] sit below it in a row, one per bar.
class BarChart extends StatelessWidget {
  final List<int> values;
  final List<String> labels;
  final Color color;
  final double height;

  const BarChart({
    super.key,
    required this.values,
    required this.labels,
    required this.color,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height,
          child: CustomPaint(painter: _BarPainter(values, color)),
        ),
        const SizedBox(height: AeroSpace.xs),
        Row(children: [
          for (final l in labels)
            Expanded(
              child: Text(l,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: AeroText.micro),
            ),
        ]),
      ],
    );
  }
}

class _BarPainter extends CustomPainter {
  final List<int> values;
  final Color color;

  _BarPainter(this.values, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final max = values.fold<int>(1, (m, v) => v > m ? v : m);
    final slot = size.width / values.length;
    final barW = slot * 0.6;
    const minH = 2.0;
    final paint = Paint()..color = color;
    const r = Radius.circular(AeroRadius.sm / 4);
    for (var i = 0; i < values.length; i++) {
      final h = values[i] <= 0
          ? minH
          : (values[i] / max * size.height).clamp(minH, size.height);
      final x = i * slot + (slot - barW) / 2;
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, size.height - h, barW, h),
          topLeft: r,
          topRight: r,
        ),
        values[i] <= 0 ? (Paint()..color = AeroColors.surfaceAlt) : paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarPainter old) =>
      old.color != color || old.values != values;
}
