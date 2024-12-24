import flights from "./data.json"
import { pb } from "./pb"

/**
 * Given a string, capitalize the first letter and return the result.
 * If the string is empty, return an empty string.
 * @param text The string to capitalize.
 * @returns The capitalized string.
 */
function capitalize(text: string) {
    if (!text) return "";
    return text[0].toUpperCase() + text.slice(1);
}

for (const flight of flights) {
    const name = flight.name
    const [iata, icao] = flight.fleet.split("/").map((e) => e.trim())

    await pb.collection("airlines").create({
        name: capitalize(name),
        iata,
        icao
    }, { requestKey: null })
}
console.log(flights.length)