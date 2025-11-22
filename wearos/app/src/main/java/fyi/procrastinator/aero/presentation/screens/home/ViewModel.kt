package fyi.procrastinator.aero.presentation.screens.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.database.entity.TrackedFlightWithAirline
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.stateIn

class HomeViewModal(private val database: AeroDatabase) : ViewModel() {
    val flights: StateFlow<List<TrackedFlightWithAirline>> =
        database.trackedFlightDao().getTrackedFlights()
            .stateIn(
                scope = viewModelScope,
                started = kotlinx.coroutines.flow.SharingStarted.WhileSubscribed(5000),
                initialValue = emptyList()
            )
}

class HomeViewModalFactory(private val database: AeroDatabase) : ViewModelProvider.Factory {
    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(HomeViewModal::class.java)) {
            return HomeViewModal(database) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}