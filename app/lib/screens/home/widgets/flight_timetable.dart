import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_pill_button.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flight_timing.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

/// OOOI timetable: one line per phase with the best known time and delay;
/// block time always shown; scheduled/estimated/actual, runways and taxi/air
/// durations on request. Collapsed again whenever the flight changes (key
/// it by flight id).
class FlightTimetable extends StatefulWidget {
  final FlightAwareDataEntity fa;
  final String? departureTz;
  final String? arrivalTz;

  /// ATC callsign shown in the footer.
  final String? callSign;

  const FlightTimetable({
    super.key,
    required this.fa,
    required this.departureTz,
    required this.arrivalTz,
    this.callSign,
  });

  @override
  State<FlightTimetable> createState() => _FlightTimetableState();
}

class _FlightTimetableState extends State<FlightTimetable> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final fa = widget.fa;
    final timing = computeTiming(
      scheduledOut: fa.scheduledOut,
      estimatedOut: fa.estimatedOut,
      actualOut: fa.actualOut,
      scheduledOff: fa.scheduledOff,
      estimatedOff: fa.estimatedOff,
      actualOff: fa.actualOff,
      scheduledOn: fa.scheduledOn,
      estimatedOn: fa.estimatedOn,
      actualOn: fa.actualOn,
      scheduledIn: fa.scheduledIn,
      estimatedIn: fa.estimatedIn,
      actualIn: fa.actualIn,
    );
    final phases = [
      _Phase('Gate departure', Icons.door_sliding_outlined, widget.departureTz,
          fa.scheduledOut, fa.estimatedOut, fa.actualOut, null),
      _Phase('Takeoff', Icons.flight_takeoff, widget.departureTz,
          fa.scheduledOff, fa.estimatedOff, fa.actualOff, fa.actualRunwayOff),
      _Phase('Landing', Icons.flight_land, widget.arrivalTz, fa.scheduledOn,
          fa.estimatedOn, fa.actualOn, fa.actualRunwayOn),
      _Phase('Gate arrival', Icons.door_front_door_outlined, widget.arrivalTz,
          fa.scheduledIn, fa.estimatedIn, fa.actualIn, null),
    ];
    if (phases.every((p) => p.best == null)) return const SizedBox.shrink();
    // The pill column only takes room when some phase is late.
    final chipWidth = phases.any((p) => p.delta != null) ? _chipWidth : 0.0;

    String? between(TimingValue? v, String label, [Duration? scheduled]) {
      if (v == null) return null;
      final est = v.estimated ? ' (est)' : '';
      final sched =
          scheduled == null ? '' : ' · sched ${formatDurationShort(scheduled)}';
      return '$label ${formatDurationShort(v.duration)}$est$sched';
    }

    final gaps = [
      between(timing.taxiOut, 'Taxi'),
      between(timing.air, 'Air', timing.scheduledAir),
      between(timing.taxiIn, 'Taxi'),
    ];
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Timetable', style: AeroText.sectionTitle),
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
                Row(children: [
                  const Expanded(child: SizedBox.shrink()),
                  SizedBox(
                      width: _schedWidth,
                      child: Text('Scheduled',
                          textAlign: TextAlign.right, style: AeroText.label)),
                  const SizedBox(width: AeroSpace.md),
                  Text('Actual', style: AeroText.label),
                  SizedBox(width: chipWidth + AeroSpace.sm),
                ]),
                for (var i = 0; i < phases.length; i++) ...[
                  _PhaseRow(
                      phase: phases[i],
                      expanded: _expanded,
                      chipWidth: chipWidth),
                  if (_expanded && i < gaps.length && gaps[i] != null)
                    _GapRow(gaps[i]!),
                ],
                if (timing.block != null) ...[
                  const SizedBox(height: AeroSpace.sm),
                  _BlockLine(timing),
                ],
                if (widget.callSign != null && widget.callSign!.isNotEmpty)
                  Text('ATC callsign ${widget.callSign}',
                      style: AeroText.caption
                          .copyWith(fontFeatures: AeroText.tabular)),
                const SizedBox(height: AeroSpace.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AeroPillButton(
                    icon: Icons.timer_outlined,
                    label: _expanded
                        ? 'Hide timing details'
                        : 'Show timing details',
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

class _Phase {
  final String label;
  final IconData icon;
  final String? tz;
  final DateTime? scheduled;
  final DateTime? estimated;
  final DateTime? actual;
  final String? runway;
  const _Phase(this.label, this.icon, this.tz, this.scheduled, this.estimated,
      this.actual, this.runway);

  DateTime? get best => actual ?? estimated ?? scheduled;

  /// (label, color) comparing scheduled with actual/estimated; null when
  /// there's nothing to compare.
  (String, Color)? get delta {
    final resolved = actual ?? estimated;
    if (scheduled == null || resolved == null) return null;
    final mins = resolved.difference(scheduled!).inMinutes;
    // Colour marks lateness only; on time and early stay quiet.
    if (mins < 2) return null;
    final text = formatDurationShort(Duration(minutes: mins.abs()));
    return ('$text late', mins <= 15 ? AeroColors.warn : AeroColors.danger);
  }
}

const _schedWidth = 60.0;
const _chipWidth = 76.0;

class _PhaseRow extends StatelessWidget {
  final _Phase phase;
  final bool expanded;
  final double chipWidth;
  const _PhaseRow(
      {required this.phase, required this.expanded, required this.chipWidth});

  @override
  Widget build(BuildContext context) {
    final best = phase.best;
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final delta = phase.delta;
    final timeStyle = AeroText.body.copyWith(
        color: AeroColors.ink,
        fontWeight: FontWeight.w600,
        fontFeatures: AeroText.tabular);

    String fmt(DateTime t, TimeMode mode) =>
        formatClock(t, airportTz: phase.tz, mode: mode, use24: use24);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Icon(phase.icon, size: 18, color: AeroColors.ink),
          ),
          const SizedBox(width: AeroSpace.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(
                      [
                        phase.label,
                        if (expanded && phase.runway != null)
                          'Rwy ${phase.runway}',
                      ].join(' · '),
                      style: AeroText.body.copyWith(color: AeroColors.ink),
                    ),
                  ),
                  SizedBox(
                    width: _schedWidth,
                    child: phase.scheduled == null
                        ? null
                        : UnitCycle(
                            dimension: UnitDimension.time,
                            builder: (_, u) => Text(
                                fmt(phase.scheduled!, u.time),
                                textAlign: TextAlign.right,
                                style: AeroText.body
                                    .copyWith(fontFeatures: AeroText.tabular)),
                          ),
                  ),
                  const SizedBox(width: AeroSpace.md),
                  if (best != null)
                    UnitCycle(
                      dimension: UnitDimension.time,
                      builder: (_, u) =>
                          Text(fmt(best, u.time), style: timeStyle),
                    ),
                  // Fixed-width chip column keeps the times aligned.
                  const SizedBox(width: AeroSpace.sm),
                  SizedBox(
                    width: chipWidth,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: delta == null
                          ? const SizedBox.shrink()
                          : _DeltaChip(delta.$1, delta.$2),
                    ),
                  ),
                ]),
                if (expanded)
                  Builder(builder: (context) {
                    final mode = context.watch<UnitsNotifier>().time;
                    final parts = [
                      if (phase.scheduled != null)
                        'sched ${fmt(phase.scheduled!, mode)}',
                      if (phase.estimated != null)
                        'est ${fmt(phase.estimated!, mode)}',
                      if (phase.actual != null)
                        'act ${fmt(phase.actual!, mode)}',
                    ];
                    return parts.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(parts.join(' · '),
                                style: AeroText.caption
                                    .copyWith(fontFeatures: AeroText.tabular)),
                          );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  final String label;
  final Color color;
  const _DeltaChip(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AeroSpace.sm - 2, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: AeroRadius.smAll,
        ),
        child: Text(label,
            style: AeroText.micro
                .copyWith(color: color, fontWeight: FontWeight.w700)),
      );
}

/// Duration between two phases, drawn on the rail between their icons.
class _GapRow extends StatelessWidget {
  final String text;
  const _GapRow(this.text);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 24,
              child: Center(
                child: Container(width: 2, color: AeroColors.line),
              ),
            ),
            const SizedBox(width: AeroSpace.sm),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs),
              child: Text(text,
                  style: AeroText.caption.copyWith(
                      color: AeroColors.inkSoft,
                      fontFeatures: AeroText.tabular)),
            ),
          ],
        ),
      );
}

class _BlockLine extends StatelessWidget {
  final FlightTiming timing;
  const _BlockLine(this.timing);

  @override
  Widget build(BuildContext context) {
    final block = timing.block!;
    final vs = timing.blockVsSchedule;
    final mins = vs?.inMinutes;
    final compare = mins == null
        ? null
        : mins.abs() < 2
            ? 'as scheduled'
            : '${formatDurationShort(Duration(minutes: mins.abs()))} '
                '${mins > 0 ? 'longer' : 'shorter'} than scheduled';
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: 'Block ${formatDurationShort(block.duration)}'
                '${block.estimated ? ' (est)' : ''}',
            style: AeroText.body
                .copyWith(color: AeroColors.ink, fontWeight: FontWeight.w600)),
        if (compare != null)
          TextSpan(text: ' · $compare', style: AeroText.body),
      ]),
      style: const TextStyle(fontFeatures: AeroText.tabular),
    );
  }
}
