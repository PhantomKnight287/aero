import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FlightPositionEntity {
  @ApiPropertyOptional({
    description: 'FlightAware flight ID for this position',
  })
  fa_flight_id?: string;

  @ApiProperty({
    description: 'Aircraft altitude in hundreds of feet',
    example: 350,
  })
  altitude: number;

  @ApiProperty({
    description: 'Altitude change indicator',
    enum: ['C', 'D', '-'],
    example: 'C',
  })
  altitude_change: string;

  @ApiProperty({
    description: 'Groundspeed in knots',
    example: 450,
  })
  groundspeed: number;

  @ApiPropertyOptional({
    description: 'Aircraft heading in degrees (0-360)',
    example: 270,
    minimum: 0,
    maximum: 360,
  })
  heading?: number;

  @ApiProperty({
    description: 'Latitude position',
    example: 40.7128,
  })
  latitude: number;

  @ApiProperty({
    description: 'Longitude position',
    example: -74.0060,
  })
  longitude: number;

  @ApiProperty({
    description: 'Time that position was received',
    example: '2024-03-20T14:30:00Z',
  })
  timestamp: string;

  @ApiPropertyOptional({
    description: 'Update type: P=projected, O=oceanic, Z=radar, A=ADS-B, M=multilateration, D=datalink, X=surface and near surface, S=space-based, V=virtual event',
    enum: ['P', 'O', 'Z', 'A', 'M', 'D', 'X', 'S', 'V'],
  })
  update_type?: string;
}

export class FlightTrackResponseEntity {
  @ApiPropertyOptional({
    description: 'Distance flown in miles as of the latest position point',
    example: 2450,
  })
  actual_distance?: number;

  @ApiProperty({
    description: 'Array of flight positions',
    type: [FlightPositionEntity],
  })
  positions: FlightPositionEntity[];
}

