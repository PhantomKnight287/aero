-- CreateEnum
CREATE TYPE "SeatType" AS ENUM ('window', 'middle', 'aisle', 'jumpseat', 'captain', 'pilot', 'copilot', 'flight_engineer', 'flight_attendant', 'observer', 'other');

-- CreateEnum
CREATE TYPE "SeatingClass" AS ENUM ('economy', 'premium_economy', 'business', 'first', 'private', 'other');

-- CreateEnum
CREATE TYPE "BookingReason" AS ENUM ('personal', 'business', 'crew', 'training', 'repositioning', 'other');

-- CreateTable
CREATE TABLE "flight_bookings" (
    "id" TEXT NOT NULL,
    "booking_code" TEXT,
    "seat_number" TEXT,
    "seat_type" "SeatType",
    "seating_class" "SeatingClass",
    "reason" "BookingReason",
    "notes" TEXT,
    "flight_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "flight_bookings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "flight_bookings_id_key" ON "flight_bookings"("id");

-- CreateIndex
CREATE INDEX "flight_bookings_flight_id_idx" ON "flight_bookings"("flight_id");

-- CreateIndex
CREATE INDEX "flight_bookings_user_id_idx" ON "flight_bookings"("user_id");

-- CreateIndex
CREATE INDEX "flight_bookings_booking_code_idx" ON "flight_bookings"("booking_code");

-- AddForeignKey
ALTER TABLE "flight_bookings" ADD CONSTRAINT "flight_bookings_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flight"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flight_bookings" ADD CONSTRAINT "flight_bookings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
