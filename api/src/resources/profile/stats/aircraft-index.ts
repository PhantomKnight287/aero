import { prisma } from 'src/db';

export interface RegistryAirframe { typeName?: string; modelCode?: string; ageYears?: number; image?: string }
/** Registry `modelCode` is the manufacturer model ('777-31HER'), not an ICAO designator. */
export interface AircraftIndex { byReg: Map<string, RegistryAirframe> }

type Row = { reg: string; modelCode: string | null; typeName: string | null; image: string | null; age: unknown; createdAt: Date };

const YEAR_MS = 1000 * 60 * 60 * 24 * 365.25;

/** Registry lookups for the aircraft section, loaded in two queries. */
export async function loadAircraftIndex(regs: string[], now: Date): Promise<AircraftIndex> {
  const index: AircraftIndex = { byReg: new Map() };
  regs = [...new Set(regs)];
  if (!regs.length) return index;
  const [registrations, aircraft] = await Promise.all([
    prisma.aircraftRegistration.findMany({ where: { reg: { in: regs } }, include: { Aircraft: true } }),
    prisma.aircraft.findMany({ where: { reg: { in: regs } } }),
  ]);
  const airframe = (a: Row): RegistryAirframe => ({
    typeName: a.typeName ?? undefined,
    modelCode: a.modelCode ?? undefined,
    image: a.image ?? undefined,
    // Stored age was true when the row was written; 0 means unknown.
    ageYears: a.age == null || Number(a.age) <= 0
      ? undefined
      : Number(a.age) + (now.getTime() - a.createdAt.getTime()) / YEAR_MS,
  });
  for (const a of aircraft as Row[]) {
    if (a.reg) index.byReg.set(a.reg, airframe(a));
  }
  for (const r of registrations as any[]) if (r.Aircraft) index.byReg.set(r.reg, airframe(r.Aircraft));
  return index;
}
