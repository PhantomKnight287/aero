import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/country_flag.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

const _earthKm = 40075;
const _maxFlags = 11;
const _flagSize = 24.0;
const _flagStep = 18.0; // ringed flag is 28 dp, so 10 dp overlap
const _flagLabelWidth = 120.0; // room kept for "+25 · 36 countries"

/// The two machine-readable lines, 44 chars each, built only from stats
/// (never the user's name).
(String, String) passportMrz(ProfileStatsResponseEntity s, {DateTime? now}) {
  final p = s.passport;
  final years = s.availableYears.map((y) => y.toInt()).toList()..sort();
  final today = now ?? DateTime.now();
  final first = years.isEmpty ? today.year : years.first;
  final issued = DateFormat('ddMMMyy', 'en_US').format(today).toUpperCase();
  final l1 = 'P<AERO<${s.year?.toInt() ?? 'ALLTIME'}<<${p.totalFlights.toInt()}'
      '<FLT<<${p.totalCountries.toInt()}<CTRY';
  final l2 = 'FIRST<FLT<$first<<ISSUED<$issued';
  return (l1.padRight(44, '<'), l2.padRight(44, '<'));
}

/// Hub passport: cover title, flag row, headline stats, machine-readable
/// strip and the "All flight stats" row.
class PassportCard extends StatelessWidget {
  final ProfileStatsResponseEntity stats;
  final VoidCallback? onOpen;

  const PassportCard({super.key, required this.stats, this.onOpen});

  @override
  Widget build(BuildContext context) {
    final unit = context.watch<UnitsNotifier>().distance;
    final p = stats.passport;
    final (l1, l2) = passportMrz(stats);
    final value = AeroText.figureLg.copyWith(color: AeroColors.onInk);
    final small = AeroText.figure
        .copyWith(color: AeroColors.onInk, fontWeight: FontWeight.w800);
    const pad =
        EdgeInsets.fromLTRB(AeroSpace.lg, AeroSpace.lg, AeroSpace.lg, 0);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: AeroAccent.passportGradient,
        ),
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: pad,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AERO PASSPORT',
                          style: AeroText.title.copyWith(
                              color: AeroColors.onInk, letterSpacing: 0.5)),
                      const SizedBox(height: 2),
                      // Tracking breaks Devanagari's top line.
                      Text.rich(
                          TextSpan(text: 'PASSPORT · PASSEPORT · ', children: [
                            TextSpan(
                                text: 'पासपोर्ट',
                                style: TextStyle(letterSpacing: 0)),
                          ]),
                          style: AeroText.label.copyWith(
                              color: AeroAccent.onPassportMuted,
                              letterSpacing: 1.4)),
                    ],
                  ),
                ),
                const _Emblem(),
              ],
            ),
          ),
          if (stats.countries.isNotEmpty)
            Padding(
              padding: pad.copyWith(top: AeroSpace.md),
              child: _FlagRow(stats.countries.toList()),
            ),
          Padding(
            padding: pad,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _Stat('Flights',
                      Text(formatCount(p.totalFlights), style: value),
                      sub: '${formatCount(p.longHaul)} long haul'),
                ),
                Expanded(
                  flex: 7,
                  child: _Stat(
                      'Distance',
                      UnitText.distance(p.totalDistanceKm, unit,
                          style: value, unitColor: AeroAccent.onPassportMuted),
                      sub: '${formatDecimal(p.totalDistanceKm / _earthKm)}× '
                          'around Earth'),
                ),
              ],
            ),
          ),
          Padding(
            padding: pad.copyWith(top: AeroSpace.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: _Stat(
                        'Time',
                        UnitText.days(p.blockMinutes.toInt(),
                            style: small,
                            unitColor: AeroAccent.onPassportMuted))),
                Expanded(
                    child: _Stat('Airports',
                        Text(formatCount(p.totalAirports), style: small))),
                Expanded(
                    child: _Stat('Airlines',
                        Text(formatCount(p.totalAirlines), style: small))),
              ],
            ),
          ),
          const SizedBox(height: AeroSpace.lg),
          // Decorative: the same numbers are read out above.
          ExcludeSemantics(
            child: Container(
              color: AeroAccent.passportBand,
              padding: const EdgeInsets.symmetric(
                  horizontal: AeroSpace.lg, vertical: AeroSpace.sm + 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text('$l1\n$l2',
                    softWrap: false,
                    style: AeroText.mono
                        .copyWith(color: AeroAccent.onPassportMrz)),
              ),
            ),
          ),
          if (onOpen != null)
            Semantics(
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onOpen,
                child: AeroPressable(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: AeroAccent.passportRule))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AeroSpace.lg, vertical: AeroSpace.md),
                    child: Row(children: [
                      Text('All flight stats',
                          style: AeroText.body.copyWith(
                              color: AeroColors.onInk,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Icon(Icons.chevron_right,
                          size: 20, color: AeroColors.onInk),
                    ]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Emblem extends StatelessWidget {
  const _Emblem();

  @override
  Widget build(BuildContext context) => Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AeroAccent.passportEmblem),
          borderRadius: AeroRadius.smAll,
        ),
        child: Icon(Icons.flight,
            size: 20, color: AeroAccent.passportGradient.first),
      );
}

/// Overlapping ringed flags, as many as fit (max 11), then "+N · M countries".
class _FlagRow extends StatelessWidget {
  final List<CountryEntity> countries;

  const _FlagRow(this.countries);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final fit = ((box.maxWidth - _flagLabelWidth - _flagSize - 4) / _flagStep)
              .floor() +
          1;
      final shown = [countries.length, _maxFlags, fit.clamp(1, _maxFlags)]
          .reduce((a, b) => a < b ? a : b);
      final rest = countries.length - shown;
      final total = formatCount(countries.length);
      final label = rest > 0
          ? '+${formatCount(rest)} · $total countries'
          : '$total ${countries.length == 1 ? 'country' : 'countries'}';
      return Row(children: [
        SizedBox(
          width: _flagSize + 4 + (shown - 1) * _flagStep,
          height: _flagSize + 4,
          child: Stack(children: [
            for (var i = 0; i < shown; i++)
              Positioned(
                left: i * _flagStep,
                child: CountryFlag(
                    iso2: countries[i].isoCountry,
                    size: _flagSize,
                    ring: AeroAccent.passportRing),
              ),
          ]),
        ),
        const SizedBox(width: AeroSpace.sm),
        Flexible(
          child: Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AeroText.caption.copyWith(
                  color: AeroAccent.onPassportMuted,
                  fontWeight: FontWeight.w600,
                  fontFeatures: AeroText.tabular)),
        ),
      ]);
    });
  }
}

/// Uppercase label over a value scaled down to fit its column.
class _Stat extends StatelessWidget {
  final String label;
  final Widget value;
  final String? sub;

  const _Stat(this.label, this.value, {this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AeroSpace.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style:
                  AeroText.label.copyWith(color: AeroAccent.onPassportMuted)),
          const SizedBox(height: 2),
          FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: value),
          if (sub != null)
            Text(sub!,
                style: AeroText.caption.copyWith(
                    color: AeroAccent.onPassportMuted,
                    fontFeatures: AeroText.tabular)),
        ],
      ),
    );
  }
}
