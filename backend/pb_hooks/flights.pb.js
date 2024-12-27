/// <reference path="../pb_data/types.d.ts" />

routerAdd("GET", "/flights", (c) => {

  if (!c.auth) return c.json(401, { message: "Please login and try again" })
  // Get query parameters
  const from = c.requestInfo().query["from"]; // departure airport code
  const to = c.requestInfo().query["to"]; // arrival airport code
  const date = c.requestInfo().query["date"]; // flight date
  const apiKey = $os.getenv("AVIATION_STACK_API_KEY"); // Get API key from environment variable

  // Validate required parameters
  if (!from || !to || !date) {
    return c.json(400, {
      success: false,
      message: "Missing required parameters: from, to, and date are required",
    });
  }

  const _date = new Date(date);
  const dayEndDate = new Date(_date);
  dayEndDate.setDate(_date.getDate() + 1);
  try {
    /**
     * && date >= "${_date
        .toISOString()
        .replace("T", " ")
        .replace(".000Z", "")}" && date <= "${dayEndDate
        .toISOString()
        .replace("T", " ")
        .replace(".000Z", "")}"

        append this to filter before going to production. I used without this to not exceed my API quota
     */
    const records = $app.findRecordsByFilter(
      "flights",
      `arrival.iataCode = "${to}" && departure.iataCode = "${from}" `,
      "-created",
      200,
      0
    );
    if (records.length > 0) {
      console.log("Fetched from db");
      return c.json(200, { flights: records });
    }
  } catch (e) {
    console.error(e);
  }
  try {
    // Aviation Edge API endpoint for flight schedules
    const apiUrl = `https://api.aviationstack.com/v1/timetable?iataCode=${from}&type=departure&access_key=${apiKey}`;

    // Make API request
    const response = $http.send({
      method: "GET",
      url: apiUrl,
    });

    // Check if request was successful
    if (response.statusCode !== 200) {
      console.log(response.raw);
      throw new Error(`API request failed with status ${response.statusCode}`);
    }

    // Parse response
    const flights = JSON.parse(response.raw);
    let collection = $app.findCollectionByNameOrId("flights");
    for (const flight of flights.data) {
      let record = new Record(collection);
      record.set("date", _date);
      record.set("airline", flight.airline);
      record.set("arrival", flight.arrival);
      record.set("codeshared", flight.codeshared);
      record.set("flight", flight.flight);
      record.set("departure", flight.departure);
      record.set("type", flight.type);
      record.set("status", flight.scheduled);
      $app.save(record);
    }

    // Filter flights for the specific route
    const routeFlights = flights.data.filter(
      (flight) =>
        flight.departure?.iataCode === from && flight.arrival?.iataCode === to
    );

    c.response.header().add("Cache-Control", "public, max-age=300");

    return c.json(200, {
      success: true,
      date: date,
      route: {
        from: from,
        to: to,
      },
      flightCount: routeFlights.length,
      flights: routeFlights,
    });
  } catch (error) {
    console.error("Error fetching flights:", error);

    // Return error response
    return c.json(500, {
      success: false,
      message: "Failed to fetch flight data",
      error: error.message,
    });
  }
});

// Add options route for CORS
routerAdd("OPTIONS", "/api/flights", (c) => {
  c.response.header().add("Access-Control-Allow-Origin", "*");
  c.response.header().add("Access-Control-Allow-Methods", "GET, OPTIONS");
  c.response.header().add("Access-Control-Allow-Headers", "Content-Type");
  c.response.header().add("Access-Control-Max-Age", "2592000");
  return c.json(200, {});
});
