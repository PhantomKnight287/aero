import { pb } from "./pb";

// const res = await pb.send("/flights", {
//   query: {
//     from: "DEL",
//     to: "SYD",
//     date: "2025-01-01",
//   },
// });

const res = await pb.send("/flight", {
  query: {
    id: "MH141",
  },
  requestKey: null,
});
console.dir(res, { depth: null });
