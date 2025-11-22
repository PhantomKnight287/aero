package fyi.procrastinator.aero.presentation.screens.home.composables

import android.util.Log
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.Card
import androidx.wear.compose.material.Icon
import androidx.wear.compose.material.Text
import coil3.compose.AsyncImage
import fyi.procrastinator.aero.database.entity.Airline
import fyi.procrastinator.aero.database.entity.TrackedFlight
import fyi.procrastinator.aero.database.entity.TrackedFlightWithAirline
import fyi.procrastinator.aero.R

@Composable
fun TrackedFlight(
    trackedFlightWithAirline: TrackedFlightWithAirline,
    modifier: Modifier = Modifier,
    onClick: () -> Unit = {}
) {
    val airline = trackedFlightWithAirline.airline
    val flight = trackedFlightWithAirline.flight
    val airlineImage =
        if (airline.image.isNullOrBlank() || airline.image == "null") "https://www.flightaware.com/images/airline_logos/180px/${airline.icao}.png" else airline.image
    val idents =
        listOfNotNull(flight.identIata, flight.identIcao).ifEmpty { listOf(flight.flightNumber) }
    val identLabel = idents.joinToString(separator = " • ")
    Log.e("image", airlineImage);
    Card(
        modifier = modifier.padding(2.dp),
        onClick = onClick
    ) {
        Row(
            modifier = Modifier
                .padding(horizontal = 8.dp, vertical = 6.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            AsyncImage(
                model = airlineImage,
                contentDescription = "${airline.name}'s Logo",
                modifier = Modifier
                    .size(36.dp)
            )

            Spacer(modifier = Modifier.width(8.dp))

            Column(
                modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.spacedBy(2.dp)
            ) {
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text(
                        text = flight.departureAirportIata,
                        maxLines = 1,
                        fontSize = 14.sp,
                        overflow = TextOverflow.Ellipsis
                    )
                    Spacer(modifier = Modifier.width(2.dp))
                    Icon(
                        painter = painterResource(id = R.drawable.outline_arrow_right_alt_24),
                        contentDescription = null,
                        modifier = Modifier.size(12.dp)
                    )
                    Spacer(modifier = Modifier.width(2.dp))
                    Text(
                        text = flight.arrivalAirportIata,
                        maxLines = 1,
                        fontSize = 14.sp,
                        overflow = TextOverflow.Ellipsis
                    )
                }
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = flight.departureCity,
                        maxLines = 1,
                        fontSize = 12.sp,
                        overflow = TextOverflow.Ellipsis
                    )
                    Spacer(modifier = Modifier.width(2.dp))
                    Icon(
                        painter = painterResource(id = R.drawable.outline_arrow_right_alt_24),
                        contentDescription = null,
                        modifier = Modifier.size(12.dp)
                    )
                    Spacer(modifier = Modifier.width(2.dp))
                    Text(
                        text = flight.arrivalCity,
                        maxLines = 1,
                        fontSize = 12.sp,
                        overflow = TextOverflow.Ellipsis
                    )
                }
                Text(
                    text = identLabel,
                    maxLines = 1,
                    fontSize = 12.sp,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }
    }
}

@Preview
@Composable
private fun TrackedFlightPreview() {
    TrackedFlight(
        trackedFlightWithAirline = TrackedFlightWithAirline(
            airline = Airline(1, "Air India", "AIC", "AI", null),
            flight = TrackedFlight(
                flightId = 1,
                airlineUid = 1,
                flightNumber = "AIC129",
                identIata = "AI129",
                identIcao = "AIC129",
                flightDateEpochSeconds = 2000,
                departureAirportIata = "DEL",
                departureCity = "Delhi",
                arrivalAirportIata = "BLR",
                arrivalCity = "Bangalore"
            )
        )
    )
}