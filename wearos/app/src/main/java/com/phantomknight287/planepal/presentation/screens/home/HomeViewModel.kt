package com.phantomknight287.planepal.presentation.screens.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.phantomknight287.planepal.PlanePalDatabase
import com.phantomknight287.planepal.entities.Flight
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