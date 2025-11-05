import { IsOptional, IsString } from 'class-validator';

import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class GetFlightDTO {
  @ApiProperty()
  @IsString()
  iata: string;

  @ApiProperty()
  @IsString()
  icao: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  date?: string;

  @ApiProperty()
  @IsString()
  timezone: string;
}
