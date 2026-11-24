package fyi.procrastinator.aero

import fyi.procrastinator.aero.presentation.model.AirlineRef
import fyi.procrastinator.aero.presentation.model.FlightMapper
import fyi.procrastinator.aero.presentation.model.Phase
import fyi.procrastinator.aero.presentation.model.Punctuality
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test
import java.time.Instant

/** The phone payload (wear_payload.dart, v2) read back as of a given clock. */
class FlightMapperTest {
    private val airline = AirlineRef("Southwest Airlines", "WN", "SWA", null)

    // STL 15:35Z sched, out 15:42Z; PHX 18:40Z sched, estimated 19:06Z.
    private fun payload(extra: String = "") = JSONObject(
        """
        {"id":"f1","flightNo":"WN4187","identIata":"WN4187","identIcao":"SWA4187",
         "dep":{"code":"STL","icao":"KSTL","city":"St Louis","tz":"America/Chicago",
                "sched":"2026-11-23T15:35:00Z","best":"2026-11-23T15:42:00Z","gate":"E4"},
         "arr":{"code":"PHX","icao":"KPHX","city":"Phoenix","tz":"America/Phoenix",
                "sched":"2026-11-23T18:40:00Z","best":"2026-11-23T19:06:00Z"},
         "distance":"2,428 km","aircraft":"Boeing 737 MAX 8" $extra}
        """
    )

    private fun at(hm: String) = Instant.parse("2026-11-23T${hm}:00Z")

    @Test
    fun inFlightCountsDownAndColoursTheLateArrival() {
        val f = FlightMapper.map(
            payload(""","out":"2026-11-23T15:42:00Z","off":"2026-11-23T15:52:00Z""""),
            airline, at("18:26"), use24 = false,
        )!!
        assertEquals(Phase.InFlight, f.phase)
        assertEquals("40m left", f.statusLine)
        assertEquals("departed 2h 44m ago", f.sinceLine)
        assertEquals(164f / 204f, f.progress!!, 0.001f)
        // Departure 7m late is not "late"; arrival 26m late is.
        assertEquals(Punctuality.OnTime, f.dep.punctuality)
        assertEquals("7m late", f.dep.delay)
        assertEquals(Punctuality.Late, f.arr.punctuality)
        // Clocks in each airport's zone: 15:42Z is 9:42 in St Louis.
        assertEquals("9:42 AM", f.dep.time)
        assertEquals("9:35 AM", f.dep.scheduled)
        assertEquals("MON 23 NOV", f.date)
    }

    @Test
    fun beforeDepartureGoesByTheClock() {
        val f = FlightMapper.map(payload(), airline, at("12:23"), use24 = true)!!
        assertEquals(Phase.Scheduled, f.phase)
        assertEquals("Departs 9:42", f.statusLine)
        assertEquals(0f, f.progress!!, 0f)
        assertEquals(Phase.DepartsSoon, FlightMapper.map(payload(), airline, at("15:20"), true)!!.phase)
    }

    @Test
    fun cancelledHasNoProgressAndStrikesTheTimes() {
        val f = FlightMapper.map(payload(""","cancelled":true"""), airline, at("12:00"), true)!!
        assertEquals(Phase.Cancelled, f.phase)
        assertNull(f.progress)
        assertEquals(Punctuality.Cancelled, f.dep.punctuality)
        assertEquals("—", f.duration)
    }

    @Test
    fun arrivedReadsFromGateIn() {
        val f = FlightMapper.map(
            payload(""","off":"2026-11-23T15:52:00Z","on":"2026-11-23T19:00:00Z","in":"2026-11-23T19:06:00Z""""),
            airline, at("20:00"), true,
        )!!
        assertEquals(Phase.Arrived, f.phase)
        assertEquals("Arrived 54m ago", f.statusLine)
        assertEquals(1f, f.progress!!, 0f)
    }

    @Test
    fun inboundAndUnknownZone() {
        val f = FlightMapper.map(
            payload(""","inbound":{"ident":"WN2210","from":"MDW","to":"STL","arrived":true,"delayMin":31}"""),
            airline, at("12:00"), true,
        )!!
        assertEquals("Arrived 31m late", f.inbound!!.status)
        assertEquals(Punctuality.Late, f.inbound!!.punctuality)
        assertEquals("15:42Z", FlightMapper.clock(at("15:42"), null, true))
    }
}
