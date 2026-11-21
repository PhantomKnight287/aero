import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// A derived duration; [estimated] when either end isn't an actual time yet.
class TimingValue {
  final Duration duration;
  final bool estimated;
  const TimingValue(this.duration, this.estimated);
}

/// Taxi, air and block times derived from the four OOOI events
/// (gate Out, wheels Off, wheels On, gate In).
class FlightTiming {
  final TimingValue? taxiOut;
  final TimingValue? air;
  final TimingValue? taxiIn;
  final TimingValue? block;
  final Duration? scheduledAir;
  final Duration? scheduledBlock;

  const FlightTiming({
    this.taxiOut,
    this.air,
    this.taxiIn,
    this.block,
    this.scheduledAir,
    this.scheduledBlock,
  });

  /// Positive = took longer than scheduled.
  Duration? get blockVsSchedule => block == null || scheduledBlock == null
      ? null
      : block!.duration - scheduledBlock!;
}

class _Event {
  final DateTime time;
  final bool actual;
  const _Event(this.time, this.actual);
}

_Event? _best(DateTime? actual, DateTime? estimated) => actual != null
    ? _Event(actual, true)
    : estimated != null
        ? _Event(estimated, false)
        : null;

TimingValue? _between(_Event? from, _Event? to) {
  if (from == null || to == null) return null;
  final d = to.time.difference(from.time);
  if (d.isNegative) return null; // bad data: never show negative durations
  return TimingValue(d, !(from.actual && to.actual));
}

Duration? _span(DateTime? from, DateTime? to) {
  if (from == null || to == null) return null;
  final d = to.difference(from);
  return d.isNegative ? null : d;
}

FlightTiming computeTiming({
  DateTime? scheduledOut,
  DateTime? estimatedOut,
  DateTime? actualOut,
  DateTime? scheduledOff,
  DateTime? estimatedOff,
  DateTime? actualOff,
  DateTime? scheduledOn,
  DateTime? estimatedOn,
  DateTime? actualOn,
  DateTime? scheduledIn,
  DateTime? estimatedIn,
  DateTime? actualIn,
}) {
  final out = _best(actualOut, estimatedOut);
  final off = _best(actualOff, estimatedOff);
  final on = _best(actualOn, estimatedOn);
  final inn = _best(actualIn, estimatedIn);
  return FlightTiming(
    taxiOut: _between(out, off),
    air: _between(off, on),
    taxiIn: _between(on, inn),
    block: _between(out, inn),
    scheduledAir: _span(scheduledOff, scheduledOn),
    scheduledBlock: _span(scheduledOut, scheduledIn),
  );
}

/// "14 min", "7 h 08 min", "2 h".
String formatDurationShort(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60).abs();
  if (h == 0) return '$m min';
  if (m == 0) return '$h h';
  return '$h h ${m.toString().padLeft(2, '0')} min';
}

/// Clock change between two airports at one instant.
class ZoneShift {
  /// Destination offset minus origin offset (positive = clocks forward).
  final Duration change;
  final bool originDst;
  final bool destinationDst;
  const ZoneShift(this.change, this.originDst, this.destinationDst);
}

bool _tzReady = false;

/// Offsets as they are on [atUtc] (not today), so flights across a DST
/// switch are right. Null for missing/unknown zones.
ZoneShift? zoneShift(DateTime atUtc, String? originTz, String? destinationTz) {
  if (originTz == null || originTz.isEmpty) return null;
  if (destinationTz == null || destinationTz.isEmpty) return null;
  try {
    if (!_tzReady) {
      tzdata.initializeTimeZones();
      _tzReady = true;
    }
    final ms = atUtc.millisecondsSinceEpoch;
    final o = tz.getLocation(originTz).timeZone(ms);
    final d = tz.getLocation(destinationTz).timeZone(ms);
    return ZoneShift(
      Duration(milliseconds: d.offset - o.offset),
      o.isDst,
      d.isDst,
    );
  } catch (_) {
    return null;
  }
}

/// "Clocks go forward 4 h" / "Clocks go back 1 h 30 min".
String describeShift(Duration change) {
  if (change == Duration.zero) return 'No time zone change';
  final dir = change.isNegative ? 'back' : 'forward';
  return 'Clocks go $dir ${formatDurationShort(change.abs())}';
}
