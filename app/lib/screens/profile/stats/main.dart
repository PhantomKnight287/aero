import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/sections/delay_sections.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/passport_card.dart';
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
import 'package:openapi/openapi.dart';

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

  Future<void> _openReport([String path = '/profile/stats/flights']) async {
    final r = await context.push<OpenFlightRequest>(path, extra: c.year);
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
        PassportCard(stats: stats, onOpen: () => _openReport()),
        if (stats.delays.buckets.total > 0) ...[
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

  Widget _delayCard(DelaySummaryEntity d) => SummaryCard(
        gradient: AeroAccent.delayGradient,
        ctaLabel: 'All delay stats',
        onCta: () => _openReport('/profile/stats/delays'),
        child: DelayLost(d: d),
      );

  Widget _aircraftCard(AircraftStatsEntity a) {
    final image = a.mostFlownAircraftImage;
    final n = a.mostFlownAircraftFlightCount.toInt();
    final hasImage = image != null && image.isNotEmpty;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AeroAccent.aircraftGradient,
        ),
        borderRadius: AeroRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(AeroSpace.lg, AeroSpace.lg,
                AeroSpace.lg, hasImage ? AeroSpace.md : AeroSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Most flown aircraft',
                    style: AeroText.heading
                        .copyWith(color: AeroAccent.aircraftInk)),
                const SizedBox(height: AeroSpace.xs),
                Text(a.mostFlownAircraftName,
                    style: AeroText.display
                        .copyWith(color: AeroAccent.aircraftInk)),
                Text('${formatCount(n)} ${n == 1 ? 'flight' : 'flights'}',
                    style: AeroText.body.copyWith(
                        color: AeroAccent.aircraftInk,
                        fontFeatures: AeroText.tabular)),
              ],
            ),
          ),
          if (hasImage)
            ClipRRect(
              borderRadius: AeroRadius.mdBottom,
              // Fixed 16:9 centre crop, flush to the card's left, right and
              // bottom. The band is sized only once the image loads (the SVG
              // error/placeholder builders are unsized), so a failed load
              // collapses instead of leaving an empty hole.
              child: image.endsWith('.svg')
                  ? LayoutBuilder(
                      builder: (_, box) => SvgPicture.network(image,
                          width: box.maxWidth,
                          height: box.maxWidth * 9 / 16,
                          fit: BoxFit.cover,
                          placeholderBuilder: (_) => const SizedBox.shrink(),
                          errorBuilder: (_, __, ___) =>
                              const SizedBox.shrink()))
                  : CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (_, provider) => AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image(image: provider, fit: BoxFit.cover)),
                      errorWidget: (_, __, ___) => const SizedBox.shrink()),
            ),
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
