-- CreateEnum
CREATE TYPE "AltitudeChange" AS ENUM ('Climb', 'Descend', 'None');

-- CreateEnum
CREATE TYPE "UpdateType" AS ENUM ('Projected', 'Oceanic', 'Radar', 'ADSB', 'Multilateration', 'Datalink', 'Surface_And_Near_Surface', 'Spaced_Based', 'Virtual_Event');

-- AlterTable
ALTER TABLE "flight" ADD COLUMN     "fa_flight_id" TEXT,
ADD COLUMN     "flightaware_payload" JSONB;

-- AlterTable
ALTER TABLE "flights" ADD COLUMN     "fa_flight_id" TEXT;

-- CreateTable
CREATE TABLE "flight_positions" (
    "id" TEXT NOT NULL,
    "altitude" INTEGER NOT NULL,
    "altitude_change" "AltitudeChange" NOT NULL DEFAULT 'None',
    "ground_speed" INTEGER NOT NULL,
    "heading" INTEGER,
    "latitude" DECIMAL(65,30) NOT NULL,
    "longitude" DECIMAL(65,30) NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "update_type" "UpdateType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "flight_id" TEXT,

    CONSTRAINT "flight_positions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "flight_positions_id_key" ON "flight_positions"("id");

-- CreateIndex
CREATE INDEX "flight_positions_timestamp_idx" ON "flight_positions"("timestamp");

-- CreateIndex
CREATE INDEX "flight_positions_latitude_longitude_idx" ON "flight_positions"("latitude", "longitude");

-- CreateIndex
CREATE INDEX "flight_positions_altitude_idx" ON "flight_positions"("altitude");

-- CreateIndex
CREATE INDEX "flight_positions_altitude_change_idx" ON "flight_positions"("altitude_change");

-- CreateIndex
CREATE INDEX "flight_positions_ground_speed_idx" ON "flight_positions"("ground_speed");

-- CreateIndex
CREATE INDEX "flight_positions_heading_idx" ON "flight_positions"("heading");

-- CreateIndex
CREATE INDEX "flight_positions_update_type_idx" ON "flight_positions"("update_type");

-- AddForeignKey
ALTER TABLE "flight_positions" ADD CONSTRAINT "flight_positions_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flights"("id") ON DELETE SET NULL ON UPDATE CASCADE;
