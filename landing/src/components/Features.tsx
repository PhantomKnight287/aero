import { Chip, Phone, Reveal, SectionTitle } from "./primitives";

const features = [
  {
    title: "Track any flight",
    body: "Search by flight number or airport. Gate, terminal and belt on both ends, times in green when early and red when late, and a bar that shows how far along the flight is.",
    screen: "/screens/tracking.webp",
    chips: [
      "IATA + ICAO",
      "Gate · terminal · belt",
      "Gate and runway times",
      "Timezone shift",
      "Codeshares",
    ],
  },
  {
    title: "Live on the map",
    body: "Position, altitude, speed and heading refresh every few seconds, with the path flown so far drawn behind the plane.",
    screen: "/screens/live_on_map.webp",
    chips: ["Altitude · speed · heading", "Flown track", "Auto refresh"],
  },
  {
    title: "The plane, not just the flight",
    body: "Registration, age, Mode S and a photo of the actual airframe. See where it flew in from and whether that inbound flight was late, before yours is.",
    screen: "/screens/aircraft_details.webp",
    chips: [
      "Registration · Mode S",
      "Age and delivery date",
      "Inbound aircraft",
      "Rotation history",
      "Full-screen photo",
    ],
  },
  {
    title: "Airport weather, decoded",
    body: "Live METAR and TAF for any airport, turned into plain words. Tap any value to switch its unit, and every screen follows.",
    screen: "/screens/airport_weather.webp",
    chips: [
      "METAR · TAF",
      "VFR · IFR",
      "kt · km/h · mph",
      "hPa · inHg",
      "Airport · your time · UTC",
    ],
  },
  {
    title: "Your flight passport",
    body: "Every flight you've taken in one passport: countries, distance, hours in the air, minutes lost to delays and the aircraft you fly most.",
    screen: "/screens/stats.webp",
    chips: [
      "Countries and airports",
      "Distance and time",
      "Delay report",
      "Aircraft report",
      "Route map",
    ],
  },
];

export function Features() {
  return (
    <section id="features" className="scroll-mt-16 border-t border-line py-24">
      <div className="mx-auto max-w-6xl px-5">
        <SectionTitle kicker="Features" title="Built for people who read the whole board.">
          Aero shows the detail other trackers hide, laid out so it still
          reads at a glance.
        </SectionTitle>

        <div className="mt-20 space-y-28">
          {features.map((f, i) => (
            <Reveal
              key={f.title}
              className="grid items-center gap-12 md:grid-cols-2 md:gap-20"
            >
              <div className={i % 2 ? "md:order-2" : ""}>
                <p className="font-mono text-sm text-muted tabular">
                  {String(i + 1).padStart(2, "0")}
                </p>
                <h3 className="mt-2 font-display text-3xl tracking-tight sm:text-4xl">
                  {f.title}
                </h3>
                <p className="mt-4 text-lg leading-relaxed text-muted">
                  {f.body}
                </p>
                <div className="mt-6 flex flex-wrap gap-2">
                  {f.chips.map((c) => (
                    <Chip key={c}>{c}</Chip>
                  ))}
                </div>
              </div>
              <div className="relative flex justify-center">
                <div
                  aria-hidden
                  className="absolute inset-x-6 bottom-0 top-10 rounded-[2.5rem] bg-panel"
                />
                <Phone src={f.screen} alt={f.title} className="relative w-[250px]" />
              </div>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
