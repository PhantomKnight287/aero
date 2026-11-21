import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { FlightSummaryEntity } from 'src/resources/profile/entities/profile-stats.entity';

/** One leg flown by an airframe, as reported by FlightAware. */
export class AircraftLegEntity {
  @ApiProperty() faFlightId: string;
  @ApiProperty() ident: string;
  @ApiPropertyOptional() identIata?: string;
  @ApiPropertyOptional() identIcao?: string;
  @ApiProperty({ description: 'FlightAware status text' }) status: string;
  @ApiPropertyOptional() originIata?: string;
  @ApiPropertyOptional() originIcao?: string;
  @ApiPropertyOptional() originCity?: string;
  @ApiPropertyOptional() originTimezone?: string;
  @ApiPropertyOptional() destinationIata?: string;
  @ApiPropertyOptional() destinationIcao?: string;
  @ApiPropertyOptional() destinationCity?: string;
  @ApiPropertyOptional() destinationTimezone?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) scheduledOut?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) estimatedOut?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) actualOut?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) scheduledIn?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) estimatedIn?: string;
  @ApiPropertyOptional({ description: 'ISO time' }) actualIn?: string;
  @ApiPropertyOptional({ description: 'Seconds, negative = early' })
  arrivalDelay?: number;
  @ApiPropertyOptional({ description: '0-100' }) progressPercent?: number;
  @ApiProperty() cancelled: boolean;
}

export class AircraftHistoryEntity {
  @ApiProperty({ nullable: true, type: String, example: 'A6-EOF' })
  registration: string | null;

  @ApiProperty({
    nullable: true,
    type: AircraftLegEntity,
    description: "This airframe's previous leg (inbound to this flight)",
  })
  inbound: AircraftLegEntity | null;

  @ApiProperty({
    type: [FlightSummaryEntity],
    description: "The user's other logged flights on the same registration",
  })
  ownFlights: FlightSummaryEntity[];
}
