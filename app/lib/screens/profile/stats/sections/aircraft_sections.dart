import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/stat_bar_list.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/tokens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

const _preview = 8;

String _flights(num n) => '${count(n)} ${n == 1 ? 'flight' : 'flights'}';

/// Sheet listing every flight on one type; rows open the flight.
void _showTypeFlights(BuildContext context, AircraftTypeEntity t) {
  showListSheet(context, t.typeName, [
    for (final f in t.flights)
      PastFlightRow(flight: f, onTap: popFlight(context, f) ?? () {}),
  ]);
}

/// Most flown types as bars; each row opens that type's flights.
class AircraftTypesSection extends StatelessWidget {
  final AircraftSectionEntity a;

  const AircraftTypesSection({super.key, required this.a});

  static bool shows(AircraftSectionEntity a) => a.types.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    StatBar bar(AircraftTypeEntity t) => StatBar(
          label: Text(t.typeCode ?? t.typeName, style: AeroText.heading),
          value: t.flightCount,
          valueLabel: count(t.flightCount),
          onTap: () => _showTypeFlights(context, t),
        );
    final types = a.types.toList();
    return StatSection(
      title: 'Aircraft types',
      hero: count(types.length),
      heroUnit: types.length == 1 ? 'type flown' : 'types flown',
      onShowMore: types.length > _preview
          ? () => showListSheet(context, 'Aircraft types', [
                for (final t in types)
                  _TypeSheetRow(
                      t: t, onTap: () => _showTypeFlights(context, t)),
              ])
          : null,
      child: StatBarList(
        labelWidth: 56,
        color: AeroAccent.passport,
        rows: [for (final t in types.take(_preview)) bar(t)],
      ),
    );
  }
}

class _TypeSheetRow extends StatelessWidget {
  final AircraftTypeEntity t;
  final VoidCallback onTap;

  const _TypeSheetRow({required this.t, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AeroPressable(
          child: Row(children: [
            Expanded(
              child: SheetRow(
                title: t.typeName,
                lines: [if (t.typeCode != null) t.typeCode!],
                value: _flights(t.flightCount),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AeroColors.muted),
          ]),
        ),
      ),
    );
  }
}

/// Every family in the server's map; unflown ones are muted.
class TypeCollectionSection extends StatelessWidget {
  final AircraftSectionEntity a;

  const TypeCollectionSection({super.key, required this.a});

  static bool shows(AircraftSectionEntity a) => a.families.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final fams = a.families.toList();
    final flown = fams.where((f) => f.flightCount > 0).length;
    return StatSection(
      title: 'Type collection',
      heroWidget: Text.rich(TextSpan(children: [
        TextSpan(
            text: '${count(flown)} of ${count(fams.length)}',
            style: AeroText.hero),
        TextSpan(text: ' families', style: AeroText.heroUnit),
      ])),
      child: LayoutBuilder(builder: (context, box) {
        const cols = 3;
        final w = (box.maxWidth - AeroSpace.sm * (cols - 1)) / cols;
        return Wrap(
          spacing: AeroSpace.sm,
          runSpacing: AeroSpace.sm,
          children: [for (final f in fams) _FamilyTile(f: f, width: w)],
        );
      }),
    );
  }
}

class _FamilyTile extends StatelessWidget {
  final AircraftFamilyEntity f;
  final double width;

  const _FamilyTile({required this.f, required this.width});

  @override
  Widget build(BuildContext context) {
    final flown = f.flightCount > 0;
    final first = flown ? DateTime.tryParse(f.firstFlown ?? '') : null;
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 84),
      padding: const EdgeInsets.all(AeroSpace.md),
      decoration: BoxDecoration(
        color: flown ? AeroAccent.aircraftTile : AeroColors.surfaceAlt,
        borderRadius: AeroRadius.smAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(f.family,
              style: AeroText.heading
                  .copyWith(color: flown ? AeroColors.ink : AeroColors.muted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          if (flown) ...[
            Text(_flights(f.flightCount), style: tabularBody),
            if (first != null)
              Text('first ${DateFormat('MMM y').format(first)}',
                  style: tabularCaption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
          ] else
            Text('not yet', style: AeroText.caption),
        ],
      ),
    );
  }
}

/// Oldest/newest airframe and the most flown tail.
class AirframesSection extends StatelessWidget {
  final AircraftSectionEntity a;

  const AirframesSection({super.key, required this.a});

  static bool shows(AircraftSectionEntity a) =>
      a.airframes.oldest != null || a.airframes.mostFlownTail != null;

  @override
  Widget build(BuildContext context) {
    final af = a.airframes;
    final median = af.medianAgeYears;
    final tail = af.mostFlownTail;
    return StatSection(
      title: 'Airframes',
      hero: median == null ? null : formatDecimal(median),
      heroUnit: 'yrs median age',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (af.oldest != null) _AirframeRow(caption: 'Oldest', x: af.oldest!),
          if (af.newest != null && af.newest!.reg != af.oldest?.reg) ...[
            const Divider(height: 1, color: AeroColors.line),
            _AirframeRow(caption: 'Newest', x: af.newest!),
          ],
          if (tail != null) ...[
            if (af.oldest != null)
              const Divider(height: 1, color: AeroColors.line),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MOST FLOWN TAIL', style: AeroText.label),
                  Text(
                      [tail.reg, tail.typeName, _flights(tail.count)]
                          .whereType<String>()
                          .join(' · '),
                      style: AeroText.heading),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AirframeRow extends StatelessWidget {
  final String caption;
  final AirframeEntity x;

  const _AirframeRow({required this.caption, required this.x});

  @override
  Widget build(BuildContext context) {
    final onTap = popFlight(context, x.flight);
    final image = x.image;
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
      child: Row(children: [
        if (image != null && image.isNotEmpty && !image.endsWith('.svg')) ...[
          ClipRRect(
            borderRadius: AeroRadius.smAll,
            child: CachedNetworkImage(
              imageUrl: image,
              width: 64,
              height: 36,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const SizedBox(width: 64),
            ),
          ),
          const SizedBox(width: AeroSpace.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(caption.toUpperCase(), style: AeroText.label),
              Text([x.typeCode, x.reg].whereType<String>().join(' · '),
                  style: AeroText.heading),
              Text(
                  [x.typeName, flightIdents(x.flight)]
                      .whereType<String>()
                      .where((s) => s.isNotEmpty)
                      .join(' · '),
                  style: AeroText.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(width: AeroSpace.sm),
        Text('${formatDecimal(x.ageYears)} yrs',
            style: AeroText.body.copyWith(
                color: AeroColors.ink,
                fontWeight: FontWeight.w600,
                fontFeatures: AeroText.tabular)),
        if (onTap != null)
          const Icon(Icons.chevron_right, size: 20, color: AeroColors.muted),
      ]),
    );
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
