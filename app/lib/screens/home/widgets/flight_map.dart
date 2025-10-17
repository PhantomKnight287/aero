import 'dart:math';
import 'dart:async';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:plane_pal/constants/main.dart';
import 'package:plane_pal/services/main.dart';

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
  final Function(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner)? onAircraftSelected;

  const FlightMap({
    super.key,
    required this.mapController,
    this.arrivalAirport,
    this.departureAirport,
    required this.coordinates,
    this.onAircraftSelected,
  });

  @override
  State<FlightMap> createState() => _FlightMapState();
}

class _FlightMapState extends State<FlightMap> {
  List<FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner> _aircraft = [];
  bool _isLoading = false;
  String? _error;
  Timer? _updateTimer;
  final FlightDataService _flightService = FlightDataService();

  @override
  void initState() {
    super.initState();
    _fetchAircraft();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _updateTimer = Timer.periodic(const Duration(seconds: 30), (_) {
          _fetchAircraft();
        });
      },
    );
    // Update aircraft data every 30 seconds
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchAircraft() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final bounds = getVisibleMapBounds(widget.mapController);
      final response = await _flightService.getFlightsInBounds(
        minLat: bounds.minLat,
        maxLat: bounds.maxLat,
        minLng: bounds.minLng,
        maxLng: bounds.maxLng,
      );

      if (response.success == true) {
        final flightsJson = response.flights!;
        final filteredAircrafts = flightsJson
            .where((aircraft) =>
                aircraft.latitude != null &&
                aircraft.longitude != null &&
                aircraft.isOnGround == false)
            .toList();
        
        print("filtered: ${filteredAircrafts.length}");
        setState(() {
          _aircraft = filteredAircrafts;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch aircraft data';
          _isLoading = false;
        });
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Marker _buildAircraftMarker(FlightsControllerGetFlightsInBoundsV1200ResponseFlightsInner aircraft) {
    return Marker(
      point: LatLng(aircraft.latitude!.toDouble(), aircraft.longitude!.toDouble()),
      width: 30,
      height: 30,
      child: GestureDetector(
        onTap: () {
          if (widget.onAircraftSelected != null) {
            widget.onAircraftSelected!(aircraft);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.flight,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
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
                // Aircraft markers
                ..._aircraft.map((aircraft) => _buildAircraftMarker(aircraft)),
              ],
            ),
            if (widget.arrivalAirport != null &&
                widget.departureAirport != null)
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
          ],
        ),
        // Loading indicator
        if (_isLoading)
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Loading aircrafts...'),
                ],
              ),
            ),
          ),
        // Error indicator
        if (_error != null)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        // Aircraft count indicator and refresh button
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_aircraft.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_aircraft.length} aircrafts',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                onPressed: _fetchAircraft,
                backgroundColor: Colors.white.withOpacity(0.9),
                child: const Icon(Icons.refresh, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
