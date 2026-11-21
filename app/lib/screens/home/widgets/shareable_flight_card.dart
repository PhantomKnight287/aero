import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/openapi.dart';

import 'package:aero/extensions/duration.dart';
import 'package:aero/formatters/time.dart';
import 'package:aero/formatters/units.dart';
import 'package:aero/utils/duration.dart';

class ShareableFlightCard extends StatelessWidget {
  const ShareableFlightCard({
    super.key,
    required this.info,
    this.distanceUnit = DistanceUnit.km,
    this.timeMode = TimeMode.airport,
  });

  final FlightResponseEntity info;

  /// Passed in (not read from context): the card is rendered off-tree by
  /// captureFromWidget, outside the providers.
  final DistanceUnit distanceUnit;
  final TimeMode timeMode;

  static const _bgBottom = Color(0xFF0E0E12);
  static const _bgTop = Color(0xFF17171E);
  static const _line = Color(0x29FFFFFF);
  static const _muted = Color(0xCCFFFFFF);
  static const _faint = Color(0x80FFFFFF);

  @override
  Widget build(BuildContext context) {
    final departure = info.departure;
    final arrival = info.arrival;
    final airline = info.airline;
    final fa = info.flightAwareData;

    final departureTime =
        DateTime.parse((departure.revisedTime ?? departure.scheduledTime).utc);
    final arrivalTime =
        DateTime.parse((arrival.revisedTime ?? arrival.scheduledTime).utc);
    final departureScheduled = DateTime.parse(departure.scheduledTime.utc);
    final arrivalScheduled = DateTime.parse(arrival.scheduledTime.utc);
    final departureDelay = departure.revisedTime != null
        ? departureTime.difference(departureScheduled)
        : null;
    final arrivalDelay = arrival.revisedTime != null
        ? arrivalTime.difference(arrivalScheduled)
        : null;

    Duration duration;
    try {
      duration = calculateFlightDuration(
        departureTime: departureTime.toIso8601String(),
        departureTimezone: departure.airport.timeZone,
        arrivalTime: arrivalTime.toIso8601String(),
        arrivalTimezone: arrival.airport.timeZone,
      );
    } catch (_) {
      duration = arrivalTime.difference(departureTime);
    }

    final use24 = MediaQuery.of(context).alwaysUse24HourFormat;
    final status = _statusText(fa);

    final flightLine = info.flightNo +
        (fa?.identIata != null && fa!.identIata!.isNotEmpty
            ? '  ·  ${fa.identIata}'
            : '');

    return Container(
      width: 480,
      height: 740,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _bgBottom,
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: _bgTop,
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(
                    airline: airline,
                    flightLine: flightLine,
                    status: status,
                  ),
                  const Spacer(),
                  _RouteBlock(
                    depCode: departure.airport.iata.isNotEmpty
                        ? departure.airport.iata
                        : '—',
                    arrCode: arrival.airport.iata.isNotEmpty
                        ? arrival.airport.iata
                        : '—',
                    depCity: departure.airport.municipalityName,
                    arrCity: arrival.airport.municipalityName,
                    depTime: formatClock(departureTime.toUtc(),
                        airportTz: departure.airport.timeZone,
                        mode: timeMode,
                        use24: use24),
                    arrTime: formatClock(arrivalTime.toUtc(),
                        airportTz: arrival.airport.timeZone,
                        mode: timeMode,
                        use24: use24),
                    depDelay: departureDelay,
                    arrDelay: arrivalDelay,
                    duration: duration,
                  ),
                ],
              ),
            ),
          ),
          const _Perforation(),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MetaGrid(
                    date: formatDayAndMonth(departureTime),
                    duration: duration.toHumanReadable(),
                    aircraft: info.aircraft?.model ??
                        info.aircraft?.registration ??
                        '—',
                  ),
                  const Gap(18),
                  _AirportRow(
                    side: 'DEPARTURE',
                    terminal: departure.terminal,
                    gate: fa?.gateOrigin ?? departure.gate,
                    baggage: null,
                    runway: fa?.actualRunwayOff,
                  ),
                  const Gap(12),
                  _AirportRow(
                    side: 'ARRIVAL',
                    terminal: arrival.terminal,
                    gate: fa?.gateDestination ?? arrival.gate,
                    baggage: fa?.baggageClaim ?? arrival.baggageBelt,
                    runway: fa?.actualRunwayOn,
                  ),
                  const Spacer(),
                  _Footer(
                    distanceKm: info.greatCircleDistance.km,
                    distanceUnit: distanceUnit,
                    registration: info.aircraft?.registration,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String? _statusText(FlightAwareDataEntity? fa) {
    if (fa?.cancelled == true) return 'CANCELLED';
    if (fa?.diverted == true) return 'DIVERTED';
    return null;
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.airline,
    required this.flightLine,
    required this.status,
  });
  final dynamic airline;
  final String flightLine;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final logo = airline.image as String?;
    final icao = airline.icao as String?;

    Widget logoWidget = const SizedBox(width: 38, height: 38);
    if (logo != null) {
      logoWidget = SvgPicture.network(logo, width: 38, height: 38);
    } else if (icao != null && icao.isNotEmpty) {
      logoWidget = CachedNetworkImage(
        imageUrl:
            'https://www.flightaware.com/images/airline_logos/180px/$icao.png',
        width: 38,
        height: 38,
        errorWidget: (_, __, ___) => const SizedBox.shrink(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoWidget,
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (airline.name as String?) ?? 'Airline',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              const Gap(3),
              Text(
                flightLine,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: ShareableFlightCard._faint,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (status != null) ...[
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: status == 'CANCELLED'
                  ? const Color(0xFFE53935)
                  : const Color(0xFFFB8C00),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status!,
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RouteBlock extends StatelessWidget {
  const _RouteBlock({
    required this.depCode,
    required this.arrCode,
    required this.depCity,
    required this.arrCity,
    required this.depTime,
    required this.arrTime,
    required this.depDelay,
    required this.arrDelay,
    required this.duration,
  });
  final String depCode;
  final String arrCode;
  final String depCity;
  final String arrCity;
  final String depTime;
  final String arrTime;
  final Duration? depDelay;
  final Duration? arrDelay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _Endpoint(
            code: depCode,
            city: depCity,
            time: depTime,
            delay: depDelay,
            alignEnd: false,
          ),
        ),
        SizedBox(
          width: 96,
          child: Padding(
            // align the path roughly with the centre of the IATA codes
            padding: const EdgeInsets.only(top: 22),
            child: _RouteLine(label: duration.toHumanReadable()),
          ),
        ),
        Expanded(
          child: _Endpoint(
            code: arrCode,
            city: arrCity,
            time: arrTime,
            delay: arrDelay,
            alignEnd: true,
          ),
        ),
      ],
    );
  }
}

class _Endpoint extends StatelessWidget {
  const _Endpoint({
    required this.code,
    required this.city,
    required this.time,
    required this.delay,
    required this.alignEnd,
  });
  final String code;
  final String city;
  final String time;
  final Duration? delay;
  final bool alignEnd;

  static const _codeStyle = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 54,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 1,
    letterSpacing: -1.5,
  );

  static const _cityStyle = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    color: ShareableFlightCard._muted,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  @override
  Widget build(BuildContext context) {
    final align = alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textAlign = alignEnd ? TextAlign.end : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(code, style: _codeStyle, textAlign: textAlign),
        const Gap(8),
        Text(
          city,
          style: _cityStyle,
          textAlign: textAlign,
          maxLines: 2,
          softWrap: true,
        ),
        const Gap(14),
        _TimeBlock(time: time, delay: delay, alignment: align),
      ],
    );
  }
}

class _Perforation extends StatelessWidget {
  const _Perforation();

  static const _height = 22.0;
  static const _notch = 18.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(color: ShareableFlightCard._bgTop),
          Positioned(
            left: -_notch / 2,
            top: (_height - _notch) / 2,
            child: Container(
              width: _notch,
              height: _notch,
              decoration: const BoxDecoration(
                color: ShareableFlightCard._bgBottom,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -_notch / 2,
            top: (_height - _notch) / 2,
            child: Container(
              width: _notch,
              height: _notch,
              decoration: const BoxDecoration(
                color: ShareableFlightCard._bgBottom,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Center(
              child: _DashedLine(color: Colors.white.withOpacity(0.22)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteLine extends StatelessWidget {
  const _RouteLine({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 11,
            color: ShareableFlightCard._faint,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const Gap(8),
        Row(
          children: [
            const Expanded(
                child: _DashedLine(color: ShareableFlightCard._line)),
            const Gap(6),
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.18)),
              ),
              child: Transform.rotate(
                angle: 1.5708,
                child: const Icon(
                  Icons.flight,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(6),
            const Expanded(
                child: _DashedLine(color: ShareableFlightCard._line)),
          ],
        ),
      ],
    );
  }
}

class _TimeBlock extends StatelessWidget {
  const _TimeBlock({
    required this.time,
    required this.delay,
    required this.alignment,
  });
  final String time;
  final Duration? delay;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final hasDelay = delay != null && delay != Duration.zero;
    final isEarly = hasDelay && delay!.isNegative;
    final color = !hasDelay
        ? ShareableFlightCard._faint
        : isEarly
            ? const Color(0xFF66BB6A)
            : const Color(0xFFEF5350);
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        if (hasDelay) ...[
          const Gap(2),
          Text(
            isEarly
                ? '${delay!.abs().toHumanReadable()} early'
                : '${delay!.toHumanReadable()} late',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ],
    );
  }
}

class _MetaGrid extends StatelessWidget {
  const _MetaGrid({
    required this.date,
    required this.duration,
    required this.aircraft,
  });
  final String date;
  final String duration;
  final String aircraft;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: _MetaCell(label: 'DATE', value: date)),
            Expanded(child: _MetaCell(label: 'DURATION', value: duration)),
          ],
        ),
        const Gap(14),
        _MetaCell(label: 'AIRCRAFT', value: aircraft),
      ],
    );
  }
}

class _MetaCell extends StatelessWidget {
  const _MetaCell({
    required this.label,
    required this.value,
    this.align = CrossAxisAlignment.start,
  });
  final String label;
  final String value;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: ShareableFlightCard._faint,
            letterSpacing: 1.4,
          ),
        ),
        const Gap(4),
        Text(
          value,
          softWrap: true,
          textAlign:
              align == CrossAxisAlignment.end ? TextAlign.end : TextAlign.start,
          style: const TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _AirportRow extends StatelessWidget {
  const _AirportRow({
    required this.side,
    required this.terminal,
    required this.gate,
    required this.baggage,
    required this.runway,
  });
  final String side;
  final String? terminal;
  final String? gate;
  final String? baggage;
  final String? runway;

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[
      _MetaCell(label: 'TERMINAL', value: _val(terminal)),
      _MetaCell(label: 'GATE', value: _val(gate)),
      _MetaCell(label: 'BAGGAGE', value: _val(baggage)),
      _MetaCell(
        label: 'RUNWAY',
        value: _val(runway),
        align: CrossAxisAlignment.end,
      ),
    ];

    final isDeparture = side == 'DEPARTURE';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 64,
          child: Row(
            children: [
              Icon(
                isDeparture ? Icons.flight_takeoff : Icons.flight_land,
                size: 13,
                color: ShareableFlightCard._faint,
              ),
              const Gap(6),
              Expanded(
                child: Text(
                  isDeparture ? 'DEP' : 'ARR',
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 9,
                    color: ShareableFlightCard._faint,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (var i = 0; i < cells.length; i++) Expanded(child: cells[i]),
      ],
    );
  }

  String _val(String? s) => (s == null || s.isEmpty) ? '—' : s;
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.distanceKm,
    required this.distanceUnit,
    required this.registration,
  });
  final String? distanceKm;
  final DistanceUnit distanceUnit;
  final String? registration;

  @override
  Widget build(BuildContext context) {
    final km = distanceKm != null ? double.tryParse(distanceKm!) : null;
    final distance = km != null
        ? '${formatDistance(km, distanceUnit)}  ·  ${formatDistance(km, nextOf(DistanceUnit.values, distanceUnit))}'
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DashedLine(color: Colors.white.withOpacity(0.12)),
        const Gap(14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'AERO',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: ShareableFlightCard._muted,
                letterSpacing: 3,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (registration != null && registration!.isNotEmpty) ...[
              const Gap(12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Text(
                  registration!,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: ShareableFlightCard._muted,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const Spacer(),
            if (distance != null)
              Text(
                distance,
                style: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 11,
                  color: ShareableFlightCard._faint,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            ),
          ),
        );
      },
    );
  }
}
