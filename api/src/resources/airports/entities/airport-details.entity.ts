import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

/** A raw aviation weather string alongside its decoded structured form. */
export class DecodedWeatherEntity {
  @ApiPropertyOptional({
    description: 'Raw aviation weather string (METAR/TAF)',
    type: String,
    nullable: true,
  })
  raw?: string | null;

  @ApiPropertyOptional({
    description:
      'Structured/decoded representation of the raw string. Null when decoding failed or no raw string was available.',
    type: Object,
    nullable: true,
  })
  decoded?: Record<string, any> | null;
}

export class AirportDetailsEntity {
  @ApiProperty({ example: 'VIDP', description: 'Airport identifier (ICAO)' })
  ident: string;

  @ApiPropertyOptional({
    description: 'FlightAware airport delay information, if any',
    type: Object,
    nullable: true,
  })
  delays?: Record<string, any> | null;

  @ApiPropertyOptional({
    description: 'Latest METAR observation (raw + decoded)',
    type: DecodedWeatherEntity,
    nullable: true,
  })
  metar?: DecodedWeatherEntity | null;

  @ApiPropertyOptional({
    description: 'TAF forecast (raw + decoded)',
    type: DecodedWeatherEntity,
    nullable: true,
  })
  taf?: DecodedWeatherEntity | null;
}
