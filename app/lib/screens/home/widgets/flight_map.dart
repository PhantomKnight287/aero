import 'package:aero/screens/home/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.phantomknight287.planepal',
      tileProvider: CancellableNetworkTileProvider(),
    );

class FlightMap extends StatelessWidget {
  final AnimatedMapController mapController;
  final Airport? departureAirport;
  final Airport? arrivalAirport;

  const FlightMap({
    super.key,
    required this.mapController,
    this.arrivalAirport,
    this.departureAirport,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController.mapController,
      options: MapOptions(
        initialCenter: const LatLng(51.5, -0.09),
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
            if (arrivalAirport != null)
              Marker(
                point: LatLng(arrivalAirport!.lat, arrivalAirport!.long),
                width: 10,
                height: 10,
                child: FlutterLogo(),
              ),
            if (departureAirport != null)
              Marker(
                point: LatLng(departureAirport!.lat, departureAirport!.long),
                width: 10,
                height: 10,
                child: FlutterLogo(),
              )
          ],
        ),
        if (arrivalAirport != null && departureAirport != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: [
                  LatLng(
                    arrivalAirport!.lat,
                    arrivalAirport!.long,
                  ),
                  LatLng(
                    departureAirport!.lat,
                    departureAirport!.long,
                  ),
                ],
                color: Colors.blue,
                strokeWidth: 3,
                pattern: StrokePattern.dotted(),
              ),
            ],
          ),
      ],
    );
  }
}
