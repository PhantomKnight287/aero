/*
  Warnings:

  - You are about to drop the column `fa_flight_id` on the `flight` table. All the data in the column will be lost.
  - You are about to drop the column `flightaware_payload` on the `flight` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "flight" DROP COLUMN "fa_flight_id",
DROP COLUMN "flightaware_payload";

-- CreateTable
CREATE TABLE "flight_aware_data" (
    "id" TEXT NOT NULL,
    "fa_flight_id" TEXT NOT NULL,
    "ident" TEXT NOT NULL,
    "ident_icao" TEXT,
    "ident_iata" TEXT,
    "actual_runway_off" TEXT,
    "actual_runway_on" TEXT,
    "operator" TEXT,
    "operator_icao" TEXT,
    "operator_iata" TEXT,
    "flight_number" TEXT,
    "registration" TEXT,
    "atc_ident" TEXT,
    "inbound_fa_flight_id" TEXT,
    "codeshares_iata" TEXT[],
    "departure_delay" INTEGER,
    "arrival_delay" INTEGER,
    "filed_ete" INTEGER,
    "progress_percent" INTEGER,
    "status" TEXT NOT NULL,
    "aircraft_type" TEXT,
    "route_distance" INTEGER,
    "filed_airspeed" INTEGER,
    "filed_altitude" INTEGER,
    "route" TEXT,
    "baggage_claim" TEXT,
    "seats_cabin_business" INTEGER,
    "seats_cabin_coach" INTEGER,
    "seats_cabin_first" INTEGER,
    "gate_origin" TEXT,
    "gate_destination" TEXT,
    "terminal_origin" TEXT,
    "terminal_destination" TEXT,
    "scheduled_out" TIMESTAMP(3),
    "estimated_out" TIMESTAMP(3),
    "actual_out" TIMESTAMP(3),
    "scheduled_off" TIMESTAMP(3),
    "estimated_off" TIMESTAMP(3),
    "actual_off" TIMESTAMP(3),
    "scheduled_on" TIMESTAMP(3),
    "estimated_on" TIMESTAMP(3),
    "actual_on" TIMESTAMP(3),
    "scheduled_in" TIMESTAMP(3),
    "estimated_in" TIMESTAMP(3),
    "actual_in" TIMESTAMP(3),
    "foresight_predictions_available" BOOLEAN NOT NULL DEFAULT false,
    "blocked" BOOLEAN NOT NULL DEFAULT false,
    "diverted" BOOLEAN NOT NULL DEFAULT false,
    "cancelled" BOOLEAN NOT NULL DEFAULT false,
    "position_only" BOOLEAN NOT NULL DEFAULT false,
    "origin_code" TEXT,
    "origin_code_icao" TEXT,
    "origin_code_iata" TEXT,
    "origin_code_lid" TEXT,
    "origin_timezone" TEXT,
    "origin_name" TEXT,
    "origin_city" TEXT,
    "destination_code" TEXT,
    "destination_code_icao" TEXT,
    "destination_code_iata" TEXT,
    "destination_code_lid" TEXT,
    "destination_timezone" TEXT,
    "destination_name" TEXT,
    "destination_city" TEXT,
    "flight_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "flight_aware_data_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "flight_aware_data_id_key" ON "flight_aware_data"("id");

-- CreateIndex
CREATE UNIQUE INDEX "flight_aware_data_flight_id_key" ON "flight_aware_data"("flight_id");

-- CreateIndex
CREATE INDEX "flight_aware_data_ident_idx" ON "flight_aware_data"("ident");

-- CreateIndex
CREATE INDEX "flight_aware_data_fa_flight_id_idx" ON "flight_aware_data"("fa_flight_id");

-- CreateIndex
CREATE INDEX "flight_aware_data_registration_idx" ON "flight_aware_data"("registration");

-- AddForeignKey
ALTER TABLE "flight_aware_data" ADD CONSTRAINT "flight_aware_data_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flight"("id") ON DELETE CASCADE ON UPDATE CASCADE;
