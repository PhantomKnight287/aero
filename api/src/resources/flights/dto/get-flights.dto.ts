import { ApiProperty } from '@nestjs/swagger';
import { IsDateString, IsString, Length } from 'class-validator';

export class GetFlightsDTO {
  @ApiProperty({
    description: 'Departure airport IATA code',
    example: 'LAX',
  })
  @IsString()
  @Length(3, 3)
  from: string;

  @ApiProperty({
    description: 'Arrival airport IATA code',
    example: 'JFK',
  })
  @IsString()
  @Length(3, 3)
  to: string;

  @ApiProperty({
    description: 'Flight date in ISO format',
    example: '2024-03-20',
  })
  @IsDateString()
  date: string;
} 