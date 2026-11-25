import { useLayoutEffect, useRef, useState } from "react";
import { STATES, frameAt, type StoryState, type Tone } from "@/data/flightStory";
import { SectionTitle, Watch } from "./primitives";

const PLANE =
  "M21 16v-2l-8-5V3.5a1.5 1.5 0 0 0-3 0V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5Z";
const NAV = 64; // sticky offset: the nav's h-16

const text: Record<Tone, string> = {
  muted: "text-muted",
  success: "text-success",
  danger: "text-danger",
  warn: "text-warn",
};
const dot: Record<Tone, string> = {
  muted: "bg-muted",
  success: "bg-success",
  danger: "bg-danger",
  warn: "bg-warn",
};

function useReducedMotion() {
  const [reduced] = useState(
    () => window.matchMedia("(prefers-reduced-motion: reduce)").matches,
  );
  return reduced;
}

/**
 * One flight, start to finish: the section is tall, its content sticks, and
 * scrolling through it steps the strip and the watch through every state.
 */
export function FlightStory() {
  const reduced = useReducedMotion();
  const ref = useRef<HTMLDivElement>(null);
  const [progress, setProgress] = useState(0);

  // Layout effect so a reload mid-section paints the right state first.
  useLayoutEffect(() => {
    if (reduced) return;
    const measure = () => {
      const el = ref.current;
      if (!el) return;
      const r = el.getBoundingClientRect();
      setProgress((NAV - r.top) / (r.height - window.innerHeight + NAV));
    };
    measure();
    let frame = 0;
    const onScroll = () => {
      cancelAnimationFrame(frame);
      frame = requestAnimationFrame(measure);
    };
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", onScroll);
    return () => {
      cancelAnimationFrame(frame);
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", onScroll);
    };
  }, [reduced]);

  const title = (
    <SectionTitle kicker="Live" title="One flight, start to finish.">
      <span className="hidden sm:inline">
        Scroll to follow UA1581 from the gate in Los Angeles to the belt in
        Newark, on your phone and on your wrist.
      </span>
    </SectionTitle>
  );

  if (reduced) {
    return (
      <section id="story" className="scroll-mt-16 border-t border-line py-24">
        <div className="mx-auto max-w-6xl space-y-10 px-5">
          {title}
          {STATES.map((s) => (
            <div key={s.key} className="grid items-center gap-6 md:grid-cols-[1fr_200px]">
              <Strip s={s} plane={s.plane[1]} />
              <Watch className="mx-auto w-[180px]">
                <WatchFace s={s} plane={s.plane[1]} />
              </Watch>
            </div>
          ))}
        </div>
      </section>
    );
  }

  const { index, plane } = frameAt(progress);
  const s = STATES[index];
  const n = STATES.length;

  const jump = (i: number) => {
    const el = ref.current;
    if (!el) return;
    const top = el.getBoundingClientRect().top + window.scrollY;
    const span = el.offsetHeight - window.innerHeight + NAV;
    window.scrollTo({ top: top - NAV + ((i + 0.5) / n) * span, behavior: "smooth" });
  };

  return (
    <section id="story" className="scroll-mt-16 border-t border-line pt-24">
      {/* Title scrolls normally so the pinned panel fits short phones. */}
      <div className="mx-auto max-w-6xl px-5">{title}</div>
      <div ref={ref} style={{ height: `${n * 80}vh` }}>
        <div className="sticky top-16 flex h-[calc(100svh-4rem)] items-center overflow-hidden">
          <div className="mx-auto w-full max-w-6xl px-5">
            <div className="flex flex-wrap gap-x-1 gap-y-1">
              {STATES.map((st, i) => (
                <button
                  key={st.key}
                  onClick={() => jump(i)}
                  aria-current={i === index ? "step" : undefined}
                  className={`rounded-full px-3 py-1 text-sm transition-colors ${
                    i === index
                      ? "bg-ink font-semibold text-white"
                      : i < index
                        ? "text-ink hover:bg-panel"
                        : "text-muted hover:bg-panel"
                  }`}
                >
                  {st.label}
                </button>
              ))}
            </div>
            <div className="mt-4 grid items-center gap-4 sm:mt-8 sm:gap-6 lg:grid-cols-[1fr_280px] lg:gap-12">
              <Strip s={s} plane={plane} />
              <Watch className="mx-auto w-[150px] sm:w-[240px] lg:w-[280px] [@media(max-height:640px)]:w-[120px]">
                <WatchFace s={s} plane={plane} />
              </Watch>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

function TimeLine({ t, right = false }: { t: StoryState["dep"]; right?: boolean }) {
  const parts = [
    <span key="t" className={`font-semibold ${t.tone === "muted" ? "" : text[t.tone]}`}>
      {t.time}
    </span>,
    t.sched && (
      <span key="s" className="text-muted line-through">
        {t.sched}
      </span>
    ),
    <span key="d" className={text[t.tone]}>
      {t.delta}
    </span>,
  ].filter(Boolean);
  if (right) parts.reverse();
  return <p className="flex gap-1.5 whitespace-nowrap">{parts}</p>;
}

/** The app's flight header, spelled out for one moment of the flight. */
function Strip({ s, plane }: { s: StoryState; plane: number }) {
  return (
    <div className="rounded-2xl bg-panel p-5 sm:p-6">
      <div className="flex flex-wrap items-baseline justify-between gap-x-6 gap-y-1">
        <p className="hidden text-xs font-semibold uppercase tracking-[0.12em] text-muted tabular sm:block">
          UA1581 · UAL1581 · Mon 23 Nov · Boeing 777-200 · N797UA
        </p>
        <p key={s.key} className="swap flex items-center gap-2 text-sm font-semibold">
          <span className={`h-2 w-2 rounded-full ${dot[s.tone]}`} /> {s.status}
        </p>
      </div>
      <div className="mt-4 flex items-center gap-4">
        <div>
          <p className="font-display text-3xl">LAX</p>
          <p className="text-xs text-muted">KLAX · Gate 77</p>
        </div>
        <div className="relative h-6 flex-1">
          <div className="absolute inset-x-0 top-1/2 h-[3px] -translate-y-1/2 rounded bg-line" />
          <div
            className="absolute left-0 top-1/2 h-[3px] -translate-y-1/2 rounded bg-ink"
            style={{ width: `${plane}%` }}
          />
          <span
            className="absolute top-1/2 flex h-6 w-6 -translate-x-1/2 -translate-y-1/2 items-center justify-center rounded-full bg-ink text-white"
            style={{ left: `${plane}%` }}
          >
            <svg viewBox="0 0 24 24" className="h-3.5 w-3.5 rotate-90" fill="currentColor" aria-hidden>
              <path d={PLANE} />
            </svg>
          </span>
        </div>
        <div className="text-right">
          <p className="font-display text-3xl">EWR</p>
          <p className="text-xs text-muted">KEWR · Gate C125</p>
        </div>
      </div>
      <div key={s.key} className="swap mt-3 flex justify-between gap-3 text-xs tabular sm:text-sm">
        <TimeLine t={s.dep} />
        <TimeLine t={s.arr} right />
      </div>
      <p key={`${s.key}-line`} className="swap mt-4 border-t border-line pt-3 text-sm text-ink-soft">
        {s.line}
      </p>
    </div>
  );
}

// Wear OS colours on black, from the watch app.
const watchTone: Record<Tone, string> = {
  muted: "#9e9e9e",
  success: "#4caf50",
  danger: "#ef5350",
  warn: "#ffa726",
};

/**
 * The Wear OS flight screen redrawn as SVG, so it shows the same flight as
 * the strip and the plane can ride the arc as you scroll.
 */
function WatchFace({ s, plane }: { s: StoryState; plane: number }) {
  const cx = 227, cy = 200, r = 132;
  const theta = Math.PI * (1 - plane / 100);
  const px = cx + r * Math.cos(theta);
  const py = cy - r * Math.sin(theta);
  const heading = (Math.atan2(r * Math.sin(theta), -r * Math.cos(theta)) * 180) / Math.PI;
  const arc = (from: number, to: number) => {
    const a = Math.PI * (1 - from / 100), b = Math.PI * (1 - to / 100);
    return `M ${cx + r * Math.cos(a)} ${cy - r * Math.sin(a)} A ${r} ${r} 0 0 1 ${cx + r * Math.cos(b)} ${cy - r * Math.sin(b)}`;
  };
  const time = (t: StoryState["dep"]) => (t.tone === "muted" ? "#fff" : watchTone[t.tone]);
  return (
    <svg
      viewBox="0 0 454 454"
      className="block h-full w-full font-sans"
      role="img"
      aria-label={`Wear OS: ${s.status}, ${s.sub}`}
    >
      <text x={227} y={34} textAnchor="middle" fill="#bdbdbd" fontSize={26} fontWeight={600}>
        {s.clock}
      </text>
      <path d={arc(0, 100)} stroke="#4a4a4a" strokeWidth={7} fill="none" strokeLinecap="round" />
      {plane > 0 && (
        <path d={arc(0, plane)} stroke="#fff" strokeWidth={7} fill="none" strokeLinecap="round" />
      )}
      <g transform={`translate(${px} ${py})`}>
        <circle r={20} fill="#fff" />
        <g transform={`rotate(${heading}) translate(-12 -12)`}>
          <path d={PLANE} fill="#000" />
        </g>
      </g>
      <g key={s.key} className="swap">
        <text x={227} y={188} textAnchor="middle" fill="#fff" fontSize={24}>
          <tspan fill={watchTone[s.tone]}>● </tspan>
          {s.status}
        </text>
        <text x={227} y={222} textAnchor="middle" fill="#9e9e9e" fontSize={20}>
          {s.sub}
        </text>
        <text x={47} y={262} fill="#fff" fontSize={38} fontWeight={700}>LAX</text>
        <text x={408} y={262} textAnchor="end" fill="#fff" fontSize={38} fontWeight={700}>EWR</text>
        <text x={47} y={318} fill={time(s.dep)} fontSize={34} fontWeight={700}>{s.dep.time}</text>
        <text x={408} y={318} textAnchor="end" fill={time(s.arr)} fontSize={34} fontWeight={700}>
          {s.arr.time}
        </text>
        <text x={47} y={352} fill={watchTone[s.dep.tone]} fontSize={21}>{s.dep.delta}</text>
        <text x={408} y={352} textAnchor="end" fill={watchTone[s.arr.tone]} fontSize={21}>
          {s.arr.delta}
        </text>
      </g>
      <text x={227} y={390} textAnchor="middle" fill="#9e9e9e" fontSize={17} fontWeight={600} letterSpacing={1}>
        UA1581 · UAL1581
      </text>
      <text x={227} y={414} textAnchor="middle" fill="#9e9e9e" fontSize={17} fontWeight={600} letterSpacing={1}>
        MON 23 NOV
      </text>
    </svg>
  );
}
