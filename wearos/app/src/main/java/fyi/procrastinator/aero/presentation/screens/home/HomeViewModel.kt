package fyi.procrastinator.aero.presentation.screens.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import fyi.procrastinator.aero.PlanePalDatabase
import fyi.procrastinator.aero.entities.Flight
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.stateIn

class HomeViewModel(private val database: PlanePalDatabase) : ViewModel() {
    val flights: StateFlow<List<Flight>> = database.flightsDao().getAllFlights()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = emptyList()
        )
}