package fyi.procrastinator.aero.presentation.screens.list

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.wear.compose.foundation.lazy.TransformingLazyColumn
import androidx.wear.compose.foundation.lazy.items
import androidx.wear.compose.foundation.lazy.rememberTransformingLazyColumnState
import androidx.wear.compose.material3.Card
import androidx.wear.compose.material3.CardDefaults
import androidx.wear.compose.material3.Icon
import androidx.wear.compose.material3.ListHeader
import androidx.wear.compose.material3.ScreenScaffold
import androidx.wear.compose.material3.SurfaceTransformation
import androidx.wear.compose.material3.Text
import androidx.wear.compose.material3.lazy.rememberTransformationSpec
import androidx.wear.compose.material3.lazy.transformedHeight
import androidx.wear.compose.ui.tooling.preview.WearPreviewDevices
import androidx.wear.compose.ui.tooling.preview.WearPreviewFontScales
import fyi.procrastinator.aero.R
import fyi.procrastinator.aero.presentation.components.AirlineMark
import fyi.procrastinator.aero.presentation.components.StatusDot
import fyi.procrastinator.aero.presentation.components.dotColor
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.theme.AeroColors
import fyi.procrastinator.aero.presentation.theme.AeroText
import fyi.procrastinator.aero.presentation.theme.PreviewScaffold
import fyi.procrastinator.aero.presentation.theme.CalSans

/** Flights sent from the phone, newest first. */
@Composable
fun FlightListScreen(flights: List<FlightUi>, onOpen: (FlightUi) -> Unit) {
    val state = rememberTransformingLazyColumnState()
    val spec = rememberTransformationSpec()
    ScreenScaffold(scrollState = state) { padding ->
        if (flights.isEmpty()) {
            EmptyState()
            return@ScreenScaffold
        }
        TransformingLazyColumn(state = state, contentPadding = padding) {
            item {
                ListHeader(
                    modifier = Modifier.fillMaxWidth().transformedHeight(this, spec),
                    transformation = SurfaceTransformation(spec),
                ) {
                    Text("Flights", fontFamily = CalSans)
                }
            }
            items(flights, key = { it.id }) { f ->
                FlightCard(
                    flight = f,
                    onClick = { onOpen(f) },
                    modifier = Modifier.fillMaxWidth().transformedHeight(this, spec),
                    transformation = SurfaceTransformation(spec),
                )
            }
        }
    }
}

@Composable
private fun FlightCard(
    flight: FlightUi,
    onClick: () -> Unit,
    modifier: Modifier,
    transformation: SurfaceTransformation,
) {
    Card(
        onClick = onClick,
        modifier = modifier,
        transformation = transformation,
        colors = CardDefaults.cardColors(containerColor = AeroColors.panel),
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                AirlineMark(flight.airlineIata, flight.logoUrl, size = 18)
                Spacer(Modifier.width(6.dp))
                Text(
                    "${flight.ident} · ${flight.date}",
                    style = AeroText.label,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )
            }
            Text("${flight.dep.code} → ${flight.arr.code}", style = AeroText.code)
            Row(verticalAlignment = Alignment.CenterVertically) {
                StatusDot(flight.dotColor())
                Spacer(Modifier.width(6.dp))
                Text(
                    "${flight.phase.label} · ${flight.statusLine}".let {
                        // 'Cancelled · Cancelled' reads twice; say it once.
                        if (flight.statusLine == flight.phase.label) flight.statusLine else it
                    },
                    style = AeroText.caption.copy(color = AeroColors.text),
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )
            }
        }
    }
}

@Composable
private fun EmptyState() {
    Box(Modifier.fillMaxSize().padding(24.dp), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(
                painterResource(R.drawable.ic_flight),
                contentDescription = null,
                tint = AeroColors.muted,
                modifier = Modifier.size(24.dp),
            )
            Spacer(Modifier.size(8.dp))
            Text("No flights yet", style = AeroText.body, textAlign = TextAlign.Center)
            Text(
                "Open a flight on your phone and tap Send to wearable.",
                style = AeroText.caption,
                textAlign = TextAlign.Center,
            )
        }
    }
}

@WearPreviewDevices
@WearPreviewFontScales
@Composable
fun FlightListPreview() = PreviewScaffold { FlightListScreen(MockFlights.all) {} }

@WearPreviewDevices
@Composable
fun FlightListEmptyPreview() = PreviewScaffold { FlightListScreen(emptyList()) {} }
