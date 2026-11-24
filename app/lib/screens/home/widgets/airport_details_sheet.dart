import 'dart:math';

import 'package:aero/constants/main.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_pill_button.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/components/country_flag.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

/// Bottom sheet for an airport: identity and facts, delays, decoded METAR
/// and TAF. The airport record from the details call (country, region,
/// elevation) replaces whatever the caller knew.
class AirportDetailsSheet extends StatefulWidget {
  final AirportEntity airport;

  /// IANA zone for airport-time clocks; unknown zones show UTC.
  final String? timeZone;

  /// Pins "now" for tests.
  final DateTime? now;

  const AirportDetailsSheet(
      {super.key, required this.airport, this.timeZone, this.now});

  @override
  State<AirportDetailsSheet> createState() => _AirportDetailsSheetState();
}

class _AirportDetailsSheetState extends State<AirportDetailsSheet> {
  bool _loading = true;
  AirportDetailsEntity? _details;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    AirportDetailsEntity? details;
    try {
      details = (await openapi
              .getAirportsApi()
              .airportsControllerGetAirportDetailsV1(
                  ident: widget.airport.ident))
          .data;
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _details = details;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final a = _details?.airport ?? widget.airport;
    final subtitle = [
      if (_has(a.iataCode)) a.iataCode!,
      a.ident,
      if (_has(a.municipality)) a.municipality!,
      _typeName(a.type),
    ].join(' · ');

    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
      child: SingleChildScrollView(
        child: AeroSheet(
          title: a.name,
          subtitle: subtitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Facts(airport: a),
              ..._live(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _live(BuildContext context) {
    if (_loading) {
      return [
        for (var i = 0; i < 2; i++) ...[
          const SizedBox(height: AeroSpace.xl),
          Container(
            height: 120,
            decoration: const BoxDecoration(
                color: AeroColors.surfaceAlt, borderRadius: AeroRadius.mdAll),
          ),
        ],
      ];
    }
    final d = _details;
    final delays = _map(d?.delays?.value);
    final metar = d?.metar?.raw;
    final taf = d?.taf?.raw;
    if (delays == null && metar == null && taf == null) {
      return [
        const SizedBox(height: AeroSpace.xl),
        Text(
            d == null
                ? 'Live information is unavailable right now.'
                : 'No weather or delay information is published for this airport.',
            style: AeroText.body),
      ];
    }
    final now = (widget.now ?? DateTime.now()).toUtc();
    return [
      if (delays != null) ...[
        const SizedBox(height: AeroSpace.xl),
        _Delays(delays: delays),
      ],
      if (metar != null) ...[
        const SizedBox(height: AeroSpace.xl),
        _Metar(
            raw: metar,
            d: _map(d!.metar!.decoded?.value),
            now: now,
            timeZone: widget.timeZone),
      ],
      if (taf != null) ...[
        const SizedBox(height: AeroSpace.xl),
        _Taf(
            raw: taf,
            d: _map(d!.taf!.decoded?.value),
            now: now,
            timeZone: widget.timeZone,
            explainSm: metar == null),
      ],
    ];
  }
}

// ---------------------------------------------------------------------------
// Sections
// ---------------------------------------------------------------------------

class _Facts extends StatelessWidget {
  final AirportEntity airport;

  const _Facts({required this.airport});

  @override
  Widget build(BuildContext context) {
    final a = airport;
    final elevation = num.tryParse(a.elevation ?? '');
    final country = a.isoCountry.toUpperCase();
    final region =
        a.isoRegion.contains('-') ? a.isoRegion.split('-').last : a.isoRegion;
    return _Panel(
      child: Wrap(
        spacing: AeroSpace.xl,
        runSpacing: AeroSpace.md,
        children: [
          if (elevation != null)
            _Fact(
              'Elevation',
              UnitCycle(
                dimension: UnitDimension.altitude,
                builder: (_, u) =>
                    _value(formatElevation(elevation, u.altitude)),
              ),
            ),
          _Fact('Coordinates', _value('${_coord(a.lat)}, ${_coord(a.long)}')),
          if (country.isNotEmpty)
            _Fact(
              'Country',
              Row(mainAxisSize: MainAxisSize.min, children: [
                CountryFlag(iso2: country, size: 16),
                const SizedBox(width: AeroSpace.xs),
                _value(_has(region) ? '$country · $region' : country),
              ]),
            ),
          if (_continents[a.continent] != null)
            _Fact('Continent', _value(_continents[a.continent]!)),
        ],
      ),
    );
  }
}

class _Delays extends StatelessWidget {
  final Map delays;

  const _Delays({required this.delays});

  @override
  Widget build(BuildContext context) {
    final secs = delays['delay_secs'] is num ? delays['delay_secs'] as num : 0;
    final category = delays['category']?.toString() ?? '';
    final reasons = _list(delays['reasons']).map(_map).whereType<Map>();
    final head = secs <= 0 || category == 'none'
        ? 'No delays reported'
        : '${_sentence(category)} delays · ${formatLongDuration(secs ~/ 60)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Delays', style: AeroText.sectionTitle),
        const SizedBox(height: AeroSpace.sm),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: _delayColor(delays['color']?.toString()),
                      shape: BoxShape.circle),
                ),
                const SizedBox(width: AeroSpace.sm),
                Expanded(child: Text(head, style: _strong)),
              ]),
              for (final r in reasons)
                Padding(
                  padding: const EdgeInsets.only(
                      left: AeroSpace.lg, top: AeroSpace.xs),
                  child: Text(
                      [
                        r['reason']?.toString() ?? '',
                        if (r['delay_secs'] is num &&
                            (r['delay_secs'] as num) > 0)
                          formatLongDuration((r['delay_secs'] as num) ~/ 60),
                      ].where((s) => s.isNotEmpty).join(' · '),
                      style: AeroText.caption),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metar extends StatelessWidget {
  final String raw;
  final Map? d;
  final DateTime now;
  final String? timeZone;

  const _Metar(
      {required this.raw, required this.d, required this.now, this.timeZone});

  @override
  Widget build(BuildContext context) {
    final u = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final d = this.d;
    final category = d?['flightCategory']?.toString();
    final obs = _map(d?['observation_time'] ?? d?['observationTime']);
    final at = obs == null ? null : _stamp(obs, now);
    final temp = _num(d?['temperatureC']);
    final dew = _num(d?['dewpointC']);
    final alt = _map(d?['altimeter']);
    final inHg = _num(alt?['inHg']);
    final hpa = _num(alt?['hPa']) ?? (inHg == null ? null : inHg * 33.8639);
    final vis = _map(d?['visibility']);
    final weather = _weatherList(_list(d?['weather']));
    final clouds = _sky(_map(d?['sky']), u.altitude);
    final flags = [
      if (d?['isCavok'] == true) 'CAVOK',
      if (d?['isNoSignificantChange'] == true) 'NOSIG',
      if (d?['isAutomated'] == true) 'AUTO',
      if (d?['isCorrected'] == true) 'COR',
    ];
    final summary = weather ??
        (d?['isCavok'] == true ? 'Ceiling and visibility OK' : clouds) ??
        'Clear';
    final ago = at == null ? null : now.difference(at).inMinutes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(child: Text('Weather now', style: AeroText.sectionTitle)),
          if (category != null)
            Text(category,
                style:
                    AeroText.heading.copyWith(color: _categoryColor(category))),
        ]),
        const SizedBox(height: AeroSpace.sm),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  if (temp != null) ...[
                    UnitCycle(
                      dimension: UnitDimension.temperature,
                      builder: (_, u) => Text(formatTemp(temp, u.temperature),
                          style: AeroText.figure),
                    ),
                    const SizedBox(width: AeroSpace.sm),
                  ],
                  Expanded(child: Text(summary, style: _strong)),
                ],
              ),
              if (at != null)
                UnitCycle(
                  dimension: UnitDimension.time,
                  builder: (_, u) => Text(
                      [
                        'observed ${formatClock(at, airportTz: timeZone, mode: u.time, use24: use24)}',
                        if (ago != null && ago >= 0 && ago < 1440)
                          '${formatLongDuration(ago)} ago',
                      ].join(' · '),
                      style: AeroText.caption
                          .copyWith(fontFeatures: AeroText.tabular)),
                ),
              const SizedBox(height: AeroSpace.md),
              _Row('Wind', UnitDimension.speed,
                  (u) => _wind(_map(d?['wind']), u.speed)),
              _Row('Visibility', UnitDimension.distance,
                  (u) => _visibility(vis, u.distance),
                  note: (u) => u.distance == DistanceUnit.mi && vis != null
                      ? _smNote
                      : null),
              if (dew != null)
                _Row(
                    'Dewpoint',
                    UnitDimension.temperature,
                    (u) => [
                          formatTemp(dew, u.temperature),
                          if (temp != null) '${_humidity(temp, dew)}% humidity',
                        ].join(' · ')),
              if (hpa != null)
                _Row('Pressure', UnitDimension.pressure,
                    (u) => formatPressure(hpa, u.pressure)),
              if (clouds != null)
                _Row('Clouds', UnitDimension.altitude,
                    (u) => _sky(_map(d?['sky']), u.altitude)!),
              if (weather != null) _Row('Weather', null, (_) => weather),
              if (flags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AeroSpace.xs),
                  child: Text(flags.join(' · '), style: AeroText.caption),
                ),
              const SizedBox(height: AeroSpace.md),
              _Raw(label: 'METAR', raw: raw),
            ],
          ),
        ),
      ],
    );
  }
}

class _Taf extends StatelessWidget {
  final String raw;
  final Map? d;
  final DateTime now;
  final String? timeZone;

  /// No METAR above to explain "SM", so this panel does.
  final bool explainSm;

  const _Taf(
      {required this.raw,
      required this.d,
      required this.now,
      this.timeZone,
      this.explainSm = false});

  @override
  Widget build(BuildContext context) {
    final u = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    String clock(Map? t) => t == null
        ? '—'
        : formatClock(_stamp(t, now),
            airportTz: timeZone, mode: u.time, use24: use24);
    final d = this.d;
    final issued = _map(d?['issuedAt']);
    final from = _map(d?['validFrom']);
    final to = _map(d?['validTo']);
    final periods = _list(d?['forecast']).map(_map).whereType<Map>().toList();
    final head = [
      if (from != null && to != null) 'valid ${clock(from)} → ${clock(to)}',
      if (issued != null) 'issued ${clock(issued)}',
      if (d?['isAmended'] == true) 'amended',
      if (d?['isCorrected'] == true) 'corrected',
      if (d?['isCancelled'] == true) 'cancelled',
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Forecast', style: AeroText.sectionTitle),
        if (head.isNotEmpty)
          UnitCycle(
            dimension: UnitDimension.time,
            builder: (_, __) => Text(head,
                style:
                    AeroText.caption.copyWith(fontFeatures: AeroText.tabular)),
          ),
        const SizedBox(height: AeroSpace.sm),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < periods.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: AeroColors.line),
                _Period(p: periods[i], isBase: i == 0, units: u, clock: clock),
              ],
              if (explainSm && u.distance == DistanceUnit.mi)
                Text(_smNote, style: AeroText.caption),
              const SizedBox(height: AeroSpace.md),
              _Raw(label: 'TAF', raw: raw),
            ],
          ),
        ),
      ],
    );
  }
}

/// One TAF line: when on the left, what on the right. Units follow the
/// rows above (tap Wind, Visibility or Clouds there to switch).
class _Period extends StatelessWidget {
  final Map p;
  final bool isBase;
  final UnitsNotifier units;
  final String Function(Map?) clock;

  const _Period(
      {required this.p,
      required this.isBase,
      required this.units,
      required this.clock});

  @override
  Widget build(BuildContext context) {
    final change = p['changeType']?.toString();
    final prob = _num(p['probability']);
    final start = _map(p['start']);
    final end = _map(p['end']);
    final kind = isBase
        ? null
        : [
            if (prob != null) 'PROB${formatCount(prob)}',
            if (change != null && change != 'FM') change,
          ].join(' ');
    final when = isBase
        ? 'Now'
        : start == null
            ? '—'
            : (change == 'FM' || end == null)
                ? clock(start)
                : '${clock(start)}–${clock(end)}';

    final what = [
      _wind(_map(p['wind']), units.speed),
      _visibility(_map(p['visibility']), units.distance),
      _weatherList(_list(p['weather'])),
      _sky(_map(p['sky']), units.altitude),
      if (p['isCavok'] == true) 'CAVOK',
      if (p['isNoSignificantWeather'] == true) 'No significant weather',
    ].whereType<String>().where((s) => s != '—').join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(when,
                    style: _strong.copyWith(fontFeatures: AeroText.tabular)),
                if (kind != null && kind.isNotEmpty)
                  Text(kind, style: AeroText.caption),
              ],
            ),
          ),
          Expanded(
              child: Text(what.isEmpty ? '—' : what,
                  style: AeroText.body.copyWith(color: AeroColors.ink))),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small pieces
// ---------------------------------------------------------------------------

final _strong =
    AeroText.body.copyWith(color: AeroColors.ink, fontWeight: FontWeight.w600);

Widget _value(String s) =>
    Text(s, style: AeroText.body.copyWith(color: AeroColors.ink));

class _Panel extends StatelessWidget {
  final Widget child;

  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AeroSpace.md),
        decoration: const BoxDecoration(
            color: AeroColors.surfaceAlt, borderRadius: AeroRadius.mdAll),
        child: child,
      );
}

class _Fact extends StatelessWidget {
  final String label;
  final Widget value;

  const _Fact(this.label, this.value);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AeroText.caption.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          value,
        ],
      );
}

/// Label | value row inside a panel. With a [dimension] the value is a
/// [UnitCycle]: tap it to switch that unit everywhere.
class _Row extends StatelessWidget {
  final String label;
  final UnitDimension? dimension;
  final String Function(UnitsNotifier) value;
  final String? Function(UnitsNotifier)? note;

  const _Row(this.label, this.dimension, this.value, {this.note});

  @override
  Widget build(BuildContext context) {
    Widget body(UnitsNotifier u) {
      final n = note?.call(u);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _value(value(u)),
          if (n != null) Text(n, style: AeroText.caption),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 92, child: Text(label, style: AeroText.body)),
          Expanded(
            child: dimension == null
                ? body(context.watch<UnitsNotifier>())
                : UnitCycle(dimension: dimension!, builder: (_, u) => body(u)),
          ),
        ],
      ),
    );
  }
}

/// "Show raw METAR" pill; the raw string in mono when open.
class _Raw extends StatefulWidget {
  final String label;
  final String raw;

  const _Raw({required this.label, required this.raw});

  @override
  State<_Raw> createState() => _RawState();
}

class _RawState extends State<_Raw> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AeroPillButton(
          icon: Icons.code,
          label: '${_open ? 'Hide' : 'Show'} raw ${widget.label}',
          trailing: _open ? Icons.expand_less : Icons.expand_more,
          onTap: () => setState(() => _open = !_open),
        ),
        if (_open) ...[
          const SizedBox(height: AeroSpace.sm),
          SelectableText(widget.raw,
              style: AeroText.mono.copyWith(letterSpacing: 0)),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Formatting (decoded payloads are free-form JSON)
// ---------------------------------------------------------------------------

bool _has(String? s) => s != null && s.isNotEmpty;
Map? _map(Object? v) => v is Map ? v : null;
List _list(Object? v) => v is List ? v : const [];
num? _num(Object? v) => v is num ? v : null;

String _n(num n) => n == n.roundToDouble() ? formatCount(n) : formatDecimal(n);

String _coord(String v) {
  final d = double.tryParse(v);
  return d == null ? v : formatDecimal(d, digits: 4);
}

const _smNote = 'SM is the statute mile, the ordinary land mile '
    '(1.609 km) used in US weather reports.';

/// A day/hour/minute stamp (METAR/TAF give no month or year) as UTC: the
/// month that puts it nearest [now].
DateTime _stamp(Map t, DateTime now) {
  final day = _num(t['day'])?.toInt() ?? now.day;
  final h = _num(t['hour'])?.toInt() ?? 0;
  final m = _num(t['minute'])?.toInt() ?? 0;
  final options = [-1, 0, 1]
      .map((dm) => DateTime.utc(now.year, now.month + dm, day, h, m))
      .toList()
    ..sort(
        (a, b) => a.difference(now).abs().compareTo(b.difference(now).abs()));
  return options.first;
}

int _humidity(num t, num td) {
  final a = exp((17.625 * td) / (243.04 + td));
  final b = exp((17.625 * t) / (243.04 + t));
  return (100 * (a / b)).round().clamp(0, 100);
}

String _wind(Map? w, SpeedUnit u) {
  if (w == null) return '—';
  if (w['isCalm'] == true) return 'Calm';
  final speed = _num(w['speedKt']);
  final gust = _num(w['gustKt']);
  final dir = _num(w['directionDeg']);
  final from = w['isVariable'] == true
      ? 'Variable'
      : dir == null
          ? null
          : '${_n(dir)}° ${_cardinal(dir)}';
  return [
    if (from != null) from,
    if (speed != null) formatSpeed(speed, u),
    if (gust != null) 'gusts ${formatSpeed(gust, u)}',
  ].join(' · ');
}

String _cardinal(num deg) {
  const dirs = [
    'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', //
    'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW',
  ];
  return dirs[((deg % 360) / 22.5).round() % 16];
}

/// km shows metres under 5 km (how visibility is reported outside the US);
/// mi is the statute mile, labelled SM as in the reports.
String _visibility(Map? v, DistanceUnit u) {
  if (v == null) return '—';
  final sm = _num(v['visibilitySm']);
  final m = _num(v['visibilityM']) ?? (sm == null ? null : sm * 1609.344);
  if (m == null) return '—';
  final prefix =
      v['isLessThan'] == true ? '<' : (v['isMoreThan'] == true ? '≥' : '');
  String figure(num x) => x >= 10
      ? formatCount(x)
      : formatDecimal(x, digits: x < 1 ? 2 : 1)
          .replaceFirst(RegExp(r'[.,]0+$'), '');
  final value = switch (u) {
    DistanceUnit.km =>
      m < 5000 ? '${formatCount(m)} m' : '${figure(m / 1000)} km',
    DistanceUnit.mi => '${figure(sm ?? m / 1609.344)} SM',
    DistanceUnit.nm => '${figure(m / 1852)} nm',
  };
  return '$prefix$value';
}

String? _weatherList(List list) {
  final parts = list
      .map((w) => _weather(_map(w)))
      .whereType<String>()
      .where((s) => s.isNotEmpty)
      .toList();
  return parts.isEmpty ? null : parts.join(', ');
}

String? _weather(Map? w) {
  if (w == null) return null;
  final bits = [
    if (w['intensity'] == 'LIGHT') 'Light',
    if (w['intensity'] == 'HEAVY') 'Heavy',
    if (w['isVicinity'] == true) 'Nearby',
    if (w['descriptor'] != null) _wx(w['descriptor'].toString()),
    ..._list(w['phenomena']).map((p) => _wx(p.toString())),
  ];
  final out = bits.join(' ');
  final sentence = out.isEmpty ? null : _sentence(out.toLowerCase());
  return sentence ?? w['raw']?.toString();
}

/// Cloud bases are above ground, so FL (a pressure altitude) shows feet.
String? _sky(Map? sky, AltitudeUnit u) {
  if (sky == null) return null;
  final layers = _list(sky['layers']).map(_map).whereType<Map>();
  if (layers.isEmpty) {
    final vv = _num(sky['verticalVisibilityFt']);
    return vv == null ? null : 'Vertical visibility ${formatElevation(vv, u)}';
  }
  return layers.map((l) {
    final cover = _coverage(l['coverage']?.toString());
    final alt = _num(l['altitudeFtAgl']);
    final type = switch (l['type']?.toString().toUpperCase()) {
      'CB' => ' cumulonimbus',
      'TCU' => ' towering cumulus',
      null || '' => '',
      final t => ' $t',
    };
    return alt == null
        ? '$cover$type'
        : '$cover ${formatElevation(alt, u)}$type';
  }).join(', ');
}

String _coverage(String? c) => switch (c) {
      'FEW' => 'Few',
      'SCT' => 'Scattered',
      'BKN' => 'Broken',
      'OVC' => 'Overcast',
      'NSC' => 'No significant cloud',
      'NCD' => 'No cloud detected',
      'SKC' || 'CLR' => 'Clear',
      'VV' => 'Vertical visibility',
      _ => c ?? '—',
    };

String _wx(String code) =>
    const {
      'MI': 'Shallow',
      'PR': 'Partial',
      'BC': 'Patches',
      'DR': 'Drifting',
      'BL': 'Blowing',
      'SH': 'Showers',
      'TS': 'Thunderstorm',
      'FZ': 'Freezing',
      'DZ': 'Drizzle',
      'RA': 'Rain',
      'SN': 'Snow',
      'SG': 'Snow grains',
      'IC': 'Ice crystals',
      'PL': 'Ice pellets',
      'GR': 'Hail',
      'GS': 'Small hail',
      'UP': 'Unknown precipitation',
      'BR': 'Mist',
      'FG': 'Fog',
      'FU': 'Smoke',
      'VA': 'Volcanic ash',
      'DU': 'Dust',
      'SA': 'Sand',
      'HZ': 'Haze',
      'PY': 'Spray',
      'PO': 'Dust whirls',
      'SQ': 'Squalls',
      'FC': 'Funnel cloud',
      'SS': 'Sandstorm',
      'DS': 'Duststorm',
    }[code.toUpperCase()] ??
    code;

const _continents = {
  'AF': 'Africa',
  'AN': 'Antarctica',
  'AS': 'Asia',
  'EU': 'Europe',
  'NA': 'North America',
  'OC': 'Oceania',
  'SA': 'South America',
};

String _typeName(AirportType t) {
  final words = t.name
      .replaceAllMapped(RegExp('[A-Z]'), (m) => ' ${m[0]}')
      .split(RegExp(r'[_\s]+'))
      .where((w) => w.isNotEmpty)
      .join(' ')
      .toLowerCase();
  return _sentence(words);
}

String _sentence(String s) => s.isEmpty
    ? s
    : '${s[0].toUpperCase()}${s.substring(1).replaceAll('_', ' ')}';

/// Status colour only: green fine, orange moderate, red severe.
Color _delayColor(String? c) => switch (c) {
      'red' => AeroColors.danger,
      'yellow' => AeroColors.warn,
      'green' => AeroColors.success,
      _ => AeroColors.muted,
    };

Color _categoryColor(String c) => switch (c.toUpperCase()) {
      'VFR' => AeroColors.success,
      'MVFR' => AeroColors.warn,
      'IFR' || 'LIFR' => AeroColors.danger,
      _ => AeroColors.ink,
    };
