export const CONTINENT_BUCKETS = [
  'asia', 'europe', 'north_america', 'middle_east', 'oceania', 'africa',
  'central_america', 'caribbean', 'south_america',
] as const;
export type ContinentBucket = (typeof CONTINENT_BUCKETS)[number];

const set = (s: string) => new Set(s.split(' '));
const MIDDLE_EAST = set('AE BH CY EG IL IQ IR JO KW LB OM PS QA SA SY TR YE');
const CENTRAL_AMERICA = set('BZ CR GT HN MX NI PA SV');
const CARIBBEAN = set('AG AI AW BB BL BQ BS CU CW DM DO GD GP HT JM KN KY LC MF MQ MS PR SX TC TT VC VG VI');
const BY_CONTINENT: Record<string, ContinentBucket> = {
  AS: 'asia', EU: 'europe', NA: 'north_america', OC: 'oceania', AF: 'africa', SA: 'south_america',
};

/** Static ISO lists first, then the OurAirports continent; null when unknown. Never throws. */
export function continentBucket(isoCountry?: string | null, ourAirportsContinent?: string | null): ContinentBucket | null {
  const c = (isoCountry ?? '').toUpperCase();
  if (MIDDLE_EAST.has(c)) return 'middle_east';
  if (CENTRAL_AMERICA.has(c)) return 'central_america';
  if (CARIBBEAN.has(c)) return 'caribbean';
  return BY_CONTINENT[(ourAirportsContinent ?? '').toUpperCase()] ?? null;
}
