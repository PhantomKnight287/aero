package fyi.procrastinator.aero.presentation.model

/** Sample flights for previews until the phone sync is wired up. */
object MockFlights {
    val inFlight = FlightUi(
        id = "ua1581",
        airline = "United Airlines",
        airlineIata = "UA",
        ident = "UA1581",
        identIcao = "UAL1581",
        date = "MON 23 NOV",
        dep = SideUi(
            code = "LAX", icao = "KLAX", city = "Los Angeles",
            time = "10:24", scheduled = "10:30", delay = "6m early",
            punctuality = Punctuality.Early, gate = "77", terminal = "7", runway = "25R",
        ),
        arr = SideUi(
            code = "EWR", icao = "KEWR", city = "Newark",
            time = "15:15", scheduled = "15:38", delay = "23m early",
            punctuality = Punctuality.Early, gate = "C125", terminal = "C", belt = "6",
        ),
        phase = Phase.InFlight,
        progress = 0.48f,
        sinceLine = "departed 2h 23m ago",
        statusLine = "2h 27m left",
        duration = "4h 51m",
        distance = "2,523 nm",
        aircraft = "Boeing 777-200",
        aircraftCode = "B772",
        registration = "N797UA",
        inbound = InboundUi(
            route = "EWR → LAX",
            ident = "UA2238",
            status = "Arrived 19m early",
            punctuality = Punctuality.Early,
        ),
    )

    val late = FlightUi(
        id = "wn4187",
        airline = "Southwest Airlines",
        airlineIata = "WN",
        ident = "WN4187",
        identIcao = "SWA4187",
        date = "MON 23 NOV",
        dep = SideUi(
            code = "STL", icao = "KSTL", city = "St Louis",
            time = "09:42", scheduled = "09:35", delay = "7m late",
            punctuality = Punctuality.OnTime, gate = "E4", terminal = "2",
        ),
        arr = SideUi(
            code = "PHX", icao = "KPHX", city = "Phoenix",
            time = "12:06", scheduled = "11:40", delay = "26m late",
            punctuality = Punctuality.Late, terminal = "4",
        ),
        phase = Phase.InFlight,
        progress = 0.81f,
        sinceLine = "departed 2h 44m ago",
        statusLine = "40m left",
        duration = "3h 24m",
        distance = "1,311 nm",
        aircraft = "Boeing 737 MAX 8",
        aircraftCode = "B38M",
        registration = "N8872Q",
        inbound = InboundUi(
            route = "MDW → STL",
            ident = "WN2210",
            status = "Arrived 31m late",
            punctuality = Punctuality.Late,
        ),
    )

    val scheduled = FlightUi(
        id = "aa1",
        airline = "American Airlines",
        airlineIata = "AA",
        ident = "AA1",
        identIcao = "AAL1",
        date = "TUE 24 NOV",
        dep = SideUi(
            code = "JFK", icao = "KJFK", city = "New York",
            time = "09:00", delay = "On time",
            punctuality = Punctuality.OnTime, gate = "B32", terminal = "8",
        ),
        arr = SideUi(
            code = "LAX", icao = "KLAX", city = "Los Angeles",
            time = "12:31", delay = "On time",
            punctuality = Punctuality.OnTime, terminal = "4",
        ),
        phase = Phase.Scheduled,
        progress = 0f,
        sinceLine = "departs in 3h 12m",
        statusLine = "Departs 09:00",
        duration = "6h 31m",
        distance = "2,145 nm",
        aircraft = "Airbus A321",
        aircraftCode = "A321",
        registration = "N114NN",
    )

    val landed = FlightUi(
        id = "dl958",
        airline = "Delta Air Lines",
        airlineIata = "DL",
        ident = "DL958",
        identIcao = "DAL958",
        date = "MON 23 NOV",
        dep = SideUi(
            code = "LAX", icao = "KLAX", city = "Los Angeles",
            time = "06:02", scheduled = "06:00", delay = "2m late",
            punctuality = Punctuality.OnTime, gate = "24", terminal = "2",
        ),
        arr = SideUi(
            code = "JFK", icao = "KJFK", city = "New York",
            time = "14:20", scheduled = "14:35", delay = "15m early",
            punctuality = Punctuality.Early, gate = "B20", terminal = "4", belt = "11",
        ),
        phase = Phase.Arrived,
        progress = 1f,
        statusLine = "Arrived 12m ago",
        duration = "5h 18m",
        distance = "2,145 nm",
        aircraft = "Airbus A330-900",
        aircraftCode = "A339",
        registration = "N411DX",
    )

    val cancelled = FlightUi(
        id = "ek201",
        airline = "Emirates",
        airlineIata = "EK",
        ident = "EK201",
        identIcao = "UAE201",
        date = "TUE 24 NOV",
        dep = SideUi(
            code = "DXB", icao = "OMDB", city = "Dubai",
            time = "02:30", delay = "Cancelled",
            punctuality = Punctuality.Cancelled, terminal = "3",
        ),
        arr = SideUi(
            code = "JFK", icao = "KJFK", city = "New York",
            time = "08:25", delay = "Cancelled",
            punctuality = Punctuality.Cancelled, terminal = "4",
        ),
        phase = Phase.Cancelled,
        progress = null,
        statusLine = "Cancelled",
        duration = "—",
        distance = "5,941 nm",
        aircraft = "Airbus A380-800",
        aircraftCode = "A388",
        registration = "A6-EOF",
    )

    val all = listOf(inFlight, late, scheduled, landed, cancelled)
}
