package fyi.procrastinator.aero.presentation.screens.home

import android.app.Application
import android.text.format.DateFormat
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.database.entity.TrackedFlightWithAirline
import fyi.procrastinator.aero.presentation.model.AirlineRef
import fyi.procrastinator.aero.presentation.model.FlightMapper
import fyi.procrastinator.aero.presentation.model.FlightUi
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn
import org.json.JSONObject
import java.time.Instant

/**
 * Flights the phone sent, as the screens draw them. Re-mapped every 30 s:
 * countdowns, progress and phase are worked out from the clock here, so
 * they keep moving away from the phone.
 */
class HomeViewModel(app: Application) : AndroidViewModel(app) {
    private val rows = AeroDatabase.getDatabase(app).trackedFlightDao().getTrackedFlights()

    private val ticks = flow {
        while (true) {
            emit(Instant.now())
            delay(30_000)
        }
    }

    val flights: StateFlow<List<FlightUi>> = combine(rows, ticks) { list, now ->
        val use24 = DateFormat.is24HourFormat(getApplication())
        list.mapNotNull { toUi(it, now, use24) }
    }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), emptyList())

    private fun toUi(row: TrackedFlightWithAirline, now: Instant, use24: Boolean): FlightUi? =
        try {
            val a = row.airline
            FlightMapper.map(
                JSONObject(row.flight.payload),
                AirlineRef(a.name, a.iata, a.icao, a.image),
                now,
                use24,
            )
        } catch (e: Exception) {
            // A malformed row shouldn't blank the whole list.
            Log.w("HomeViewModel", "Skipping flight ${row.flight.remoteId}", e)
            null
        }
}
