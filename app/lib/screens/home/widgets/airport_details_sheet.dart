import 'dart:math';

import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/constants/main.dart';

/// Bottom sheet for a tapped airport marker. Renders the basic info we already
/// have (name/ident/IATA/location) immediately, then fetches live detail
/// (delays + fully decoded METAR/TAF) from the backend in the background.
class AirportDetailsSheet extends StatefulWidget {
  final AirportEntity airport;

  const AirportDetailsSheet({super.key, required this.airport});

  @override
  State<AirportDetailsSheet> createState() => _AirportDetailsSheetState();
}

class _AirportDetailsSheetState extends State<AirportDetailsSheet> {
  final _airportsApi = openapi.getAirportsApi();

  bool _loading = true;
  bool _failed = false;
  AirportDetailsEntity? _details;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final res = await _airportsApi.airportsControllerGetAirportDetailsV1(
        ident: widget.airport.ident,
      );
      if (!mounted) return;
      setState(() {
        _details = res.data;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _failed = true;
        _loading = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // JsonObject helpers (decoded payloads are free-form JSON)
  // ---------------------------------------------------------------------------

  Map<dynamic, dynamic>? _asMap(Object? v) => v is Map ? v : null;
  List<dynamic> _asList(Object? v) => v is List ? v : const [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(maxHeight: size.height * 0.88),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(14),
              _buildHeader(context),
              const Gap(10),
              _buildAirportFacts(context),
              const Gap(12),
              if (_loading)
                _buildLoading(context)
              else if (_failed)
                _buildUnavailable('Live information is unavailable right now.')
              else
                _buildDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header + static airport facts (available immediately)
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final airport = widget.airport;
    final iata = airport.iataCode;
    final subtitle = [
      airport.ident,
      if (iata != null && iata.isNotEmpty) iata,
      if (airport.municipality != null && airport.municipality!.isNotEmpty)
        airport.municipality!,
    ].join('  •  ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Symbols.local_airport, color: Colors.white),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                airport.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        _typeBadge(context, airport.type),
      ],
    );
  }

  Widget _typeBadge(BuildContext context, AirportType type) {
    final label = _formatEnum(type.name);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildAirportFacts(BuildContext context) {
    final a = widget.airport;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (a.elevation != null && a.elevation!.isNotEmpty)
          UnitCycle(
            dimension: UnitDimension.altitude,
            builder: (context, u) => _statChip(
              context,
              'ELEV',
              num.tryParse(a.elevation!) == null
                  ? '${a.elevation} ft'
                  : formatElevation(num.parse(a.elevation!), u.altitude),
            ),
          ),
        _statChip(context, 'COUNTRY', a.isoCountry),
        _statChip(context, 'REGION', a.isoRegion),
        _statChip(context, 'CONTINENT', a.continent),
        if (a.gpsCode != null && a.gpsCode!.isNotEmpty)
          _statChip(context, 'GPS', a.gpsCode!),
        _statChip(
          context,
          'COORDS',
          '${_fmtCoord(a.lat)}, ${_fmtCoord(a.long)}',
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Live detail
  // ---------------------------------------------------------------------------

  Widget _buildDetails(BuildContext context) {
    final details = _details;
    if (details == null) {
      return _buildUnavailable('Live information is unavailable right now.');
    }

    final delays = _asMap(details.delays?.value);
    final metar = details.metar;
    final taf = details.taf;
    final metarDecoded = _asMap(metar?.decoded?.value);
    final tafDecoded = _asMap(taf?.decoded?.value);

    final hasAnything =
        delays != null || (metar?.raw != null) || (taf?.raw != null);

    if (!hasAnything) {
      return _buildUnavailable(
        'No live weather or delay information is published for this airport.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (delays != null) ...[
          _sectionTitle('Delays'),
          const Gap(4),
          _buildDelayCard(context, delays),
          const Gap(12),
        ],
        if (metar != null && metar.raw != null) ...[
          _sectionTitle('METAR'),
          const Gap(4),
          _buildMetarCard(context, metar.raw!, metarDecoded),
          const Gap(12),
        ],
        if (taf != null && taf.raw != null) ...[
          _sectionTitle('TAF'),
          const Gap(4),
          _buildTafCard(context, taf.raw!, tafDecoded),
        ],
      ],
    );
  }

  // ----- Delays -----

  Widget _buildDelayCard(BuildContext context, Map<dynamic, dynamic> delays) {
    final theme = Theme.of(context);
    final color = _delayColor(delays['color']?.toString());
    final category = delays['category']?.toString() ?? 'unknown';
    final delaySecs =
        (delays['delay_secs'] is num) ? (delays['delay_secs'] as num) : 0;
    final reasons = _asList(delays['reasons'])
        .map((r) => _asMap(r)?['reason']?.toString() ?? r.toString())
        .where((s) => s.isNotEmpty)
        .toList();

    return _card(
      context,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconTile(Symbols.timer, color),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      category == 'none'
                          ? 'No delays reported'
                          : _formatEnum(category),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    _pill(
                      delaySecs > 0
                          ? _fmtSeconds(delaySecs.toInt())
                          : 'On time',
                      color,
                    ),
                  ],
                ),
                if (reasons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      reasons.join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color
                            ?.withValues(alpha: 0.75),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----- METAR -----

  Widget _buildMetarCard(
    BuildContext context,
    String raw,
    Map<dynamic, dynamic>? d,
  ) {
    final theme = Theme.of(context);
    final flightCategory = d?['flightCategory']?.toString();
    final obs = _asMap(d?['observation_time'] ?? d?['observationTime']);
    final temp = _numOrNull(d?['temperatureC']);
    final dew = _numOrNull(d?['dewpointC']);
    final altimeter = _asMap(d?['altimeter']);
    final hPa = _numOrNull(altimeter?['hPa']);
    final inHg = _numOrNull(altimeter?['inHg']);

    final flags = <String>[
      if (d?['isCavok'] == true) 'CAVOK',
      if (d?['isNoSignificantChange'] == true) 'NOSIG',
      if (d?['isAutomated'] == true) 'AUTO',
      if (d?['isCorrected'] == true) 'COR',
    ];

    final weather = _formatWeatherList(_asList(d?['weather']));
    final clouds = _formatSky(_asMap(d?['sky']));

    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconTile(Symbols.partly_cloudy_day, theme.colorScheme.primary),
              const Gap(10),
              Expanded(
                child: Text(
                  obs != null
                      ? 'Observed ${_fmtDhm(obs)}Z'
                      : 'Current observation',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              if (flightCategory != null)
                _pill(flightCategory, _flightCatColor(flightCategory)),
            ],
          ),
          const Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _statChip(context, 'WIND', _formatWind(_asMap(d?['wind']))),
              _statChip(
                context,
                'VISIBILITY',
                _formatVisibility(_asMap(d?['visibility'])),
              ),
              if (temp != null)
                UnitCycle(
                  dimension: UnitDimension.temperature,
                  builder: (context, u) => _statChip(
                      context, 'TEMP', formatTemp(temp, u.temperature)),
                ),
              if (dew != null)
                UnitCycle(
                  dimension: UnitDimension.temperature,
                  builder: (context, u) => _statChip(
                      context, 'DEWPOINT', formatTemp(dew, u.temperature)),
                ),
              if (temp != null && dew != null)
                _statChip(context, 'HUMIDITY', '${_relHumidity(temp, dew)}%'),
              if (hPa != null || inHg != null)
                _statChip(
                  context,
                  'QNH',
                  [
                    if (hPa != null) '${_fmtNum(hPa)} hPa',
                    if (inHg != null) '${formatDecimal(inHg, digits: 2)} inHg',
                  ].join('  '),
                ),
            ],
          ),
          if (weather != null) ...[
            const Gap(10),
            _labelledLine(context, Symbols.rainy, 'Weather', weather),
          ],
          if (clouds != null) ...[
            const Gap(10),
            _labelledLine(context, Symbols.cloud, 'Clouds', clouds),
          ],
          if (flags.isNotEmpty) ...[
            const Gap(10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: flags.map((f) => _flag(context, f)).toList(),
            ),
          ],
          const Gap(12),
          _rawBox(context, raw),
        ],
      ),
    );
  }

  // ----- TAF -----

  Widget _buildTafCard(
    BuildContext context,
    String raw,
    Map<dynamic, dynamic>? d,
  ) {
    final theme = Theme.of(context);
    final issued = _asMap(d?['issuedAt']);
    final from = _asMap(d?['validFrom']);
    final to = _asMap(d?['validTo']);
    final periods = _asList(d?['forecast']);

    final headerBits = <String>[
      if (issued != null) 'Issued ${_fmtDhm(issued)}Z',
      if (from != null && to != null)
        'Valid ${_fmtDhm(from)} → ${_fmtDhm(to)}Z',
    ];

    final amendFlags = <String>[
      if (d?['isAmended'] == true) 'AMENDED',
      if (d?['isCorrected'] == true) 'CORRECTED',
      if (d?['isCancelled'] == true) 'CANCELLED',
    ];

    return _card(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconTile(Symbols.schedule, theme.colorScheme.primary),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Forecast',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    if (headerBits.isNotEmpty)
                      Text(
                        headerBits.join('  •  '),
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.textTheme.bodySmall?.color
                              ?.withValues(alpha: 0.75),
                        ),
                      ),
                  ],
                ),
              ),
              for (final f in amendFlags) ...[
                const Gap(4),
                _pill(f, Colors.orange),
              ],
            ],
          ),
          const Gap(10),
          ...periods.asMap().entries.map((e) {
            final isFirst = e.key == 0;
            return Padding(
              padding: EdgeInsets.only(top: isFirst ? 0 : 8),
              child: _buildTafPeriod(context, _asMap(e.value), isFirst),
            );
          }),
          const Gap(12),
          _rawBox(context, raw),
        ],
      ),
    );
  }

  Widget _buildTafPeriod(
    BuildContext context,
    Map<dynamic, dynamic>? p,
    bool isBase,
  ) {
    if (p == null) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final changeType = p['changeType']?.toString();
    final prob = _numOrNull(p['probability']);
    final start = _asMap(p['start']);
    final end = _asMap(p['end']);

    final label = isBase
        ? 'BASE'
        : [
            if (prob != null) 'PROB${_fmtNum(prob)}',
            changeType ?? 'FM',
          ].join(' ');
    final labelColor = _changeColor(isBase ? 'BASE' : (changeType ?? 'FM'));

    final timeRange = (start != null && end != null)
        ? '${_fmtDhm(start)} → ${_fmtDhm(end)}Z'
        : (start != null ? 'From ${_fmtDhm(start)}Z' : null);

    final weather = _formatWeatherList(_asList(p['weather']));
    final clouds = _formatSky(_asMap(p['sky']));
    final extraFlags = <String>[
      if (p['isCavok'] == true) 'CAVOK',
      if (p['isNoSignificantWeather'] == true) 'NSW',
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pill(label, labelColor),
              const Gap(8),
              if (timeRange != null)
                Expanded(
                  child: Text(
                    timeRange,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.8),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _statChip(context, 'WIND', _formatWind(_asMap(p['wind']))),
              _statChip(
                context,
                'VISIBILITY',
                _formatVisibility(_asMap(p['visibility'])),
              ),
            ],
          ),
          if (weather != null) ...[
            const Gap(8),
            _labelledLine(context, Symbols.rainy, 'Weather', weather),
          ],
          if (clouds != null) ...[
            const Gap(8),
            _labelledLine(context, Symbols.cloud, 'Clouds', clouds),
          ],
          if (extraFlags.isNotEmpty) ...[
            const Gap(8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: extraFlags.map((f) => _flag(context, f)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared small widgets
  // ---------------------------------------------------------------------------

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );

  Widget _card(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
        ),
      ),
      child: child,
    );
  }

  Widget _iconTile(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget _statChip(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.55),
            ),
          ),
          const Gap(1),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _flag(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _labelledLine(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const Gap(8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.5,
                color: theme.textTheme.bodyMedium?.color,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rawBox(BuildContext context, String raw) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: SelectableText(
        raw,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }

  Widget _buildUnavailable(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Symbols.cloud_off, size: 18, color: Colors.grey.shade500),
          const Gap(8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(2, (i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  // ---------------------------------------------------------------------------
  // Formatting helpers
  // ---------------------------------------------------------------------------

  num? _numOrNull(Object? v) => v is num ? v : null;

  String _fmtNum(num n) =>
      n == n.roundToDouble() ? n.toInt().toString() : n.toString();

  String _fmtCoord(String value) {
    final d = double.tryParse(value);
    return d == null ? value : formatDecimal(d, digits: 4);
  }

  String _fmtDhm(Map<dynamic, dynamic> t) {
    final h = _numOrNull(t['hour'])?.toInt() ?? 0;
    final m = _numOrNull(t['minute'])?.toInt() ?? 0;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  String _fmtSeconds(int seconds) {
    final mins = (seconds / 60).round();
    if (mins < 60) return '${mins}m';
    final h = mins ~/ 60;
    final r = mins % 60;
    return r == 0 ? '${h}h' : '${h}h ${r}m';
  }

  int _relHumidity(num t, num td) {
    final num1 = exp((17.625 * td) / (243.04 + td));
    final num2 = exp((17.625 * t) / (243.04 + t));
    return (100 * (num1 / num2)).round().clamp(0, 100);
  }

  String _formatWind(Map<dynamic, dynamic>? wind) {
    if (wind == null) return '—';
    if (wind['isCalm'] == true) return 'Calm';
    final speed = _numOrNull(wind['speedKt']);
    final gust = _numOrNull(wind['gustKt']);
    final dir = _numOrNull(wind['directionDeg']);
    final variable = wind['isVariable'] == true;

    final dirStr = variable
        ? 'VRB'
        : (dir != null ? '${_fmtNum(dir)}° ${_cardinal(dir)}' : '—');
    final spdStr = speed != null ? '${_fmtNum(speed)}kt' : '';
    final gustStr = gust != null ? ' G${_fmtNum(gust)}kt' : '';
    return '$dirStr $spdStr$gustStr'.trim();
  }

  String _cardinal(num deg) {
    const dirs = [
      'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', //
      'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW',
    ];
    return dirs[((deg % 360) / 22.5).round() % 16];
  }

  String _formatVisibility(Map<dynamic, dynamic>? vis) {
    if (vis == null) return '—';
    final m = _numOrNull(vis['visibilityM']);
    final sm = _numOrNull(vis['visibilitySm']);
    final prefix = vis['isLessThan'] == true
        ? '<'
        : (vis['isMoreThan'] == true ? '≥' : '');
    if (m != null) {
      final smCalc = (m / 1609.344);
      final smStr = smCalc >= 1
          ? formatDecimal(smCalc)
          : formatDecimal(smCalc, digits: 2);
      return '$prefix${_fmtNum(m)} m  ($smStr SM)';
    }
    if (sm != null) return '$prefix${_fmtNum(sm)} SM';
    return '—';
  }

  String? _formatWeatherList(List<dynamic> list) {
    if (list.isEmpty) return null;
    final parts = list
        .map((w) => _formatWeather(_asMap(w)))
        .where((s) => s != null && s.isNotEmpty)
        .cast<String>()
        .toList();
    return parts.isEmpty ? null : parts.join(', ');
  }

  String? _formatWeather(Map<dynamic, dynamic>? w) {
    if (w == null) return null;
    final intensity = w['intensity']?.toString();
    final isVicinity = w['isVicinity'] == true;
    final descriptor = w['descriptor']?.toString();
    final phenomena = _asList(w['phenomena']).map((p) => p.toString()).toList();

    final bits = <String>[];
    if (intensity == 'LIGHT') bits.add('Light');
    if (intensity == 'HEAVY') bits.add('Heavy');
    if (isVicinity) bits.add('Nearby');
    if (descriptor != null) bits.add(_wxCode(descriptor));
    bits.addAll(phenomena.map(_wxCode));
    final out = bits.where((s) => s.isNotEmpty).join(' ');
    return out.isEmpty ? (w['raw']?.toString()) : out;
  }

  String? _formatSky(Map<dynamic, dynamic>? sky) {
    if (sky == null) return null;
    final layers = _asList(sky['layers']);
    if (layers.isEmpty) {
      if (sky['verticalVisibilityFt'] != null) {
        return 'Vertical visibility ${_fmtNum(_numOrNull(sky['verticalVisibilityFt'])!)} ft';
      }
      return null;
    }
    return layers
        .map((l) => _formatLayer(_asMap(l)))
        .where((s) => s != null)
        .cast<String>()
        .join(',  ');
  }

  String? _formatLayer(Map<dynamic, dynamic>? l) {
    if (l == null) return null;
    final coverage = _coverageName(l['coverage']?.toString());
    final alt = _numOrNull(l['altitudeFtAgl']);
    final type = l['type']?.toString();
    final typeStr =
        (type != null && type.isNotEmpty) ? ' ${_cloudType(type)}' : '';
    if (alt == null) return '$coverage$typeStr';
    return '$coverage @ ${_fmtNum(alt)}ft$typeStr';
  }

  // ----- code dictionaries -----

  String _coverageName(String? c) {
    switch (c) {
      case 'FEW':
        return 'Few';
      case 'SCT':
        return 'Scattered';
      case 'BKN':
        return 'Broken';
      case 'OVC':
        return 'Overcast';
      case 'NSC':
        return 'No significant cloud';
      case 'NCD':
        return 'No cloud detected';
      case 'SKC':
      case 'CLR':
        return 'Clear';
      case 'VV':
        return 'Vertical vis';
      default:
        return c ?? '—';
    }
  }

  String _cloudType(String t) {
    switch (t.toUpperCase()) {
      case 'CB':
        return '(Cumulonimbus)';
      case 'TCU':
        return '(Towering cumulus)';
      default:
        return '($t)';
    }
  }

  String _wxCode(String code) {
    const map = {
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
      'UP': 'Unknown precip',
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
    };
    return map[code.toUpperCase()] ?? code;
  }

  Color _delayColor(String? c) {
    switch (c) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.orange;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _flightCatColor(String category) {
    switch (category.toUpperCase()) {
      case 'VFR':
        return Colors.green;
      case 'MVFR':
        return Colors.blue;
      case 'IFR':
        return Colors.red;
      case 'LIFR':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _changeColor(String type) {
    switch (type.toUpperCase()) {
      case 'BASE':
        return Colors.blueGrey;
      case 'BECMG':
        return Colors.indigo;
      case 'TEMPO':
        return Colors.orange;
      case 'FM':
        return Colors.teal;
      default:
        return Colors.blueGrey;
    }
  }

  String _formatEnum(String name) {
    return name
        .split(RegExp(r'[_\s]'))
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
