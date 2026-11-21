import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_pill_button.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flight_phases.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

/// Altitude (and, expanded, ground speed) over time with phases and events.
/// No text on the plot: events are dots, details live in the readout and
/// the event list, so nothing collides on a narrow phone. Dragging scrubs
/// a cursor and reports the point (for the map marker).
class FlightProfile extends StatefulWidget {
  final BuiltList<FlightPositionEntity> positions;
  final String? departureTz;
  final ValueChanged<ProfilePoint?>? onScrub;

  const FlightProfile({
    super.key,
    required this.positions,
    this.departureTz,
    this.onScrub,
  });

  /// FlightAware altitude is in hundreds of feet.
  static List<ProfilePoint> toPoints(
          Iterable<FlightPositionEntity> positions) =>
      [
        for (final p in positions)
          if (DateTime.tryParse(p.timestamp) != null)
            ProfilePoint(
              DateTime.parse(p.timestamp).toUtc(),
              p.altitude * 100.0,
              p.groundspeed.toDouble(),
              heading: p.heading?.toDouble(),
              lat: p.latitude.toDouble(),
              lon: p.longitude.toDouble(),
            ),
      ]..sort((a, b) => a.time.compareTo(b.time));

  @override
  State<FlightProfile> createState() => _FlightProfileState();
}

class _FlightProfileState extends State<FlightProfile> {
  bool _expanded = false;
  ProfilePoint? _cursor;

  // Cached per positions list.
  BuiltList<FlightPositionEntity>? _source;
  List<ProfilePoint> _points = const [];
  List<ProfilePoint> _drawn = const [];
  FlightPhases? _phases;

  void _prepare() {
    if (identical(_source, widget.positions)) return;
    _source = widget.positions;
    _points = FlightProfile.toPoints(widget.positions);
    _phases = detectPhases(_points);
    _drawn = _phases == null
        ? const []
        : downsample(_points, 300, keep: _phases!.eventPoints);
  }

  void _setCursor(ProfilePoint? p) {
    if (identical(p, _cursor)) return;
    setState(() => _cursor = p);
    widget.onScrub?.call(p);
  }

  @override
  Widget build(BuildContext context) {
    _prepare();
    final phases = _phases;
    if (phases == null) return const SizedBox.shrink();
    final units = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final levels = phases.cruiseLevelsFt
        .map((ft) => formatAltitude(ft, units.altitude))
        .toList();
    // Collapse repeats like FL340 → FL360 → FL340 into the list as-is: the
    // sequence is the story.
    final summary = [
      levels.join(' → '),
      'max ${formatSpeed(phases.maxSpeed.groundSpeedKt, units.speed)}',
    ].join(' · ');

    final cursor = _cursor;
    final readout = cursor == null
        ? null
        : [
            formatClock(cursor.time,
                airportTz: widget.departureTz, mode: units.time, use24: use24),
            formatAltitude(cursor.altitudeFt, units.altitude),
            formatSpeed(cursor.groundSpeedKt, units.speed),
            if (cursor.heading != null)
              '${cursor.heading!.round().toString().padLeft(3, '0')}°',
          ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Flight profile', style: AeroText.heading),
        const SizedBox(height: AeroSpace.sm),
        Container(
          padding: const EdgeInsets.all(AeroSpace.md),
          decoration: const BoxDecoration(
            color: AeroColors.surfaceAlt,
            borderRadius: AeroRadius.mdAll,
          ),
          child: AnimatedSize(
            duration: reduceMotion ? Duration.zero : AeroMotion.move,
            curve: AeroMotion.easeOut,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UnitCycle(
                  dimension: UnitDimension.altitude,
                  builder: (_, __) => Text(summary,
                      style: AeroText.body.copyWith(
                          color: AeroColors.ink,
                          fontWeight: FontWeight.w600,
                          fontFeatures: AeroText.tabular)),
                ),
                const SizedBox(height: 2),
                // Fixed-height readout: the hint invites the drag, the
                // values replace it while scrubbing.
                SizedBox(
                  height: 18,
                  child: Text(
                    readout ?? 'Drag across the chart to explore',
                    style: AeroText.caption.copyWith(
                        color:
                            readout == null ? AeroColors.muted : AeroColors.ink,
                        fontFeatures: AeroText.tabular),
                  ),
                ),
                const SizedBox(height: AeroSpace.sm),
                _ScrubChart(
                  key: const ValueKey('altitude-chart'),
                  points: _drawn,
                  value: (p) => p.altitudeFt,
                  gridLabel: (v) => formatAltitude(v, units.altitude),
                  events: [
                    phases.topOfClimb,
                    for (final st in phases.steps) st.point,
                    phases.topOfDescent,
                  ],
                  cursor: cursor,
                  onCursor: _setCursor,
                  height: 132,
                  semanticsLabel: 'Altitude profile',
                ),
                const SizedBox(height: AeroSpace.xs),
                _PhaseStrip(points: _points, phases: phases),
                if (_expanded) ...[
                  const SizedBox(height: AeroSpace.lg),
                  Text('Ground speed',
                      style: AeroText.caption
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: AeroSpace.xs),
                  _ScrubChart(
                    key: const ValueKey('speed-chart'),
                    points: _drawn,
                    value: (p) => p.groundSpeedKt,
                    gridLabel: (v) => formatSpeed(v, units.speed),
                    events: [phases.maxSpeed],
                    cursor: cursor,
                    onCursor: _setCursor,
                    height: 96,
                    semanticsLabel: 'Ground speed profile',
                  ),
                  const SizedBox(height: AeroSpace.md),
                  _EventList(
                    phases: phases,
                    departureTz: widget.departureTz,
                    onSelect: _setCursor,
                  ),
                ],
                const SizedBox(height: AeroSpace.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AeroPillButton(
                    icon: Icons.show_chart,
                    label: _expanded
                        ? 'Hide speed & events'
                        : 'Show speed & events',
                    trailing: _expanded ? Icons.expand_less : Icons.expand_more,
                    onTap: () => setState(() => _expanded = !_expanded),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// One series over time, painted by hand (no chart-library chrome). Drag or
/// tap to move the cursor; release clears it.
class _ScrubChart extends StatelessWidget {
  final List<ProfilePoint> points;
  final double Function(ProfilePoint) value;
  final String Function(double) gridLabel;
  final List<ProfilePoint> events;
  final ProfilePoint? cursor;
  final ValueChanged<ProfilePoint?> onCursor;
  final double height;
  final String semanticsLabel;

  const _ScrubChart({
    super.key,
    required this.points,
    required this.value,
    required this.gridLabel,
    required this.events,
    required this.cursor,
    required this.onCursor,
    required this.height,
    required this.semanticsLabel,
  });

  ProfilePoint _nearest(double x, double width) {
    final start = points.first.time.millisecondsSinceEpoch;
    final span = points.last.time.millisecondsSinceEpoch - start;
    final t = start + (x / width).clamp(0.0, 1.0) * span;
    var best = points.first;
    for (final p in points) {
      if ((p.time.millisecondsSinceEpoch - t).abs() <
          (best.time.millisecondsSinceEpoch - t).abs()) {
        best = p;
      }
    }
    return best;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: LayoutBuilder(builder: (context, c) {
        final plotWidth = c.maxWidth - _ChartPainter.gutter;
        void at(Offset local) => onCursor(_nearest(local.dx, plotWidth));
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => at(d.localPosition),
          onTapUp: (_) => onCursor(null),
          onTapCancel: () {},
          onHorizontalDragStart: (d) => at(d.localPosition),
          onHorizontalDragUpdate: (d) => at(d.localPosition),
          onHorizontalDragEnd: (_) => onCursor(null),
          onHorizontalDragCancel: () => onCursor(null),
          child: CustomPaint(
            size: Size(c.maxWidth, height),
            painter: _ChartPainter(
              points: points,
              value: value,
              gridLabel: gridLabel,
              events: events,
              cursor: cursor,
              labelStyle: AeroText.micro,
            ),
          ),
        );
      }),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<ProfilePoint> points;
  final double Function(ProfilePoint) value;
  final String Function(double) gridLabel;
  final List<ProfilePoint> events;
  final ProfilePoint? cursor;
  final TextStyle labelStyle;

  _ChartPainter({
    required this.points,
    required this.value,
    required this.gridLabel,
    required this.events,
    required this.cursor,
    required this.labelStyle,
  });

  /// Right-hand space for grid labels, so they never sit on the data.
  static const gutter = 52.0;
  static const _topPad = 8.0; // room for the highest dot's ring

  /// A "nice" grid step giving at most ~3 lines below [max].
  static double niceStep(double max) {
    final raw = max / 3;
    for (final s in const [
      50.0,
      100.0,
      200.0,
      250.0,
      500.0,
      1000.0,
      2000.0,
      2500.0,
      5000.0,
      10000.0,
      20000.0,
      25000.0,
      50000.0
    ]) {
      if (s >= raw) return s;
    }
    return 100000;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final maxV = points.map(value).reduce((a, b) => a > b ? a : b);
    final ceiling = maxV * 1.08; // headroom above the highest point
    final step = niceStep(maxV);
    final plotW = size.width - gutter;
    final start = points.first.time.millisecondsSinceEpoch;
    final span = (points.last.time.millisecondsSinceEpoch - start)
        .clamp(1, 1 << 62)
        .toDouble();
    final h = size.height - _topPad;
    double x(ProfilePoint p) =>
        (p.time.millisecondsSinceEpoch - start) / span * plotW;
    double y(double v) => _topPad + h - (v / ceiling).clamp(0, 1) * h;

    // Recessive hairline grid; labels in the gutter, centred on the line.
    final grid = Paint()
      ..color = AeroColors.line
      ..strokeWidth = 1;
    for (var v = step; v <= ceiling; v += step) {
      final gy = y(v);
      canvas.drawLine(Offset(0, gy), Offset(plotW, gy), grid);
      final tp = TextPainter(
        text: TextSpan(text: gridLabel(v), style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: gutter - 6);
      tp.paint(canvas, Offset(plotW + 6, gy - tp.height / 2));
    }
    canvas.drawLine(Offset(0, y(0)), Offset(plotW, y(0)), grid);

    // Area wash + 2px line.
    final line = Path()..moveTo(x(points.first), y(value(points.first)));
    for (final p in points.skip(1)) {
      line.lineTo(x(p), y(value(p)));
    }
    final area = Path.from(line)
      ..lineTo(x(points.last), y(0))
      ..lineTo(x(points.first), y(0))
      ..close();
    canvas.drawPath(
        area, Paint()..color = AeroColors.ink.withValues(alpha: 0.05));
    canvas.drawPath(
      line,
      Paint()
        ..color = AeroColors.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );

    // Event dots: r=4 with a 2px surface ring.
    void dot(ProfilePoint p, {double r = 4}) {
      final c = Offset(x(p), y(value(p)));
      canvas.drawCircle(c, r + 2, Paint()..color = AeroColors.surfaceAlt);
      canvas.drawCircle(c, r, Paint()..color = AeroColors.ink);
    }

    for (final e in events) {
      dot(e);
    }

    final cur = cursor;
    if (cur != null) {
      final cx = x(cur);
      canvas.drawLine(
        Offset(cx, 0),
        Offset(cx, size.height),
        Paint()
          ..color = AeroColors.ink
          ..strokeWidth = 1,
      );
      dot(cur, r: 5);
    }
  }

  @override
  bool shouldRepaint(_ChartPainter old) =>
      old.cursor != cursor ||
      !identical(old.points, points) ||
      old.gridLabel(1000) != gridLabel(1000);
}

/// Climb | cruise | descent band under the altitude chart, widths by time.
/// A segment shows its name only when the name fits.
class _PhaseStrip extends StatelessWidget {
  final List<ProfilePoint> points;
  final FlightPhases phases;
  const _PhaseStrip({required this.points, required this.phases});

  @override
  Widget build(BuildContext context) {
    int secs(DateTime a, DateTime b) => b.difference(a).inSeconds.abs();
    final first = points.first.time;
    final last = points.last.time;
    final parts = [
      ('Climb', secs(first, phases.topOfClimb.time), 0.14),
      ('Cruise', secs(phases.topOfClimb.time, phases.topOfDescent.time), 0.06),
      ('Descent', secs(phases.topOfDescent.time, last), 0.14),
    ].where((p) => p.$2 > 0).toList();

    return Padding(
      // Same width as the plot area (charts keep a label gutter on the right).
      padding: const EdgeInsets.only(right: _ChartPainter.gutter),
      child: SizedBox(
        height: 18,
        child: Row(children: [
          for (var i = 0; i < parts.length; i++) ...[
            if (i > 0) const SizedBox(width: 2), // surface gap
            Expanded(
              flex: parts[i].$2,
              child: LayoutBuilder(builder: (context, c) {
                final tp = TextPainter(
                  text: TextSpan(text: parts[i].$1, style: AeroText.micro),
                  textDirection: TextDirection.ltr,
                )..layout();
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AeroColors.ink.withValues(alpha: parts[i].$3),
                    borderRadius: AeroRadius.smAll,
                  ),
                  child: tp.width + 8 <= c.maxWidth
                      ? Text(parts[i].$1,
                          style: AeroText.micro.copyWith(color: AeroColors.ink))
                      : null,
                );
              }),
            ),
          ],
        ]),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  final FlightPhases phases;
  final String? departureTz;
  final ValueChanged<ProfilePoint?> onSelect;
  const _EventList(
      {required this.phases,
      required this.departureTz,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    String alt(num ft) => formatAltitude(ft, units.altitude);
    final rows = <(String, ProfilePoint, String)>[
      ('Top of climb', phases.topOfClimb, alt(phases.cruiseLevelsFt.first)),
      for (final s in phases.steps)
        (
          s.toFt > s.fromFt ? 'Step climb' : 'Step descent',
          s.point,
          '${alt(s.fromFt)} → ${alt(s.toFt)}'
        ),
      (
        'Max ground speed',
        phases.maxSpeed,
        formatSpeed(phases.maxSpeed.groundSpeedKt, units.speed)
      ),
      ('Top of descent', phases.topOfDescent, alt(phases.cruiseLevelsFt.last)),
    ]..sort((a, b) => a.$2.time.compareTo(b.$2.time));

    return Column(children: [
      for (final r in rows)
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onSelect(r.$2),
          child: AeroPressable(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs + 2),
              child: Row(children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: AeroColors.ink, shape: BoxShape.circle),
                ),
                const SizedBox(width: AeroSpace.md),
                Expanded(
                  child: Text(r.$1,
                      style: AeroText.body.copyWith(color: AeroColors.ink)),
                ),
                Text(
                  '${formatClock(r.$2.time, airportTz: departureTz, mode: units.time, use24: use24)} · ${r.$3}',
                  style:
                      AeroText.caption.copyWith(fontFeatures: AeroText.tabular),
                ),
                const SizedBox(width: AeroSpace.xs),
                const Icon(Icons.my_location,
                    size: 14, color: AeroColors.muted),
              ]),
            ),
          ),
        ),
    ]);
  }
}
