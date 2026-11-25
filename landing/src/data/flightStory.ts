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
    key: "boarding",
    label: "Boarding",
    status: "Boarding",
    tone: "success",
    sub: "Gate 77",
    line: "Boarding at gate 77 · doors close 10:15",
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
    line: "Departed 2h 10m ago · FL370 · 489 kt",
    clock: "10:09",
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
    line: "Holding over Newark · arrival pushed back",
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
