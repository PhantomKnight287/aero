package com.phantomknight287.planepal.presentation

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.google.android.horologist.annotations.ExperimentalHorologistApi
import com.google.android.horologist.compose.layout.AppScaffold
import com.google.android.horologist.compose.layout.ScreenScaffold
import com.google.android.horologist.compose.layout.rememberResponsiveColumnState
import com.phantomknight287.planepal.presentation.screens.HomeScreen
import com.phantomknight287.planepal.presentation.theme.PlanePalTheme


enum class PlanePalScreens {
    home,
    flight
}

@OptIn(ExperimentalHorologistApi::class)
@Composable
fun PlanePalApp(
    controller: NavHostController = rememberSwipeDismissableNavController(),
    modifier: Modifier = Modifier,
) {
    PlanePalTheme {
        AppScaffold {
            SwipeDismissableNavHost(
                navController = controller,
                startDestination = PlanePalScreens.home.name, modifier = modifier,
            ) {
                composable(
                    route = PlanePalScreens.home.name
                ) {
                    HomeScreen()
                }

                composable(
                    route = PlanePalScreens.flight.name
                ) {

                }
            }
        }
    }
}