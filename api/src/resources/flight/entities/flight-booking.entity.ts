import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  BookingReason,
  SeatType,
  SeatingClass,
} from '@prisma/client';

export class FlightBookingEntity {
  @ApiProperty({
    description: 'Unique booking identifier',
    example: 'booking_abc123',
  })
  id: string;

  @ApiPropertyOptional({
    description: 'Booking code/confirmation code (e.g., "ABC123")',
    example: 'ABC123',
  })
  bookingCode?: string | null;

  @ApiPropertyOptional({
    description: 'Seat number (e.g., "12A", "1F")',
    example: '12A',
  })
  seatNumber?: string | null;

  @ApiPropertyOptional({
    description: 'Type of seat position',
    enum: SeatType,
    example: SeatType.window,
  })
  seatType?: SeatType | null;

  @ApiPropertyOptional({
    description: 'Class of service',
    enum: SeatingClass,
    example: SeatingClass.economy,
  })
  seatingClass?: SeatingClass | null;

  @ApiPropertyOptional({
    description: 'Reason for the flight',
    enum: BookingReason,
    example: BookingReason.personal,
  })
  reason?: BookingReason | null;

  @ApiPropertyOptional({
    description: 'Additional notes about the booking',
    example: 'Window seat preferred',
  })
  notes?: string | null;

  @ApiProperty({
    description: 'Flight ID associated with this booking',
    example: 'flight_abc123',
  })
  flightId: string;

  @ApiProperty({
    description: 'User ID who owns this booking',
    example: 'user_abc123',
  })
  userId: string;

  @ApiProperty({
    description: 'Date and time when the booking was created',
    example: '2024-03-20T10:00:00Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Date and time when the booking was last updated',
    example: '2024-03-20T10:00:00Z',
  })
  updatedAt: Date;
}

