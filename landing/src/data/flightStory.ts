/**
 * One flight, UA1581 LAX → EWR, told state by state. The landing page's
 * scroll story walks through these in order; the strip and the watch both
 * read from the same state so they never disagree.
 */

export type Tone = "muted" | "success" | "danger" | "warn";

export type Time = {
  time: string;
  /** Scheduled time, shown struck through when it differs from `time`. */
  sched?: string;
  delta: string;
  tone: Tone;
};

export type StoryState = {
  key: string;
  /** Short name for the step row. */
  label: string;
  status: string;
  /** Status dot colour. */
  tone: Tone;
  /** Line under the status, as on the watch. */
  sub: string;
  /** Wider line on the strip. */
  line: string;
  /** The watch's clock in this moment. */
  clock: string;
  dep: Time;
  arr: Time;
  /** Where the plane sits on the route, in %, across this state. */
  plane: [number, number];
  /** Live altitude (ft) and ground speed (kt), shown as tappable units. */
  alt?: number;
  speed?: number;
  /** Arrival airport METAR, raw and in plain words. */
  metar?: { raw: string; decoded: string };
};

const onTime = (time: string): Time => ({ time, delta: "On time", tone: "muted" });
const depEarly: Time = { time: "10:24", sched: "10:30", delta: "6m early", tone: "success" };

export const STATES: StoryState[] = [
  {
    key: "scheduled",
    label: "Scheduled",
    status: "Scheduled",
    tone: "success",
    sub: "Departs 10:30",
    line: "Terminal 7 · gate opens 09:45",
    clock: "08:40",
    dep: onTime("10:30"),
    arr: onTime("15:38"),
    plane: [0, 0],
  },
  {
    key: "inbound",
    label: "Inbound",
    status: "Scheduled",
    tone: "warn",
    sub: "Inbound 25m late",
    line: "N797UA inbound from SFO, landed 25m late",
    clock: "09:31",
    dep: { time: "10:30", delta: "At risk", tone: "warn" },
    arr: onTime("15:38"),
    plane: [0, 0],
  },
  {
    key: "boarding",
    label: "Boarding",
    status: "Boarding",
    tone: "success",
    sub: "Gate 77",
    line: "Quick turn · back on time · boarding at gate 77",
    clock: "09:58",
    dep: onTime("10:30"),
    arr: onTime("15:38"),
    plane: [0, 0],
  },
  {
    key: "taxiing",
    label: "Taxi",
    status: "Taxiing",
    tone: "success",
    sub: "Runway 25R",
    line: "Pushed back 10:24 · taxiing to runway 25R",
    clock: "10:27",
    dep: depEarly,
    arr: { time: "15:15", sched: "15:38", delta: "23m early", tone: "success" },
    plane: [0, 4],
  },
  {
    key: "inflight",
    label: "In flight",
    status: "In flight",
    tone: "success",
    sub: "2h 40m left",
    line: "Departed 2h 10m ago",
    alt: 37000,
    speed: 489,
    clock: "12:34",
    dep: depEarly,
    arr: { time: "15:15", sched: "15:38", delta: "23m early", tone: "success" },
    plane: [4, 46],
  },
  {
    key: "late",
    label: "Delayed",
    status: "In flight",
    tone: "warn",
    sub: "Holding · 38m left",
    line: "Holding over Newark",
    alt: 14000,
    speed: 230,
    clock: "14:41",
    dep: depEarly,
    arr: { time: "15:52", sched: "15:38", delta: "14m late", tone: "danger" },
    plane: [46, 92],
  },
  {
    key: "landed",
    label: "Landed",
    status: "Landed",
    tone: "success",
    sub: "Taxiing to C125",
    line: "Landed 15:49 on 22L · taxiing to gate C125",
    clock: "15:50",
    dep: depEarly,
    arr: { time: "15:49", sched: "15:38", delta: "11m late", tone: "danger" },
    plane: [92, 100],
    metar: {
      raw: "KEWR 232051Z 22014KT 10SM BKN045 08/M02 A3002",
      decoded: "Wind SW 14 kt · 10 mi · broken 4,500 ft · 8°C · 30.02 inHg",
    },
  },
  {
    key: "arrived",
    label: "Arrived",
    status: "Arrived",
    tone: "success",
    sub: "Gate C125 · belt 6",
    line: "At gate C125 · bags on belt 6",
    clock: "15:58",
    dep: depEarly,
    arr: { time: "15:54", sched: "15:38", delta: "16m late", tone: "danger" },
    plane: [100, 100],
    metar: {
      raw: "KEWR 232051Z 22014KT 10SM BKN045 08/M02 A3002",
      decoded: "Wind SW 14 kt · 10 mi · broken 4,500 ft · 8°C · 30.02 inHg",
    },
  },
];

/** Maps scroll progress through the story (0..1) to a state and plane %. */
export function frameAt(progress: number): { index: number; plane: number } {
  const n = STATES.length;
  const p = Math.min(Math.max(progress, 0), 1) * n;
  const index = Math.min(Math.floor(p), n - 1);
  const local = Math.min(p - index, 1);
  const [from, to] = STATES[index].plane;
  return { index, plane: from + (to - from) * local };
}

/** Altitude in flight level, feet or metres (unit 0, 1, 2). */
export function fmtAlt(ft: number, unit: number): string {
  if (unit === 0) return `FL${String(Math.round(ft / 100)).padStart(3, "0")}`;
  if (unit === 1) return `${ft.toLocaleString("en-US")} ft`;
  return `${Math.round(ft * 0.3048).toLocaleString("en-US")} m`;
}

/** Ground speed in knots, km/h or mph (unit 0, 1, 2). */
export function fmtSpeed(kt: number, unit: number): string {
  if (unit === 0) return `${kt} kt`;
  if (unit === 1) return `${Math.round(kt * 1.852)} km/h`;
  return `${Math.round(kt * 1.15078)} mph`;
}
