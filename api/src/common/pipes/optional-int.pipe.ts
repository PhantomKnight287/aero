import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';

/**
 * Optional integer query param. The global ValidationPipe (transform +
 * enableImplicitConversion) turns a missing `number` query into NaN before
 * param pipes run, so ParseIntPipe({ optional: true }) rejects it. Treat
 * undefined, '' and NaN as "not given"; anything else must be an integer.
 */
@Injectable()
export class OptionalIntPipe implements PipeTransform {
  transform(value: unknown): number | undefined {
    if (value === undefined || value === null || value === '') return undefined;
    if (typeof value === 'number' && Number.isNaN(value)) return undefined;
    const n = Number(value);
    if (!Number.isInteger(n)) {
      throw new BadRequestException('Validation failed (integer expected)');
    }
    return n;
  }
}
