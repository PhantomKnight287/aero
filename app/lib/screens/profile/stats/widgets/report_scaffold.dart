import 'package:aero/screens/profile/stats/stats_controller.dart';
import 'package:aero/screens/profile/stats/widgets/year_filter.dart';
import 'package:aero/services/profile.dart';
import 'package:aero/ui/components/aero_pill_button.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

/// Shared report page: back + title, year filter, error/retry, spinner,
/// then the sections [build] returns, spaced evenly.
class ReportScaffold extends StatefulWidget {
  final String title;
  final int? year;
  final StatsController? controller;
  final List<Widget> Function(ProfileStatsResponseEntity s) build;

  const ReportScaffold({
    super.key,
    required this.title,
    required this.build,
    this.year,
    this.controller,
  });

  @override
  State<ReportScaffold> createState() => _ReportScaffoldState();
}

class _ReportScaffoldState extends State<ReportScaffold> {
  late final StatsController _c;

  @override
  void initState() {
    super.initState();
    final service = ProfileService();
    _c = widget.controller ??
        StatsController(
          fetchStats: (y) => service.getProfileStats(year: y),
          // Reports only need stats.
          fetchHistory: (_, __) async => null,
        );
    _c.year = widget.year;
    _c.load();
  }

  @override
  void dispose() {
    if (widget.controller == null) _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroColors.surface,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _c,
          builder: (context, _) {
            final s = _c.stats;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  AeroSpace.lg, AeroSpace.sm, AeroSpace.lg, AeroSpace.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon:
                          const Icon(Icons.chevron_left, color: AeroColors.ink),
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: Text(widget.title,
                          style: AeroText.display,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                  const SizedBox(height: AeroSpace.md),
                  if (s != null && s.availableYears.isNotEmpty) ...[
                    YearFilter(
                      years: [for (final y in s.availableYears) y.toInt()],
                      selected: _c.year,
                      onChanged: _c.setYear,
                    ),
                    const SizedBox(height: AeroSpace.lg),
                  ],
                  if (_c.error != null) ...[
                    Text(_c.error!,
                        style: AeroText.caption
                            .copyWith(color: AeroColors.danger)),
                    const SizedBox(height: AeroSpace.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AeroPillButton(
                          icon: Icons.refresh, label: 'Retry', onTap: _c.load),
                    ),
                    const SizedBox(height: AeroSpace.lg),
                  ],
                  if (s == null && _c.error != null)
                    const SizedBox.shrink()
                  else if (s == null)
                    const Padding(
                      padding: EdgeInsets.all(AeroSpace.xxl),
                      child: Center(
                          child:
                              CircularProgressIndicator(color: AeroColors.ink)),
                    )
                  else
                    // Only sections with data, so hidden ones leave no gap.
                    for (final w in widget.build(s)) ...[
                      w,
                      const SizedBox(height: AeroSpace.xxl),
                    ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
