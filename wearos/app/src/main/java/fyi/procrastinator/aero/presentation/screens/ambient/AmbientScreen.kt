package fyi.procrastinator.aero.presentation.screens.ambient

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material3.Text
import androidx.wear.compose.ui.tooling.preview.WearPreviewDevices
import fyi.procrastinator.aero.presentation.components.FlightArc
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.theme.AeroColors
import fyi.procrastinator.aero.presentation.theme.AeroText
import fyi.procrastinator.aero.presentation.theme.AeroTheme
import java.time.Instant
import java.time.ZoneId
import java.time.format.DateTimeFormatter

/**
 * Wrist-down view: the current flight in hairlines, white and grey on
 * black, no colour fills. Redrawn once a minute; the whole thing drifts a
 * few pixels each minute so nothing burns in.
 */
@Composable
fun AmbientScreen(
    flight: FlightUi?,
    now: Instant,
    use24: Boolean,
    zone: ZoneId = ZoneId.systemDefault(),
) {
    val minute = now.epochSecond / 60
    val drift = ((minute % 5) - 2).toInt() * 2 // -4..4 dp, cycles every 5 min
    val clock = DateTimeFormatter.ofPattern(if (use24) "H:mm" else "h:mm")
        .format(now.atZone(zone))
    val dim = AeroText.caption.copy(color = AeroColors.muted)
    val bright = AeroText.body.copy(color = AeroColors.text)

    Box(
        Modifier.fillMaxSize().background(AeroColors.ink).offset(drift.dp, drift.dp),
        contentAlignment = Alignment.Center,
    ) {
        Text(
            clock,
            style = bright.copy(fontWeight = FontWeight.Medium),
            modifier = Modifier.align(Alignment.TopCenter).padding(top = 14.dp),
        )
        if (flight == null) {
            Text("No flight", style = dim)
            return@Box
        }
        Column(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            Text(flight.idents, style = AeroText.label)
            Box(Modifier.fillMaxWidth().aspectRatio(2.2f)) {
                FlightArc(flight.progress, Modifier.matchParentSize(), ambient = true)
                Text(
                    flight.statusLine,
                    style = bright,
                    modifier = Modifier.align(Alignment.BottomCenter),
                )
            }
            Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                Text(flight.dep.code, style = AeroText.code)
                Text(flight.arr.code, style = AeroText.code)
            }
            Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                Text(flight.dep.time, style = dim)
                Text(flight.arr.time, style = dim)
            }
        }
    }
}

private val previewNow = Instant.parse("2026-11-23T23:09:00Z")

@WearPreviewDevices
@Composable
fun AmbientInFlightPreview() = AeroTheme {
    AmbientScreen(MockFlights.inFlight, previewNow, use24 = true, zone = ZoneId.of("UTC"))
}

@WearPreviewDevices
@Composable
fun AmbientEmptyPreview() = AeroTheme { AmbientScreen(null, previewNow, use24 = true, zone = ZoneId.of("UTC")) }
