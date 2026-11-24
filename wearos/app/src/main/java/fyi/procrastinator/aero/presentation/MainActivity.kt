package fyi.procrastinator.aero.presentation

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.text.format.DateFormat
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.core.content.ContextCompat
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.wear.ambient.AmbientLifecycleObserver
import coil3.ImageLoader
import coil3.compose.setSingletonImageLoaderFactory
import coil3.svg.SvgDecoder
import fyi.procrastinator.aero.presentation.model.FlightStore
import fyi.procrastinator.aero.presentation.screens.ambient.AmbientScreen
import fyi.procrastinator.aero.presentation.screens.home.HomeViewModel
import fyi.procrastinator.aero.presentation.theme.AeroTheme
import java.time.Instant

class MainActivity : ComponentActivity() {
    private val home: HomeViewModel by viewModels()

    /** Null when interactive; the time of the last ambient update otherwise. */
    private var ambientAt by mutableStateOf<Instant?>(null)

    private val ambient = AmbientLifecycleObserver(
        this,
        object : AmbientLifecycleObserver.AmbientLifecycleCallback {
            override fun onEnterAmbient(details: AmbientLifecycleObserver.AmbientDetails) {
                ambientAt = Instant.now()
            }

            override fun onUpdateAmbient() {
                ambientAt = Instant.now()
            }

            override fun onExitAmbient() {
                ambientAt = null
            }
        },
    )

    private val askNotifications =
        registerForActivityResult(ActivityResultContracts.RequestPermission()) { }

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        setTheme(android.R.style.Theme_DeviceDefault)
        lifecycle.addObserver(ambient)

        // Gate changes and delays notify; Wear OS 4+ asks once for that.
        if (Build.VERSION.SDK_INT >= 33 &&
            ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
            != PackageManager.PERMISSION_GRANTED
        ) {
            askNotifications.launch(Manifest.permission.POST_NOTIFICATIONS)
        }

        setContent {
            // Airline logos are SVGs; Coil needs the decoder registered.
            setSingletonImageLoaderFactory { ctx ->
                ImageLoader.Builder(ctx).components { add(SvgDecoder.Factory()) }.build()
            }
            val flights = home.flights.collectAsStateWithLifecycle()
            AeroTheme {
                val at = ambientAt
                if (at != null) {
                    AmbientScreen(
                        flight = FlightStore.current(home.flightsAt(at), at),
                        now = at,
                        use24 = DateFormat.is24HourFormat(this),
                    )
                } else {
                    AeroNavigator(flights)
                }
            }
        }
    }
}
