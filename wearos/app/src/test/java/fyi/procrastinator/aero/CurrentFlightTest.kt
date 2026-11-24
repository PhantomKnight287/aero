package fyi.procrastinator.aero

import fyi.procrastinator.aero.presentation.model.FlightStore
import fyi.procrastinator.aero.presentation.model.MockFlights
import fyi.procrastinator.aero.presentation.model.Phase
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test
import java.time.Instant

/** Which flight the tile and complication show. */
class CurrentFlightTest {
    private val now = Instant.parse("2026-11-23T18:00:00Z")
    private fun h(hours: Long) = now.plusSeconds(hours * 3600)

    private val inFlight = MockFlights.inFlight.copy(departsAt = h(-2), arrivesAt = h(2))
    private val tomorrow = MockFlights.scheduled.copy(departsAt = h(15), arrivesAt = h(21))
    private val soon = MockFlights.scheduled.copy(id = "soon", departsAt = h(3), arrivesAt = h(6))
    private val landedAgo = { hours: Long ->
        MockFlights.landed.copy(departsAt = h(-hours - 5), arrivesAt = h(-hours))
    }

    @Test
    fun underWayBeatsEverything() =
        assertEquals(inFlight, FlightStore.current(listOf(tomorrow, landedAgo(1), inFlight), now))

    @Test
    fun otherwiseTheNextDeparture() =
        assertEquals(soon, FlightStore.current(listOf(tomorrow, soon, landedAgo(1)), now))

    @Test
    fun aCancelledNextFlightStillShows() {
        val cancelled = MockFlights.cancelled.copy(departsAt = h(1), arrivesAt = h(13))
        assertEquals(Phase.Cancelled, FlightStore.current(listOf(tomorrow, cancelled), now)!!.phase)
    }

    @Test
    fun aRecentLandingUntilSixHours() {
        assertEquals(landedAgo(2), FlightStore.current(listOf(landedAgo(2)), now))
        assertNull(FlightStore.current(listOf(landedAgo(7)), now))
    }

    @Test
    fun nothingStored() = assertNull(FlightStore.current(emptyList(), now))
}
