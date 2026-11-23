import 'package:aero/formatters/units.dart';
import 'package:aero/screens/profile/stats/open_flight_request.dart';
import 'package:aero/screens/profile/stats/widgets/past_flight_row.dart';
import 'package:aero/screens/profile/stats/widgets/record_row.dart';
import 'package:aero/ui/components/aero_sheet.dart';
import 'package:aero/ui/tokens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart';

/// '1,234' (locale-aware)
String count(num n) => formatCount(n);

/// 'DEL', falling back to the ICAO code.
String airportCode(StatsAirportEntity a) => a.iata ?? a.icao ?? '';

/// 'DEL · VIDP' (either alone when the other is missing).
String airportCodes(StatsAirportEntity a) =>
    [a.iata, a.icao].whereType<String>().join(' · ');

final tabularBody = AeroText.body.copyWith(fontFeatures: AeroText.tabular);
final tabularCaption =
    AeroText.caption.copyWith(fontFeatures: AeroText.tabular);

/// "based on N flights" note for FlightAware-sourced sections.
Widget basedOn(num n, {String suffix = ''}) =>
    Text('based on ${count(n)} flights$suffix', style: tabularCaption);

/// Pops an [OpenFlightRequest] for [f] up to the hub; null when the flight
/// has no usable date.
VoidCallback? popFlight(BuildContext context, StatsFlightSummaryEntity f) {
  // Same departure-local day the hub's flight log opens with.
  final date = flightDay(f);
  if (date == null) return null;
  return () => context.pop(OpenFlightRequest(
      flightNo: f.flightNo, date: date, faFlightId: f.faFlightId));
}

/// A record row that pops an [OpenFlightRequest] up to the hub.
Widget recordRow(
  BuildContext context,
  String caption,
  StatsRecordEntity? r,
  String Function(num value) format,
) {
  if (r == null) return const SizedBox.shrink();
  return RecordRow(
    caption: caption,
    flight: r.flight,
    value: format(r.value),
    onTap: popFlight(context, r.flight),
  );
}

/// Full list in an [AeroSheet]; rows scroll when they outgrow the screen.
void showListSheet(BuildContext context, String title, List<Widget> rows) {
  showAeroSheet(
    context,
    AeroSheet(
      title: title,
      child: Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: rows.length,
          separatorBuilder: (_, __) =>
              const Divider(height: AeroSpace.lg, color: AeroColors.line),
          itemBuilder: (_, i) => rows[i],
        ),
      ),
    ),
  );
}

/// Title line, detail line(s) and a trailing value, for sheet rows.
class SheetRow extends StatelessWidget {
  final Widget? leading;
  final String title;
  final List<String> lines;
  final String value;

  const SheetRow({
    super.key,
    this.leading,
    required this.title,
    this.lines = const [],
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (leading != null) ...[leading!, const SizedBox(width: AeroSpace.md)],
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AeroText.heading),
            for (final l in lines)
              Text(l,
                  style: AeroText.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
      const SizedBox(width: AeroSpace.sm),
      Text(value,
          style: AeroText.body.copyWith(
              color: AeroColors.ink,
              fontWeight: FontWeight.w600,
              fontFeatures: AeroText.tabular)),
    ]);
  }
}
