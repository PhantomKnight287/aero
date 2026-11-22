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

  /// Unit size relative to the digits; larger for body-sized text.
  final double unitScale;

  const UnitText(this.parts,
      {super.key,
      required this.style,
      this.unitColor = AeroColors.muted,
      this.unitScale = 0.55});

  /// '623h 24m'; '38m' under an hour.
  UnitText.duration(int minutes,
      {super.key,
      required this.style,
      this.unitColor = AeroColors.muted,
      this.unitScale = 0.55})
      : parts = [
          if (minutes >= 60) ...[(_n(minutes ~/ 60), false), ('h', true)],
          ('${minutes >= 60 ? ' ' : ''}${minutes % 60}', false),
          ('m', true),
        ];

  /// '25d 23h'.
  UnitText.days(int minutes,
      {super.key,
      required this.style,
      this.unitColor = AeroColors.muted,
      this.unitScale = 0.55})
      : parts = [
          (_n(minutes ~/ 1440), false),
          ('d', true),
          (' ${minutes % 1440 ~/ 60}', false),
          ('h', true),
        ];

  /// '4,96,500 km' in the user's unit.
  UnitText.distance(num km, DistanceUnit u,
      {super.key,
      required this.style,
      this.unitColor = AeroColors.muted,
      this.unitScale = 0.55})
      : parts = [
          (_n(convertDistance(km, u)), false),
          (' ${unitLabel(u)}', true),
        ];

  /// An already formatted value ('15h 47m', '7,369 ft') with the unit
  /// letters after its digits greyed.
  UnitText.parse(String s,
      {super.key,
      required this.style,
      this.unitColor = AeroColors.muted,
      this.unitScale = 0.55})
      : parts = _split(s);

  static final _unit = RegExp(r'(?<=\d)\s?(km|mi|nm|ft|h|m|d)\b');

  static List<(String, bool)> _split(String s) {
    final out = <(String, bool)>[];
    s.splitMapJoin(_unit, onMatch: (m) {
      out.add((m[0]!, true));
      return '';
    }, onNonMatch: (t) {
      if (t.isNotEmpty) out.add((t, false));
      return '';
    });
    return out;
  }

  // No explicit locale: follows Intl.defaultLocale.
  static String _n(num v) => NumberFormat.decimalPattern().format(v.round());

  @override
  Widget build(BuildContext context) {
    final unit = style.copyWith(
        color: unitColor,
        fontSize: style.fontSize! * unitScale,
        fontWeight: FontWeight.w500);
    return Text.rich(TextSpan(children: [
      for (final (text, isUnit) in parts)
        TextSpan(text: text, style: isUnit ? unit : style),
    ]));
  }
}
