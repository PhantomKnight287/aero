import { inboundCacheTtl } from './aircraft-history.util';

describe('inboundCacheTtl', () => {
  it('keeps an airborne inbound leg fresh (120s)', () => {
    expect(inboundCacheTtl({ actual_off: '2026-11-15T06:00:00Z' })).toBe(120);
  });
  it('caches a landed leg for an hour', () => {
    expect(inboundCacheTtl({ actual_on: '2026-11-15T09:00:00Z' })).toBe(3600);
    expect(inboundCacheTtl({ actual_in: '2026-11-15T09:10:00Z' })).toBe(3600);
  });
  it('caches a cancelled leg for an hour', () => {
    expect(inboundCacheTtl({ cancelled: true })).toBe(3600);
  });
});
