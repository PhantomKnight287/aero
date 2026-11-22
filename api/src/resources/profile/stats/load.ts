import { prisma } from 'src/db';
import { loadAirportIndex } from './airport-index';
import { isCounted, normalizeFlight } from './stats-flight';

/** Loads the user's log and returns counted flights with their source rows. */
export async function loadCountedFlights(userId: string, now: Date) {
  const rows = await prisma.flight.findMany({
    include: { greatCircleDistance: true, flightAwareData: true },
    where: { userId },
  });
  const codes = rows.flatMap((r) =>
    [r.departure, r.arrival].map((s: any) => s?.airport ?? {}),
  );
  const index = await loadAirportIndex(codes);
  return rows
    .map((row) => ({ row, f: normalizeFlight(row, index) }))
    .filter((x) => isCounted(x.f, now));
}
