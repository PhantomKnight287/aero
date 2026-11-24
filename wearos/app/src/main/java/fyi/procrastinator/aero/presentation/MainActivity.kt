package fyi.procrastinator.aero.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.theme.AeroTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        setTheme(android.R.style.Theme_DeviceDefault)
        setContent {
            AeroTheme {
                // ponytail: mock data until the phone sync is mapped to FlightUi
                // (HomeViewModal still holds the Room flights for that).
                AeroNavigator(MockFlights.all)
            }
        }
    }
}
