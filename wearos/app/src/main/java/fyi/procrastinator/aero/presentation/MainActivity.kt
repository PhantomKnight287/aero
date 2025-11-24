/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter to find the
 * most up to date changes to the libraries and their usages.
 */

package fyi.procrastinator.aero.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.lifecycle.ViewModelProvider
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.presentation.screens.home.HomeScreen
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModal
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModalFactory
import fyi.procrastinator.aero.presentation.theme.AeroTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)

        setTheme(android.R.style.Theme_DeviceDefault)
        val database = AeroDatabase.getDatabase(applicationContext)
        val homeScreenViewModel = ViewModelProvider(
            this,
            HomeViewModalFactory(database)
        )[HomeViewModal::class.java]

        setContent {
            AeroTheme {
                AeroNavigator()
                HomeScreen(
                    homeViewModal = homeScreenViewModel,
                )
            }
        }
    }
}
