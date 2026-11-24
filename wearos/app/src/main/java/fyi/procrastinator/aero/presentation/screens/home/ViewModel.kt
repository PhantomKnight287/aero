package fyi.procrastinator.aero.presentation.screens.home

import android.app.Application
import android.text.format.DateFormat
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.presentation.model.FlightStore
import fyi.procrastinator.aero.presentation.model.FlightUi
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn
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

    /** Latest rows, for re-mapping at an arbitrary time (ambient updates). */
    private val latest = rows.stateIn(viewModelScope, SharingStarted.Eagerly, emptyList())

    /**
     * Flights as of [now]. Ambient mode calls this on each once-a-minute
     * update; the 30 s ticker below may not run while the CPU sleeps.
     */
    fun flightsAt(now: Instant): List<FlightUi> {
        val use24 = DateFormat.is24HourFormat(getApplication())
        return latest.value.mapNotNull { FlightStore.toUi(it, now, use24) }
    }

    val flights: StateFlow<List<FlightUi>> = combine(rows, ticks) { list, now ->
        val use24 = DateFormat.is24HourFormat(getApplication())
        list.mapNotNull { FlightStore.toUi(it, now, use24) }
    }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), emptyList())
}
