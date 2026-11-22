import 'package:aero/formatters/time.dart';
import 'package:aero/utils/flag.dart';
import 'package:aero/utils/great_circle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('flagEmoji', () {
    expect(flagEmoji('IN'), '🇮🇳');
    expect(flagEmoji('gb'), '🇬🇧');
  });

  test('great circle crosses antimeridian continuously', () {
    final pts = greatCirclePoints(
        const LatLng(21.32, -157.92), const LatLng(35.77, 140.39));
    expect(pts.length, 49);
    for (var i = 1; i < pts.length; i++) {
      expect((pts[i].longitude - pts[i - 1].longitude).abs(), lessThan(180));
    }
    for (final p in pts) {
      final n = ((p.longitude + 180) % 360 + 360) % 360 - 180;
      expect(n.abs(), greaterThanOrEqualTo(140));
    }
  });

  test('formatLongDuration', () {
    expect(formatLongDuration(25139), '17d 11h');
    expect(formatLongDuration(454), '7h 34m');
    expect(formatLongDuration(38), '38m');
    expect(formatLongDuration(0), '0m');
  });
}
