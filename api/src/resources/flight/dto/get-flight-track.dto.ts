import { IsOptional, IsString } from 'class-validator';

import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class GetFlightTrackDTO {
  @ApiProperty({
    description: 'IATA flight number',
    example: 'UA123',
  })
  @IsString()
  iata: string;

  @ApiProperty({
    description: 'ICAO flight number',
    example: 'UAL123',
  })
  @IsString()
  icao: string;

  @ApiPropertyOptional({
    description:
      'Flight date (ISO format). Defaults to current date if not provided',
    example: '2024-03-20',
  })
  @IsString()
  @IsOptional()
  date?: string;

  @ApiPropertyOptional({
    description:
      'Timezone of the user or intended context. Accepts IANA (e.g., Asia/Kolkata) or common abbreviations (e.g., IST, CEST). Defaults to UTC.',
    example: 'IST',
  })
  @IsString()
  @IsOptional()
  timezone?: string;
}
