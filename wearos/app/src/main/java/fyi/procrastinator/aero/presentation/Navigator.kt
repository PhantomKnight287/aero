package fyi.procrastinator.aero.presentation

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModal
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModalFactory

@Composable
fun AeroNavigator(modifier: Modifier = Modifier) {
    val context = LocalContext.current
    val database = AeroDatabase.getDatabase(context.applicationContext)
    val homeScreenViewModel: HomeViewModal = viewModel(
        factory = HomeViewModalFactory(database)
    )
    val navController = rememberSwipeDismissableNavController()
}