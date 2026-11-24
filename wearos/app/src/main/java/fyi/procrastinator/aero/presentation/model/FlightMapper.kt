package fyi.procrastinator.aero.presentation.model

import org.json.JSONObject
import java.time.Duration
import java.time.Instant
import java.time.ZoneId
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlin.math.abs

/**
 * Turns the phone's `flight` payload (v2, see app/lib/services/wear_payload.dart)
 * into what the screens draw, as of [now]. Phase and punctuality follow the
 * phone's flight_status.dart so both devices say the same thing.
 */
object FlightMapper {

    /** Late means more than 15 minutes, as on the phone. */
    private const val LATE_CUTOFF_MIN = 15

    fun map(
        flight: JSONObject,
        airline: AirlineRef,
        now: Instant,
        use24: Boolean,
    ): FlightUi? {
        val dep = flight.optJSONObject("dep") ?: return null
        val arr = flight.optJSONObject("arr") ?: return null
        val depSched = dep.instant("sched") ?: return null
        val arrSched = arr.instant("sched") ?: return null
        val depBest = dep.instant("best") ?: depSched
        val arrBest = arr.instant("best") ?: arrSched
        val cancelled = flight.optBoolean("cancelled")
        val diverted = flight.optBoolean("diverted")
        val inAt = flight.instant("in")
        val onAt = flight.instant("on")

        val phase = when {
            cancelled -> Phase.Cancelled
            diverted -> Phase.Diverted
            inAt != null -> Phase.Arrived
            onAt != null -> Phase.Landed
            flight.instant("off") != null -> Phase.InFlight
            flight.instant("out") != null -> Phase.Taxiing
            now.isBefore(depBest.minus(Duration.ofMinutes(40))) -> Phase.Scheduled
            now.isBefore(depBest) -> Phase.DepartsSoon
            // No pushback seen (or a stale snapshot): go by the clock.
            now.isBefore(arrBest) -> Phase.InFlight
            else -> Phase.Arrived
        }

        val total = Duration.between(depBest, arrBest).seconds
        val progress = when (phase) {
            Phase.Cancelled, Phase.Diverted -> null
            Phase.Landed, Phase.Arrived -> 1f
            else -> if (total <= 0) 0f
            else (Duration.between(depBest, now).seconds.toFloat() / total).coerceIn(0f, 1f)
        }

        fun until(t: Instant) = span(Duration.between(now, t))
        fun since(t: Instant) = span(Duration.between(t, now))
        val depZone = zone(dep.str("tz"))
        val statusLine = when (phase) {
            Phase.Scheduled -> "Departs ${clock(depBest, depZone, use24)}"
            Phase.DepartsSoon -> "Departs in ${until(depBest)}"
            Phase.Taxiing, Phase.InFlight ->
                if (arrBest.isAfter(now)) "${until(arrBest)} left" else "Landing now"
            Phase.Landed -> "Landed ${since(onAt ?: arrBest)} ago"
            Phase.Arrived -> "Arrived ${since(inAt ?: arrBest)} ago"
            Phase.Cancelled -> "Cancelled"
            Phase.Diverted -> "Diverted"
        }
        val sinceLine = when (phase) {
            Phase.Scheduled, Phase.DepartsSoon -> "departs in ${until(depBest)}"
            Phase.Taxiing, Phase.InFlight -> "departed ${since(depBest)} ago"
            else -> null
        }

        return FlightUi(
            id = flight.str("id") ?: flight.optString("flightNo"),
            airline = airline.name ?: airline.iata ?: "",
            airlineIata = airline.iata ?: airline.icao ?: "",
            logoUrl = airline.image ?: airline.pngUrl,
            logoFallbackUrl = airline.pngUrl.takeIf { airline.image != null },
            ident = flight.str("identIata") ?: flight.optString("flightNo"),
            identIcao = flight.str("identIcao"),
            date = DateTimeFormatter.ofPattern("EEE d MMM", Locale.ENGLISH)
                .format(depSched.atZone(depZone ?: ZoneOffset.UTC))
                .uppercase(Locale.ENGLISH),
            dep = side(dep, depSched, depBest, cancelled, use24),
            arr = side(arr, arrSched, arrBest, cancelled, use24),
            phase = phase,
            progress = progress,
            sinceLine = sinceLine,
            statusLine = statusLine,
            duration = if (cancelled) "—" else span(Duration.between(depBest, arrBest)),
            distance = flight.str("distance") ?: "—",
            aircraft = flight.str("aircraft"),
            aircraftCode = flight.str("aircraftCode"),
            registration = flight.str("registration"),
            inbound = flight.optJSONObject("inbound")?.let { inbound(it, use24) },
            divertedTo = flight.str("divertedTo"),
        )
    }

    private fun side(
        j: JSONObject,
        sched: Instant,
        best: Instant,
        cancelled: Boolean,
        use24: Boolean,
    ): SideUi {
        val z = zone(j.str("tz"))
        val delay = Duration.between(sched, best).toMinutes().toInt()
        return SideUi(
            code = j.str("code") ?: "—",
            icao = j.str("icao")?.takeIf { it != j.str("code") },
            city = j.str("city") ?: "",
            time = clock(best, z, use24),
            scheduled = if (best != sched && !cancelled) clock(sched, z, use24) else null,
            delay = if (cancelled) "Cancelled" else delayLabel(delay),
            punctuality = punctuality(delay, cancelled),
            gate = j.str("gate"),
            terminal = j.str("terminal"),
            belt = j.str("belt"),
            runway = j.str("runway"),
        )
    }

    private fun inbound(j: JSONObject, use24: Boolean): InboundUi {
        val delay = j.optInt("delayMin")
        val cancelled = j.optBoolean("cancelled")
        val arrival = j.instant("arrival")
        val status = when {
            cancelled -> "Cancelled"
            j.optBoolean("arrived") -> "Arrived ${delayLabel(delay).lowercase()}"
            arrival != null ->
                "Lands ${clock(arrival, zone(j.str("tz")), use24)}, ${delayLabel(delay).lowercase()}"
            else -> delayLabel(delay)
        }
        return InboundUi(
            route = "${j.str("from") ?: "—"} → ${j.str("to") ?: "—"}",
            ident = j.str("ident") ?: "",
            status = status,
            punctuality = punctuality(delay, cancelled),
        )
    }

    fun punctuality(delayMin: Int, cancelled: Boolean) = when {
        cancelled -> Punctuality.Cancelled
        delayMin > LATE_CUTOFF_MIN -> Punctuality.Late
        delayMin < 0 -> Punctuality.Early
        else -> Punctuality.OnTime
    }

    fun delayLabel(min: Int) = when {
        min > 0 -> "${span(Duration.ofMinutes(min.toLong()))} late"
        min < 0 -> "${span(Duration.ofMinutes(-min.toLong()))} early"
        else -> "On time"
    }

    /** '38m', '7h 34m', '2d 3h' — the phone's formatLongDuration. */
    fun span(d: Duration): String {
        val m = abs(d.toMinutes())
        if (m < 60) return "${m}m"
        if (m >= 1440) {
            val h = Math.round(m / 60.0)
            return "${h / 24}d ${h % 24}h"
        }
        return "${m / 60}h ${m % 60}m"
    }

    /** Local time at the airport; UTC with a Z when its zone is unknown. */
    fun clock(t: Instant, zone: ZoneId?, use24: Boolean): String {
        if (zone == null) {
            return DateTimeFormatter.ofPattern("HH:mm").format(t.atZone(ZoneOffset.UTC)) + "Z"
        }
        val pattern = if (use24) "H:mm" else "h:mm a"
        return DateTimeFormatter.ofPattern(pattern, Locale.ENGLISH).format(t.atZone(zone))
    }

    private fun zone(id: String?): ZoneId? =
        id?.let { runCatching { ZoneId.of(it) }.getOrNull() }

    private fun JSONObject.str(key: String): String? =
        if (isNull(key)) null else optString(key).takeIf { it.isNotBlank() && it != "null" }

    private fun JSONObject.instant(key: String): Instant? =
        str(key)?.let { runCatching { Instant.parse(it) }.getOrNull() }
}

/** The airline row the listener stores next to the flight. */
data class AirlineRef(
    val name: String?,
    val iata: String?,
    val icao: String?,
    val image: String?,
) {
    /** FlightAware's PNG by ICAO: the fallback when our SVG is missing or fails. */
    val pngUrl: String?
        get() = icao?.let { "https://www.flightaware.com/images/airline_logos/180px/$it.png" }
}
