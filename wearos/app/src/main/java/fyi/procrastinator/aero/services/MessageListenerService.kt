package fyi.procrastinator.aero.services

import android.content.Intent
import android.util.Log
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService
import fyi.procrastinator.aero.database.AeroDatabase
import fyi.procrastinator.aero.database.dao.AirlineDAO
import fyi.procrastinator.aero.database.dao.TrackedFlightDao
import fyi.procrastinator.aero.database.entity.Airline
import fyi.procrastinator.aero.database.entity.TrackedFlight
import fyi.procrastinator.aero.presentation.MainActivity
import java.nio.charset.StandardCharsets
import java.time.Instant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import org.json.JSONObject

// make sure the name of this class matches the one in AndroidManifest.xml
class MessageListenerService : WearableListenerService() {

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val database by lazy { AeroDatabase.getDatabase(applicationContext) }
    private val airlineDao: AirlineDAO by lazy { database.airlineDao() }
    private val trackedFlightDao: TrackedFlightDao by lazy { database.trackedFlightDao() }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }

    override fun onMessageReceived(event: MessageEvent) {
        super.onMessageReceived(event)
        Log.e("ReceivedMessage","Path=${event.path}");
        when (event.path) {
            "/boot" -> launchApp()
            "/register-flight" -> handleRegisterFlight(event.data)
        }
    }

    private fun launchApp() {
        val intent = Intent(this, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        startActivity(intent)
    }

    private fun handleRegisterFlight(payload: ByteArray?) {
        if (payload == null) return
        val rawJson = payload.toString(StandardCharsets.UTF_8)
        Log.e("RawJson", rawJson)
        serviceScope.launch {
            try {
                val json = JSONObject(rawJson)
                val airlineJson = json.optJSONObject("airline")
                val flightJson = json.optJSONObject("flight")

                if (airlineJson == null || flightJson == null) {
                    Log.w(TAG, "Missing airline or flight data in payload: $rawJson")
                    return@launch
                }

                val airline = airlineFromJson(airlineJson)
                val trackedFlight = flightFromJson(flightJson, airline.uid)

                airlineDao.upsertAirline(airline)
                trackedFlightDao.upsertTrackedFlight(trackedFlight)
            } catch (e: Exception) {
                Log.e(TAG, "Failed to persist tracked flight", e)
            }
        }
    }

    private fun airlineFromJson(json: JSONObject): Airline {
        val iata = json.optString("iata").orNullIfBlank()
        val icao = json.optString("icao").orNullIfBlank()
        val name = json.optString("name").orNullIfBlank()
        val image = json.optString("image").orNullIfBlank()

        val uidSeed = listOfNotNull(iata, icao, name).firstOrNull()
        val uid = uidSeed?.hashCode() ?: (name?.hashCode() ?: DEFAULT_AIRLINE_ID)

        return Airline(
            uid = uid,
            name = name,
            icao = icao,
            iata = iata,
            image = image
        )
    }

    private fun flightFromJson(json: JSONObject, airlineUid: Int): TrackedFlight {
        val flightNumber = json.optString("flightNo")
            .takeIf { it.isNotBlank() }
            ?: json.optString("identIata")
            .takeIf { it.isNotBlank() }
            ?: json.optString("identIcao")
            .takeIf { it.isNotBlank() }
            ?: json.optString("id")
            .ifBlank { "UNKNOWN" }

        return TrackedFlight(
            airlineUid = airlineUid,
            flightNumber = flightNumber,
            identIata = json.optString("identIata").orNullIfBlank(),
            identIcao = json.optString("identIcao").orNullIfBlank(),
            flightDateEpochSeconds = parseEpochSeconds(json.optString("date")),
            departureAirportIata = json.optString("departureAirportIata").ifBlank { "--" },
            departureCity = json.optString("departureCity").ifBlank { "--" },
            arrivalAirportIata = json.optString("arrivalAirportIata").ifBlank { "--" },
            arrivalCity = json.optString("arrivalCity").ifBlank { "--" },
        )
    }

    private fun parseEpochSeconds(raw: String?): Long {
        return raw
            ?.takeIf { it.isNotBlank() }
            ?.let {
                try {
                    Instant.parse(it).epochSecond
                } catch (e: Exception) {
                    Log.w(TAG, "Unable to parse date: $it", e)
                    null
                }
            } ?: 0L
    }

    private fun String.orNullIfBlank(): String? = takeIf { it.isNotBlank() }

    companion object {
        private const val TAG = "MessageListenerService"
        private const val DEFAULT_AIRLINE_ID = 0
    }
}