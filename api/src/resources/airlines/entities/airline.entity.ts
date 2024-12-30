import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AirlineEntity {
  @ApiProperty()
  id: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  icao: string;

  @ApiProperty()
  iata: string;

  @ApiPropertyOptional()
  image: string;
}
