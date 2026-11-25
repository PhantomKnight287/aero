# Landing Scroll Story + Wear OS Row Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the static hero `FlightStrip` with a pinned, scroll-driven flight story (strip + mirrored watch), and add a Wear OS Features row.

**Architecture:** Pure state data + a `frameAt(progress)` mapper in one data file; a `FlightStory` component reads section scroll progress via one passive rAF-throttled listener and renders strip + `Watch`. `Watch` is a new primitive reused by the Features row.

**Tech Stack:** React 19, Tailwind v4 (tokens in `landing/src/index.css`), Vite, bun. No new deps.

**Spec:** `docs/superpowers/specs/2026-11-25-landing-scroll-story-design.md`

## Global Constraints

- No new dependencies.
- Colors only from `@theme` tokens: `ink`, `muted`, `line`, `panel`, `success`, `danger`, `warn`.
- Flight data matches watch previews: UA1581 · UAL1581 · Mon 23 Nov · LAX (KLAX, Gate 77) → EWR (KEWR, Gate C125); dep sched 10:30 actual 10:24; arr sched 15:38 est 15:15.
- `prefers-reduced-motion: reduce` → no sticky, no scroll mapping; stacked list.
- Use bun, not npm.

## Review Focus

- Reload mid-section (browser restores scroll): story must show the correct state on first paint, not Scheduled. → Task 2 Step 4 checks.
- Progress exactly 1.0 (bottom of section): must show Arrived, not index out of range. → Task 1 check.
- Progress < 0 or > 1 (section above/below viewport): clamp. → Task 1 check.
- Clicking a state label lands on that state, not the boundary of the previous one. → Task 2 Step 4.
- Narrow phone (375px): strip times and watch fit without horizontal scroll. → Task 2 Step 4.

---

### Task 1: Story data + `frameAt`

**Files:**
- Create: `landing/src/data/flightStory.ts`
- Create: `landing/public/watch/{scheduled,inflight,late,arrived,list,panels,ambient}.webp`

**Interfaces:**
- Produces:
  ```ts
  export type Tone = "muted" | "success" | "danger" | "warn";
  export type StoryState = {
    key: string; label: string; status: string; tone: Tone;
    dep: { time: string; sched?: string; delta?: string; tone: Tone };
    arr: { time: string; sched?: string; delta?: string; tone: Tone };
    line: string;            // centre/sub line, e.g. "departed 2h 10m ago · 2h 40m left"
    plane: [number, number]; // % range along the bar for this state
    watch: string;           // /watch/*.webp
  };
  export const STATES: StoryState[];
  export function frameAt(progress: number): { index: number; plane: number };
  ```

- [ ] **Step 1: Convert assets.** From `wearos/app/src/screenshotTestDebug/reference/fyi/procrastinator/aero/ScreenshotPreviewsKt/`, the `_c345b2a8_0.png` (454px) files for Scheduled, InFlight, Late, Arrived, List, Panels, Ambient: `cwebp -q 85 <in> -o landing/public/watch/<lower>.webp`.
- [ ] **Step 2: Write `STATES`** in this order with plane ranges: Scheduled [0,0], Boarding [0,0], Taxiing [0,4], In flight [4,46], Late [46,70], Landed [70,98], Arrived [100,100]. Watch: Scheduled/Boarding→scheduled, Taxiing/In flight→inflight, Late→late, Landed/Arrived→arrived. Late state: arr time red (`danger`) e.g. 15:52 vs 15:38 "14m late". Other copy is builder's call within Global Constraints.
- [ ] **Step 3: Implement `frameAt`.** Clamp progress to [0,1]; `index = min(floor(p*n), n-1)`; `local = p*n - index` (clamped 0..1); `plane = lerp(range[0], range[1], local)`.
- [ ] **Step 4: Check.**
  Run from `landing/`:
  ```bash
  bun -e 'import {frameAt,STATES as S} from "./src/data/flightStory.ts";
  const a=(c,m)=>{if(!c)throw Error(m)};
  a(frameAt(-1).index===0,"clamp low");
  a(frameAt(1).index===S.length-1,"p=1 is last");
  a(frameAt(2).plane===100,"clamp high");
  const i=S.findIndex(s=>s.key==="inflight"); const n=S.length;
  a(frameAt((i+0.5)/n).plane===25,"lerp mid in-flight");
  console.log("ok")'
  ```
  Expected: `ok`
- [ ] **Step 5: Commit** `feat(landing): flight story states and watch assets`

### Task 2: `Watch` primitive + `FlightStory` section

**Files:**
- Modify: `landing/src/components/primitives.tsx` (add `Watch`)
- Create: `landing/src/components/FlightStory.tsx`
- Modify: `landing/src/components/Hero.tsx` (delete `FlightStrip`, its call)
- Modify: `landing/src/App.tsx` (render `<FlightStory />` after `<Hero />`)
- Modify: `landing/src/index.css` (delete now-unused `.fly` rules)

**Interfaces:**
- Consumes: `STATES`, `frameAt` from Task 1.
- Produces: `export function Watch({ src, alt, className }: { src: string; alt: string; className?: string })` — round frame: `rounded-full overflow-hidden` image inside an `bg-ink` bezel ring with shadow, sized by `className` width, `aspect-square`.

- [ ] **Step 1: `Watch`** in `primitives.tsx` per interface; lazy-loaded img.
- [ ] **Step 2: `FlightStory`.**
  - `useReducedMotion()` via `matchMedia("(prefers-reduced-motion: reduce)")` (local helper in the file).
  - Reduced: render each `STATES` item as strip + small `Watch`, stacked.
  - Else: `<section ref style={{height: `${STATES.length*80}vh`}}>` with inner `sticky top-16 h-[calc(100svh-4rem)]` flex-centred.
  - Progress: `(-rect.top) / (rect.height - innerHeight)`; compute once on mount (restored-scroll case) and on `scroll` (passive, rAF-throttled). Store `progress` in state; derive frame with `frameAt`.
  - Label row: buttons for each state; active one `text-ink font-semibold`, others `text-muted`; click → `window.scrollTo({ top: sectionTop + ((i+0.5)/n)*(height - innerHeight), behavior: "smooth" })`.
  - Strip: reuse the old `FlightStrip` markup, fed from current state; plane `left: ${frame.plane}%`, progress fill same width. Tone→class map: `success→text-success`, `danger→text-danger`, `warn→text-warn`, `muted→text-muted`; dot uses `bg-*` equivalent.
  - Watch beside strip (`lg:` row, stacked below on mobile, `w-[200px] sm:w-[260px]`). Crossfade: render all 4 distinct watch images absolutely stacked, `opacity-100` on current, `transition-opacity duration-300`.
  - Section heading via `SectionTitle kicker="Live" title="One flight, start to finish."` above sticky content (builder may adjust copy).
- [ ] **Step 3: Remove `FlightStrip`** from `Hero.tsx` and `.fly` CSS; add `<FlightStory />` in `App.tsx`.
- [ ] **Step 4: Verify.** `bun run build && bun run lint` → no errors. `bun run dev`, open in browser:
  - Scroll through: status/times/watch step through all 7 states; plane moves smoothly; Late shows red arrival.
  - Reload while mid-section → correct state on first paint.
  - Click each label → that state shows.
  - 375px width: no horizontal scroll.
  - Emulate reduced motion → stacked list, no sticky.
- [ ] **Step 5: Commit** `feat(landing): scroll-driven flight story with watch`

### Task 3: Wear OS Features row

**Files:**
- Modify: `landing/src/components/Features.tsx`
- Modify: `landing/src/components/Sections.tsx` (remove Wear OS item from `details`, drop unused `Watch` lucide import)

**Interfaces:**
- Consumes: `Watch` from Task 2.

- [ ] **Step 1:** Add optional `watches?: string[]` to feature items; when present render an offset stack of 3 `Watch`es (list, panels, ambient; largest centre, two smaller behind, slight rotation) instead of `Phone`. Append item: title "On your wrist", body about sending flights to the watch, live status, gate/times, ambient mode; chips e.g. "Wear OS", "Synced from phone", "Gate · times · status", "Ambient mode", "Aircraft and inbound".
- [ ] **Step 2:** Remove Wear OS entry from `details` in `Sections.tsx` (grid becomes 5; fine).
- [ ] **Step 3: Verify.** `bun run build && bun run lint` clean; row 06 renders, alternates side correctly, no layout break at 375px.
- [ ] **Step 4: Commit** `feat(landing): Wear OS features row`
