import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/aircraft_registry.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

/// Opens a flight by identifier and (local) departure date; [faFlightId]
/// pins the exact FlightAware flight when known.
typedef OpenFlight = void Function(String ident, DateTime date,
    {String? faFlightId});

/// Everything about the airframe operating a flight: photo, age, registry
/// country, raw data, registration history, and (when supplied) its
/// inbound leg, the user's other flights on it, and its recent legs.
class AircraftSection extends StatefulWidget {
  final FlightResponseEntity info;
  final AircraftHistoryEntity? history;
  final bool historyLoading;
  final List<AircraftLegEntity>? recent;
  final bool recentLoading;
  final VoidCallback? onLoadRecent;

  final OpenFlight? onOpenFlight;

  const AircraftSection({
    super.key,
    required this.info,
    this.history,
    this.historyLoading = false,
    this.recent,
    this.recentLoading = false,
    this.onLoadRecent,
    this.onOpenFlight,
  });

  @override
  State<AircraftSection> createState() => _AircraftSectionState();
}

class _AircraftSectionState extends State<AircraftSection> {
  bool _showPayload = false;

  AircraftEntity? get _aircraft => widget.info.aircraft;

  /// Age in years at [at], from first flight (or delivery) date. Null
  /// when neither is known or [at] is before it.
  double? _ageAt(DateTime at) {
    final from = DateTime.tryParse(
        _aircraft?.firstFlightDate ?? _aircraft?.deliveryDate ?? '');
    if (from == null) return null;
    final days = at.difference(from).inDays;
    return days < 0 ? null : days / 365.25;
  }

  @override
  Widget build(BuildContext context) {
    // History comes from FlightAware and can exist without aircraft details.
    final aircraft = _aircraft;
    final registrations = aircraft?.registrations?.toList() ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (aircraft?.model != null) ...[
          Text(aircraft!.model!, style: AeroText.heading),
          const SizedBox(height: AeroSpace.sm),
        ],
        if (widget.history?.registration != null) ...[
          _Rotation(
            info: widget.info,
            history: widget.history!,
            recent: widget.recent,
            recentLoading: widget.recentLoading,
            onLoadRecent: widget.onLoadRecent,
            onOpenFlight: widget.onOpenFlight,
          ),
          const SizedBox(height: AeroSpace.md),
        ],
        if (aircraft?.registration != null) _buildAircraftCard(aircraft!),
        if (widget.history?.ownFlights.isNotEmpty == true) ...[
          const SizedBox(height: AeroSpace.md),
          _OwnFlightsRow(
            registration: widget.history!.registration ?? '',
            flights: widget.history!.ownFlights.toList(),
            onOpenFlight: widget.onOpenFlight,
          ),
        ],
        if (registrations.isNotEmpty) ...[
          const SizedBox(height: AeroSpace.lg),
          _RegistrationHistory(registrations: registrations),
        ],
      ],
    );
  }

  Widget _buildAircraftCard(AircraftEntity aircraft) {
    final country =
        registryCountry(hex: aircraft.modeS, reg: aircraft.registration);
    // One base for both ages so they agree; stored age is a stale
    // snapshot, used only when no dates are known.
    final age = _ageAt(DateTime.now()) ?? double.tryParse(aircraft.age ?? '');
    final onDay = _ageAt(widget.info.date);
    final showOnDay =
        onDay != null && age != null && (age - onDay).abs() >= 1 / 12;

    return Container(
      padding: const EdgeInsets.all(AeroSpace.md),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (aircraft.image != null) ...[
            ClipRRect(
              borderRadius: AeroRadius.smAll,
              child: CachedNetworkImage(imageUrl: aircraft.image!),
            ),
            const SizedBox(height: AeroSpace.md),
          ],
          Wrap(
            spacing: AeroSpace.md,
            runSpacing: AeroSpace.md,
            alignment: WrapAlignment.spaceBetween,
            children: [
              if (age != null)
                _Fact(
                  label: 'Age',
                  value: formatAge(age),
                  note: showOnDay ? '${formatAge(onDay)} on this flight' : null,
                ),
              if (aircraft.deliveryDate != null)
                _Fact(
                  label: 'Delivery Date',
                  value: formatDate(DateTime.parse(aircraft.deliveryDate!)),
                  alignEnd: true,
                ),
              _Fact(
                label: 'Registration',
                value: aircraft.registration!,
                note: country == null
                    ? null
                    : '${flagEmoji(country.iso2)} ${country.name}',
              ),
              if (aircraft.modeS != null && aircraft.modeS!.isNotEmpty)
                _Fact(
                  label: 'Mode S',
                  value: aircraft.modeS!.toUpperCase(),
                  alignEnd: true,
                  tabular: true,
                ),
            ],
          ),
          _buildPayload(aircraft),
        ],
      ),
    );
  }

  Widget _buildPayload(AircraftEntity aircraft) {
    final payload = aircraft.payload?.asMap;
    final entries = payload == null
        ? const <MapEntry<String, dynamic>>[]
        : payload.entries
            .where(
                (e) => e.value is String || e.value is num || e.value is bool)
            .where((e) => e.key != 'id' && e.key != 'numRegistrations')
            .map((e) => MapEntry<String, dynamic>('${e.key}', e.value))
            .toList();
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AeroSpace.md),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _showPayload = !_showPayload),
          child: AeroPressable(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _showPayload ? 'Hide more info' : 'Show more info',
                  style: AeroText.body.copyWith(
                      color: AeroColors.ink, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: AeroSpace.xs),
                Icon(_showPayload ? Icons.expand_less : Icons.expand_more,
                    size: 18, color: AeroColors.ink),
              ],
            ),
          ),
        ),
        if (_showPayload) ...[
          const SizedBox(height: AeroSpace.sm),
          for (final e in entries) _PayloadRow(entry: e),
        ],
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  final String label;
  final String value;
  final String? note;
  final bool alignEnd;
  final bool tabular;

  const _Fact({
    required this.label,
    required this.value,
    this.note,
    this.alignEnd = false,
    this.tabular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AeroText.caption.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(
          value,
          style: AeroText.body.copyWith(
            color: AeroColors.ink,
            fontFeatures: tabular ? AeroText.tabular : null,
          ),
        ),
        if (note != null) ...[
          const SizedBox(height: 2),
          Text(note!, style: AeroText.caption),
        ],
      ],
    );
  }
}

class _PayloadRow extends StatelessWidget {
  final MapEntry<String, dynamic> entry;
  const _PayloadRow({required this.entry});

  static String _formatKey(String key) => key
      .replaceAll('_', ' ')
      .replaceAllMapped(RegExp(r'(?<!^)([A-Z0-9])'), (m) => ' ${m.group(1)}')
      .split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  static bool? _asBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v == 1 ? true : (v == 0 ? false : null);
    if (v is String) {
      final s = v.trim().toLowerCase();
      if (['true', 'yes', 'y', '1'].contains(s)) return true;
      if (['false', 'no', 'n', '0'].contains(s)) return false;
    }
    return null;
  }

  static String _formatValue(dynamic v) {
    if (v is String) {
      final d = DateTime.tryParse(v);
      if (d != null) return formatDate(d);
    }
    return '$v';
  }

  @override
  Widget build(BuildContext context) {
    final b = _asBool(entry.value);
    final color = b == null
        ? AeroColors.ink
        : (b ? AeroColors.success : AeroColors.danger);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(_formatKey(entry.key),
                style: AeroText.caption.copyWith(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: AeroSpace.sm),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (b != null) ...[
                  Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: AeroSpace.xs),
                ],
                Flexible(
                  child: Text(
                    b == null ? _formatValue(entry.value) : (b ? 'Yes' : 'No'),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: AeroText.caption.copyWith(
                        color: color,
                        fontWeight:
                            b == null ? FontWeight.w400 : FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RegistrationHistory extends StatelessWidget {
  final List<AircraftRegistrationEntity> registrations;
  const _RegistrationHistory({required this.registrations});

  @override
  Widget build(BuildContext context) {
    final sorted = [...registrations]..sort((a, b) {
        final ad = DateTime.tryParse(a.registrationDate ?? '');
        final bd = DateTime.tryParse(b.registrationDate ?? '');
        if (ad == null && bd == null) return 0;
        if (ad == null) return 1;
        if (bd == null) return -1;
        return bd.compareTo(ad);
      });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Registration History', style: AeroText.heading),
        const SizedBox(height: AeroSpace.sm),
        Container(
          padding: const EdgeInsets.all(AeroSpace.md),
          decoration: const BoxDecoration(
            color: AeroColors.surfaceAlt,
            borderRadius: AeroRadius.mdAll,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < sorted.length; i++) ...[
                if (i > 0) const Divider(height: AeroSpace.lg),
                _RegistrationRow(reg: sorted[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RegistrationRow extends StatelessWidget {
  final AircraftRegistrationEntity reg;
  const _RegistrationRow({required this.reg});

  @override
  Widget build(BuildContext context) {
    final color = reg.active ? AeroColors.success : AeroColors.muted;
    final date = DateTime.tryParse(reg.registrationDate ?? '');
    final country = registryCountry(hex: reg.hexIcao, reg: reg.reg);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AeroSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(reg.reg,
                    style: AeroText.body.copyWith(
                        color: AeroColors.ink, fontWeight: FontWeight.w700)),
                if (country != null) ...[
                  const SizedBox(width: AeroSpace.xs),
                  Text(flagEmoji(country.iso2), style: AeroText.body),
                ],
                const SizedBox(width: AeroSpace.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AeroSpace.sm - 2, vertical: 2),
                  decoration: BoxDecoration(
                    color: reg.active
                        ? AeroColors.successTint
                        : AeroColors.surfaceAlt,
                    borderRadius: AeroRadius.smAll,
                  ),
                  child: Text(
                    reg.active ? 'Active' : 'Inactive',
                    style: AeroText.micro
                        .copyWith(color: color, fontWeight: FontWeight.w700),
                  ),
                ),
              ]),
              if (reg.airlineName != null && reg.airlineName!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(reg.airlineName!, style: AeroText.caption),
              ],
              if (date != null) ...[
                const SizedBox(height: 2),
                Text('Registered on ${formatDate(date)}',
                    style: AeroText.micro),
              ],
              if (reg.hexIcao != null && reg.hexIcao!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text('Mode S ${reg.hexIcao!.toUpperCase()}',
                    style: AeroText.micro
                        .copyWith(fontFeatures: AeroText.tabular)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Minimum turnaround before we warn that the inbound aircraft may delay
/// this flight. ponytail: one value for all types; widebodies need longer.
const _minTurnaround = Duration(minutes: 45);

/// "EK381 · UAE381" (distinct idents, IATA first).
String _idents(String? iata, String? icao, String fallback) =>
    {iata ?? fallback, icao ?? fallback}.where((s) => s.isNotEmpty).join(' · ');

/// "35 min late" / "3 min early" / "on time" from seconds of delay.
String _delayText(num? seconds) {
  final m = (seconds ?? 0) ~/ 60;
  if (m >= 1) return '$m min late';
  if (m <= -1) return '${-m} min early';
  return 'on time';
}

Color _delayColor(num? seconds) {
  final m = (seconds ?? 0) ~/ 60;
  if (m >= 15) return AeroColors.danger;
  if (m >= 5) return AeroColors.warn;
  return AeroColors.success;
}

DateTime? _legArrival(AircraftLegEntity l) =>
    DateTime.tryParse(l.actualIn ?? l.estimatedIn ?? l.scheduledIn ?? '');

class _Tappable extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const _Tappable({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) => onTap == null
      ? child
      : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: AeroPressable(child: child),
        );
}

/// Status chip: uppercase micro label on a tinted pill.
class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final Color tint;
  const _Chip(this.label, this.color, this.tint);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AeroSpace.sm, vertical: AeroSpace.xs),
        decoration: BoxDecoration(color: tint, borderRadius: AeroRadius.smAll),
        child: Text(label,
            style: AeroText.micro.copyWith(
                color: color, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
      );
}

enum _Mark { arrow, dot, none, dashed }

/// One row of the timeline: a 24px rail (line + optional marker) and content.
class _RailRow extends StatelessWidget {
  final _Mark mark;
  final bool lineAbove;
  final bool lineBelow;
  final Widget child;

  const _RailRow({
    required this.mark,
    required this.child,
    this.lineAbove = true,
    this.lineBelow = true,
  });

  Widget _line(bool on) => Expanded(
        child: Center(
          child: Container(width: 2, color: on ? AeroColors.ink : null),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final marker = switch (mark) {
      _Mark.arrow =>
        const Icon(Icons.arrow_upward, size: 18, color: AeroColors.ink),
      _Mark.dot => Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
              color: AeroColors.ink, shape: BoxShape.circle),
        ),
      _Mark.dashed => Column(children: [
          for (var i = 0; i < 3; i++)
            Container(
                width: 2,
                height: 4,
                margin: const EdgeInsets.only(bottom: 3),
                color: AeroColors.muted),
        ]),
      _Mark.none => const SizedBox.shrink(),
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(children: [
              _line(lineAbove),
              marker,
              _line(lineBelow),
            ]),
          ),
          const SizedBox(width: AeroSpace.md),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// The airframe's rotation, newest first: this flight, the airport it
/// departs from, the inbound leg, its origin, then earlier legs on demand.
class _Rotation extends StatelessWidget {
  final FlightResponseEntity info;
  final AircraftHistoryEntity history;
  final List<AircraftLegEntity>? recent;
  final bool recentLoading;
  final VoidCallback? onLoadRecent;
  final OpenFlight? onOpenFlight;

  const _Rotation({
    required this.info,
    required this.history,
    required this.recent,
    required this.recentLoading,
    this.onLoadRecent,
    this.onOpenFlight,
  });

  DateTime? get _ourDeparture =>
      DateTime.tryParse(info.departure.scheduledTime.utc);

  /// (chip, color, tint, sentence) for the top of the card, or null.
  (String, Color, Color, String)? _summary(BuildContext context) {
    final leg = history.inbound;
    if (leg == null) return null;
    if (leg.cancelled) {
      return (
        'INBOUND CANCELLED',
        AeroColors.danger,
        AeroColors.dangerTint,
        'The aircraft\'s previous flight was cancelled'
      );
    }
    final arrival = _legArrival(leg);
    final ours = _ourDeparture;
    if (arrival != null && ours != null) {
      final gap = ours.difference(arrival);
      if (gap < _minTurnaround) {
        return (
          'TIGHT TURNAROUND',
          AeroColors.danger,
          AeroColors.dangerTint,
          gap.isNegative
              ? 'Arrives ${-gap.inMinutes} min after your scheduled departure'
              : 'Only ${gap.inMinutes} min between its arrival and your departure'
        );
      }
    }
    final delay = _delayText(leg.arrivalDelay);
    if (leg.actualIn != null) {
      return (
        'ARRIVED',
        AeroColors.success,
        AeroColors.successTint,
        'The inbound aircraft arrived $delay'
      );
    }
    final units = context.watch<UnitsNotifier>();
    final at = arrival == null
        ? ''
        : ' at ${formatClock(arrival, airportTz: leg.destinationTimezone, mode: units.time, use24: MediaQuery.of(context).alwaysUse24HourFormat)}';
    return (
      'INBOUND EN ROUTE',
      AeroColors.ink,
      AeroColors.surface,
      'The inbound aircraft lands$at, $delay'
    );
  }

  /// Recent legs strictly before the inbound (or our flight when there is
  /// no inbound), newest first. Future legs and the inbound itself drop out.
  List<AircraftLegEntity> _earlier() {
    final cutoff =
        DateTime.tryParse(history.inbound?.scheduledOut ?? '') ?? _ourDeparture;
    if (cutoff == null) return const [];
    final legs = (recent ?? const <AircraftLegEntity>[]).where((l) {
      final out = DateTime.tryParse(l.scheduledOut ?? '');
      return out != null &&
          out.isBefore(cutoff) &&
          l.faFlightId != history.inbound?.faFlightId;
    }).toList()
      ..sort((a, b) => b.scheduledOut!.compareTo(a.scheduledOut!));
    return legs;
  }

  @override
  Widget build(BuildContext context) {
    final summary = _summary(context);
    final inbound = history.inbound;
    final legs = [if (inbound != null) inbound, ..._earlier()];
    final fa = info.flightAwareData;
    final departed = fa?.actualOut ?? fa?.actualOff;
    final ourStatus = departed != null
        ? 'Departed ${_delayText(fa?.departureDelay)}'
        : 'Not departed yet';
    final ourColor =
        departed != null ? _delayColor(fa?.departureDelay) : AeroColors.muted;
    final ourOrigin = info.departure.airport.iata.isNotEmpty
        ? info.departure.airport.iata
        : info.departure.airport.icao;

    return Container(
      padding: const EdgeInsets.all(AeroSpace.md),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (summary != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: _Chip(summary.$1, summary.$2, summary.$3),
            ),
            const SizedBox(height: AeroSpace.sm),
            Text(summary.$4,
                style: AeroText.body.copyWith(color: AeroColors.ink)),
            const SizedBox(height: AeroSpace.md),
          ],
          _RailRow(
            mark: _Mark.arrow,
            lineAbove: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AeroSpace.sm),
              child: Row(children: [
                Expanded(
                  child: Text('This flight',
                      style: AeroText.body.copyWith(
                          color: AeroColors.ink, fontWeight: FontWeight.w600)),
                ),
                Text(ourStatus,
                    style: AeroText.caption.copyWith(
                        color: ourColor, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
          _RailRow(
            mark: _Mark.dot,
            child: _AirportLabel(ourOrigin),
          ),
          for (final leg in legs) ...[
            _RailRow(
              mark: _Mark.none,
              child: _ChainLeg(leg: leg, onOpenFlight: onOpenFlight),
            ),
            _RailRow(
              mark: _Mark.dot,
              child: _AirportLabel(leg.originIata ?? leg.originIcao ?? '—'),
            ),
          ],
          _RailRow(
            mark: _Mark.dashed,
            lineAbove: false,
            lineBelow: false,
            child: recent == null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: _Tappable(
                      onTap: recentLoading ? null : onLoadRecent,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AeroSpace.sm),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                              recentLoading
                                  ? 'Loading earlier flights…'
                                  : 'Show earlier flights',
                              style: AeroText.body.copyWith(
                                  color: AeroColors.ink,
                                  fontWeight: FontWeight.w600)),
                          if (!recentLoading) ...[
                            const SizedBox(width: AeroSpace.xs),
                            const Icon(Icons.expand_more,
                                size: 18, color: AeroColors.ink),
                          ],
                        ]),
                      ),
                    ),
                  )
                : legs.length == (inbound != null ? 1 : 0)
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AeroSpace.sm),
                        child: Text('No earlier flights found',
                            style: AeroText.caption),
                      )
                    : const SizedBox(height: AeroSpace.sm),
          ),
        ],
      ),
    );
  }
}

class _AirportLabel extends StatelessWidget {
  final String code;
  const _AirportLabel(this.code);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(code,
            style: AeroText.caption.copyWith(
                fontWeight: FontWeight.w600, fontFeatures: AeroText.tabular)),
      );
}

/// A leg in the chain: cities, codes, idents + local departure, arrival.
class _ChainLeg extends StatelessWidget {
  final AircraftLegEntity leg;
  final OpenFlight? onOpenFlight;
  const _ChainLeg({required this.leg, this.onOpenFlight});

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final arrival = _legArrival(leg);
    final departure = DateTime.tryParse(leg.scheduledOut ?? '');
    String code(String? iata, String? icao) =>
        [iata, icao].whereType<String>().join(' ');
    final title = leg.originCity != null || leg.destinationCity != null
        ? '${leg.originCity ?? leg.originIata ?? '—'} → ${leg.destinationCity ?? leg.destinationIata ?? '—'}'
        : '${leg.originIata ?? '—'} → ${leg.destinationIata ?? '—'}';
    final ident = leg.identIata ?? leg.identIcao ?? leg.ident;
    final idents = _idents(leg.identIata, leg.identIcao, leg.ident);
    final dep = departure == null
        ? null
        : 'Dep ${formatDateClock(departure, airportTz: leg.originTimezone, mode: units.time, use24: use24)}';

    return _Tappable(
      onTap: onOpenFlight == null || departure == null
          ? null
          : () => onOpenFlight!(ident, departure.toLocal(),
              faFlightId: leg.faFlightId),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AeroSpace.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AeroText.body.copyWith(
                          color: AeroColors.ink, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                      '${code(leg.originIata, leg.originIcao)} → '
                      '${code(leg.destinationIata, leg.destinationIcao)}',
                      style: AeroText.caption.copyWith(
                          color: AeroColors.ink,
                          fontFeatures: AeroText.tabular)),
                  const SizedBox(height: 2),
                  Text(idents,
                      style: AeroText.caption
                          .copyWith(fontFeatures: AeroText.tabular)),
                  if (dep != null) Text(dep, style: AeroText.caption),
                ],
              ),
            ),
            const SizedBox(width: AeroSpace.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (arrival != null)
                  Text(
                    '${leg.actualIn != null ? 'Arrived' : 'Arrives'} '
                    '${formatClock(arrival, airportTz: leg.destinationTimezone, mode: units.time, use24: use24)}',
                    style: AeroText.caption.copyWith(
                        color: AeroColors.ink, fontFeatures: AeroText.tabular),
                  ),
                const SizedBox(height: 2),
                Text(
                  leg.cancelled ? 'Cancelled' : _delayText(leg.arrivalDelay),
                  style: AeroText.micro.copyWith(
                      color: leg.cancelled
                          ? AeroColors.danger
                          : _delayColor(leg.arrivalDelay),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// "You have N flights on <reg> ›" → sheet with the full list.
class _OwnFlightsRow extends StatelessWidget {
  final String registration;
  final List<FlightSummaryEntity> flights;
  final OpenFlight? onOpenFlight;

  const _OwnFlightsRow({
    required this.registration,
    required this.flights,
    this.onOpenFlight,
  });

  void _open(BuildContext context) {
    showAeroSheet(
      context,
      AeroSheet(
        title: 'Your history on $registration',
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: flights.length,
            separatorBuilder: (_, __) => const Divider(height: AeroSpace.lg),
            itemBuilder: (sheetContext, i) {
              final f = flights[i];
              final date = DateTime.parse(f.date).toLocal();
              return _Tappable(
                onTap: onOpenFlight == null
                    ? null
                    : () {
                        Navigator.of(sheetContext).pop();
                        onOpenFlight!(f.flightNo, date);
                      },
                child: Row(children: [
                  AirlineLogo(
                      svgUrl: f.airline.image, icao: f.airline.icao, size: 28),
                  const SizedBox(width: AeroSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${f.departureAirportCode} → ${f.arrivalAirportCode}',
                            style: AeroText.heading),
                        if (f.departureAirportName.isNotEmpty ||
                            f.arrivalAirportName.isNotEmpty)
                          Text(
                            '${f.departureAirportName} → ${f.arrivalAirportName}',
                            style: AeroText.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(DateFormat('d MMM yyyy').format(date),
                          style: AeroText.body.copyWith(
                              color: AeroColors.ink,
                              fontFeatures: AeroText.tabular)),
                      Text(_idents(f.flightNo, f.callSign, f.flightNo),
                          style: AeroText.caption
                              .copyWith(fontFeatures: AeroText.tabular)),
                    ],
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = flights.length;
    return _Tappable(
      onTap: () => _open(context),
      child: Container(
        padding: const EdgeInsets.all(AeroSpace.md),
        decoration: const BoxDecoration(
          color: AeroColors.surfaceAlt,
          borderRadius: AeroRadius.mdAll,
        ),
        child: Row(children: [
          const Icon(Icons.airplane_ticket_outlined,
              size: 20, color: AeroColors.ink),
          const SizedBox(width: AeroSpace.md),
          Expanded(
            child: Text(
                'You have $n ${n == 1 ? 'flight' : 'flights'} on $registration',
                style: AeroText.body.copyWith(
                    color: AeroColors.ink, fontWeight: FontWeight.w600)),
          ),
          const Icon(Icons.chevron_right, color: AeroColors.muted),
        ]),
      ),
    );
  }
}
