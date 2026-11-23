import { AircraftIndex } from '../aircraft-index';
import { FAMILIES, TYPE_NAMES, codeForModel, familyOf } from '../families';
import { StatsFlight } from '../stats-flight';

type Airframe = { reg: string; typeCode?: string; typeName?: string; ageYears: number; image?: string; flight: StatsFlight };

const localDate = (f: StatsFlight) =>
  `${f.local.year}-${String(f.local.month).padStart(2, '0')}-${String(f.local.day).padStart(2, '0')}`;
const newestFirst = (a: StatsFlight, b: StatsFlight) => b.date.getTime() - a.date.getTime();
const round1 = (n: number) => Math.round(n * 10) / 10;

export function aircraftReport(fs: StatsFlight[], idx: AircraftIndex) {
  const regName = (f: StatsFlight) => (f.reg ? idx.byReg.get(f.reg)?.typeName : undefined) ?? f.typeName;

  // A code-less flight borrows the ICAO code of another flight whose
  // registry type name matches (registry names are coarser than codes).
  const codeByName = new Map<string, string>();
  for (const f of fs) {
    const n = regName(f);
    if (f.typeCode && n && !codeByName.has(n)) codeByName.set(n, f.typeCode);
  }
  const codeOf = (f: StatsFlight) =>
    f.typeCode ?? codeByName.get(regName(f) ?? '') ?? codeForModel(regName(f));

  type Type = { typeCode?: string; typeName: string; image?: string; flights: StatsFlight[] };
  const types = new Map<string, Type>();
  const regFlights = new Map<string, StatsFlight[]>();
  for (const f of fs) {
    if (f.reg) regFlights.set(f.reg, [...(regFlights.get(f.reg) ?? []), f]);
    const code = codeOf(f);
    const name = (code && TYPE_NAMES[code]) || regName(f) || code;
    if (!name) continue;
    const key = code ?? name;
    const t = types.get(key) ?? { typeCode: code, typeName: name, flights: [] };
    t.image ??= f.reg ? idx.byReg.get(f.reg)?.image : undefined;
    t.flights.push(f);
    types.set(key, t);
  }

  const typeList = [...types.values()]
    .map((t) => ({ ...t, flightCount: t.flights.length, flights: [...t.flights].sort(newestFirst) }))
    .sort((a, b) => b.flightCount - a.flightCount);

  const families = FAMILIES.map((fam) => {
    const flown = fs.filter((f) => familyOf(codeOf(f)) === fam.name);
    return {
      family: fam.name,
      typeCodes: fam.codes,
      flightCount: flown.length,
      firstFlown: flown.map(localDate).sort()[0] ?? null,
    };
  });
  // Flown by count, then unflown in map order (stable sort, both counts 0).
  families.sort((a, b) => b.flightCount - a.flightCount);

  const airframes: Airframe[] = [];
  for (const [reg, flights] of regFlights) {
    const r = idx.byReg.get(reg);
    if (r?.ageYears == null || r.ageYears <= 0) continue;
    const flight = [...flights].sort(newestFirst)[0];
    const code = codeOf(flight);
    airframes.push({
      reg, typeCode: code, typeName: (code && TYPE_NAMES[code]) || r.typeName,
      ageYears: round1(r.ageYears), image: r.image, flight,
    });
  }
  airframes.sort((a, b) => b.ageYears - a.ageYears);
  const ages = airframes.map((a) => a.ageYears).sort((a, b) => a - b);
  const mid = Math.floor(ages.length / 2);
  const median = !ages.length ? null : ages.length % 2 ? ages[mid] : round1((ages[mid - 1] + ages[mid]) / 2);

  const top = [...regFlights].sort((a, b) => b[1].length - a[1].length)[0];
  const topCode = top && codeOf(top[1][0]);
  const mostFlownTail = top && top[1].length >= 2
    ? { reg: top[0], typeName: (topCode && TYPE_NAMES[topCode]) || regName(top[1][0]), count: top[1].length }
    : null;

  return {
    basedOn: typeList.reduce((n, t) => n + t.flightCount, 0),
    types: typeList,
    families,
    airframes: {
      medianAgeYears: median,
      oldest: airframes[0] ?? null,
      newest: airframes[airframes.length - 1] ?? null,
      mostFlownTail,
    },
  };
}
