import { icons, DEFAULT_ICON_INDEX } from "@/data/icons";
import { GITHUB, GithubMark, Phone } from "./primitives";

export function Nav() {
  return (
    <header className="sticky top-0 z-50 border-b border-line/70 bg-white/75 backdrop-blur-xl">
      <nav className="mx-auto flex h-16 max-w-6xl items-center justify-between px-5">
        <a href="#" className="flex items-center gap-2.5">
          <img
            src={`/icons/${icons[DEFAULT_ICON_INDEX]}`}
            alt=""
            className="h-8 w-8 rounded-[9px]"
          />
          <span className="font-display text-xl tracking-tight">Aero</span>
        </a>
        <div className="hidden items-center gap-8 text-sm text-muted md:flex">
          {[
            ["Features", "#features"],
            ["Share", "#share"],
            ["Icons", "#icons"],
            ["Self-host", "#self-host"],
          ].map(([label, href]) => (
            <a key={href} href={href} className="transition-colors hover:text-ink">
              {label}
            </a>
          ))}
        </div>
        <a
          href={GITHUB}
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center gap-2 rounded-full bg-ink px-4 py-2 text-sm font-medium text-white transition-transform active:scale-[0.97]"
        >
          <GithubMark className="h-4 w-4" />
          GitHub
        </a>
      </nav>
    </header>
  );
}

export function Hero() {
  return (
    <section className="relative overflow-hidden">
      {/* faint grid, like a chart's background */}
      <div
        aria-hidden
        className="pointer-events-none absolute inset-0 [background-image:linear-gradient(to_right,#00000008_1px,transparent_1px),linear-gradient(to_bottom,#00000008_1px,transparent_1px)] [background-size:48px_48px] [mask-image:radial-gradient(ellipse_at_top,black_30%,transparent_75%)]"
      />
      <div className="relative mx-auto grid max-w-6xl items-center gap-16 px-5 pb-16 pt-16 sm:pt-24 lg:grid-cols-[1.05fr_1fr] lg:pb-24">
        <div>
          <p className="inline-flex items-center gap-2 rounded-full bg-panel px-3 py-1 text-sm text-ink-soft">
            <span className="h-2 w-2 rounded-full bg-success" />
            Free and open source · Android
          </p>
          <h1 className="mt-6 font-display text-5xl leading-[1.02] tracking-tight sm:text-6xl lg:text-7xl">
            Every flight,
            <br />
            in full detail.
          </h1>
          <p className="mt-6 max-w-xl text-lg leading-relaxed text-muted">
            Aero tracks any flight from any airline and shows everything: both
            IATA and ICAO codes, gate to runway times, the aircraft and where
            it flew in from, and the weather at both ends, decoded.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <a
              href={GITHUB}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 rounded-full bg-ink px-6 py-3 font-medium text-white transition-transform active:scale-[0.97]"
            >
              <GithubMark />
              Get it on GitHub
            </a>
            <a
              href="#features"
              className="inline-flex items-center gap-2 rounded-full bg-panel px-6 py-3 font-medium transition-colors hover:bg-line"
            >
              See what it shows
            </a>
          </div>
        </div>

        <div className="relative mx-auto h-[560px] w-full max-w-[460px]">
          <Phone
            src="/screens/hero_live.webp"
            alt="Aero showing UA1581 from Los Angeles to Newark live on the map"
            eager
            className="absolute left-1/2 top-0 w-[240px] -translate-x-1/2"
          />
          <img
            src="/cards/board.webp"
            alt="Departures board share card"
            className="absolute -right-2 top-[150px] w-[250px] rotate-[3deg] rounded-xl shadow-[0_20px_40px_-12px_rgba(0,0,0,0.4)] sm:-right-8 sm:w-[290px]"
          />
          <img
            src="/cards/pass.webp"
            alt="Boarding pass share card"
            className="absolute -left-2 bottom-6 w-[270px] -rotate-[4deg] rounded-xl shadow-[0_20px_40px_-12px_rgba(0,0,0,0.35)] sm:-left-10 sm:w-[310px]"
          />
        </div>
      </div>
      <FlightStrip />
    </section>
  );
}

/** The app's header, spelled out: the kind of detail every flight gets. */
function FlightStrip() {
  return (
    <div className="mx-auto max-w-6xl px-5 pb-20">
      <div className="rounded-2xl bg-panel p-5 sm:p-6">
        <div className="flex flex-wrap items-baseline justify-between gap-x-6 gap-y-1">
          <p className="text-xs font-semibold uppercase tracking-[0.12em] text-muted tabular">
            UA1581 · UAL1581 · Mon 23 Nov · Boeing 777-200 · N797UA
          </p>
          <p className="flex items-center gap-2 text-sm font-semibold">
            <span className="h-2 w-2 rounded-full bg-success" /> In flight
          </p>
        </div>
        <div className="mt-4 flex items-center gap-4">
          <div>
            <p className="font-display text-3xl">LAX</p>
            <p className="text-xs text-muted">KLAX · Gate 77</p>
          </div>
          <div className="relative h-6 flex-1">
            <div className="absolute inset-x-0 top-1/2 h-[3px] -translate-y-1/2 rounded bg-line" />
            <div className="absolute left-0 top-1/2 h-[3px] w-[46%] -translate-y-1/2 rounded bg-ink" />
            <span
              className="fly absolute top-1/2 flex h-6 w-6 -translate-x-1/2 -translate-y-1/2 items-center justify-center rounded-full bg-ink text-white"
              style={{ left: "46%" }}
            >
              <svg viewBox="0 0 24 24" className="h-3.5 w-3.5 rotate-90" fill="currentColor" aria-hidden>
                <path d="M21 16v-2l-8-5V3.5a1.5 1.5 0 0 0-3 0V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5Z" />
              </svg>
            </span>
          </div>
          <div className="text-right">
            <p className="font-display text-3xl">EWR</p>
            <p className="text-xs text-muted">KEWR · Gate C125</p>
          </div>
        </div>
        <div className="mt-3 flex justify-between text-sm tabular">
          <p>
            <span className="font-semibold text-success">10:24</span>{" "}
            <span className="text-muted line-through">10:30</span>{" "}
            <span className="text-success">6m early</span>
          </p>
          <p className="hidden text-muted sm:block">departed 2h 10m ago · 2h 40m left</p>
          <p>
            <span className="text-success">23m early</span>{" "}
            <span className="text-muted line-through">15:38</span>{" "}
            <span className="font-semibold text-success">15:15</span>
          </p>
        </div>
      </div>
    </div>
  );
}
