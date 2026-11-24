import 'package:aero/formatters/units.dart';
import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/components/unit_cycle.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

import 'flight_status.dart';
import 'progress_bar.dart';

class FlightAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const FlightAction(this.icon, this.label, this.onTap);
}

/// Logo, 'WN 4187 · SWA4187 · MON 23 NOV', 'St Louis to Phoenix',
/// codeshares, the actions menu and close.
class FlightHeader extends StatelessWidget {
  final FlightResponseEntity info;
  final LiveStatus status;
  final DateTime now;
  final List<FlightAction> actions;
  final VoidCallback onClose;

  const FlightHeader({
    super.key,
    required this.info,
    required this.status,
    required this.now,
    required this.actions,
    required this.onClose,
  });

  /// The one place status is coloured: a small dot.
  Color get _dot => switch (status.phase) {
        FlightPhase.cancelled || FlightPhase.diverted => AeroColors.danger,
        _ => status.overall == Punctuality.late
            ? AeroColors.warn
            : AeroColors.success,
      };

  String _kicker() {
    final fa = info.flightAwareData;
    final idents = <String>{
      fa?.identIata ?? info.flightNo,
      if (fa?.identIcao != null) fa!.identIcao!,
      if (fa?.identIcao == null && info.callSign.isNotEmpty) info.callSign,
    }.where((s) => s.isNotEmpty);
    // `local` strings carry an offset that DateTime.parse folds into UTC,
    // so zone the UTC instant at the departure airport instead.
    final utc =
        DateTime.tryParse(info.departure.scheduledTime.utc) ?? info.date;
    final local = airportTime(utc, info.departure.airport.timeZone);
    return [...idents, DateFormat('EEE d MMM').format(local)]
        .join(' · ')
        .toUpperCase();
  }

  static String _city(RouteAirportEntity a) =>
      a.municipalityName.isNotEmpty ? a.municipalityName : a.name;

  @override
  Widget build(BuildContext context) {
    final fa = info.flightAwareData;
    final shares = [
      ...?(fa?.codesharesIata?.isNotEmpty == true
          ? fa!.codesharesIata
          : fa?.codesharesIcao),
    ].map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    final caption = AeroText.caption.copyWith(fontFeatures: AeroText.tabular);
    final progress = status.progress(now);
    final (sinceDep, toArr) = status.barCaption(now) ?? (null, null);
    final head = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AeroSpace.xs),
          child: AirlineLogo(
              svgUrl: info.airline.image, icao: info.airline.icao, size: 36),
        ),
        const SizedBox(width: AeroSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_kicker(),
                  style:
                      AeroText.label.copyWith(fontFeatures: AeroText.tabular)),
              const SizedBox(height: 2),
              Text(
                  '${_city(info.departure.airport)} to ${_city(info.arrival.airport)}',
                  style: AeroText.title),
              if (shares.isNotEmpty)
                Text(
                    'also sold as ${shares.take(2).join(', ')}'
                    '${shares.length > 2 ? ' +${shares.length - 2}' : ''}',
                    style: AeroText.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Flight actions',
          onPressed: () => showAeroSheet(
            context,
            AeroSheet(
              title: 'Flight',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final a in actions)
                    _ActionRow(
                      action: a,
                      close: () => Navigator.of(context).pop(),
                    ),
                ],
              ),
            ),
          ),
          icon: const Icon(Icons.more_horiz, color: AeroColors.ink),
          visualDensity: VisualDensity.compact,
        ),
        IconButton(
          tooltip: 'Close',
          onPressed: onClose,
          icon: const Icon(Icons.close, color: AeroColors.ink),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
    final before = status.phase == FlightPhase.scheduled ||
        status.phase == FlightPhase.boardingSoon;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        head,
        const SizedBox(height: AeroSpace.lg),
        Row(children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: _dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: AeroSpace.sm),
          Expanded(
            child: UnitCycle(
              dimension: UnitDimension.time,
              builder: (_, u) {
                final clock = formatClock(status.departure.best,
                    airportTz: info.departure.airport.timeZone,
                    mode: u.time,
                    use24: MediaQuery.of(context).alwaysUse24HourFormat);
                // Full width: AnimatedSwitcher centres its child.
                return SizedBox(
                  width: double.infinity,
                  child: Text(
                      before
                          ? '${status.bandText(now)} · departs $clock'
                          : status.bandText(now),
                      style: AeroText.heading
                          .copyWith(fontFeatures: AeroText.tabular)),
                );
              },
            ),
          ),
        ]),
        if (progress != null) ...[
          const SizedBox(height: AeroSpace.sm),
          RouteProgressBar(
            from: _code(info.departure.airport),
            to: _code(info.arrival.airport),
            progress: progress,
          ),
          if (sinceDep != null)
            Row(children: [
              Expanded(child: Text(sinceDep, style: caption)),
              if (toArr != null) Text(toArr, style: caption),
            ]),
        ],
        if (now.difference(info.date).inDays > 7)
          Text('Older than 7 days — times may no longer update.',
              style: AeroText.caption),
      ],
    );
  }
}

String _code(RouteAirportEntity a) => a.iata.isNotEmpty ? a.iata : a.icao;

class _ActionRow extends StatelessWidget {
  final FlightAction action;
  final VoidCallback close;

  const _ActionRow({required this.action, required this.close});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          close();
          action.onTap();
        },
        child: AeroPressable(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AeroSpace.md),
            child: Row(children: [
              Icon(action.icon, size: 22, color: AeroColors.ink),
              const SizedBox(width: AeroSpace.md),
              Expanded(
                child: Text(action.label,
                    style: AeroText.body.copyWith(
                        color: AeroColors.ink, fontWeight: FontWeight.w600)),
              ),
              const Icon(Icons.chevron_right,
                  size: 20, color: AeroColors.muted),
            ]),
          ),
        ),
      ),
    );
  }
}
