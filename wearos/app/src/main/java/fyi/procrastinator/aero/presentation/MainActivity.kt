package fyi.procrastinator.aero.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.runtime.getValue
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import coil3.ImageLoader
import coil3.compose.setSingletonImageLoaderFactory
import coil3.svg.SvgDecoder
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModel
import fyi.procrastinator.aero.presentation.theme.AeroTheme

class MainActivity : ComponentActivity() {
    private val home: HomeViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        setTheme(android.R.style.Theme_DeviceDefault)
        setContent {
            // Airline logos are SVGs; Coil needs the decoder registered.
            setSingletonImageLoaderFactory { ctx ->
                ImageLoader.Builder(ctx).components { add(SvgDecoder.Factory()) }.build()
            }
            val flights by home.flights.collectAsStateWithLifecycle()
            AeroTheme { AeroNavigator(flights) }
        }
    }
}
