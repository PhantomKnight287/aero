import 'package:aero/ui/components/aero_pressable.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/components/airline_logo.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

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
  final List<FlightAction> actions;
  final VoidCallback onClose;

  const FlightHeader({
    super.key,
    required this.info,
    required this.actions,
    required this.onClose,
  });

  String _kicker() {
    final fa = info.flightAwareData;
    final idents = <String>{
      fa?.identIata ?? info.flightNo,
      if (fa?.identIcao != null) fa!.identIcao!,
      if (fa?.identIcao == null && info.callSign.isNotEmpty) info.callSign,
    }.where((s) => s.isNotEmpty);
    final local =
        DateTime.tryParse(info.departure.scheduledTime.local) ?? info.date;
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
    return Row(
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
                Text('also sold as ${shares.join(', ')}',
                    style: AeroText.caption),
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
  }
}

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
