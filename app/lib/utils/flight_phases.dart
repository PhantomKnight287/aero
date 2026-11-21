/// Flight profile analysis: phases, top of climb/descent, step climbs.
/// Pure Dart so it can be unit-tested with synthetic profiles.
class ProfilePoint {
  final DateTime time;
  final double altitudeFt;
  final double groundSpeedKt;
  final double? heading;
  final double? lat;
  final double? lon;

  const ProfilePoint(this.time, this.altitudeFt, this.groundSpeedKt,
      {this.heading, this.lat, this.lon});
}

class StepClimb {
  final ProfilePoint point;
  final int fromFt;
  final int toFt;
  const StepClimb(this.point, this.fromFt, this.toFt);
}

class FlightPhases {
  final ProfilePoint topOfClimb;
  final ProfilePoint topOfDescent;
  final List<StepClimb> steps;
  final ProfilePoint maxSpeed;
  final List<int> cruiseLevelsFt;
  final double? averageCruiseSpeedKt;

  const FlightPhases({
    required this.topOfClimb,
    required this.topOfDescent,
    required this.steps,
    required this.maxSpeed,
    required this.cruiseLevelsFt,
    required this.averageCruiseSpeedKt,
  });

  /// Points that should survive downsampling (the dots on the chart).
  List<ProfilePoint> get eventPoints => [
        topOfClimb,
        for (final s in steps) s.point,
        maxSpeed,
        topOfDescent,
      ];
}

/// Altitude may wander this much and still count as level (ADS-B noise).
const _levelToleranceFt = 400.0;

/// A level segment must last this long to count as cruise.
const _minLevelDuration = Duration(minutes: 5);

/// Below this share of the max altitude a level-off isn't cruise
/// (e.g. a hold or ATC level-off during climb).
const _cruiseFloorShare = 0.5;

class _Segment {
  final int start;
  final int end;
  final int levelFt;
  const _Segment(this.start, this.end, this.levelFt);
}

int _roundTo1000(double ft) => (ft / 1000).round() * 1000;

/// Null when there are fewer than 20 points or the aircraft never got
/// above 1,000 ft.
FlightPhases? detectPhases(List<ProfilePoint> input) {
  if (input.length < 20) return null;
  final pts = [...input]..sort((a, b) => a.time.compareTo(b.time));
  final maxAlt = pts.map((p) => p.altitudeFt).reduce((a, b) => a > b ? a : b);
  if (maxAlt < 1000) return null;

  // Level segments: from an anchor point, extend while within tolerance.
  final segments = <_Segment>[];
  var i = 0;
  while (i < pts.length) {
    final anchor = pts[i].altitudeFt;
    var j = i;
    while (j + 1 < pts.length &&
        (pts[j + 1].altitudeFt - anchor).abs() <= _levelToleranceFt) {
      j++;
    }
    final long = pts[j].time.difference(pts[i].time) >= _minLevelDuration;
    if (long && anchor >= maxAlt * _cruiseFloorShare) {
      final mean = pts
              .sublist(i, j + 1)
              .map((p) => p.altitudeFt)
              .reduce((a, b) => a + b) /
          (j - i + 1);
      final level = _roundTo1000(mean);
      // Noise can split one level into two segments: merge them.
      if (segments.isNotEmpty && segments.last.levelFt == level) {
        segments[segments.length - 1] = _Segment(segments.last.start, j, level);
      } else {
        segments.add(_Segment(i, j, level));
      }
      i = j + 1;
    } else {
      i++;
    }
  }

  var maxSpeedIdx = 0;
  for (var k = 1; k < pts.length; k++) {
    if (pts[k].groundSpeedKt > pts[maxSpeedIdx].groundSpeedKt) maxSpeedIdx = k;
  }

  if (segments.isEmpty) {
    var top = 0;
    for (var k = 1; k < pts.length; k++) {
      if (pts[k].altitudeFt > pts[top].altitudeFt) top = k;
    }
    return FlightPhases(
      topOfClimb: pts[top],
      topOfDescent: pts[top],
      steps: const [],
      maxSpeed: pts[maxSpeedIdx],
      cruiseLevelsFt: [_roundTo1000(pts[top].altitudeFt)],
      averageCruiseSpeedKt: null,
    );
  }

  final toc = segments.first.start;
  final tod = segments.last.end;
  final interior =
      tod - toc > 1 ? pts.sublist(toc + 1, tod) : pts.sublist(toc, tod + 1);
  final avg = interior.map((p) => p.groundSpeedKt).reduce((a, b) => a + b) /
      interior.length;

  return FlightPhases(
    topOfClimb: pts[toc],
    topOfDescent: pts[tod],
    steps: [
      for (var k = 1; k < segments.length; k++)
        if ((segments[k].levelFt - segments[k - 1].levelFt).abs() >= 1000)
          StepClimb(pts[segments[k].start], segments[k - 1].levelFt,
              segments[k].levelFt),
    ],
    maxSpeed: pts[maxSpeedIdx],
    cruiseLevelsFt: [for (final s in segments) s.levelFt],
    averageCruiseSpeedKt: avg,
  );
}

/// At most ~[max] evenly strided points, always keeping the ends and [keep].
List<ProfilePoint> downsample(List<ProfilePoint> pts, int max,
    {List<ProfilePoint> keep = const []}) {
  if (pts.length <= max) return pts;
  final stride = pts.length / max;
  final picked = <int>{0, pts.length - 1};
  for (var k = 0; k < max; k++) {
    picked.add((k * stride).floor());
  }
  final keepSet = keep.toSet();
  for (var k = 0; k < pts.length; k++) {
    if (keepSet.contains(pts[k])) picked.add(k);
  }
  final sorted = picked.toList()..sort();
  return [for (final k in sorted) pts[k]];
}
