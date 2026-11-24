package fyi.procrastinator.aero.presentation.model

import java.time.Instant

/**
 * What the watch screens draw, already formatted. Kept apart from the Room
 * entities so real data can be mapped in later without touching the UI.
 */
data class FlightUi(
    val id: String,
    val airline: String,
    val airlineIata: String,
    /** Our SVG logo, else FlightAware's PNG. */
    val logoUrl: String? = null,
    /** Tried when [logoUrl] fails (the PNG, when the SVG was first). */
    val logoFallbackUrl: String? = null,
    /** 'UA1581' */
    val ident: String,
    /** 'UAL1581' */
    val identIcao: String? = null,
    /** 'MON 23 NOV' at the departure airport */
    val date: String,
    val dep: SideUi,
    val arr: SideUi,
    val phase: Phase,
    /** 0..1 gate to gate; null when cancelled or diverted */
    val progress: Float?,
    /** 'departed 2h 23m ago', 'departs in 3h 12m' */
    val sinceLine: String? = null,
    /** '2h 27m left', 'Landed 12m ago' */
    val statusLine: String,
    val duration: String,
    val distance: String,
    val aircraft: String? = null,
    val aircraftCode: String? = null,
    val registration: String? = null,
    val inbound: InboundUi? = null,
    val divertedTo: String? = null,
    /** Raw best times, for the tile timeline and complication countdowns. */
    val departsAt: Instant? = null,
    val arrivesAt: Instant? = null,
) {
    val idents get() = listOfNotNull(ident, identIcao).joinToString(" · ")

    /** Punctuality the flight is judged by: the arrival's. */
    val overall
        get() = if (phase == Phase.Cancelled) Punctuality.Cancelled else arr.punctuality
}

data class SideUi(
    /** 'LAX' */
    val code: String,
    val icao: String? = null,
    val city: String,
    /** Best known time: actual, else estimated, else scheduled. */
    val time: String,
    /** Shown struck through when the time moved. */
    val scheduled: String? = null,
    /** '6m early', 'On time', '26m late' */
    val delay: String,
    val punctuality: Punctuality,
    val gate: String? = null,
    val terminal: String? = null,
    val belt: String? = null,
    val runway: String? = null,
)

data class InboundUi(
    /** 'EWR → LAX' */
    val route: String,
    /** 'UA2238' */
    val ident: String,
    /** 'Arrived 19m early', 'Lands 08:27, 12m late' */
    val status: String,
    val punctuality: Punctuality,
)

enum class Phase(val label: String) {
    Scheduled("Scheduled"),
    DepartsSoon("Departs soon"),
    Taxiing("Taxiing"),
    InFlight("In flight"),
    Landed("Landed"),
    Arrived("Arrived"),
    Cancelled("Cancelled"),
    Diverted("Diverted"),
}

/** Late means more than 15 minutes, as on the phone. */
enum class Punctuality { Early, OnTime, Late, Cancelled }
