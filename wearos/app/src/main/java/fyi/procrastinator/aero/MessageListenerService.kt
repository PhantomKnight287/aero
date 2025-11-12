package fyi.procrastinator.aero

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.compose.ui.platform.LocalContext
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.preferencesDataStore
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService
import fyi.procrastinator.aero.presentation.MainActivity
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import fyi.procrastinator.aero.entities.Flight
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.json.JSONObject
import java.time.Instant
import java.util.Date
import kotlin.math.log

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "state")

class MessageListenerService : WearableListenerService() {
    override fun onMessageReceived(event: MessageEvent) {
        super.onMessageReceived(event)
        Log.e("Event", event.path)

        when (event.path) {
            "/boot" -> {
                val intent = Intent(this, MainActivity::class.java).apply {
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                startActivity(intent)
            }

            "/login-token" -> {
                val token = stringPreferencesKey("token")
                CoroutineScope(Dispatchers.IO).launch {
                    applicationContext.dataStore.edit { state ->
                        state[token] = String(event.data, Charsets.UTF_8)
                    }
                }.invokeOnCompletion {
                    println("Saved the token")
                }
            }

            "/register-flight" -> {
                val database = PlanePalDatabase.getDatabase(applicationContext)
                val flight = JSONObject(String(event.data, Charsets.UTF_8))

                CoroutineScope(Dispatchers.Main).launch {
                    database.flightsDao().insertFlight(
                        Flight(
                            id = flight.get("id") as String,
                            date = Date.from(Instant.parse(flight.get("date") as String)),
                            flightIata = flight.get("flightIata") as String,
                            flightIcao = flight.get("flightIcao") as String,
                            origin = flight.get("origin") as String,
                            destination = flight.get("destination") as String,
                        )
                    )
                }
            }
        }

    }
}