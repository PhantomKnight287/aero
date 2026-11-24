package fyi.procrastinator.aero.presentation.screens.detail

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.wear.compose.foundation.lazy.TransformingLazyColumn
import androidx.wear.compose.foundation.lazy.TransformingLazyColumnItemScope
import androidx.wear.compose.foundation.lazy.rememberTransformingLazyColumnState
import androidx.wear.compose.material3.ScreenScaffold
import androidx.wear.compose.material3.Text
import androidx.wear.compose.material3.lazy.TransformationSpec
import androidx.wear.compose.material3.lazy.rememberTransformationSpec
import androidx.wear.compose.material3.lazy.transformedHeight
import androidx.wear.compose.ui.tooling.preview.WearPreviewDevices
import fyi.procrastinator.aero.presentation.components.FlightArc
import fyi.procrastinator.aero.presentation.components.InfoRow
import fyi.procrastinator.aero.presentation.components.Panel
import fyi.procrastinator.aero.presentation.components.StatusDot
import fyi.procrastinator.aero.presentation.components.color
import fyi.procrastinator.aero.presentation.components.dotColor
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.model.Punctuality
import fyi.procrastinator.aero.presentation.model.SideUi
import fyi.procrastinator.aero.presentation.theme.AeroColors
import fyi.procrastinator.aero.presentation.theme.AeroText
import fyi.procrastinator.aero.presentation.theme.PreviewScaffold

/** One flight: arc and times up top, then departure, arrival, plane. */
@Composable
fun FlightDetailScreen(flight: FlightUi, startAt: Int = 0) {
    // [startAt] lets previews open scrolled down to the panels.
    val state = rememberTransformingLazyColumnState(initialAnchorItemIndex = startAt)
    val spec = rememberTransformationSpec()
    ScreenScaffold(scrollState = state) { padding ->
        TransformingLazyColumn(
            state = state,
            contentPadding = padding,
            verticalArrangement = Arrangement.spacedBy(6.dp),
        ) {
            item { Hero(flight, Modifier.fit(this, spec)) }
            item { Times(flight, Modifier.fit(this, spec)) }
            item {
                Column(
                    Modifier.fit(this, spec).padding(bottom = 4.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                ) {
                    Text(flight.idents, style = AeroText.label)
                    Text(flight.date, style = AeroText.label)
                }
            }
            item { SidePanel("Departure", flight.dep, departure = true, Modifier.panel(this, spec)) }
            item { SidePanel("Arrival", flight.arr, departure = false, Modifier.panel(this, spec)) }
            item {
                Panel(Modifier.panel(this, spec)) {
                    Text("FLIGHT", style = AeroText.label)
                    InfoRow("Duration", flight.duration)
                    InfoRow("Distance", flight.distance)
                    flight.aircraft?.let { InfoRow("Aircraft", it) }
                    val reg = listOfNotNull(flight.registration, flight.aircraftCode)
                    if (reg.isNotEmpty()) InfoRow("Reg", reg.joinToString(" · "))
                }
            }
            flight.inbound?.let { inbound ->
                item {
                    Panel(Modifier.panel(this, spec)) {
                        Text("INBOUND AIRCRAFT", style = AeroText.label)
                        Text("${inbound.ident} · ${inbound.route}", style = AeroText.body)
                        Text(
                            inbound.status,
                            style = AeroText.body.copy(color = inbound.punctuality.color()),
                        )
                    }
                }
            }
        }
    }
}

private fun Modifier.fit(scope: TransformingLazyColumnItemScope, spec: TransformationSpec) =
    fillMaxWidth().transformedHeight(scope, spec)

/** Panels sit a little in from the sides so the round edge doesn't clip them. */
private fun Modifier.panel(scope: TransformingLazyColumnItemScope, spec: TransformationSpec) =
    fit(scope, spec).padding(horizontal = 6.dp)

/** Arc with the status inside it and the codes under its feet. */
@Composable
private fun Hero(flight: FlightUi, modifier: Modifier) {
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally) {
        Box(Modifier.fillMaxWidth().aspectRatio(2.2f)) {
            FlightArc(flight.progress, Modifier.matchParentSize())
            Column(
                Modifier.align(Alignment.BottomCenter),
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    StatusDot(flight.dotColor())
                    Spacer(Modifier.width(5.dp))
                    Text(
                        flight.divertedTo?.let { "Diverted to $it" } ?: flight.phase.label,
                        style = AeroText.body.copy(
                            color = if (flight.progress == null) flight.dotColor()
                            else AeroColors.text,
                        ),
                    )
                }
                if (flight.statusLine != flight.phase.label) {
                    Text(flight.statusLine, style = AeroText.caption)
                }
            }
        }
        Row(
            Modifier.fillMaxWidth().padding(horizontal = 10.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            Text(flight.dep.code, style = AeroText.code)
            Text(flight.arr.code, style = AeroText.code)
        }
    }
}

/** Both clocks, coloured by punctuality, struck through when cancelled. */
@Composable
private fun Times(flight: FlightUi, modifier: Modifier) {
    Row(modifier.padding(horizontal = 12.dp), horizontalArrangement = Arrangement.SpaceBetween) {
        Clock(flight.dep, Alignment.Start)
        Clock(flight.arr, Alignment.End)
    }
}

@Composable
private fun Clock(side: SideUi, align: Alignment.Horizontal) {
    val cancelled = side.punctuality == Punctuality.Cancelled
    Column(horizontalAlignment = align) {
        Text(
            side.time,
            style = AeroText.clock.copy(
                color = side.punctuality.color(),
                textDecoration = if (cancelled) TextDecoration.LineThrough else null,
            ),
        )
        Text(
            side.delay,
            style = AeroText.caption.copy(
                color = if (side.punctuality == Punctuality.OnTime) AeroColors.muted
                else side.punctuality.color(),
            ),
        )
    }
}

@Composable
private fun SidePanel(title: String, side: SideUi, departure: Boolean, modifier: Modifier) {
    Panel(modifier) {
        Text("${title.uppercase()} · ${side.code}", style = AeroText.label)
        Text(
            listOfNotNull(side.city, side.icao).joinToString(" · "),
            style = AeroText.caption,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
        )
        Spacer(Modifier.height(2.dp))
        side.terminal?.let { InfoRow("Terminal", it) }
        side.gate?.let { InfoRow("Gate", it) }
        side.belt?.let { InfoRow("Belt", it) }
        side.runway?.let { InfoRow("Runway", it) }
        side.scheduled?.let { InfoRow("Sched.", it, AeroColors.muted) }
        InfoRow(
            if (departure) "Departs" else "Arrives",
            side.time,
            side.punctuality.color(),
        )
    }
}

@WearPreviewDevices
@Composable
fun DetailInFlightPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.inFlight) }

@WearPreviewDevices
@Composable
fun DetailLatePreview() = PreviewScaffold { FlightDetailScreen(MockFlights.late) }

@WearPreviewDevices
@Composable
fun DetailScheduledPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.scheduled) }

@WearPreviewDevices
@Composable
fun DetailArrivedPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.landed) }

@WearPreviewDevices
@Composable
fun DetailCancelledPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.cancelled) }

@WearPreviewDevices
@Composable
fun DetailPanelsPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.inFlight, startAt = 4) }

@WearPreviewDevices
@Composable
fun DetailAircraftPreview() = PreviewScaffold { FlightDetailScreen(MockFlights.late, startAt = 6) }
