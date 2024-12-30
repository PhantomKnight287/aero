import { pb } from "./pb";

const airports = await pb.collection("airports").getFullList();

for (const airport of airports) {
  const record = await pb.collection("airports").getOne(airport.id);
  const data = await fetch("http://localhost:5000/v1/airports", {
    method: "POST",
    body: JSON.stringify({
      ident: record.ident,
      type: record.type,
      elevation: Number(record.elevation),
      continent: record.continent,
      isoCountry: record.iso_country,
      municipality: record.municipality,
      gpsCode: record.gps_code,
      iataCode: record.iata_code,
      name: record.name,
      lat: record.lat,
      long: record.long,
      isoRegion: record.iso_region,
    }),
    headers: {
      "Content-Type": "application/json",
    },
  });
  console.log(await data.json());
}
