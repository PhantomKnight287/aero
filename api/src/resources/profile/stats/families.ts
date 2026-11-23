/** Aircraft families for the type collection, in display order (spec table). */
export const FAMILIES: { name: string; codes: string[] }[] = [
  { name: 'A220', codes: ['BCS1', 'BCS3'] },
  { name: 'A320 family', codes: ['A318', 'A319', 'A320', 'A321', 'A19N', 'A20N', 'A21N'] },
  { name: 'A330', codes: ['A332', 'A333', 'A338', 'A339'] },
  { name: 'A340', codes: ['A342', 'A343', 'A345', 'A346'] },
  { name: 'A350', codes: ['A359', 'A35K'] },
  { name: 'A380', codes: ['A388'] },
  { name: '737', codes: ['B735', 'B736', 'B737', 'B738', 'B739', 'B37M', 'B38M', 'B39M', 'B3XM'] },
  { name: '747', codes: ['B744', 'B748'] },
  { name: '757', codes: ['B752', 'B753'] },
  { name: '767', codes: ['B762', 'B763', 'B764'] },
  { name: '777', codes: ['B772', 'B773', 'B77L', 'B77W', 'B778', 'B779'] },
  { name: '787', codes: ['B788', 'B789', 'B78X'] },
  { name: 'ATR', codes: ['AT43', 'AT45', 'AT72', 'AT75', 'AT76'] },
  { name: 'Dash 8', codes: ['DH8A', 'DH8B', 'DH8C', 'DH8D'] },
  { name: 'E-Jets', codes: ['E170', 'E75L', 'E75S', 'E190', 'E195', 'E290', 'E295'] },
  { name: 'CRJ', codes: ['CRJ1', 'CRJ2', 'CRJ7', 'CRJ9', 'CRJX'] },
];

const byCode = new Map(FAMILIES.flatMap((f) => f.codes.map((c) => [c, f.name] as const)));

export const familyOf = (code?: string) => (code ? byCode.get(code) : undefined);

/** ICAO type designator -> model name, for codes FlightAware reports. */
export const TYPE_NAMES: Record<string, string> = {
  BCS1: 'Airbus A220-100', BCS3: 'Airbus A220-300',
  A318: 'Airbus A318', A319: 'Airbus A319', A320: 'Airbus A320', A321: 'Airbus A321',
  A19N: 'Airbus A319neo', A20N: 'Airbus A320neo', A21N: 'Airbus A321neo',
  A332: 'Airbus A330-200', A333: 'Airbus A330-300', A338: 'Airbus A330-800neo', A339: 'Airbus A330-900neo',
  A342: 'Airbus A340-200', A343: 'Airbus A340-300', A345: 'Airbus A340-500', A346: 'Airbus A340-600',
  A359: 'Airbus A350-900', A35K: 'Airbus A350-1000', A388: 'Airbus A380-800',
  B735: 'Boeing 737-500', B736: 'Boeing 737-600', B737: 'Boeing 737-700', B738: 'Boeing 737-800',
  B739: 'Boeing 737-900', B37M: 'Boeing 737 MAX 7', B38M: 'Boeing 737 MAX 8', B39M: 'Boeing 737 MAX 9',
  B3XM: 'Boeing 737 MAX 10',
  B744: 'Boeing 747-400', B748: 'Boeing 747-8',
  B752: 'Boeing 757-200', B753: 'Boeing 757-300',
  B762: 'Boeing 767-200', B763: 'Boeing 767-300', B764: 'Boeing 767-400',
  B772: 'Boeing 777-200', B773: 'Boeing 777-300', B77L: 'Boeing 777-200LR', B77W: 'Boeing 777-300ER',
  B778: 'Boeing 777-8', B779: 'Boeing 777-9',
  B788: 'Boeing 787-8', B789: 'Boeing 787-9', B78X: 'Boeing 787-10',
  AT43: 'ATR 42-300', AT45: 'ATR 42-500', AT72: 'ATR 72', AT75: 'ATR 72-500', AT76: 'ATR 72-600',
  DH8A: 'Dash 8-100', DH8B: 'Dash 8-200', DH8C: 'Dash 8-300', DH8D: 'Dash 8-400',
  E170: 'Embraer 170', E75L: 'Embraer 175', E75S: 'Embraer 175', E190: 'Embraer 190', E195: 'Embraer 195',
  E290: 'Embraer E190-E2', E295: 'Embraer E195-E2',
  CRJ1: 'CRJ100', CRJ2: 'CRJ200', CRJ7: 'CRJ700', CRJ9: 'CRJ900', CRJX: 'CRJ1000',
};

const norm = (s: string) => s.toLowerCase().replace(/[^a-z0-9]/g, '');
const codeByModel = new Map(Object.entries(TYPE_NAMES).reverse().map(([c, n]) => [norm(n), c]));

/** 'Airbus A320 NEO' -> 'A20N' when the registry name is an exact known model. */
export const codeForModel = (name?: string) => (name ? codeByModel.get(norm(name)) : undefined);
