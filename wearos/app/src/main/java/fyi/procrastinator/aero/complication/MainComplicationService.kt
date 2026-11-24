package fyi.procrastinator.aero.complication

import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.drawable.Icon
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationText
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.CountDownTimeReference
import androidx.wear.watchface.complications.data.LongTextComplicationData
import androidx.wear.watchface.complications.data.MonochromaticImage
import androidx.wear.watchface.complications.data.NoDataComplicationData
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.RangedValueComplicationData
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.data.TimeDifferenceComplicationText
import androidx.wear.watchface.complications.data.TimeDifferenceStyle
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceUpdateRequester
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService
import fyi.procrastinator.aero.R
import fyi.procrastinator.aero.presentation.MainActivity
import fyi.procrastinator.aero.presentation.model.FlightStore
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.model.Phase
import java.time.Instant

/**
 * The current flight on any watch face. Short: countdown + code. Long:
 * route and countdown. Ranged: the progress ring. Countdowns are
 * TimeDifference texts, so the watch face redraws them every minute itself.
 */
class MainComplicationService : SuspendingComplicationDataSourceService() {

    override fun getPreviewData(type: ComplicationType): ComplicationData? =
        build(type, MockFlights.inFlight, tap = null)

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        val now = Instant.now()
        val flight = FlightStore.current(FlightStore.all(this, now), now)
        return build(request.complicationType, flight, openApp(this))
    }

    private fun build(type: ComplicationType, flight: FlightUi?, tap: PendingIntent?): ComplicationData? {
        if (flight == null) return NoDataComplicationData()
        val icon = MonochromaticImage.Builder(Icon.createWithResource(this, R.drawable.ic_flight)).build()
        val route = "${flight.dep.code}→${flight.arr.code}"
        val (countdown, short) = countdown(flight)
        val description = plain("${flight.ident} $route, ${flight.phase.label}")

        return when (type) {
            ComplicationType.SHORT_TEXT ->
                ShortTextComplicationData.Builder(short, description)
                    .setTitle(plain(if (flight.phase.beforeOff) flight.dep.code else flight.arr.code))
                    .setMonochromaticImage(icon)
                    .setTapAction(tap)
                    .build()

            ComplicationType.LONG_TEXT ->
                LongTextComplicationData.Builder(countdown, description)
                    .setTitle(plain("${flight.ident} · $route"))
                    .setMonochromaticImage(icon)
                    .setTapAction(tap)
                    .build()

            ComplicationType.RANGED_VALUE ->
                RangedValueComplicationData.Builder(
                    value = (flight.progress ?: 0f) * 100f,
                    min = 0f,
                    max = 100f,
                    contentDescription = description,
                )
                    .setText(short)
                    .setTitle(plain(flight.arr.code))
                    .setMonochromaticImage(icon)
                    .setTapAction(tap)
                    .build()

            else -> null
        }
    }

    /** (long text, short text) for where the flight stands. */
    private fun countdown(f: FlightUi): Pair<ComplicationText, ComplicationText> = when (f.phase) {
        Phase.Scheduled, Phase.DepartsSoon -> f.departsAt?.let {
            ticking(it, "Departs in ^1") to ticking(it, "^1")
        } ?: (plain(f.statusLine) to plain(f.dep.time))

        Phase.Taxiing, Phase.InFlight -> f.arrivesAt?.let {
            ticking(it, "^1 left") to ticking(it, "^1")
        } ?: (plain(f.statusLine) to plain(f.arr.time))

        Phase.Landed, Phase.Arrived -> plain(f.statusLine) to plain("Landed")
        Phase.Cancelled -> plain("Cancelled") to plain("Cncl")
        Phase.Diverted -> plain(f.divertedTo?.let { "Diverted to $it" } ?: "Diverted") to plain("Divert")
    }

    private val Phase.beforeOff get() = this == Phase.Scheduled || this == Phase.DepartsSoon

    private fun ticking(to: Instant, format: String) =
        TimeDifferenceComplicationText.Builder(
            TimeDifferenceStyle.SHORT_DUAL_UNIT,
            CountDownTimeReference(to),
        ).setText(format).build()

    private fun plain(s: String) = PlainComplicationText.Builder(s).build()

    private fun openApp(context: Context) = PendingIntent.getActivity(
        context,
        0,
        Intent(context, MainActivity::class.java),
        PendingIntent.FLAG_IMMUTABLE,
    )

    companion object {
        /** Ask every watch face showing this complication to refresh it. */
        fun refresh(context: Context) = ComplicationDataSourceUpdateRequester.create(
            context,
            ComponentName(context, MainComplicationService::class.java),
        ).requestUpdateAll()
    }
}
