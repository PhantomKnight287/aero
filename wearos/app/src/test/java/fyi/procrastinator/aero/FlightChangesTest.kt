package fyi.procrastinator.aero

import fyi.procrastinator.aero.presentation.model.FlightChanges
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Test

/** Which differences between two sends of a flight buzz the wrist. */
class FlightChangesTest {
    private fun flight(
        depGate: String? = "E4",
        depBest: String = "2026-11-23T15:35:00Z",
        arrGate: String? = null,
        belt: String? = null,
        extra: String = "",
    ) = JSONObject(
        """
        {"dep":{"tz":"America/Chicago","best":"$depBest","gate":${depGate?.let { "\"$it\"" }}},
         "arr":{"gate":${arrGate?.let { "\"$it\"" }},"belt":${belt?.let { "\"$it\"" }}} $extra}
        """
    )

    private fun changes(old: JSONObject?, new: JSONObject) = FlightChanges.of(old, new, use24 = true)

    @Test
    fun firstSendIsNotAChange() = assertEquals(emptyList<String>(), changes(null, flight()))

    @Test
    fun sameDataIsQuiet() = assertEquals(emptyList<String>(), changes(flight(), flight()))

    @Test
    fun gateChangedAndAssigned() {
        assertEquals(listOf("Gate changed E4 → E9"), changes(flight(), flight(depGate = "E9")))
        assertEquals(listOf("Gate E4"), changes(flight(depGate = null), flight()))
        // A gate going blank in a later send isn't news.
        assertEquals(emptyList<String>(), changes(flight(), flight(depGate = null)))
    }

    @Test
    fun departureSlipOfFifteenMinutesOrMore() {
        assertEquals(
            listOf("Departure 25m later, now 10:00"),
            changes(flight(), flight(depBest = "2026-11-23T16:00:00Z")),
        )
        assertEquals(emptyList<String>(), changes(flight(), flight(depBest = "2026-11-23T15:45:00Z")))
    }

    @Test
    fun departureGateAndDelayStopOnceAirborne() {
        val airborne = ""","off":"2026-11-23T15:52:00Z""""
        assertEquals(
            emptyList<String>(),
            changes(flight(extra = airborne), flight(depGate = "E9", depBest = "2026-11-23T17:00:00Z", extra = airborne)),
        )
    }

    @Test
    fun arrivalGateAndBelt() = assertEquals(
        listOf("Arrival gate B12", "Bags on belt 6"),
        changes(flight(), flight(arrGate = "B12", belt = "6")),
    )

    @Test
    fun cancelledSaysOnlyThat() = assertEquals(
        listOf("Flight cancelled"),
        changes(flight(), flight(depGate = "E9", extra = ""","cancelled":true""")),
    )

    @Test
    fun divertedNamesTheAirport() = assertEquals(
        listOf("Diverted to TUS"),
        changes(flight(), flight(extra = ""","diverted":true,"divertedTo":"TUS"""")),
    )

    @Test
    fun nothingAfterReachingTheGate() = assertEquals(
        emptyList<String>(),
        changes(flight(), flight(belt = "6", extra = ""","in":"2026-11-23T19:06:00Z"""")),
    )
}
