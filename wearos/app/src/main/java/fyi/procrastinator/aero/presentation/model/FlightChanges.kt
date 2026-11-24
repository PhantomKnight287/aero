package fyi.procrastinator.aero.presentation.model

import org.json.JSONObject
import java.time.Duration
import java.time.Instant
import java.time.ZoneId

/**
 * What changed between the stored copy of a flight and a fresh one from the
 * phone, worded for a notification. Only changes worth a buzz on the wrist:
 * gates, belt, a real departure slip, cancellation, diversion. Nothing once
 * the flight has reached the gate.
 */
object FlightChanges {

    /** A departure moving later by at least this much is worth telling. */
    private val SLIP = Duration.ofMinutes(15)

    fun of(old: JSONObject?, new: JSONObject, use24: Boolean): List<String> {
        if (old == null) return emptyList() // first send: nothing changed
        if (new.has("in") && !new.isNull("in")) return emptyList() // arrived

        if (!old.optBoolean("cancelled") && new.optBoolean("cancelled")) {
            return listOf("Flight cancelled")
        }
        val out = mutableListOf<String>()
        if (!old.optBoolean("diverted") && new.optBoolean("diverted")) {
            out += new.text("divertedTo")?.let { "Diverted to $it" } ?: "Diverted"
        }

        val oldDep = old.optJSONObject("dep")
        val newDep = new.optJSONObject("dep")
        val oldArr = old.optJSONObject("arr")
        val newArr = new.optJSONObject("arr")
        val departed = new.text("off") != null

        if (!departed) {
            change(oldDep?.text("gate"), newDep?.text("gate"))?.let { (from, to) ->
                out += if (from == null) "Gate $to" else "Gate changed $from → $to"
            }
            val was = oldDep?.instant("best")
            val now = newDep?.instant("best")
            if (was != null && now != null && Duration.between(was, now) >= SLIP) {
                val zone = newDep.text("tz")?.let { runCatching { ZoneId.of(it) }.getOrNull() }
                out += "Departure ${FlightMapper.span(Duration.between(was, now))} later, " +
                    "now ${FlightMapper.clock(now, zone, use24)}"
            }
        }
        change(oldArr?.text("gate"), newArr?.text("gate"))?.let { (from, to) ->
            out += if (from == null) "Arrival gate $to" else "Arrival gate changed $from → $to"
        }
        change(oldArr?.text("belt"), newArr?.text("belt"))?.let { (_, to) ->
            out += "Bags on belt $to"
        }
        return out
    }

    /** (old, new) when [new] is set and differs from [old]; a gate going blank isn't news. */
    private fun change(old: String?, new: String?): Pair<String?, String>? =
        if (new != null && new != old) old to new else null

    private fun JSONObject.text(key: String): String? =
        if (isNull(key)) null else optString(key).takeIf { it.isNotBlank() && it != "null" }

    private fun JSONObject.instant(key: String): Instant? =
        text(key)?.let { runCatching { Instant.parse(it) }.getOrNull() }
}
