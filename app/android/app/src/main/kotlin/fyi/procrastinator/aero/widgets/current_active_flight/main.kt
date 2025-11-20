package fyi.procrastinator.aero.widgets.current_active_flight

import HomeWidgetGlanceState
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.glance.GlanceId
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import HomeWidgetGlanceStateDefinition
import android.graphics.Bitmap
import android.util.Log
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.Image
import androidx.glance.appwidget.ImageProvider
import androidx.glance.color.ColorProvider
import androidx.glance.currentState
import androidx.glance.layout.Column
import androidx.glance.state.GlanceStateDefinition
import androidx.core.net.toUri
import androidx.glance.ColorFilter
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.ImageProvider
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxHeight
import androidx.glance.layout.height
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.layout.padding
import androidx.glance.layout.wrapContentHeight
import androidx.glance.preview.ExperimentalGlancePreviewApi
import androidx.glance.preview.Preview
import androidx.glance.text.FontFamily
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import coil3.imageLoader
import coil3.request.CachePolicy
import coil3.request.ErrorResult
import coil3.request.ImageRequest
import fyi.procrastinator.aero.R
import java.util.Locale
import coil3.request.SuccessResult
import coil3.toBitmap

class CurrentActiveFlight : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            RenderWidget(context, currentState())
        }
    }

    @Composable
    private fun RenderWidget(context: Context, currentState: HomeWidgetGlanceState) {
        val prefs = currentState.preferences
        val airlineLogo = prefs.getString("airline_logo", null)
        val flightNumberIata = prefs.getString("flight_number_iata", null)
        val flightNumberIcao = prefs.getString("flight_number_icao", null)
        val destinationName = prefs.getString("destination", null)
        val arrivalAirportCode = prefs.getString("arrival_airport_code", null)
        val departureAirportCode = prefs.getString("departure_airport_code", null)
        val departureTimeLocal = prefs.getString("departure_time_local", null)
        val arrivalTimeLocal = prefs.getString("arrival_time_local", null)
        val isDelayInDeparture = prefs.getBoolean("is_delay_in_departure", false)
        val isDelayInArrival = prefs.getBoolean("is_delay_in_arrival", false)
        val isExpediteInDeparture = prefs.getBoolean("is_expedite_in_departure", false)
        val isExpediteInArrival = prefs.getBoolean("is_expedite_in_arrival", false)

        val hasRequiredFlightData = listOf(
            flightNumberIata,
            flightNumberIcao,
            destinationName,
            arrivalAirportCode,
            departureAirportCode,
            departureTimeLocal,
            arrivalTimeLocal
        ).all { !it.isNullOrBlank() }

        if (hasRequiredFlightData) {
            CurrentActiveFlightWidget(
                airlineLogo = airlineLogo.orEmpty(),
                flightNumberIata = flightNumberIata!!,
                flightNumberIcao = flightNumberIcao!!,
                destinationName = destinationName!!,
                arrivalAirportCode = arrivalAirportCode!!,
                departureAirportCode = departureAirportCode!!,
                departureTimeLocal = departureTimeLocal!!,
                arrivalTimeLocal = arrivalTimeLocal!!,
                isDelayInDeparture = isDelayInDeparture,
                isDelayInArrival = isDelayInArrival,
                isExpediteInDeparture = isExpediteInDeparture,
                isExpediteInArrival = isExpediteInArrival,
                context = context
            )
        } else {
            EmptyFlightStateWidget()
        }
    }
}

private suspend fun Context.getImage(url: String, force: Boolean = false): Bitmap? {
    val request = ImageRequest.Builder(this).data(url).apply {
        if (force) {
            memoryCachePolicy(CachePolicy.DISABLED)
            diskCachePolicy(CachePolicy.DISABLED)
        }
    }.build()

    return when (val result = imageLoader.execute(request)) {
        is ErrorResult -> {
            Log.e("ImageLoadingError", result.throwable.message, result.throwable)
            throw result.throwable
        }

        is SuccessResult -> result.image.toBitmap()
    }
}

@Composable
fun CurrentActiveFlightWidget(
    airlineLogo: String,
    flightNumberIata: String,
    flightNumberIcao: String,
    destinationName: String,
    arrivalAirportCode: String,
    departureAirportCode: String,
    departureTimeLocal: String,
    arrivalTimeLocal: String,
    isDelayInDeparture: Boolean,
    isDelayInArrival: Boolean,
    isExpediteInDeparture: Boolean,
    isExpediteInArrival: Boolean,
    context: Context?,
) {
    val departureColor = flightStatusColor(isDelayInDeparture, isExpediteInDeparture)
    val arrivalColor = flightStatusColor(isDelayInArrival, isExpediteInArrival)
    var image by remember(airlineLogo) {
        mutableStateOf<Bitmap?>(null)
    }
    LaunchedEffect(airlineLogo) {
        image = context?.getImage(airlineLogo)
    }

    Box(
        modifier = GlanceModifier.background(
            ColorProvider(
                day = Color.White, night = Color.Black
            )
        ).fillMaxWidth()
    ) {
        Column(
            modifier = GlanceModifier
                .fillMaxSize()
                .padding(16.dp),
            verticalAlignment = Alignment.Vertical.Top,
            horizontalAlignment = Alignment.Horizontal.Start
        ) {
            Column(
                modifier = GlanceModifier.fillMaxWidth(),
                verticalAlignment = Alignment.Vertical.CenterVertically,
                horizontalAlignment = Alignment.Horizontal.Start
            ) {
                Image(
                    provider = (if (image != null) {
                        ImageProvider(image!!)
                    } else {
                        airlineLogoProvider(airlineLogo)
                    }),
                    contentDescription = "Airline Logo",
                    modifier = GlanceModifier.size(30.dp)
                )
                Spacer(modifier = GlanceModifier.height(12.dp))
                Column {
                    Row(
                        verticalAlignment = Alignment.Vertical.CenterVertically,
                        horizontalAlignment = Alignment.Horizontal.Start
                    ) {
                        Text(
                            text = flightNumberIata,
                            style = TextStyle(
                                fontSize = 16.sp,
                                fontWeight = FontWeight.Normal,
                                color = GlanceTheme.colors.secondary,
                            )
                        )
                        Spacer(modifier = GlanceModifier.width(4.dp))
                        Text(
                            text = "•",
                            style = TextStyle(
                                fontSize = 16.sp,
                                color = GlanceTheme.colors.secondary
                            )
                        )
                        Spacer(modifier = GlanceModifier.width(4.dp))
                        Text(
                            text = flightNumberIcao,
                            style = TextStyle(
                                fontSize = 16.sp,
                                fontWeight = FontWeight.Normal,
                                color = GlanceTheme.colors.secondary,
                            )
                        )
                    }
                    Text(
                        text = "to $destinationName",
                        style = TextStyle(
                            fontSize = 14.sp,
                            fontWeight = FontWeight.Bold,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                }
            }

            Spacer(modifier = GlanceModifier.height(10.dp))

            FlightLegRow(
                icon = "↗",
                airportCode = departureAirportCode,
                time = departureTimeLocal,
                timeColor = departureColor
            )
            Spacer(modifier = GlanceModifier.height(6.dp))
            FlightLegRow(
                icon = "↘",
                airportCode = arrivalAirportCode,
                time = arrivalTimeLocal,
                timeColor = arrivalColor
            )

        }
    }
}

@Composable
private fun FlightLegRow(
    icon: String,
    airportCode: String,
    time: String,
    timeColor: Color,
) {
    Row(
        modifier = GlanceModifier.fillMaxWidth(),
        verticalAlignment = Alignment.Vertical.CenterVertically,
        horizontalAlignment = Alignment.Horizontal.Start
    ) {
        Row(
            verticalAlignment = Alignment.Vertical.CenterVertically,
            horizontalAlignment = Alignment.Horizontal.Start
        ) {
            Text(
                text = icon,
                style = TextStyle(
                    fontSize = 18.sp,
                    color = GlanceTheme.colors.onSurface, fontWeight = FontWeight.Bold,
                )
            )
            Spacer(modifier = GlanceModifier.width(4.dp))
            Text(
                text = airportCode,
                style = TextStyle(
                    fontSize = 14.sp,
                    fontFamily = FontFamily.SansSerif,
                    color = GlanceTheme.colors.onSurface
                )
            )
        }
        Spacer(modifier = GlanceModifier.defaultWeight())
        Text(
            text = time,
            style = TextStyle(
                fontSize = 14.sp,
                fontFamily = FontFamily.SansSerif,
                fontWeight = FontWeight.Bold,
                color = ColorProvider(day = timeColor, night = timeColor)
            )
        )
    }
}

@Composable
private fun EmptyFlightStateWidget() {
    Box(
        modifier = GlanceModifier
            .fillMaxWidth()
            .background(
                ColorProvider(
                    day = Color.White,
                    night = Color.Black
                )
            )
            .padding(16.dp)
    ) {
        Column(
            modifier = GlanceModifier.fillMaxSize(),
            verticalAlignment = Alignment.Vertical.Top,
            horizontalAlignment = Alignment.Horizontal.Start
        ) {
            Image(
                provider = ImageProvider(R.mipmap.ic_launcher),
                contentDescription = "Aero logo",
                modifier = GlanceModifier.size(36.dp)
            )

            Spacer(modifier = GlanceModifier.height(70.dp))
            Column(
                horizontalAlignment = Alignment.Horizontal.Start
            ) {
                Text(
                    text = "No Flights",
                    style = TextStyle(
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.secondary
                    )
                )
                Spacer(modifier = GlanceModifier.height(4.dp))
                Row(
                    verticalAlignment = Alignment.Vertical.CenterVertically,
                    horizontalAlignment = Alignment.Horizontal.CenterHorizontally
                ) {
                    Image(
                        provider = ImageProvider(R.drawable.baseline_add_circle_24),
                        contentDescription = "Add button",
                        modifier = GlanceModifier.size(16.dp), colorFilter = ColorFilter.tint(
                            GlanceTheme.colors.secondary
                        )
                    )
                    Spacer(modifier = GlanceModifier.width(6.dp))
                    Text(
                        text = "Tap to add",
                        style = TextStyle(
                            fontSize = 14.sp,
                            color = GlanceTheme.colors.secondary

                        )
                    )
                }
            }
        }
    }
}


private fun flightStatusColor(
    isDelayed: Boolean,
    isExpedited: Boolean
): Color {
    return when {
        isDelayed -> Color(0xFFFF6F61)
        isExpedited -> Color(0xFF80CBC4)
        else -> Color(0xFF4CAF50)
    }
}

private val allowedLogoSchemes = setOf("content", "android.resource", "file")

private fun airlineLogoProvider(airlineLogo: String?): ImageProvider {
    val uri = airlineLogo
        ?.takeIf { it.isNotBlank() }
        ?.let { runCatching { it.toUri() }.getOrNull() }

    val scheme = uri?.scheme?.lowercase(Locale.ROOT)
    return if (uri != null && scheme in allowedLogoSchemes) {
        ImageProvider(uri)
    } else {
        ImageProvider(R.mipmap.ic_launcher)
    }
}


@Preview(widthDp = 200)
@Composable
@OptIn(ExperimentalGlancePreviewApi::class)
private fun CurrentActiveFlightWidgetPreview() {
    CurrentActiveFlightWidget(
        airlineLogo = "https://www.flightaware.com/images/airline_logos/180px/ACA.png",
        flightNumberIata = "AC43",
        flightNumberIcao = "ACA43",
        destinationName = "Berlin",
        arrivalAirportCode = "DOH",
        departureAirportCode = "HKG",
        departureTimeLocal = "05:30",
        arrivalTimeLocal = "17:50",
        isDelayInDeparture = false,
        isDelayInArrival = false,
        isExpediteInDeparture = false,
        isExpediteInArrival = false,
        context = null,
    )
}


@Preview(widthDp = 200)
@Composable
@OptIn(ExperimentalGlancePreviewApi::class)
private fun CurrentActiveFlightWidgetPreviewEmpty() {
    EmptyFlightStateWidget()
}