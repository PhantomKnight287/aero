package fyi.procrastinator.aero.tile

import android.content.Context
import android.text.format.DateFormat
import androidx.wear.protolayout.ActionBuilders
import androidx.wear.protolayout.ColorBuilders.argb
import androidx.wear.protolayout.DeviceParametersBuilders.DeviceParameters
import androidx.wear.protolayout.DimensionBuilders.dp
import androidx.wear.protolayout.LayoutElementBuilders
import androidx.wear.protolayout.LayoutElementBuilders.Column
import androidx.wear.protolayout.LayoutElementBuilders.LayoutElement
import androidx.wear.protolayout.LayoutElementBuilders.Row
import androidx.wear.protolayout.LayoutElementBuilders.Spacer
import androidx.wear.protolayout.ModifiersBuilders
import androidx.wear.protolayout.ResourceBuilders
import androidx.wear.protolayout.TimelineBuilders
import androidx.wear.protolayout.TimelineBuilders.TimeInterval
import androidx.wear.protolayout.material.CircularProgressIndicator
import androidx.wear.protolayout.material.ProgressIndicatorColors
import androidx.wear.protolayout.material.Text
import androidx.wear.protolayout.material.Typography
import androidx.wear.protolayout.material.layouts.EdgeContentLayout
import androidx.wear.protolayout.material.layouts.PrimaryLayout
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import androidx.wear.tiles.tooling.preview.Preview
import androidx.wear.tiles.tooling.preview.TilePreviewData
import androidx.wear.tooling.preview.devices.WearDevices
import com.google.android.horologist.annotations.ExperimentalHorologistApi
import com.google.android.horologist.tiles.SuspendingTileService
import fyi.procrastinator.aero.presentation.MainActivity
import fyi.procrastinator.aero.presentation.model.FlightStore
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.model.Phase
import fyi.procrastinator.aero.presentation.model.Punctuality
import java.time.Duration
import java.time.Instant

private const val RESOURCES_VERSION = "1"

/** Timeline step and reach: countdowns stay right without waking the app. */
private val STEP = Duration.ofMinutes(5)
private val REACH = Duration.ofHours(2)

/**
 * The current flight at a glance: progress ring round the edge, codes,
 * status and both clocks. Tapping opens the app.
 */
@OptIn(ExperimentalHorologistApi::class)
class MainTileService : SuspendingTileService() {

    override suspend fun resourcesRequest(requestParams: RequestBuilders.ResourcesRequest) =
        resources()

    override suspend fun tileRequest(requestParams: RequestBuilders.TileRequest): TileBuilders.Tile {
        val now = Instant.now()
        val use24 = DateFormat.is24HourFormat(this)
        val rows = FlightStore.rows(this)
        val device = requestParams.deviceConfiguration

        // One entry per step, each mapped at its own start time, so phase,
        // countdown and ring are right whenever the tile is looked at.
        val timeline = TimelineBuilders.Timeline.Builder()
        var t = now
        while (t.isBefore(now.plus(REACH))) {
            val flights = rows.mapNotNull { FlightStore.toUi(it, t, use24) }
            val flight = FlightStore.current(flights, t)
            timeline.addTimelineEntry(
                TimelineBuilders.TimelineEntry.Builder()
                    .setValidity(
                        TimeInterval.Builder()
                            .setStartMillis(t.toEpochMilli())
                            .setEndMillis(t.plus(STEP).toEpochMilli())
                            .build()
                    )
                    .setLayout(layoutOf(tileLayout(this, device, flight)))
                    .build()
            )
            t = t.plus(STEP)
        }
        return TileBuilders.Tile.Builder()
            .setResourcesVersion(RESOURCES_VERSION)
            .setTileTimeline(timeline.build())
            .setFreshnessIntervalMillis(REACH.toMillis())
            .build()
    }

    companion object {
        /** Ask the system to redraw the tile (new data from the phone). */
        fun refresh(context: Context) =
            TileService.getUpdater(context).requestUpdate(MainTileService::class.java)
    }
}

private fun resources() = ResourceBuilders.Resources.Builder()
    .setVersion(RESOURCES_VERSION)
    .build()

private fun layoutOf(root: LayoutElement) =
    LayoutElementBuilders.Layout.Builder().setRoot(root).build()

// Same palette as the app (theme/Theme.kt), as ARGB ints for protolayout.
private val TEXT = 0xFFFFFFFF.toInt()
private val MUTED = 0xFF8E8E93.toInt()
private val TRACK = 0xFF3A3A3C.toInt()
private val SUCCESS = 0xFF4CAF50.toInt()
private val DANGER = 0xFFEF5350.toInt()
private val WARN = 0xFFFFA726.toInt()

private fun Punctuality.argb() = when (this) {
    Punctuality.Early -> SUCCESS
    Punctuality.Late, Punctuality.Cancelled -> DANGER
    Punctuality.OnTime -> TEXT
}

private fun FlightUi.statusColour() = when {
    phase == Phase.Cancelled || phase == Phase.Diverted -> DANGER
    overall == Punctuality.Late -> WARN
    else -> SUCCESS
}

private fun text(context: Context, s: String, typography: Int, colour: Int) =
    Text.Builder(context, s)
        .setTypography(typography)
        .setColor(argb(colour))
        .setMaxLines(1)
        .build()

private fun openApp(context: Context) = ModifiersBuilders.Modifiers.Builder()
    .setClickable(
        ModifiersBuilders.Clickable.Builder()
            .setId("open")
            .setOnClick(
                ActionBuilders.LaunchAction.Builder()
                    .setAndroidActivity(
                        ActionBuilders.AndroidActivity.Builder()
                            .setPackageName(context.packageName)
                            .setClassName(MainActivity::class.java.name)
                            .build()
                    )
                    .build()
            )
            .build()
    )
    .build()

internal fun tileLayout(context: Context, device: DeviceParameters, flight: FlightUi?): LayoutElement {
    if (flight == null) {
        return PrimaryLayout.Builder(device)
            .setResponsiveContentInsetEnabled(true)
            .setPrimaryLabelTextContent(text(context, "Aero", Typography.TYPOGRAPHY_CAPTION1, MUTED))
            .setContent(
                Column.Builder()
                    .addContent(text(context, "No flights", Typography.TYPOGRAPHY_TITLE3, TEXT))
                    .addContent(
                        text(context, "Send one from your phone", Typography.TYPOGRAPHY_CAPTION2, MUTED)
                    )
                    .setModifiers(openApp(context))
                    .build()
            )
            .build()
    }

    val ring = CircularProgressIndicator.Builder()
        .setProgress(flight.progress ?: 0f)
        .setCircularProgressIndicatorColors(
            ProgressIndicatorColors(
                argb(TEXT),
                argb(if (flight.progress == null) DANGER else TRACK),
            )
        )
        .build()

    val status = flight.divertedTo?.let { "Diverted to $it" }
        ?: if (flight.statusLine == flight.phase.label) flight.statusLine
        else "${flight.phase.label} · ${flight.statusLine}"

    val clocks = Row.Builder()
        .addContent(
            text(context, flight.dep.time, Typography.TYPOGRAPHY_BODY1, flight.dep.punctuality.argb())
        )
        .addContent(text(context, "  →  ", Typography.TYPOGRAPHY_BODY1, MUTED))
        .addContent(
            text(context, flight.arr.time, Typography.TYPOGRAPHY_BODY1, flight.arr.punctuality.argb())
        )
        .build()

    return EdgeContentLayout.Builder(device)
        .setResponsiveContentInsetEnabled(true)
        .setEdgeContent(ring)
        .setPrimaryLabelTextContent(
            text(context, "${flight.ident} · ${flight.date}", Typography.TYPOGRAPHY_CAPTION2, MUTED)
        )
        .setContent(
            Column.Builder()
                .addContent(
                    text(
                        context,
                        "${flight.dep.code} → ${flight.arr.code}",
                        Typography.TYPOGRAPHY_TITLE2,
                        TEXT,
                    )
                )
                .addContent(text(context, status, Typography.TYPOGRAPHY_CAPTION1, flight.statusColour()))
                .addContent(Spacer.Builder().setHeight(dp(4f)).build())
                .addContent(clocks)
                .setModifiers(openApp(context))
                .build()
        )
        .setSecondaryLabelTextContent(
            text(
                context,
                listOfNotNull(flight.dep.gate?.let { "Gate $it" }, flight.aircraftCode)
                    .joinToString(" · ").ifEmpty { flight.airline },
                Typography.TYPOGRAPHY_CAPTION2,
                MUTED,
            )
        )
        .build()
}

private fun previewOf(context: Context, flight: FlightUi?) = TilePreviewData({ resources() }) {
    TileBuilders.Tile.Builder()
        .setResourcesVersion(RESOURCES_VERSION)
        .setTileTimeline(
            TimelineBuilders.Timeline.fromLayoutElement(
                tileLayout(context, it.deviceConfiguration, flight)
            )
        )
        .build()
}

@Preview(device = WearDevices.SMALL_ROUND)
@Preview(device = WearDevices.LARGE_ROUND)
fun tileInFlightPreview(context: Context) = previewOf(context, MockFlights.inFlight)

@Preview(device = WearDevices.LARGE_ROUND)
fun tileLatePreview(context: Context) = previewOf(context, MockFlights.late)

@Preview(device = WearDevices.LARGE_ROUND)
fun tileCancelledPreview(context: Context) = previewOf(context, MockFlights.cancelled)

@Preview(device = WearDevices.LARGE_ROUND)
fun tileEmptyPreview(context: Context) = previewOf(context, null)
