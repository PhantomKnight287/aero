package com.phantomknight287.planepal.presentation.screens.home

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.Text
import com.google.android.horologist.annotations.ExperimentalHorologistApi
import com.google.android.horologist.compose.layout.ScalingLazyColumn
import com.google.android.horologist.compose.layout.ScalingLazyColumnDefaults
import com.google.android.horologist.compose.layout.rememberResponsiveColumnState
import com.phantomknight287.planepal.dataStore
import kotlinx.coroutines.flow.map
import androidx.compose.runtime.getValue
import androidx.compose.ui.text.font.FontWeight
import androidx.wear.compose.foundation.lazy.items
import androidx.wear.compose.material.Chip
import androidx.wear.compose.material.Icon
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Image


@OptIn(ExperimentalHorologistApi::class)
@Composable
fun HomeScreen(
    viewModel: HomeViewModel,
    modifier: Modifier = Modifier,
    onSignInClicked: () -> Unit
) {
    val context = LocalContext.current

    val state = context.dataStore.data.map { p ->
        p[stringPreferencesKey("token")]
    }
    val token by state.collectAsState(initial = null)
    val flights by viewModel.flights.collectAsState()

    val columnState = rememberResponsiveColumnState(
        contentPadding = ScalingLazyColumnDefaults.padding(
            first = ScalingLazyColumnDefaults.ItemType.Text,
            last = ScalingLazyColumnDefaults.ItemType.Chip
        )
    )
    ScalingLazyColumn(
        modifier = modifier.fillMaxSize(),
        columnState = columnState,
    ) {
        if (token == null)
            item {
                Text("Welcome to PlanePal")
            }
        item {
            if (token == null) {
                Button(
                    onClick = onSignInClicked,
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Text("Sign In")
                }
            } else {
                Text(
                    "Flights",
                    fontWeight = FontWeight.SemiBold,
                )
            }
        }
        if (flights.isEmpty()) {
            item {
                Text("No flights found")
            }
        }
        items(flights) {
            Chip(
                label = { Text("${it.origin} to ${it.destination}") },
                onClick = { },
                secondaryLabel = { Text("Secondary label") },
                icon = { Icon(imageVector = Icons.Default.Image, contentDescription = null) }
            )
        }

    }


}