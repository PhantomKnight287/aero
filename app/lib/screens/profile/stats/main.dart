import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/notifiers/units.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/summary_card.dart';
import 'package:aero/screens/profile/stats/widgets/year_filter.dart';
import 'package:aero/services/profile.dart';
import 'package:aero/ui/components/aero_pill_button.dart';
import 'package:aero/ui/tokens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

const _earthKm = 40075;
final _count = NumberFormat.decimalPattern();

/// Passport hub: summary cards plus the paged flight log. Tapping a flight
/// pops an [OpenFlightRequest] back to whoever pushed this screen.
class FlightStatsScreen extends StatefulWidget {
  final StatsController? controller;

  const FlightStatsScreen({super.key, this.controller});

  @override
  State<FlightStatsScreen> createState() => _FlightStatsScreenState();
}

class _FlightStatsScreenState extends State<FlightStatsScreen> {
  late final StatsController c;

  @override
  void initState() {
    super.initState();
    final service = ProfileService();
    c = widget.controller ??
        StatsController(
          fetchStats: (y) => service.getProfileStats(year: y),
          fetchHistory: (cur, y) =>
              service.getFlightHistory(cursor: cur, year: y),
        );
    c.addListener(_changed);
    c.load();
  }

  void _changed() => setState(() {});

  @override
  void dispose() {
    c.removeListener(_changed);
    if (widget.controller == null) c.dispose();
    super.dispose();
  }

  Future<void> _openReport() async {
    final r = await context.push<OpenFlightRequest>('/profile/stats/flights',
        extra: c.year);
    if (r != null && mounted) context.pop(r);
  }

  void _openFlight(StatsFlightSummaryEntity f) {
    final date = flightDay(f);
    if (date == null) return;
    context.pop(OpenFlightRequest(
        flightNo: f.flightNo, date: date, faFlightId: f.faFlightId));
  }

  @override
  Widget build(BuildContext context) {
    final stats = c.stats;
    final children = <Widget>[
      Text('Passport', style: AeroText.display),
      const SizedBox(height: AeroSpace.md),
      if (stats != null) ...[
        YearFilter(
          years: stats.availableYears.map((y) => y.toInt()).toList(),
          selected: c.year,
          onChanged: c.setYear,
        ),
        const SizedBox(height: AeroSpace.lg),
      ],
      if (c.error != null) ...[
        Text(c.error!, style: AeroText.body.copyWith(color: AeroColors.danger)),
        const SizedBox(height: AeroSpace.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: AeroPillButton(
              icon: Icons.refresh, label: 'Retry', onTap: c.load),
        ),
        const SizedBox(height: AeroSpace.lg),
      ],
      if (stats == null && c.loading) const _Spinner(),
      if (!c.loading &&
          c.error == null &&
          (stats?.passport.totalFlights ?? 0) == 0)
        const _Empty(),
      if (stats != null && stats.passport.totalFlights > 0) ...[
        _passportCard(stats.passport, stats.year),
        if (stats.delays.basedOn > 0 && stats.delays.minutesLost > 0) ...[
          const SizedBox(height: AeroSpace.md),
          _delayCard(stats.delays),
        ],
        if (stats.aircraftStats?.mostFlownAircraftName.isNotEmpty ?? false) ...[
          const SizedBox(height: AeroSpace.md),
          _aircraftCard(stats.aircraftStats!),
        ],
        const SizedBox(height: AeroSpace.xl),
        Text('Past flights', style: AeroText.sectionTitle),
        ..._history(),
      ],
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            if (n.metrics.extentAfter < 600) c.loadMoreHistory();
            return false;
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AeroSpace.lg, 0, AeroSpace.lg, AeroSpace.xl),
            children: children,
          ),
        ),
      ),
    );
  }

  List<Widget> _history() {
    final out = <Widget>[];
    int? year;
    for (final f in c.history) {
      final y = flightDay(f)?.year;
      if (y != year) {
        year = y;
        final n = c.yearCounts
            .where((e) => e.year == y)
            .map((e) => e.count.toInt())
            .firstOrNull;
        out.add(Padding(
          padding: const EdgeInsets.only(top: AeroSpace.lg),
          child: Row(children: [
            Text('$y',
                style:
                    AeroText.heading.copyWith(fontFeatures: AeroText.tabular)),
            const Spacer(),
            if (n != null)
              Text('$n ${n == 1 ? 'flight' : 'flights'}',
                  style: AeroText.caption
                      .copyWith(fontFeatures: AeroText.tabular)),
          ]),
        ));
      } else {
        out.add(const Divider(height: 1, color: AeroColors.line));
      }
      out.add(PastFlightRow(flight: f, onTap: () => _openFlight(f)));
    }
    if (c.loading || c.historyLoading) out.add(const _Spinner());
    return out;
  }

  Widget _passportCard(PassportEntity p, num? statsYear) {
    final unit = context.watch<UnitsNotifier>().distance;
    final laps = (p.totalDistanceKm / _earthKm).toStringAsFixed(1);
    final longHaul = p.longHaul.toInt();
    return SummaryCard(
      gradient: AeroAccent.passportGradient,
      ctaLabel: 'All flight stats',
      onCta: _openReport,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${statsYear == null ? 'All-time' : statsYear.toInt()} passport'
                  .toUpperCase(),
              style:
                  AeroText.label.copyWith(color: AeroAccent.onPassportMuted)),
          const SizedBox(height: AeroSpace.md),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: _Tile('Flights', _count.format(p.totalFlights),
                    sub: '$longHaul long haul')),
            Expanded(
                flex: 2,
                child: _Tile(
                    'Distance', formatDistance(p.totalDistanceKm, unit),
                    sub: '$laps× around Earth')),
          ]),
          const SizedBox(height: AeroSpace.md),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child:
                    _Tile('Time', formatLongDuration(p.blockMinutes.toInt()))),
            Expanded(child: _Tile('Airports', _count.format(p.totalAirports))),
            Expanded(child: _Tile('Airlines', _count.format(p.totalAirlines))),
          ]),
        ],
      ),
    );
  }

  Widget _delayCard(DelaySummaryEntity d) {
    final mins = d.minutesLost.round();
    final (n, unit) = mins < 60
        ? (mins, mins == 1 ? 'minute' : 'minutes')
        : ((mins / 60).round(), (mins / 60).round() == 1 ? 'hour' : 'hours');
    return SummaryCard(
      gradient: AeroAccent.delayGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_count.format(n),
              style: AeroText.hero.copyWith(color: AeroColors.onInk)),
          const SizedBox(height: AeroSpace.xs),
          Text('$unit lost to delays',
              style: AeroText.heading.copyWith(color: AeroColors.onInk)),
          if (d.delayedCount > 0)
            Text(
                'Delayed flights averaged '
                '${formatLongDuration(d.avgDelayMinutes.round())} late',
                style: AeroText.body.copyWith(
                    color: AeroAccent.onDelayMuted,
                    fontFeatures: AeroText.tabular)),
        ],
      ),
    );
  }

  Widget _aircraftCard(AircraftStatsEntity a) {
    final image = a.mostFlownAircraftImage;
    final n = a.mostFlownAircraftFlightCount.toInt();
    return SummaryCard(
      gradient: AeroAccent.aircraftGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Most flown aircraft',
              style: AeroText.heading.copyWith(color: AeroAccent.aircraftInk)),
          const SizedBox(height: AeroSpace.xs),
          Text(a.mostFlownAircraftName,
              style: AeroText.display.copyWith(color: AeroAccent.aircraftInk)),
          Text('$n ${n == 1 ? 'flight' : 'flights'}',
              style: AeroText.body.copyWith(
                  color: AeroAccent.aircraftInk,
                  fontFeatures: AeroText.tabular)),
          if (image != null && image.isNotEmpty) ...[
            const SizedBox(height: AeroSpace.md),
            image.endsWith('.svg')
                ? AspectRatio(
                    aspectRatio: 16 / 6,
                    child: SvgPicture.network(image,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink()))
                // The band is sized only once the image loads, so a failed
                // load collapses to nothing instead of an empty 16:6 hole.
                : CachedNetworkImage(
                    imageUrl: image,
                    imageBuilder: (_, provider) => AspectRatio(
                        aspectRatio: 16 / 6,
                        child: Image(image: provider, fit: BoxFit.contain)),
                    errorWidget: (_, __, ___) => const SizedBox.shrink()),
          ],
        ],
      ),
    );
  }
}

/// Label over a big white figure, with an optional muted line below.
class _Tile extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;

  const _Tile(this.label, this.value, {this.sub});

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
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value,
                style: AeroText.figure.copyWith(color: AeroColors.onInk)),
          ),
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

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AeroSpace.xxl),
      child: Column(children: [
        Text('No flights yet', style: AeroText.title),
        const SizedBox(height: AeroSpace.xs),
        Text('Flights you add to your log show up here.',
            style: AeroText.caption, textAlign: TextAlign.center),
      ]),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(AeroSpace.xl),
        child: Center(
            child: CircularProgressIndicator(
                strokeWidth: 2, color: AeroColors.muted)),
      );
}
