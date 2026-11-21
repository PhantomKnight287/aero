import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../tokens.dart';

/// Airline logo: our SVG when we have one, FlightAware PNG by ICAO otherwise,
/// plane icon as last resort. Same fallback chain used across the app.
class AirlineLogo extends StatelessWidget {
  final String? svgUrl;
  final String? icao;
  final double size;

  const AirlineLogo({super.key, this.svgUrl, this.icao, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final fallback = Icon(Icons.airplanemode_active,
        size: size * .75, color: AeroColors.muted);
    return SizedBox.square(
      dimension: size,
      child: svgUrl != null
          ? SvgPicture.network(svgUrl!, fit: BoxFit.contain)
          : icao == null
              ? fallback
              : CachedNetworkImage(
                  imageUrl:
                      'https://www.flightaware.com/images/airline_logos/180px/$icao.png',
                  fit: BoxFit.contain,
                  errorWidget: (_, __, ___) => fallback,
                ),
    );
  }
}
