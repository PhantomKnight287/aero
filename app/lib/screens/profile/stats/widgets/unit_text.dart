import 'package:aero/formatters/units.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// A number with grey, smaller unit letters on the digits' baseline:
/// '623h 24m', '4,96,500 km'. Each part is (text, isUnit).
class UnitText extends StatelessWidget {
  final List<(String, bool)> parts;
  final TextStyle style;

  /// Unit letter colour; pass a tinted muted colour on gradient cards.
  final Color unitColor;

  const UnitText(this.parts,
      {super.key, required this.style, this.unitColor = AeroColors.muted});

  /// '623h 24m'; '38m' under an hour.
  UnitText.duration(int minutes,
      {super.key, required this.style, this.unitColor = AeroColors.muted})
      : parts = [
          if (minutes >= 60) ...[(_n(minutes ~/ 60), false), ('h', true)],
          ('${minutes >= 60 ? ' ' : ''}${minutes % 60}', false),
          ('m', true),
        ];

  /// '25d 23h'.
  UnitText.days(int minutes,
      {super.key, required this.style, this.unitColor = AeroColors.muted})
      : parts = [
          (_n(minutes ~/ 1440), false),
          ('d', true),
          (' ${minutes % 1440 ~/ 60}', false),
          ('h', true),
        ];

  /// '4,96,500 km' in the user's unit.
  UnitText.distance(num km, DistanceUnit u,
      {super.key, required this.style, this.unitColor = AeroColors.muted})
      : parts = [
          (_n(convertDistance(km, u)), false),
          (' ${unitLabel(u)}', true),
        ];

  // No explicit locale: follows Intl.defaultLocale.
  static String _n(num v) => NumberFormat.decimalPattern().format(v.round());

  @override
  Widget build(BuildContext context) {
    final unit = style.copyWith(
        color: unitColor,
        fontSize: style.fontSize! * 0.55,
        fontWeight: FontWeight.w500);
    return Text.rich(TextSpan(children: [
      for (final (text, isUnit) in parts)
        TextSpan(text: text, style: isUnit ? unit : style),
    ]));
  }
}
