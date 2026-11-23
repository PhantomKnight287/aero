import { makeStatsFlight as mk } from '../fixtures';
import { AircraftIndex, RegistryAirframe } from '../aircraft-index';
import { aircraftReport } from './aircraft';

const idx = (byReg: Record<string, RegistryAirframe> = {}): AircraftIndex => ({ byReg: new Map(Object.entries(byReg)) });
const on = (iso: string) => {
  const [year, month, day] = iso.split('-').map(Number);
  return { date: new Date(`${iso}T10:00:00Z`), local: { year, month, day, weekday: 0 } };
};

describe('aircraftReport', () => {
  it('empty', () => {
    const r = aircraftReport([], idx());
    expect(r.basedOn).toBe(0);
    expect(r.types).toEqual([]);
    expect(r.families).toHaveLength(16);
    expect(r.families.every((f) => f.flightCount === 0 && f.firstFlown === null)).toBe(true);
    expect(r.airframes).toEqual({ medianAgeYears: null, oldest: null, newest: null, mostFlownTail: null });
  });

  it('code-less flight learns its code from a flight with the same registry name', () => {
    const r = aircraftReport(
      [mk({ id: 'a', typeCode: 'B77W', reg: 'A6EPO' }), mk({ id: 'b', reg: 'A6EQA' })],
      idx({
        A6EPO: { modelCode: '777-31HER', typeName: 'Boeing 777-300', image: 'img' },
        A6EQA: { modelCode: '777-31HER', typeName: 'Boeing 777-300' },
      }),
    );
    expect(r.types).toHaveLength(1);
    expect(r.types[0]).toMatchObject({ typeCode: 'B77W', typeName: 'Boeing 777-300ER', flightCount: 2, image: 'img' });
    expect(r.basedOn).toBe(2);
  });

  it('ambiguous registry name learns no code', () => {
    const r = aircraftReport(
      [mk({ id: 'a', typeCode: 'B77W', reg: 'P' }), mk({ id: 'b', typeCode: 'B772', reg: 'Q' }), mk({ id: 'c', reg: 'R' })],
      idx({ P: { typeName: 'Boeing 777' }, Q: { typeName: 'Boeing 777' }, R: { typeName: 'Boeing 777' } }),
    );
    expect(r.types.map((t) => [t.typeCode, t.typeName, t.flightCount])).toEqual([
      ['B77W', 'Boeing 777-300ER', 1], ['B772', 'Boeing 777-200', 1], [undefined, 'Boeing 777', 1],
    ]);
  });

  it('registry model code is never used as a type code', () => {
    const r = aircraftReport([mk({ reg: 'X' })], idx({ X: { modelCode: '330-343E', typeName: 'Airbus A330' } }));
    expect(r.types).toEqual([expect.objectContaining({ typeCode: undefined, typeName: 'Airbus A330', flightCount: 1 })]);
  });

  it('registry name matching a known model maps to its code', () => {
    const r = aircraftReport(
      [mk({ id: 'a', typeCode: 'B789' }), mk({ id: 'b', reg: 'Y' }), mk({ id: 'c', reg: 'W' })],
      idx({ Y: { typeName: 'Boeing 787-9' }, W: { typeName: 'Airbus A320 NEO' } }),
    );
    expect(r.types.map((t) => [t.typeCode, t.flightCount])).toEqual([['B789', 2], ['A20N', 1]]);
  });

  it('age 0 is unknown', () => {
    const r = aircraftReport([mk({ reg: 'Z' })], idx({ Z: { ageYears: 0 } }));
    expect(r.airframes.oldest).toBeNull();
  });

  it('reg without type', () => {
    const r = aircraftReport([mk({ reg: 'X' })], idx());
    expect(r.basedOn).toBe(0);
    expect(r.types).toEqual([]);
  });

  it('unknown family', () => {
    const r = aircraftReport([mk({ typeCode: 'C25A' })], idx());
    expect(r.types.map((t) => t.typeName)).toEqual(['C25A']);
    expect(r.families.every((f) => f.flightCount === 0)).toBe(true);
  });

  it('families', () => {
    const r = aircraftReport(
      [mk({ id: 'a', typeCode: 'A20N', ...on('2025-03-01') }), mk({ id: 'b', typeCode: 'A321', ...on('2024-06-01') })],
      idx(),
    );
    expect(r.families[0]).toMatchObject({ family: 'A320 family', flightCount: 2, firstFlown: '2024-06-01' });
    expect(r.families[1].flightCount).toBe(0);
  });

  it('types sorted and flights newest first', () => {
    const r = aircraftReport(
      [mk({ id: 'a', typeCode: 'A388', ...on('2024-01-01') }), mk({ id: 'b', typeCode: 'B38M' }),
        mk({ id: 'c', typeCode: 'A388', ...on('2025-01-01') })],
      idx(),
    );
    expect(r.types.map((t) => t.typeCode)).toEqual(['A388', 'B38M']);
    expect(r.types[0].flights.map((f) => f.id)).toEqual(['c', 'a']);
  });

  it('airframes', () => {
    const reg = { R1: { ageYears: 27.1 }, R2: { ageYears: 0.8 }, R3: { ageYears: 9.4 } };
    const r = aircraftReport(
      [mk({ id: '1', reg: 'R1', ...on('2024-01-01') }), mk({ id: '2', reg: 'R1', ...on('2025-01-01') }),
        mk({ id: '3', reg: 'R2' }), mk({ id: '4', reg: 'R3' })],
      idx(reg),
    );
    expect(r.airframes.oldest).toMatchObject({ reg: 'R1', ageYears: 27.1 });
    expect(r.airframes.oldest!.flight.id).toBe('2');
    expect(r.airframes.newest).toMatchObject({ reg: 'R2' });
    expect(r.airframes.medianAgeYears).toBe(9.4);
    expect(r.airframes.mostFlownTail).toMatchObject({ reg: 'R1', count: 2 });
    const once = aircraftReport([mk({ reg: 'R1' }), mk({ reg: 'R2' })], idx(reg));
    expect(once.airframes.mostFlownTail).toBeNull();
  });
});
