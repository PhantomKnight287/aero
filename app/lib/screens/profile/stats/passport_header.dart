import 'package:aero/constants/map.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flag.dart';
import 'package:aero/utils/great_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'sections/shared.dart';

/// Still route map, flag row and the summary strip.
class PassportHeader extends StatelessWidget {
  final ProfileStatsResponseEntity stats;

  const PassportHeader({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final p = stats.passport;
    final unit = context.watch<UnitsNotifier>().distance;
    final flags = stats.countries
        .where((c) => c.isoCountry.length == 2)
        .map((c) => flagEmoji(c.isoCountry));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 220,
          child: ClipRRect(
            borderRadius: AeroRadius.mdAll,
            child: stats.map.airports.isEmpty
                ? const ColoredBox(color: AeroColors.surfaceAlt)
                : _RouteMap(map: stats.map),
          ),
        ),
        const SizedBox(height: AeroSpace.lg),
        Wrap(
          spacing: AeroSpace.xs,
          runSpacing: AeroSpace.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final f in flags) Text(f, style: AeroText.title),
            const SizedBox(width: AeroSpace.xs),
            Text(
                '${count(p.totalCountries)} '
                '${p.totalCountries == 1 ? 'country' : 'countries'}',
                style: tabularBody),
          ],
        ),
        const SizedBox(height: AeroSpace.lg),
        Row(children: [
          _stat(count(p.totalFlights), 'flights'),
          _stat(formatDistance(p.totalDistanceKm, unit), 'distance'),
          _stat(formatLongDuration(p.blockMinutes.round()), 'time'),
          _stat(count(p.totalAirports), 'airports'),
          _stat(count(p.totalAirlines), 'airlines'),
        ]),
      ],
    );
  }

  Widget _stat(String value, String label) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  style: AeroText.heading
                      .copyWith(fontFeatures: AeroText.tabular)),
            ),
            Text(label.toUpperCase(), style: AeroText.label),
          ],
        ),
      );
}

class _RouteMap extends StatelessWidget {
  final MapDataEntity map;

  const _RouteMap({required this.map});

  @override
  Widget build(BuildContext context) {
    // One frame for the camera fit and the dots: CircleLayer doesn't repeat
    // worlds, so a dot left at -158 is off-screen when the fit is at 202.
    final points = airportPoints(map.airports);
    return FlutterMap(
      options: MapOptions(
        initialCameraFit: CameraFit.coordinates(
          coordinates: points,
          padding: const EdgeInsets.all(AeroSpace.xl),
          maxZoom: 6,
        ),
        interactionOptions:
            const InteractionOptions(flags: InteractiveFlag.none),
      ),
      children: [
        lightMapTileLayer,
        PolylineLayer(polylines: [
          for (final r in map.routes)
            for (final part in splitAtAntimeridian(greatCirclePoints(
              LatLng(r.fromLat.toDouble(), r.fromLon.toDouble()),
              LatLng(r.toLat.toDouble(), r.toLon.toDouble()),
            )))
              Polyline(
                points: part,
                color: AeroAccent.passport,
                strokeWidth: 2,
              ),
        ]),
        CircleLayer(circles: [
          for (final p in points)
            CircleMarker(point: p, radius: 3, color: AeroAccent.passport),
        ]),
      ],
    );
  }
}

/// Airport positions with longitudes unwrapped by [fitLongitudes], so a
/// transpacific log fits across the Pacific instead of the other way round.
List<LatLng> airportPoints(Iterable<MapAirportEntity> airports) {
  final list = airports.toList();
  final lons = fitLongitudes([for (final a in list) a.lon.toDouble()]);
  return [
    for (var i = 0; i < list.length; i++)
      LatLng(list[i].lat.toDouble(), lons[i])
  ];
}

/// [lons] (in -180..180) shifted so they cover the narrowest arc: when the
/// widest gap between neighbours isn't the one across ±180, everything west
/// of it moves east by 360. Same order as [lons].
List<double> fitLongitudes(List<double> lons) {
  if (lons.length < 2) return lons;
  final sorted = [...lons]..sort();
  var gap = sorted.first + 360 - sorted.last; // across ±180
  double? cut;
  for (var i = 0; i + 1 < sorted.length; i++) {
    final g = sorted[i + 1] - sorted[i];
    if (g > gap) {
      gap = g;
      cut = sorted[i];
    }
  }
  if (cut == null) return lons;
  return [for (final l in lons) l <= cut ? l + 360 : l];
}

/// flutter_map wants longitudes in [-180, 180]; greatCirclePoints unwraps
/// past them, so wrap back and break the line at ±180, adding the crossing
/// point to both pieces so each reaches the edge.
List<List<LatLng>> splitAtAntimeridian(List<LatLng> points) {
  double wrap(double lon) => (lon + 180) % 360 - 180;
  final parts = <List<LatLng>>[[]];
  LatLng? prev;
  for (final p in points) {
    final lon = wrap(p.longitude);
    if (prev != null && (lon - prev.longitude).abs() > 180) {
      // Going east crosses +180 (lon jumps negative), west crosses -180.
      final edge = prev.longitude > 0 ? 180.0 : -180.0;
      final next = lon + 2 * edge; // lon on prev's side of the line
      final t = (edge - prev.longitude) / (next - prev.longitude);
      final lat = prev.latitude + t * (p.latitude - prev.latitude);
      parts.last.add(LatLng(lat, edge));
      parts.add([LatLng(lat, -edge)]);
    }
    final w = LatLng(p.latitude, lon);
    parts.last.add(w);
    prev = w;
  }
  return parts;
}
