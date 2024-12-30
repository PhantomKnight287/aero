import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { AirportType } from '@prisma/client';

export class AirportEntity {
  @ApiProperty()
  id: string;

  @ApiProperty({ example: 'VIDP' })
  ident: string;

  @ApiProperty({ enumName: 'AirportType', enum: AirportType })
  type: AirportType;

  @ApiPropertyOptional({ description: 'Elevation in feet' })
  elevation?: string;

  @ApiProperty({
    examples: ['AS', 'EU'],
  })
  continent: string;

  @ApiProperty({})
  isoCountry: string;

  @ApiProperty({})
  isoRegion: string;

  @ApiPropertyOptional({})
  municipality?: string;

  @ApiPropertyOptional({})
  gpsCode?: string;

  @ApiPropertyOptional({ description: 'Nullable for private airports' })
  iataCode?: string;

  @ApiProperty({})
  name: string;

  @ApiProperty({})
  lat: string;

  @ApiProperty({})
  long: string;
}
