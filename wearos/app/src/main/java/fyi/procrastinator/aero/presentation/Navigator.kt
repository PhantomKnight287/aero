package fyi.procrastinator.aero.presentation

import androidx.compose.runtime.Composable
import androidx.wear.compose.material3.AppScaffold
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.screens.detail.FlightDetailScreen
import fyi.procrastinator.aero.presentation.screens.list.FlightListScreen

/** List → detail, swipe right to go back. */
@Composable
fun AeroNavigator(flights: List<FlightUi>) {
    val nav = rememberSwipeDismissableNavController()
    AppScaffold {
        SwipeDismissableNavHost(navController = nav, startDestination = "list") {
            composable("list") {
                FlightListScreen(flights) { nav.navigate("flight/${it.id}") }
            }
            composable("flight/{id}") { entry ->
                flights.firstOrNull { it.id == entry.arguments?.getString("id") }
                    ?.let { FlightDetailScreen(it) }
            }
        }
    }
}
