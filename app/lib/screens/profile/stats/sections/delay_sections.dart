import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/rate_bar.dart';
import 'package:aero/screens/profile/stats/widgets/record_row.dart';
import 'package:aero/screens/profile/stats/widgets/stat_bar_list.dart';
import 'package:aero/screens/profile/stats/widgets/stat_section.dart';
import 'package:aero/screens/profile/stats/widgets/summary_card.dart';
import 'package:aero/screens/profile/stats/widgets/unit_text.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/components/country_flag.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'shared.dart';

const _preview = 5;

String _late(num minutes) => formatLongDuration(minutes.round());

/// '17 h lost to delays', plus the average of delayed flights. Used on the
/// hub's delay card and the report's hero card.
class DelayLost extends StatelessWidget {
  final DelaySummaryEntity d;

  const DelayLost({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final mins = d.minutesLost.round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UnitText(
            mins < 60
                ? [(formatCount(mins), false), (' m', true)]
                : [(formatCount(mins / 60), false), (' h', true)],
            style: AeroText.hero.copyWith(color: AeroColors.onInk),
            unitColor: AeroAccent.onDelayMuted),
        const SizedBox(height: AeroSpace.xs),
        Text('lost to delays',
            style: AeroText.heading.copyWith(color: AeroColors.onInk)),
        if (d.delayedCount > 0)
          Text('Delayed flights averaged ${_late(d.avgDelayMinutes)} late',
              style: AeroText.body.copyWith(
                  color: AeroAccent.onDelayMuted,
                  fontFeatures: AeroText.tabular)),
      ],
    );
  }
}

/// Red card: % delayed, time lost, and the worst delay.
class DelayHeroCard extends StatelessWidget {
  final DelaySummaryEntity d;

  const DelayHeroCard({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final onInk = AeroColors.onInk;
    final muted = AeroText.body.copyWith(
        color: AeroAccent.onDelayMuted, fontFeatures: AeroText.tabular);
    final worst = d.worst;
    return SummaryCard(
      gradient: AeroAccent.delayGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              d.arrivedCount == 0
                  ? '0%'
                  : percent(d.delayedCount / d.arrivedCount),
              style: AeroText.hero.copyWith(color: onInk)),
          const SizedBox(height: AeroSpace.xs),
          Text('flights delayed', style: AeroText.title.copyWith(color: onInk)),
          Text(
              '${count(d.delayedCount)} of ${count(d.arrivedCount)} flights '
              'arrived later than scheduled',
              style: muted),
          if (d.minutesLost > 0) ...[
            const SizedBox(height: AeroSpace.xl),
            DelayLost(d: d),
          ],
          if (worst != null) ...[
            const SizedBox(height: AeroSpace.lg),
            Container(height: 1, color: AeroAccent.passportRule),
            const SizedBox(height: AeroSpace.md),
            _WorstDelay(r: worst),
          ],
        ],
      ),
    );
  }
}

class _WorstDelay extends StatelessWidget {
  final StatsRecordEntity r;

  const _WorstDelay({required this.r});

  @override
  Widget build(BuildContext context) {
    final f = r.flight;
    final muted = AeroText.body.copyWith(
        color: AeroAccent.onDelayMuted, fontFeatures: AeroText.tabular);
    final onTap = popFlight(context, f);
    final row = Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WORST DELAY',
                style: AeroText.label.copyWith(color: AeroAccent.onDelayMuted)),
            const SizedBox(height: AeroSpace.xs),
            Text(flightIdents(f),
                style: AeroText.heading.copyWith(color: AeroColors.onInk),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(
                [flightAirports(f), flightDate(f)]
                    .where((s) => s.isNotEmpty)
                    .join(' · '),
                style: muted,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
      const SizedBox(width: AeroSpace.sm),
      Text(_late(r.value),
          style: AeroText.figure.copyWith(color: AeroColors.onInk)),
      if (onTap != null)
        const Icon(Icons.chevron_right, size: 20, color: AeroColors.onInk),
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

/// Early … Diverted, each as a share of every flight with times.
class DelayBreakdownSection extends StatelessWidget {
  final DelaySummaryEntity d;

  const DelayBreakdownSection({super.key, required this.d});

  static bool shows(DelaySummaryEntity d) => d.buckets.total > 0;

  @override
  Widget build(BuildContext context) {
    final b = d.buckets;
    final rows = [
      ('Early', b.early),
      ('On time', b.onTime),
      ('15m late', b.late15),
      ('30m late', b.late30),
      ('45m+ late', b.late45),
      ('Cancelled', b.cancelled),
      ('Diverted', b.diverted),
    ];
    final net = d.netMinutes.round();
    return StatSection(
      title: 'Arrival performance',
      hero: d.basedOn > 0 ? _late(net.abs()) : null,
      heroUnit: net < 0 ? 'early' : 'late',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (d.basedOn > 0) ...[
            Text('cumulative arrival performance', style: tabularBody),
            const SizedBox(height: AeroSpace.lg),
          ],
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const SizedBox(height: AeroSpace.sm),
            RateRow.inline(
              label: rows[i].$1,
              fraction: rows[i].$2 / b.total,
              color: AeroAccent.delayBuckets[i],
            ),
          ],
          const SizedBox(height: AeroSpace.md),
          basedOn(b.total, suffix: ' with FlightAware times'),
        ],
      ),
    );
  }
}

/// Top three airlines by total late time.
class WorstAirlinesSection extends StatelessWidget {
  final DelaySummaryEntity d;

  const WorstAirlinesSection({super.key, required this.d});

  static List<DelayAirlineEntity> _top(DelaySummaryEntity d) =>
      (d.airlines.where((a) => a.minutesLate > 0).toList()
            ..sort((a, b) => b.minutesLate.compareTo(a.minutesLate)))
          .take(3)
          .toList();

  static bool shows(DelaySummaryEntity d) => _top(d).isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final top = _top(d);
    final first = top.first;
    return StatSection(
      title: 'Worst airlines',
      hero: _late(first.minutesLate),
      heroUnit: 'late in total',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(first.airline.name,
              style: tabularBody, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: AeroSpace.lg),
          StatBarList(
            labelWidth: 72,
            color: AeroAccent.late,
            rows: [
              for (final a in top)
                StatBar(
                  label: Row(children: [
                    AirlineLogo(
                        svgUrl: a.airline.image,
                        icao: a.airline.icao,
                        size: 20),
                    const SizedBox(width: AeroSpace.sm),
                    Expanded(
                        child: Text(a.airline.iata ?? a.airline.icao ?? '',
                            style: AeroText.heading)),
                  ]),
                  value: a.minutesLate,
                  valueLabel: _late(a.minutesLate),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Rate rows with the first five shown and the rest in a sheet.
class _RateSection<T> extends StatelessWidget {
  final String title;
  final String heroUnit;
  final List<T> items;
  final int Function(T) late;
  final int Function(T) total;
  final RateRow Function(T) row;

  const _RateSection({
    super.key,
    required this.title,
    required this.heroUnit,
    required this.items,
    required this.late,
    required this.total,
    required this.row,
  });

  @override
  Widget build(BuildContext context) {
    final sumLate = items.fold<int>(0, (s, e) => s + late(e));
    final sumTotal = items.fold<int>(0, (s, e) => s + total(e));
    Widget list(Iterable<T> xs) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, e) in xs.indexed) ...[
              if (i > 0) const SizedBox(height: AeroSpace.md),
              row(e),
            ],
          ],
        );
    return StatSection(
      title: title,
      hero: percent(sumTotal == 0 ? 0 : sumLate / sumTotal),
      heroUnit: heroUnit,
      onShowMore: items.length > _preview
          ? () => showListSheet(context, title, [for (final e in items) row(e)])
          : null,
      child: list(items.take(_preview)),
    );
  }
}

class AirlinePerformanceSection extends StatelessWidget {
  final DelaySummaryEntity d;

  const AirlinePerformanceSection({super.key, required this.d});

  static bool shows(DelaySummaryEntity d) => d.airlines.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return _RateSection<DelayAirlineEntity>(
      title: 'Airline performance',
      heroUnit: 'late arrivals',
      items: d.airlines.toList(),
      late: (a) => a.lateArrivals.toInt(),
      total: (a) => a.total.toInt(),
      row: (a) => RateRow.stacked(
        leading: AirlineLogo(
            svgUrl: a.airline.image, icao: a.airline.icao, size: 20),
        label: a.airline.name,
        note: [a.airline.iata, a.airline.icao]
            .whereType<String>()
            .where((s) => s.isNotEmpty)
            .join(' · '),
        fraction: a.total == 0 ? 0 : a.lateArrivals / a.total,
        detail: '(${count(a.lateArrivals)}/${count(a.total)})',
        color: AeroAccent.late,
      ),
    );
  }
}

class AirportPerformanceSection extends StatelessWidget {
  final DelaySummaryEntity d;

  const AirportPerformanceSection({super.key, required this.d});

  static bool shows(DelaySummaryEntity d) => d.airports.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return _RateSection<DelayAirportEntity>(
      title: 'Airport performance',
      heroUnit: 'late departures',
      items: d.airports.toList(),
      late: (a) => a.lateDepartures.toInt(),
      total: (a) => a.total.toInt(),
      row: (a) => RateRow.stacked(
        leading: CountryFlag(iso2: a.airport.isoCountry ?? '', size: 20),
        label: airportCodes(a.airport),
        note: a.airport.city,
        fraction: a.total == 0 ? 0 : a.lateDepartures / a.total,
        detail: '(${count(a.lateDepartures)}/${count(a.total)})',
        color: AeroAccent.late,
      ),
    );
  }
}

/// Every delayed flight, worst first.
class DelayedFlightsSection extends StatelessWidget {
  final DelaySummaryEntity d;

  const DelayedFlightsSection({super.key, required this.d});

  static bool shows(DelaySummaryEntity d) => d.flights.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    Widget row(StatsRecordEntity r) => RecordRow(
          caption: '',
          flight: r.flight,
          value: _late(r.value),
          valueColor: AeroAccent.late,
          onTap: popFlight(context, r.flight),
        );
    return StatSection(
      title: 'Arrival delays',
      hero: count(d.flights.length),
      heroUnit: 'total',
      onShowMore: d.flights.length > _preview
          ? () => showListSheet(
              context, 'Arrival delays', [for (final r in d.flights) row(r)])
          : null,
      child: Column(
        children: [
          for (final (i, r) in d.flights.take(_preview).indexed) ...[
            if (i > 0) const Divider(height: 1, color: AeroColors.line),
            row(r),
          ],
        ],
      ),
    );
  }
}
