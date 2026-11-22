import 'dart:math' as math;

import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 4-5 evenly spaced integer ticks from 0 up to at least [max], stepping
/// by 1, 2, 4, 5, 10, 20, 25, 50, 100, 200, 250, 500, ... (13 -> 0..16 by
/// 4). [max] <= 0 gives [0, 1].
List<int> niceTicks(int max) {
  if (max <= 0) return const [0, 1];
  int spans(int step) => (max + step - 1) ~/ step;
  final step = _steps().firstWhere((s) => spans(s) <= 4);
  final n = spans(step);
  return [for (var k = 0; k <= n; k++) k * step];
}

Iterable<int> _steps() sync* {
  yield* const [1, 2, 4, 5];
  for (var m = 10;; m *= 10) {
    yield* [m, 2 * m, m * 5 ~/ 2, 5 * m];
  }
}

const _minAxisWidth = 28.0;

/// Vertical bars, one per value, over light gridlines. Tick labels sit in
/// a y-axis column to the left and [labels] in a row below: the plot itself
/// has no text.
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
    this.height = 140,
  });

  @override
  Widget build(BuildContext context) {
    final ticks = niceTicks(values.fold<int>(0, (m, v) => v > m ? v : m));
    final top = ticks.last;
    final fmt = NumberFormat.decimalPattern();
    final tickStyle = AeroText.micro.copyWith(fontFeatures: AeroText.tabular);
    // Wide enough for the widest tick label ('1,000'), never under 28.
    final tp = TextPainter(
        text: TextSpan(text: fmt.format(top), style: tickStyle),
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context))
      ..layout();
    final axisWidth = math.max(_minAxisWidth, tp.width.ceilToDouble());
    tp.dispose();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height,
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              width: axisWidth,
              child: Stack(clipBehavior: Clip.none, children: [
                for (final t in ticks)
                  Positioned(
                    right: 0,
                    top: height * (1 - t / top),
                    child: FractionalTranslation(
                      translation: const Offset(0, -0.5),
                      child: Text(fmt.format(t), maxLines: 1, style: tickStyle),
                    ),
                  ),
              ]),
            ),
            const SizedBox(width: AeroSpace.sm),
            Expanded(
              child: CustomPaint(painter: _BarPainter(values, ticks, color)),
            ),
          ]),
        ),
        const SizedBox(height: AeroSpace.xs),
        Padding(
          padding: EdgeInsets.only(left: axisWidth + AeroSpace.sm),
          child: Row(children: [
            for (final l in labels)
              Expanded(
                child: Text(l,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: AeroText.micro),
              ),
          ]),
        ),
      ],
    );
  }
}

class _BarPainter extends CustomPainter {
  final List<int> values;
  final List<int> ticks;
  final Color color;

  _BarPainter(this.values, this.ticks, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final top = ticks.last;
    final grid = Paint()
      ..color = AeroColors.line
      ..strokeWidth = 1;
    for (final t in ticks) {
      final y = size.height * (1 - t / top);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    if (values.isEmpty) return;
    final slot = size.width / values.length;
    final barW = slot * 0.6;
    final paint = Paint()..color = color;
    for (var i = 0; i < values.length; i++) {
      if (values[i] <= 0) continue;
      final h = values[i] / top * size.height;
      final r = Radius.circular(
          [AeroRadius.sm * 0.75, barW / 2, h].reduce((a, b) => a < b ? a : b));
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(i * slot + (slot - barW) / 2, size.height - h, barW, h),
          topLeft: r,
          topRight: r,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarPainter old) =>
      old.color != color || old.values != values;
}
