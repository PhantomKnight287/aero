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
    final points = [
      for (final a in map.airports) LatLng(a.lat.toDouble(), a.lon.toDouble())
    ];
    return FlutterMap(
      options: MapOptions(
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(points),
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
            for (final part in _splitAtAntimeridian(greatCirclePoints(
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

/// flutter_map wants longitudes in [-180, 180]; greatCirclePoints unwraps
/// past them, so wrap back and break the line where it crosses.
List<List<LatLng>> _splitAtAntimeridian(List<LatLng> points) {
  final parts = <List<LatLng>>[[]];
  double? prev;
  for (final p in points) {
    final lon = (p.longitude + 180) % 360 - 180;
    if (prev != null && (lon - prev).abs() > 180) parts.add([]);
    parts.last.add(LatLng(p.latitude, lon));
    prev = lon;
  }
  return parts;
}
