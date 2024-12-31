package com.phantomknight287.planepal.presentation

import android.os.Build
import android.widget.Toast
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.NavHostController
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.google.android.horologist.annotations.ExperimentalHorologistApi
import com.google.android.horologist.compose.layout.AppScaffold
import com.phantomknight287.planepal.presentation.screens.home.HomeScreen
import com.phantomknight287.planepal.presentation.theme.PlanePalTheme
import com.phantomknight287.planepal.PlanePalDatabase
import com.phantomknight287.planepal.presentation.screens.home.HomeViewModel


enum class PlanePalScreens {
    home,
    flight
}

@OptIn(ExperimentalHorologistApi::class)
@Composable
fun PlanePalApp(
    controller: NavHostController = rememberSwipeDismissableNavController(),
    sendMessageToPhone: (String, ByteArray) -> Unit,
    modifier: Modifier = Modifier,
    database: PlanePalDatabase,
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
                    val context = LocalContext.current
                    HomeScreen(
                        onSignInClicked = {
                            sendMessageToPhone("/sign-in-request", Build.MODEL.toByteArray())
                            Toast.makeText(context, "Check Your Phone", Toast.LENGTH_LONG).show()
                        },
                        viewModel = HomeViewModel(database)
                    )
                }

                composable(
                    route = PlanePalScreens.flight.name
                ) {

                }

            }
        }
    }
}