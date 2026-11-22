import { Airport } from '@prisma/client';
import { prisma } from 'src/db';

/** Keys: 'I:<iata>' and 'C:<icao>'. */
export type AirportIndex = Map<string, Airport>;

export async function loadAirportIndex(
  codes: { iata?: string; icao?: string }[],
): Promise<AirportIndex> {
  const iatas = [...new Set(codes.map((c) => c.iata).filter(Boolean))] as string[];
  const icaos = [...new Set(codes.map((c) => c.icao).filter(Boolean))] as string[];
  const index: AirportIndex = new Map();
  if (!iatas.length && !icaos.length) return index;
  const rows = await prisma.airport.findMany({
    where: {
      OR: [
        { iataCode: { in: iatas } },
        { gpsCode: { in: icaos } },
        { ident: { in: icaos } },
      ],
    },
  });
  for (const a of rows) {
    if (a.iataCode) index.set(`I:${a.iataCode}`, a);
    if (a.gpsCode) index.set(`C:${a.gpsCode}`, a);
    index.set(`C:${a.ident}`, a);
  }
  return index;
}
