import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/home/widgets/timezone_shift.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/flight_timing.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

/// Timezone shift, one weather line per airport, and airport delays only
/// when there are any. Full METAR/TAF/delay detail lives in the airport
/// sheet these rows open.
class GoodToKnow extends StatelessWidget {
  final FlightResponseEntity info;
  final ValueChanged<RouteAirportEntity>? onAirportTap;

  const GoodToKnow({super.key, required this.info, this.onAirportTap});

  static String _code(RouteAirportEntity a) =>
      a.iata.isNotEmpty ? a.iata : a.icao;

  static String? _str(Object? json) {
    final v = json is String ? json : (json as dynamic)?.value;
    final s = v?.toString().trim();
    return s == null || s.isEmpty ? null : s;
  }

  static String _cap(String s) => s[0].toUpperCase() + s.substring(1);

  Widget? _weather(RouteAirportEntity a, TempUnit unit) {
    final o = a.conditions?.observation;
    if (o == null) return null;
    final temp = num.tryParse(_str(o.tempAir) ?? '');
    final sky = _str(o.conditions) ?? _str(o.cloudFriendly);
    final parts = [
      if (temp != null) formatTemp(temp, unit),
      if (sky != null) _cap(sky),
    ];
    if (parts.isEmpty) return null;
    return _Row(
      icon: Icons.wb_cloudy_outlined,
      text: '${_code(a)} ${parts.join(' · ')}',
      onTap: onAirportTap == null ? null : () => onAirportTap!(a),
    );
  }

  Widget? _delay(RouteAirportEntity a) {
    final d = a.conditions?.delays;
    final secs = d?.delaySecs.toInt() ?? 0;
    if (d == null || secs <= 0) return null;
    final reasons = d.reasons.map((r) => r.reason).where((s) => s.isNotEmpty);
    return _Row(
      icon: Icons.timer_outlined,
      color: AeroColors.warn,
      text: '${_code(a)} delays ~${formatLongDuration((secs / 60).round())}',
      detail: reasons.isEmpty ? null : reasons.join(' · '),
      onTap: onAirportTap == null ? null : () => onAirportTap!(a),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<UnitsNotifier>().temperature;
    final rows = [
      for (final a in [info.departure.airport, info.arrival.airport]) ...[
        _delay(a),
        _weather(a, unit),
      ],
    ].whereType<Widget>().toList();
    final at = DateTime.tryParse(info.departure.scheduledTime.utc);
    final shifts = at != null &&
        zoneShift(at, info.departure.airport.timeZone,
                info.arrival.airport.timeZone) !=
            null;
    final all = <Widget>[
      if (shifts)
        TimezoneShift(
            departure: info.departure, arrival: info.arrival, bare: true),
      ...rows,
    ];
    if (all.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Good to know', style: AeroText.sectionTitle),
        const SizedBox(height: AeroSpace.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AeroSpace.md),
          decoration: const BoxDecoration(
              color: AeroColors.surfaceAlt, borderRadius: AeroRadius.mdAll),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < all.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: AeroColors.line),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
                  child: all[i],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? detail;
  final Color color;
  final VoidCallback? onTap;

  const _Row({
    required this.icon,
    required this.text,
    this.detail,
    this.color = AeroColors.ink,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(children: [
      Icon(icon, size: 20, color: color),
      const SizedBox(width: AeroSpace.md),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: AeroText.body.copyWith(
                    color: AeroColors.ink,
                    fontWeight: FontWeight.w600,
                    fontFeatures: AeroText.tabular)),
            if (detail != null) Text(detail!, style: AeroText.caption),
          ],
        ),
      ),
      if (onTap != null)
        const Icon(Icons.chevron_right, size: 20, color: AeroColors.muted),
    ]);
    if (onTap == null) return row;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(child: row),
      ),
    );
  }
}
