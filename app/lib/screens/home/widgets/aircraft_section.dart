import 'package:aero/formatters/time.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:aero/utils/aircraft_registry.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

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

  /// Opens a flight by identifier and (local) departure date.
  final void Function(String ident, DateTime date)? onOpenFlight;

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
    final aircraft = _aircraft;
    if (aircraft == null) return const SizedBox.shrink();
    final registrations = aircraft.registrations?.toList() ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (aircraft.model != null) ...[
          Text(aircraft.model!, style: AeroText.heading),
          const SizedBox(height: AeroSpace.sm),
        ],
        if (aircraft.registration != null) _buildAircraftCard(aircraft),
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
      decoration: BoxDecoration(
        border: Border.all(color: AeroColors.line),
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
          decoration: BoxDecoration(
            border: Border.all(color: AeroColors.line),
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
