import 'dart:math';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:plane_pal/constants/main.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token={accessToken}',
      userAgentPackageName: 'com.phantomknight287.planepal',
      tileProvider: CancellableNetworkTileProvider(),
      additionalOptions: const {
        'accessToken': MAPBOX_API_KEY,
      },
      tileSize: 512,
      zoomOffset: -1,
    );

/// Get the visible bounds of the map with reasonable limits to prevent
/// querying flights across the entire world
MapBounds getVisibleMapBounds(AnimatedMapController mapController) {
  final mapState = mapController.mapController.camera;
  final center = mapState.center;
  final zoom = mapState.zoom;

  // Calculate the visible bounds based on zoom level
  // At zoom level 1, the world is roughly 180 degrees wide
  // Each zoom level doubles the detail (halves the visible area)
  final degreesPerPixel = 360 / (256 * pow(2, zoom));
  final screenWidth = 400; // Approximate screen width in pixels
  final screenHeight = 400; // Approximate screen height in pixels

  final latSpan = (screenHeight * degreesPerPixel) / 2;
  final lngSpan = (screenWidth * degreesPerPixel) / 2;

  // Calculate bounds
  double minLat = center.latitude - latSpan;
  double maxLat = center.latitude + latSpan;
  double minLng = center.longitude - lngSpan;
  double maxLng = center.longitude + lngSpan;

  // Apply reasonable bounds to prevent queries that are too large
  // Maximum span: 30 degrees (roughly 3000km at equator)
  const maxSpan = 30.0;

  if (maxLat - minLat > maxSpan) {
    final centerLat = (maxLat + minLat) / 2;
    minLat = centerLat - maxSpan / 2;
    maxLat = centerLat + maxSpan / 2;
  }

  if (maxLng - minLng > maxSpan) {
    final centerLng = (maxLng + minLng) / 2;
    minLng = centerLng - maxSpan / 2;
    maxLng = centerLng + maxSpan / 2;
  }

  // Ensure bounds are within world limits
  minLat = minLat.clamp(-90.0, 90.0);
  maxLat = maxLat.clamp(-90.0, 90.0);
  minLng = minLng.clamp(-180.0, 180.0);
  maxLng = maxLng.clamp(-180.0, 180.0);

  return MapBounds(
    minLat: minLat,
    maxLat: maxLat,
    minLng: minLng,
    maxLng: maxLng,
  );
}

class MapBounds {
  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  const MapBounds({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  @override
  String toString() {
    return 'MapBounds(minLat: $minLat, maxLat: $maxLat, minLng: $minLng, maxLng: $maxLng)';
  }
}

class FlightMap extends StatefulWidget {
  final AnimatedMapController mapController;
  final AirportEntity? departureAirport;
  final AirportEntity? arrivalAirport;
  final List<LatLng> coordinates;
  final List<LatLng> flightTrackPoints;
  final double? currentHeading;
  final Function(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)?
      onAircraftSelected;

  const FlightMap({
    super.key,
    required this.mapController,
    this.arrivalAirport,
    this.departureAirport,
    required this.coordinates,
    this.flightTrackPoints = const [],
    this.currentHeading,
    this.onAircraftSelected,
  });

  @override
  State<FlightMap> createState() => _FlightMapState();
}

class _FlightMapState extends State<FlightMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController.mapController,
          options: MapOptions(
            initialCenter: const LatLng(28.086815545374254, 76.50837368121545),
            initialZoom: 5,
            cameraConstraint: CameraConstraint.contain(
              bounds: LatLngBounds(
                const LatLng(-90, -180),
                const LatLng(90, 180),
              ),
            ),
          ),
          children: [
            openStreetMapTileLayer,
            MarkerLayer(
              markers: [
                if (widget.arrivalAirport != null)
                  Marker(
                    point: LatLng(double.parse(widget.arrivalAirport!.lat),
                        double.parse(widget.arrivalAirport!.long)),
                    width: 10,
                    height: 10,
                    child: FlutterLogo(),
                  ),
                if (widget.departureAirport != null)
                  Marker(
                    point: LatLng(double.parse(widget.departureAirport!.lat),
                        double.parse(widget.departureAirport!.long)),
                    width: 10,
                    height: 10,
                    child: FlutterLogo(),
                  ),
              ],
            ),
            if (widget.arrivalAirport != null &&
                widget.departureAirport != null &&
                widget.flightTrackPoints.isEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(
                        double.parse(widget.arrivalAirport!.lat),
                        double.parse(widget.arrivalAirport!.long),
                      ),
                      LatLng(
                        double.parse(widget.departureAirport!.lat),
                        double.parse(widget.departureAirport!.long),
                      ),
                    ],
                    color: Colors.blueAccent,
                    strokeWidth: 4,
                    borderStrokeWidth: 2,
                    borderColor: Colors.white70,
                  ),
                ],
              ),
              if(widget.flightTrackPoints.isEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                    points: widget.coordinates.map((e) => e).toList(),
                    color: Colors.blueAccent,
                    strokeWidth: 4,
                    borderStrokeWidth: 2,
                    borderColor: Colors.white70,
                    pattern: StrokePattern.dashed(segments: [10, 10])),
              ],
            ),
            if (widget.flightTrackPoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: widget.flightTrackPoints,
                    color: Colors.green,
                    strokeWidth: 3,
                    borderStrokeWidth: 1,
                    borderColor: Colors.white70,
                  ),
                ],
              ),
            if (widget.flightTrackPoints.isNotEmpty)
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.flightTrackPoints.last,
                    width: 30,
                    height: 30,
                    child: Transform.rotate(
                      angle: widget.currentHeading != null
                          ? (widget.currentHeading! * pi / 180)
                          : 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.flight,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
