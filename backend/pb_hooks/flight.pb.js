/// <reference path="../pb_data/types.d.ts" />

routerAdd("GET", '/flight', (c) => {
    if (!c.auth) return c.json(401, { message: "Please login and try again" })
    const iata = c.requestInfo().query['iata']
    const icao = c.requestInfo().query['icao']
    const searchedDate = c.requestInfo().query['date']
    if (!iata || !icao) return c.json(400, { message: "Id of the flight is not provided" })
    const date = new Date(searchedDate ?? Date.now())
    date.setUTCHours(0, 0, 0, 0)
    const nextDate = new Date(date)
    nextDate.setDate(
        date.getDate() + 1
    )
    const collection = $app.findCollectionByNameOrId("flight");
    /**
     * `(call_sign = "${id}" || flight_no = "${id}") && date>="${date
            .toISOString()
            .replace("T", " ")
            .replace(".000Z", "")}" && date <= "${nextDate.toISOString().replace("T", " ").replace(".000Z", "")}"`
     */
    const records = $app.findRecordsByFilter(
        "flight",
        `(call_sign = "${iata}" || flight_no = "${iata}" || call_sign = "${icao}" || flight_no = "${icao}")`,
        "-created",
        200,
        0
    );
    if (records.length) {
        console.log("from db")
        return c.json(200, records[0])
    }
    const apiKey = $os.getenv("RAPID_API_KEY")
    const url = `https://aerodatabox.p.rapidapi.com/flights/number/${iata}/${date.toISOString().split("T")[0]
        }?withAircraftImage=false&withLocation=false`
    console.log(date.toISOString())
    const res = $http.send({
        url,
        method: "GET",
        headers: {
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "aerodatabox.p.rapidapi.com",
        }
    })
    const json = res.json
    if (json == null) return c.json(500, { message: "Unable to track the flight" })

    const record = new Record(collection)
    record.set("flight_no", json[0].number.replace(/ /g, ''))
    record.set("call_sign", json[0].callSign)
    record.set("aircraft", json[0].aircraft)
    record.set("airline", json[0].airline)
    record.set("arrival", json[0].arrival)
    record.set("cargo", json[0].isCargo)
    record.set("date", date)
    if (json.length >= 2) {
        record.set("departure", json[1].departure)
    }
    else {
        record.set("departure", json[0].departure)
    }
    $app.save(record)
    return c.json(200, res.json)
})