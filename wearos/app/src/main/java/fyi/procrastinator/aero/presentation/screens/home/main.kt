package fyi.procrastinator.aero.presentation.screens.home

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.wear.compose.foundation.lazy.ScalingLazyColumn
import androidx.wear.compose.foundation.lazy.items
import androidx.wear.compose.foundation.lazy.rememberScalingLazyListState
import androidx.wear.compose.material.Text
import fyi.procrastinator.aero.presentation.screens.home.composables.TrackedFlight

@Composable
fun HomeScreen(
    homeViewModal: HomeViewModal,
    modifier: Modifier = Modifier
) {
    val flights by homeViewModal.flights.collectAsState()
    val columnState = rememberScalingLazyListState(
        initialCenterItemIndex = flights.size - 1,

    )
    ScalingLazyColumn(
        modifier = modifier,
        state = columnState,
    ){
        item {

            Text("Recently Tracked Flights")
        }
        items(flights){
            TrackedFlight(trackedFlightWithAirline = it)
        }
    }

}