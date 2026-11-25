import {
  ArrowLeftRight,
  BarChart3,
  LayoutGrid,
  PlaneLanding,
  Smartphone,
} from "lucide-react";
import { icons, DEFAULT_ICON_INDEX } from "@/data/icons";
import { GITHUB, GithubMark, Reveal, SectionTitle } from "./primitives";

export function Share() {
  const shadow = "rounded-xl shadow-[0_24px_48px_-16px_rgba(0,0,0,0.35)]";
  return (
    <section id="share" className="scroll-mt-16 bg-panel py-24">
      <div className="mx-auto max-w-6xl px-5">
        <SectionTitle kicker="Share" title="Four ways to show off a flight.">
          Card, boarding pass, departures board or a story with the route on
          the map. Pick one, see it, share it. Made from the flight's real
          data, 1080 pixels wide.
        </SectionTitle>

        <div className="mt-16 grid items-end gap-6 sm:grid-cols-2 lg:grid-cols-[0.8fr_1fr_1.25fr]">
          <Reveal>
            <img src="/cards/story.webp" alt="Story share card with the route on a map" className={shadow} loading="lazy" />
            <p className="mt-3 text-sm text-muted">Story · 9:16</p>
          </Reveal>
          <Reveal delay={80}>
            <img src="/cards/card.webp" alt="Card share card with the aircraft photo" className={shadow} loading="lazy" />
            <p className="mt-3 text-sm text-muted">Card · 4:5</p>
          </Reveal>
          <div className="space-y-6 sm:col-span-2 lg:col-span-1">
            <Reveal delay={160}>
              <img src="/cards/pass.webp" alt="Boarding pass share card" className={shadow} loading="lazy" />
              <p className="mt-3 text-sm text-muted">Pass</p>
            </Reveal>
            <Reveal delay={240}>
              <img src="/cards/board.webp" alt="Departures board share card" className={shadow} loading="lazy" />
              <p className="mt-3 text-sm text-muted">Board</p>
            </Reveal>
          </div>
        </div>
      </div>
    </section>
  );
}

const details = [
  {
    icon: ArrowLeftRight,
    title: "Tap to switch units",
    body: "Distance, speed, altitude, temperature, pressure and clocks. Change one and every screen follows.",
  },
  {
    icon: PlaneLanding,
    title: "Inbound aircraft",
    body: "Your plane's previous leg, live. Know it's running late before your flight does.",
  },
  {
    icon: BarChart3,
    title: "Delay report",
    body: "Hours lost to delays, the average, and which airlines and airports cost you most.",
  },
  {
    icon: Smartphone,
    title: "Home screen widget",
    body: "Your current flight's status without opening the app.",
  },
  {
    icon: LayoutGrid,
    title: "Twelve app icons",
    body: "Pick the one that suits your home screen.",
  },
];

export function Details() {
  return (
    <section className="py-24">
      <div className="mx-auto max-w-6xl px-5">
        <SectionTitle kicker="And more" title="The small things add up." />
        <div className="mt-14 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {details.map((d, i) => (
            <Reveal key={d.title} delay={(i % 3) * 70}>
              <div className="h-full rounded-2xl bg-panel p-6">
                <d.icon className="h-6 w-6" strokeWidth={1.75} />
                <h3 className="mt-5 font-semibold">{d.title}</h3>
                <p className="mt-1.5 leading-relaxed text-muted">{d.body}</p>
              </div>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}

export function Icons({ icon, onPick }: { icon: string; onPick: (icon: string) => void }) {
  return (
    <section id="icons" className="scroll-mt-16 border-t border-line py-24">
      <div className="mx-auto max-w-6xl px-5">
        <SectionTitle kicker="App icons" title="Make it yours.">
          Twelve icons in the app. Tap one to try it on this page.
        </SectionTitle>
        <Reveal className="mt-12 grid grid-cols-4 gap-5 sm:grid-cols-6 lg:grid-cols-12">
          {icons.map((ic, i) => (
            <button
              key={ic}
              onClick={() => onPick(ic)}
              aria-pressed={ic === icon}
              className="group text-center"
            >
              <img
                src={`/icons/${ic}`}
                alt={`App icon ${i + 1}`}
                loading="lazy"
                className={`mx-auto aspect-square w-full max-w-20 rounded-[22%] shadow-sm ring-black/5 transition-transform duration-300 group-hover:-translate-y-1 group-active:scale-95 ${
                  ic === icon ? "ring-2 ring-ink ring-offset-2 ring-offset-paper" : "ring-1"
                }`}
              />
              <span className="mt-2 block text-xs text-muted">
                {ic === icon ? "Selected" : i === DEFAULT_ICON_INDEX ? "Default" : "\u00a0"}
              </span>
            </button>
          ))}
        </Reveal>
      </div>
    </section>
  );
}

export function SelfHost() {
  return (
    <section id="self-host" className="scroll-mt-16 px-5 pb-24">
      <Reveal className="mx-auto grid max-w-6xl items-center gap-10 rounded-3xl bg-black p-8 text-white dark:ring-1 dark:ring-white/10 sm:p-12 lg:grid-cols-2">
        <div>
          <h2 className="font-display text-4xl tracking-tight sm:text-5xl">
            Free. Open source.
            <br />
            Yours to run.
          </h2>
          <p className="mt-5 max-w-md text-lg leading-relaxed text-white/65">
            No subscription and no ads. Run your own instance and pay only for
            the flight data APIs you use.
          </p>
          <a
            href={GITHUB}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-8 inline-flex items-center gap-2 rounded-full bg-white px-6 py-3 font-medium text-black transition-transform active:scale-[0.97]"
          >
            <GithubMark />
            View on GitHub
          </a>
        </div>
        <pre className="overflow-x-auto rounded-2xl bg-white/[0.06] p-6 font-mono text-sm leading-7 ring-1 ring-white/10">
          <code>
            <span className="text-white/40">$ </span>git clone {GITHUB}
            {"\n"}
            <span className="text-white/40">$ </span>cd aero/api && bun install
            {"\n"}
            <span className="text-white/40">$ </span>bun run start:dev
            {"\n\n"}
            <span className="text-white/40"># then, in app/</span>
            {"\n"}
            <span className="text-white/40">$ </span>flutter run --dart-define-from-file=.env
          </code>
        </pre>
      </Reveal>
    </section>
  );
}

export function Footer({ icon }: { icon: string }) {
  return (
    <footer className="border-t border-line">
      <div className="mx-auto flex max-w-6xl flex-wrap items-center justify-between gap-4 px-5 py-8 text-sm text-muted">
        <div className="flex items-center gap-2.5">
          <img src={`/icons/${icon}`} alt="" className="h-6 w-6 rounded-[7px]" />
          <span>Aero · flight tracking in full detail</span>
        </div>
        <a href={GITHUB} target="_blank" rel="noopener noreferrer" className="hover:text-ink">
          GitHub
        </a>
      </div>
    </footer>
  );
}
