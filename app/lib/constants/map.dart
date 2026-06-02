import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:aero/constants/main.dart';

/// Minimum zoom level at which the map starts querying the backend for airports
/// within the visible bounds. Below this, the visible area is too large to query
/// without flooding the DB and the client.
const double kAirportQueryMinZoom = 4.0;

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token={accessToken}',
      userAgentPackageName: 'com.phantomknight287.aero',
      tileProvider: CancellableNetworkTileProvider(),
      additionalOptions: const {
        'accessToken': MAPBOX_API_KEY,
      },
      tileDimension: 512,
      zoomOffset: -1,
    );
