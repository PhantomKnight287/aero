package fyi.procrastinator.aero.presentation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.State
import androidx.wear.compose.material3.AppScaffold
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.screens.detail.FlightDetailScreen
import fyi.procrastinator.aero.presentation.screens.list.FlightListScreen

/**
 * List → detail, swipe right to go back. Takes a [State], read inside each
 * destination: the nav graph is built once, so a plain list captured here
 * would stay the empty one from the first frame.
 */
@Composable
fun AeroNavigator(flights: State<List<FlightUi>>) {
    val nav = rememberSwipeDismissableNavController()
    AppScaffold {
        SwipeDismissableNavHost(navController = nav, startDestination = "list") {
            composable("list") {
                FlightListScreen(flights.value) { nav.navigate("flight/${it.id}") }
            }
            composable("flight/{id}") { entry ->
                flights.value.firstOrNull { it.id == entry.arguments?.getString("id") }
                    ?.let { FlightDetailScreen(it) }
            }
        }
    }
}
