import { BadRequestException, ValidationPipe } from '@nestjs/common';
import { OptionalIntPipe } from './optional-int.pipe';

describe('OptionalIntPipe', () => {
  const pipe = new OptionalIntPipe();

  it('treats missing, empty and NaN as not given', () => {
    expect(pipe.transform(undefined)).toBeUndefined();
    expect(pipe.transform(null)).toBeUndefined();
    expect(pipe.transform('')).toBeUndefined();
    expect(pipe.transform(NaN)).toBeUndefined();
  });

  it('parses integers from strings and numbers', () => {
    expect(pipe.transform('2025')).toBe(2025);
    expect(pipe.transform(30)).toBe(30);
  });

  it('rejects non-integers', () => {
    expect(() => pipe.transform('abc')).toThrow(BadRequestException);
    expect(() => pipe.transform('20.5')).toThrow(BadRequestException);
  });

  it('accepts what the global ValidationPipe makes of a missing number query', async () => {
    // Same options as main.ts. A missing `year?: number` query arrives here as NaN.
    const global = new ValidationPipe({
      whitelist: true,
      transform: true,
      transformOptions: { enableImplicitConversion: true },
    });
    const v = await global.transform(undefined, {
      type: 'query',
      metatype: Number,
      data: 'year',
    });
    expect(pipe.transform(v)).toBeUndefined();
  });
});
