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
    </section>
  );
}
