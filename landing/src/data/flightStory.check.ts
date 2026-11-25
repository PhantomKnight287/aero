import { frameAt, STATES as S } from "./flightStory.ts";
const a = (c: boolean, m: string) => { if (!c) throw Error(m); };
a(frameAt(-1).index === 0, "clamp low");
a(frameAt(1).index === S.length - 1, "p=1 is last");
a(frameAt(2).plane === 100, "clamp high");
const i = S.findIndex((s) => s.key === "inflight"); const n = S.length;
a(frameAt((i + 0.5) / n).plane === 25, "lerp mid in-flight");
a(frameAt(0).plane === 0, "start at 0");
console.log("ok");
