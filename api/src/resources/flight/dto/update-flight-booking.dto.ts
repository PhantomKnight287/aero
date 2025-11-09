import {
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
  ValidateIf,
} from 'class-validator';

import { ApiPropertyOptional } from '@nestjs/swagger';
import {
  BookingReason,
  SeatType,
  SeatingClass,
} from '@prisma/client';

export class UpdateFlightBookingDTO {
  @ApiPropertyOptional({
    description: 'Booking code/confirmation code (e.g., "ABC123"). Set to null to clear.',
    example: 'ABC123',
    maxLength: 50,
    nullable: true,
  })
  @ValidateIf((o) => o.bookingCode !== null && o.bookingCode !== undefined)
  @IsString()
  @IsOptional()
  @MaxLength(50)
  bookingCode?: string | null;

  @ApiPropertyOptional({
    description: 'Seat number (e.g., "12A", "1F"). Set to null to clear.',
    example: '12A',
    maxLength: 10,
    nullable: true,
  })
  @ValidateIf((o) => o.seatNumber !== null && o.seatNumber !== undefined)
  @IsString()
  @IsOptional()
  @MaxLength(10)
  seatNumber?: string | null;

  @ApiPropertyOptional({
    description: 'Type of seat position. Set to null to clear.',
    enum: SeatType,
    example: SeatType.window,
    nullable: true,
  })
  @ValidateIf((o) => o.seatType !== null && o.seatType !== undefined)
  @IsEnum(SeatType)
  @IsOptional()
  seatType?: SeatType | null;

  @ApiPropertyOptional({
    description: 'Class of service. Set to null to clear.',
    enum: SeatingClass,
    example: SeatingClass.economy,
    nullable: true,
  })
  @ValidateIf((o) => o.seatingClass !== null && o.seatingClass !== undefined)
  @IsEnum(SeatingClass)
  @IsOptional()
  seatingClass?: SeatingClass | null;

  @ApiPropertyOptional({
    description: 'Reason for the flight. Set to null to clear.',
    enum: BookingReason,
    example: BookingReason.personal,
    nullable: true,
  })
  @ValidateIf((o) => o.reason !== null && o.reason !== undefined)
  @IsEnum(BookingReason)
  @IsOptional()
  reason?: BookingReason | null;

  @ApiPropertyOptional({
    description: 'Additional notes about the booking. Set to null to clear.',
    example: 'Window seat preferred',
    maxLength: 500,
    nullable: true,
  })
  @ValidateIf((o) => o.notes !== null && o.notes !== undefined)
  @IsString()
  @IsOptional()
  @MaxLength(500)
  notes?: string | null;
}

