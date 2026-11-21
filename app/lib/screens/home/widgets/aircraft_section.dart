import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/ui/components/aero_button.dart';
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
        if (widget.history?.inbound != null) ...[
          _InboundCard(
            leg: widget.history!.inbound!,
            ourDeparture:
                DateTime.tryParse(widget.info.departure.scheduledTime.utc),
            onOpenFlight: widget.onOpenFlight,
          ),
          const SizedBox(height: AeroSpace.md),
        ],
        if (aircraft?.registration != null) _buildAircraftCard(aircraft!),
        if (widget.history?.ownFlights.isNotEmpty == true) ...[
          const SizedBox(height: AeroSpace.lg),
          _OwnTailFlights(
            flights: widget.history!.ownFlights.toList(),
            onOpenFlight: widget.onOpenFlight,
          ),
        ],
        if (widget.history?.registration != null) ...[
          const SizedBox(height: AeroSpace.lg),
          _RecentLegs(
            registration: widget.history!.registration!,
            legs: widget.recent,
            loading: widget.recentLoading,
            onLoad: widget.onLoadRecent,
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

/// One leg: idents, route, status and arrival time.
class _LegRow extends StatelessWidget {
  final AircraftLegEntity leg;
  final OpenFlight? onOpenFlight;
  const _LegRow({required this.leg, this.onOpenFlight});

  @override
  Widget build(BuildContext context) {
    final units = context.watch<UnitsNotifier>();
    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final arrival = DateTime.tryParse(
        leg.actualIn ?? leg.estimatedIn ?? leg.scheduledIn ?? '');
    final departure = DateTime.tryParse(leg.scheduledOut ?? '');
    final delayMin = (leg.arrivalDelay ?? 0) ~/ 60;
    final delayText = leg.cancelled
        ? 'Cancelled'
        : delayMin >= 5
            ? '$delayMin min late'
            : delayMin <= -5
                ? '${-delayMin} min early'
                : 'On time';
    final delayColor = leg.cancelled || delayMin >= 15
        ? AeroColors.danger
        : delayMin >= 5
            ? AeroColors.warn
            : AeroColors.success;
    String code(String? iata, String? icao) =>
        [iata, icao].whereType<String>().join(' ');
    final route = '${code(leg.originIata, leg.originIcao)} → '
        '${code(leg.destinationIata, leg.destinationIcao)}';
    // Cities + scheduled departure dated in the origin's zone (same zone
    // rule as the arrival time, which uses the destination's).
    final places = [
      if (leg.originCity != null || leg.destinationCity != null)
        '${leg.originCity ?? '—'} → ${leg.destinationCity ?? '—'}',
      if (departure != null)
        'Dep ${formatDateClock(departure, airportTz: leg.originTimezone, mode: units.time, use24: use24)}',
    ].join(' · ');
    final ident = leg.identIata ?? leg.identIcao ?? leg.ident;

    return _Tappable(
      onTap: onOpenFlight == null || departure == null
          ? null
          : () => onOpenFlight!(ident, departure.toLocal(),
              faFlightId: leg.faFlightId),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_idents(leg.identIata, leg.identIcao, leg.ident),
                      style: AeroText.body.copyWith(
                          color: AeroColors.ink,
                          fontWeight: FontWeight.w600,
                          fontFeatures: AeroText.tabular)),
                  const SizedBox(height: 2),
                  Text(route,
                      style: AeroText.caption.copyWith(
                          color: AeroColors.ink,
                          fontFeatures: AeroText.tabular)),
                  if (places.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(places, style: AeroText.caption),
                  ],
                ],
              ),
            ),
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
                Text(delayText,
                    style: AeroText.micro.copyWith(
                        color: delayColor, fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InboundCard extends StatelessWidget {
  final AircraftLegEntity leg;
  final DateTime? ourDeparture;
  final OpenFlight? onOpenFlight;
  const _InboundCard(
      {required this.leg, required this.ourDeparture, this.onOpenFlight});

  /// Warning when the inbound arrival leaves less than [_minTurnaround]
  /// before our scheduled departure; null when it's comfortable.
  String? _warning() {
    final arrival = DateTime.tryParse(
        leg.actualIn ?? leg.estimatedIn ?? leg.scheduledIn ?? '');
    if (arrival == null || ourDeparture == null || leg.cancelled) return null;
    final gap = ourDeparture!.difference(arrival);
    if (gap >= _minTurnaround) return null;
    return gap.isNegative
        ? 'Arrives ${-gap.inMinutes} min after your scheduled departure'
        : 'Only ${gap.inMinutes} min between its arrival and your departure';
  }

  @override
  Widget build(BuildContext context) {
    final warning = _warning();
    return Container(
      padding: const EdgeInsets.all(AeroSpace.md),
      decoration: const BoxDecoration(
        color: AeroColors.surfaceAlt,
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Your aircraft',
              style: AeroText.caption.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text('Its previous flight, before it operates yours',
              style: AeroText.micro),
          const SizedBox(height: AeroSpace.sm),
          _LegRow(leg: leg, onOpenFlight: onOpenFlight),
          if (warning != null) ...[
            const SizedBox(height: AeroSpace.sm),
            Container(
              padding: const EdgeInsets.all(AeroSpace.sm),
              decoration: const BoxDecoration(
                color: AeroColors.dangerTint,
                borderRadius: AeroRadius.smAll,
              ),
              child: Row(children: [
                const Icon(Icons.schedule, size: 16, color: AeroColors.danger),
                const SizedBox(width: AeroSpace.sm),
                Expanded(
                  child: Text(warning,
                      style: AeroText.caption.copyWith(
                          color: AeroColors.danger,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],
        ],
      ),
    );
  }
}

class _OwnTailFlights extends StatefulWidget {
  final List<FlightSummaryEntity> flights;
  final OpenFlight? onOpenFlight;
  const _OwnTailFlights({required this.flights, this.onOpenFlight});

  @override
  State<_OwnTailFlights> createState() => _OwnTailFlightsState();
}

class _OwnTailFlightsState extends State<_OwnTailFlights> {
  static const _collapsed = 5;
  bool _all = false;

  @override
  Widget build(BuildContext context) {
    final all = widget.flights;
    final shown = _all ? all : all.take(_collapsed).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("You've flown this tail (${all.length})", style: AeroText.heading),
        const SizedBox(height: AeroSpace.sm),
        for (final f in shown)
          _Tappable(
            onTap: widget.onOpenFlight == null
                ? null
                : () => widget.onOpenFlight!(
                    f.flightNo, DateTime.parse(f.date).toLocal()),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AeroSpace.xs + 2),
              child: Row(children: [
                AirlineLogo(
                  svgUrl: f.airline.image,
                  icao: f.airline.icao,
                  size: 20,
                ),
                const SizedBox(width: AeroSpace.sm),
                SizedBox(
                  width: 84,
                  child: Text(
                    DateFormat('d MMM yyyy')
                        .format(DateTime.parse(f.date).toLocal()),
                    style: AeroText.caption
                        .copyWith(fontFeatures: AeroText.tabular),
                  ),
                ),
                Expanded(
                  child: Text(_idents(f.flightNo, f.callSign, f.flightNo),
                      style: AeroText.body.copyWith(
                          color: AeroColors.ink,
                          fontWeight: FontWeight.w600,
                          fontFeatures: AeroText.tabular)),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '${f.departureAirportCode} → ${f.arrivalAirportCode}',
                          style:
                              AeroText.caption.copyWith(color: AeroColors.ink)),
                      if (f.departureAirportName.isNotEmpty ||
                          f.arrivalAirportName.isNotEmpty)
                        Text(
                          '${f.departureAirportName} → ${f.arrivalAirportName}',
                          style: AeroText.micro,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AeroSpace.xs),
                const Icon(Icons.chevron_right,
                    size: 18, color: AeroColors.muted),
              ]),
            ),
          ),
        if (all.length > _collapsed && !_all)
          Align(
            alignment: Alignment.centerLeft,
            child: _Tappable(
              onTap: () => setState(() => _all = true),
              child: Padding(
                padding: const EdgeInsets.only(top: AeroSpace.xs),
                child: Text('Show all (${all.length})',
                    style: AeroText.body.copyWith(
                        color: AeroColors.ink, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
      ],
    );
  }
}

class _RecentLegs extends StatelessWidget {
  final String registration;
  final List<AircraftLegEntity>? legs;
  final bool loading;
  final VoidCallback? onLoad;
  final OpenFlight? onOpenFlight;

  const _RecentLegs({
    required this.registration,
    required this.legs,
    required this.loading,
    this.onLoad,
    this.onOpenFlight,
  });

  @override
  Widget build(BuildContext context) {
    if (legs == null) {
      return AeroButton.secondary(
        label: 'Show recent flights of $registration',
        loading: loading,
        onPressed: onLoad,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Recent flights of $registration', style: AeroText.heading),
        const SizedBox(height: AeroSpace.sm),
        if (legs!.isEmpty)
          Text('No recent flights found', style: AeroText.caption)
        else
          for (final leg in legs!)
            _LegRow(leg: leg, onOpenFlight: onOpenFlight),
      ],
    );
  }
}
