package fyi.procrastinator.aero.presentation.model

import android.content.Context
import android.text.format.DateFormat
import android.util.Log
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.database.entity.TrackedFlightWithAirline
import org.json.JSONObject
import java.time.Duration
import java.time.Instant

/** Stored flights as the UI sees them; shared by the app, tile and complication. */
object FlightStore {

    fun toUi(row: TrackedFlightWithAirline, now: Instant, use24: Boolean): FlightUi? =
        try {
            val a = row.airline
            FlightMapper.map(
                JSONObject(row.flight.payload),
                AirlineRef(a.name, a.iata, a.icao, a.image),
                now,
                use24,
            )
        } catch (e: Exception) {
            // A malformed row shouldn't blank everything else.
            Log.w("FlightStore", "Skipping flight ${row.flight.remoteId}", e)
            null
        }

    /** Every stored flight as of [now] (one DB read). */
    suspend fun all(context: Context, now: Instant): List<FlightUi> {
        val use24 = DateFormat.is24HourFormat(context)
        return AeroDatabase.getDatabase(context).trackedFlightDao().trackedFlightsOnce()
            .mapNotNull { toUi(it, now, use24) }
    }

    /** The rows themselves, for re-mapping one flight at several times. */
    suspend fun rows(context: Context) =
        AeroDatabase.getDatabase(context).trackedFlightDao().trackedFlightsOnce()

    /** How long a landed flight stays "current" on the tile and complication. */
    private val landedFor = Duration.ofHours(6)

    /**
     * The flight worth glancing at: one under way (taxiing, in the air or
     * about to leave), else the next departure (a cancelled one too: worth
     * knowing), else one that landed in the last [landedFor].
     */
    fun current(flights: List<FlightUi>, now: Instant): FlightUi? {
        val underWay = setOf(Phase.DepartsSoon, Phase.Taxiing, Phase.InFlight)
        flights.filter { it.phase in underWay }
            .minByOrNull { it.departsAt ?: Instant.MAX }
            ?.let { return it }
        flights.filter {
            (it.phase == Phase.Scheduled || it.phase == Phase.Cancelled) &&
                it.departsAt?.isAfter(now) == true
        }.minByOrNull { it.departsAt!! }?.let { return it }
        return flights.filter {
            (it.phase == Phase.Landed || it.phase == Phase.Arrived) &&
                it.arrivesAt != null && Duration.between(it.arrivesAt, now) < landedFor
        }.maxByOrNull { it.arrivesAt!! }
    }
}
