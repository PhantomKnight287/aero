import 'package:aero/formatters/time.dart';
import 'package:openapi/openapi.dart';

/// Late means more than 15 minutes, as in the stats delay rules.
const lateCutoffMinutes = 15;

enum Punctuality { early, onTime, late, cancelled }

enum FlightPhase {
  scheduled,
  boardingSoon,
  taxiingOut,
  inFlight,
  landed,
  arrived,
  cancelled,
  diverted,
}

/// One side's gate times, all UTC. Formatting into a zone is the caller's
/// job (`formatClock` honours the user's time mode).
class SideTimes {
  final DateTime scheduled;

  /// Actual, else estimated/revised, else scheduled.
  final DateTime best;
  final bool isActual;
  final bool cancelled;

  const SideTimes(this.scheduled, this.best,
      {required this.isActual, this.cancelled = false});

  int get delayMinutes => best.difference(scheduled).inMinutes;

  Punctuality get punctuality {
    if (cancelled) return Punctuality.cancelled;
    if (delayMinutes > lateCutoffMinutes) return Punctuality.late;
    if (delayMinutes < 0) return Punctuality.early;
    return Punctuality.onTime;
  }
}

class LiveStatus {
  final FlightPhase phase;
  final SideTimes departure;
  final SideTimes arrival;

  /// FlightAware's destination when diverted somewhere other than planned.
  final String? divertedToIata;
  final DateTime? landedAt;

  const LiveStatus({
    required this.phase,
    required this.departure,
    required this.arrival,
    this.divertedToIata,
    this.landedAt,
  });

  Punctuality get overall => phase == FlightPhase.cancelled
      ? Punctuality.cancelled
      : arrival.punctuality;

  String bandText(DateTime now) {
    switch (phase) {
      case FlightPhase.scheduled:
        return 'Scheduled';
      case FlightPhase.boardingSoon:
        return 'Boarding soon';
      case FlightPhase.taxiingOut:
        return 'Taxiing';
      case FlightPhase.inFlight:
        return 'In flight';
      case FlightPhase.landed:
        return 'Landed ${_span(now.difference(landedAt ?? arrival.best))} ago';
      case FlightPhase.arrived:
        return 'Arrived at gate';
      case FlightPhase.cancelled:
        return 'Cancelled';
      case FlightPhase.diverted:
        return divertedToIata == null
            ? 'Diverted'
            : 'Diverted to $divertedToIata';
    }
  }

  /// Share of gate-to-gate time gone, 0..1; null when no bar fits.
  double? progress(DateTime now) {
    switch (phase) {
      case FlightPhase.cancelled:
      case FlightPhase.diverted:
        return null;
      case FlightPhase.landed:
      case FlightPhase.arrived:
        return 1;
      default:
        final total = arrival.best.difference(departure.best).inSeconds;
        if (total <= 0) return 0;
        return (now.difference(departure.best).inSeconds / total)
            .clamp(0.0, 1.0);
    }
  }

  /// Countdown under the bar ends: ('departed 2h 10m ago', '4h 8m left').
  (String, String?)? barCaption(DateTime now) {
    switch (phase) {
      case FlightPhase.scheduled:
      case FlightPhase.boardingSoon:
        return departure.best.isAfter(now)
            ? ('departs in ${_span(departure.best.difference(now))}', null)
            : null;
      case FlightPhase.taxiingOut:
      case FlightPhase.inFlight:
        return (
          'departed ${_span(now.difference(departure.best))} ago',
          arrival.best.isAfter(now)
              ? '${_span(arrival.best.difference(now))} left'
              : 'landing now',
        );
      default:
        return null;
    }
  }

  /// '7m late · departed 2h 10m ago', '3m early · arrives in 4h 13m'.
  String sideLine(bool isDeparture, DateTime now) {
    final s = isDeparture ? departure : arrival;
    if (phase == FlightPhase.cancelled) return 'Cancelled';
    final d = s.delayMinutes;
    final head = d > 0
        ? '${_span(Duration(minutes: d))} late'
        : d < 0
            ? '${_span(Duration(minutes: -d))} early'
            : 'On time';
    final past = !s.best.isAfter(now);
    final verb = isDeparture
        ? (past ? 'departed' : 'departs in')
        : (past ? 'arrived' : 'arrives in');
    final span = _span((s.best.difference(now)).abs());
    return past ? '$head · $verb $span ago' : '$head · $verb $span';
  }
}

String _span(Duration d) => formatLongDuration(d.inMinutes.abs());

DateTime _utc(TimeEntity t) => DateTime.parse(t.utc).toUtc();

LiveStatus flightStatus(FlightResponseEntity f, DateTime now) {
  final fa = f.flightAwareData;
  final cancelled = fa?.cancelled ?? false;

  SideTimes sideOf(RouteInfoEntity r, DateTime? faSched, DateTime? faEst,
      DateTime? faActual) {
    final sched = faSched ?? _utc(r.scheduledTime);
    final est = faEst ?? (r.revisedTime == null ? null : _utc(r.revisedTime!));
    return SideTimes(sched, faActual ?? est ?? sched,
        isActual: faActual != null, cancelled: cancelled);
  }

  final dep =
      sideOf(f.departure, fa?.scheduledOut, fa?.estimatedOut, fa?.actualOut);
  final arr = sideOf(f.arrival, fa?.scheduledIn, fa?.estimatedIn, fa?.actualIn);

  final planned = f.arrival.airport.iata;
  final dest = fa?.destinationCodeIata;
  final divertedTo =
      dest != null && dest.isNotEmpty && dest != planned ? dest : null;

  FlightPhase phase;
  if (cancelled) {
    phase = FlightPhase.cancelled;
  } else if (fa?.diverted ?? false) {
    phase = FlightPhase.diverted;
  } else if (fa?.actualIn != null) {
    phase = FlightPhase.arrived;
  } else if (fa?.actualOn != null) {
    phase = FlightPhase.landed;
  } else if (fa?.actualOff != null) {
    phase = FlightPhase.inFlight;
  } else if (fa?.actualOut != null) {
    phase = FlightPhase.taxiingOut;
  } else if (now.isBefore(dep.best.subtract(const Duration(minutes: 40)))) {
    phase = FlightPhase.scheduled;
  } else if (now.isBefore(dep.best)) {
    phase = FlightPhase.boardingSoon;
  } else if (now.isBefore(arr.best)) {
    // No pushback seen (or a stale snapshot): go by the clock.
    phase = FlightPhase.inFlight;
  } else {
    phase = FlightPhase.arrived;
  }

  return LiveStatus(
    phase: phase,
    departure: dep,
    arrival: arr,
    divertedToIata: divertedTo,
    landedAt: fa?.actualOn,
  );
}
