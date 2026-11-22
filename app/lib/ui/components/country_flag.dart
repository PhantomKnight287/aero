import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

import '../tokens.dart';

// Codes the package ships a flag for. "XX" is its generic "?" flag; we want our
// own neutral circle for that instead.
final _known = {for (final c in Flag.values) c.toUpperCase()}..remove('XX');

/// Round country flag. Unknown/invalid ISO-2 renders a neutral circle.
/// [ring] draws a 2 dp outer ring (overlapping rows on the passport).
class CountryFlag extends StatelessWidget {
  final String iso2;
  final double size;
  final Color? ring;

  const CountryFlag({super.key, required this.iso2, this.size = 24, this.ring});

  @override
  Widget build(BuildContext context) {
    final code = iso2.toUpperCase();
    final ok = RegExp(r'^[A-Z]{2}$').hasMatch(code) && _known.contains(code);
    final flag = ok
        ? CircleFlag(code, size: size)
        : Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
                color: AeroColors.surfaceAlt, shape: BoxShape.circle),
          );
    if (ring == null) return SizedBox.square(dimension: size, child: flag);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: ring, shape: BoxShape.circle),
      child: flag,
    );
  }
}
