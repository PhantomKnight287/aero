import 'dart:math';

import 'package:latlong2/latlong.dart';

/// Points along the great circle a->b (slerp on unit vectors). Longitudes are
/// unwrapped so consecutive points never jump more than 180 degrees; they may
/// leave [-180, 180] when crossing the antimeridian.
List<LatLng> greatCirclePoints(LatLng a, LatLng b, {int segments = 48}) {
  List<double> vec(LatLng p) {
    final la = p.latitudeInRad, lo = p.longitudeInRad;
    return [cos(la) * cos(lo), cos(la) * sin(lo), sin(la)];
  }

  final va = vec(a), vb = vec(b);
  final dot = (va[0] * vb[0] + va[1] * vb[1] + va[2] * vb[2]).clamp(-1.0, 1.0);
  final omega = acos(dot);
  final sinO = sin(omega);

  final out = <LatLng>[];
  var prevLon = a.longitude;
  for (var i = 0; i <= segments; i++) {
    final t = i / segments;
    final k1 = sinO.abs() < 1e-9 ? 1 - t : sin((1 - t) * omega) / sinO;
    final k2 = sinO.abs() < 1e-9 ? t : sin(t * omega) / sinO;
    final x = k1 * va[0] + k2 * vb[0];
    final y = k1 * va[1] + k2 * vb[1];
    final z = k1 * va[2] + k2 * vb[2];
    final lat = atan2(z, sqrt(x * x + y * y)) * 180 / pi;
    var lon = atan2(y, x) * 180 / pi;
    while (lon - prevLon > 180) {
      lon -= 360;
    }
    while (lon - prevLon < -180) {
      lon += 360;
    }
    prevLon = lon;
    out.add(LatLng(lat, lon));
  }
  return out;
}
