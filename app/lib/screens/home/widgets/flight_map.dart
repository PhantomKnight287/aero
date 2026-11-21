import 'dart:async';
import 'package:aero/ui/tokens.dart';
import 'dart:math';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:aero/constants/map.dart';

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
  final bool isFlightInAir;
  final List<AirportEntity> airports;
  final void Function(
    double minLat,
    double maxLat,
    double minLng,
    double maxLng,
  )? onBoundsChanged;
  final void Function(AirportEntity airport)? onAirportTap;

  /// Where the aircraft was at the point scrubbed on the flight profile.
  final LatLng? highlightPosition;

  const FlightMap({
    super.key,
    this.highlightPosition,
    required this.mapController,
    this.arrivalAirport,
    this.departureAirport,
    required this.coordinates,
    this.flightTrackPoints = const [],
    this.currentHeading,
    this.onAircraftSelected,
    this.isFlightInAir = false,
    this.airports = const [],
    this.onBoundsChanged,
    this.onAirportTap,
  });

  @override
  State<FlightMap> createState() => _FlightMapState();
}

class _FlightMapState extends State<FlightMap> {
  Timer? _boundsDebounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _boundsDebounce?.cancel();
    super.dispose();
  }

  /// Debounced map-movement handler. Once the user has zoomed in past the
  /// threshold, panning triggers a backend query for airports in the new bounds.
  void _handlePositionChanged(MapCamera camera, bool hasGesture) {
    if (widget.onBoundsChanged == null) return;
    _boundsDebounce?.cancel();
    _boundsDebounce = Timer(const Duration(milliseconds: 400), () {
      if (camera.zoom < kAirportQueryMinZoom) return;
      final bounds = getVisibleMapBounds(widget.mapController);
      widget.onBoundsChanged!(
        bounds.minLat,
        bounds.maxLat,
        bounds.minLng,
        bounds.maxLng,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController.mapController,
          options: MapOptions(
              initialCenter:
                  const LatLng(28.086815545374254, 76.50837368121545),
              initialZoom: 5,
              onPositionChanged: _handlePositionChanged,
              cameraConstraint: CameraConstraint.containLatitude()),
          children: [
            openStreetMapTileLayer,
            if (widget.airports.isNotEmpty)
              MarkerLayer(
                markers: widget.airports
                    .map(
                      (airport) => Marker(
                        point: LatLng(
                          double.parse(airport.lat),
                          double.parse(airport.long),
                        ),
                        width: 28,
                        height: 28,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => widget.onAirportTap?.call(airport),
                          child: Center(
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade700,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            MarkerLayer(
              markers: [
                if (widget.highlightPosition != null)
                  Marker(
                    point: widget.highlightPosition!,
                    width: 18,
                    height: 18,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AeroColors.ink,
                        shape: BoxShape.circle,
                        border: Border.all(color: AeroColors.surface, width: 3),
                        boxShadow: const [
                          BoxShadow(color: AeroColors.shadow, blurRadius: 4),
                        ],
                      ),
                    ),
                  ),
                if (widget.arrivalAirport != null)
                  Marker(
                    point: LatLng(double.parse(widget.arrivalAirport!.lat),
                        double.parse(widget.arrivalAirport!.long)),
                    width: 18,
                    height: 18,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (widget.departureAirport != null)
                  Marker(
                    point: LatLng(double.parse(widget.departureAirport!.lat),
                        double.parse(widget.departureAirport!.long)),
                    width: 18,
                    height: 18,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
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
            if (widget.flightTrackPoints.isEmpty &&
                widget.coordinates.isNotEmpty)
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
                drawInSingleWorld: false,
                polylines: [
                  Polyline(
                    points: widget.flightTrackPoints,
                    color: Colors.green,
                    strokeWidth: 3,
                    borderStrokeWidth: 1,
                    borderColor: Colors.white70,
                    strokeCap: StrokeCap.round,
                    strokeJoin: StrokeJoin.round,
                  ),
                ],
              ),
            // Show moving aircraft marker only when airborne
            if (widget.flightTrackPoints.isNotEmpty && widget.isFlightInAir)
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
            // When not airborne, show static origin/destination markers from track points
            if (widget.flightTrackPoints.isNotEmpty && !widget.isFlightInAir)
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.flightTrackPoints.first,
                    width: 18,
                    height: 18,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Marker(
                    point: widget.flightTrackPoints.last,
                    width: 18,
                    height: 18,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
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
