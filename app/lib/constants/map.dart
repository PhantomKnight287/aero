import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:aero/constants/main.dart';

/// Minimum zoom level at which the map starts querying the backend for airports
/// within the visible bounds. Below this, the visible area is too large to query
/// without flooding the DB and the client.
const double kAirportQueryMinZoom = 4.0;

TileLayer _mapboxTileLayer(String style) => TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/$style/tiles/{z}/{x}/{y}?access_token={accessToken}',
      userAgentPackageName: 'com.phantomknight287.aero',
      tileProvider: CancellableNetworkTileProvider(),
      additionalOptions: const {
        'accessToken': MAPBOX_API_KEY,
      },
      tileDimension: 512,
      zoomOffset: -1,
      // With the -1 offset, zoom 0 would request z=-1 (404): upscale z=0.
      minNativeZoom: 1,
    );

TileLayer get openStreetMapTileLayer => _mapboxTileLayer('streets-v12');

TileLayer get lightMapTileLayer => _mapboxTileLayer('light-v11');
