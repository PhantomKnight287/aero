import {
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';

import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  BookingReason,
  SeatType,
  SeatingClass,
} from '@prisma/client';

export class CreateFlightBookingDTO {
  @ApiProperty({
    description: 'Flight ID to associate the booking with',
    example: 'flight_abc123',
  })
  @IsString()
  @IsNotEmpty()
  flightId: string;

  @ApiPropertyOptional({
    description: 'Booking code/confirmation code (e.g., "ABC123")',
    example: 'ABC123',
    maxLength: 50,
  })
  @IsString()
  @IsOptional()
  @MaxLength(50)
  bookingCode?: string;

  @ApiPropertyOptional({
    description: 'Seat number (e.g., "12A", "1F")',
    example: '12A',
    maxLength: 10,
  })
  @IsString()
  @IsOptional()
  @MaxLength(10)
  seatNumber?: string;

  @ApiPropertyOptional({
    description: 'Type of seat position',
    enum: SeatType,
    example: SeatType.window,
  })
  @IsEnum(SeatType)
  @IsOptional()
  seatType?: SeatType;

  @ApiPropertyOptional({
    description: 'Class of service',
    enum: SeatingClass,
    example: SeatingClass.economy,
  })
  @IsEnum(SeatingClass)
  @IsOptional()
  seatingClass?: SeatingClass;

  @ApiPropertyOptional({
    description: 'Reason for the flight',
    enum: BookingReason,
    example: BookingReason.personal,
    default: BookingReason.personal,
  })
  @IsEnum(BookingReason)
  @IsOptional()
  reason?: BookingReason;

  @ApiPropertyOptional({
    description: 'Additional notes about the booking',
    example: 'Window seat preferred',
    maxLength: 500,
  })
  @IsString()
  @IsOptional()
  @MaxLength(500)
  notes?: string;
}

