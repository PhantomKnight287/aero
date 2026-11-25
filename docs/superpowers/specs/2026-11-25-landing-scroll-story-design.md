# Landing: scroll-driven flight story + Wear OS row

## Why
The landing page feels static and doesn't show the Wear OS app at all (one
tile in "And more"). The fixed `FlightStrip` under the hero only shows one
moment of one flight.

## Goals
- Scrolling walks one flight (UA1581 LAX→EWR, same data as the app and watch
  previews) through its life, with a watch mirroring each state.
- Wear OS gets a proper Features row.

## Non-goals / anti-goals
- No new dependencies (no GSAP / Framer Motion).
- Must not trap or hijack scroll; page must stay usable with reduced motion
  and on mobile.

## Approaches
- **A. Pinned scroll story (picked).** Tall section, sticky inner panel; scroll
  drives plane position continuously and state steps discretely; watch beside.
- B. Animate the hero strip only. Small, but no watch, so it misses the gap.
- C. Tap-through stepper. Simpler, loses the scroll feel the user wanted.

## Design
**`FlightStory` section** (new file `landing/src/components/FlightStory.tsx`),
replaces `FlightStrip` in `Hero.tsx`.
- Outer `<section>` ~`h-[500vh]`; inner `sticky top-16 h-[calc(100vh-4rem)]`.
- One `scroll` listener (rAF-throttled, passive) maps section progress 0..1
  to `progress` state. Derive `step = floor(progress * states.length)`.
- States (data array, one object each): Scheduled, Boarding, Taxiing,
  In flight, Late (delay branch, red times), Landed, Arrived. Each carries
  status label + dot color, dep/arr times, delta text, gate line, subline,
  plane % range, and watch image.
- Plane position interpolates within the current state's % range so it moves
  smoothly; text/colors swap per step with a short crossfade.
- Top row of state labels; active one highlighted; clicking scrolls to that
  state's offset (`window.scrollTo` smooth).
- Watch: round frame (CSS circle, `rounded-full overflow-hidden` + dark bezel
  ring) around 454px PNGs. Mapping: Scheduled/Boarding→Scheduled,
  Taxiing/In flight→InFlight, Late→Late, Landed/Arrived→Arrived.
- Mobile: strip on top, watch below, smaller; same scroll mechanics.
- `prefers-reduced-motion`: no sticky/scroll; render states as a stacked list
  (strip + watch per state).

**Wear OS Features row** — append "06 · On your wrist" to `features` in
`Features.tsx`, with a round watch frame instead of `Phone` (List, Panels,
Ambient previews, small offset stack). Remove the Wear OS tile from `Details`.
Add a `Watch` primitive in `primitives.tsx`, reused by both.

**Assets** — copy needed PNGs to `landing/public/watch/`, converted to webp
(matches existing `screens/`).

## Left to the builder
Exact state copy/times (keep consistent with app data), section height tuning,
crossfade timing.

## Calls made (not explicitly decided by user)
- Late shown as its own step between In flight and Landed.
- Missing watch states use nearest screenshot rather than adding new previews.
- Section placed where `FlightStrip` is now (directly under hero).

## Round 2 (approved 2026-11-25)
1. Inbound step between Scheduled and Boarding: amber dot, "Inbound 25m late",
   departure "At risk" (warn); Boarding recovers ("Quick turn · back on time").
2. METAR chip on Landed/Arrived: raw `KEWR 232051Z 22014KT 10SM BKN045 08/M02 A3002`
   + decoded line.
3. Tappable units on In flight / Delayed: altitude FL370 → 37,000 ft → 11,278 m;
   speed 489 kt → 906 km/h → 563 mph. Pure formatters covered by the check file.
6. Clicking an app icon sets nav logo, footer logo and favicon (state in App, no persistence).
7. Dark mode via `prefers-color-scheme` only: override ink/ink-soft/muted/line/panel vars,
   new `paper` token for white-on-ink; phone frame and Self-host block stay literal black.
8. Re-measure story progress on `load` and `pageshow`.
Skipped: manual theme toggle, persisted icon choice.
