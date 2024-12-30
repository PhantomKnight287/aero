-- CreateEnum
CREATE TYPE "AirportType" AS ENUM ('small_airport', 'seaplane_base', 'medium_airport', 'large_airport', 'heliport', 'closed', 'balloonport');

-- CreateEnum
CREATE TYPE "FlightType" AS ENUM ('arrival', 'departure');

-- CreateEnum
CREATE TYPE "FlightStatus" AS ENUM ('scheduled', 'active', 'landed', 'cancelled', 'incident', 'diverted');

-- CreateTable
CREATE TABLE "airports" (
    "id" TEXT NOT NULL,
    "ident" TEXT NOT NULL,
    "type" "AirportType" NOT NULL,
    "elevation" DECIMAL(65,30),
    "continent" TEXT NOT NULL,
    "iso_country" TEXT NOT NULL,
    "iso_region" TEXT NOT NULL,
    "municipality" TEXT,
    "gps_code" TEXT,
    "iata_code" TEXT,
    "name" TEXT NOT NULL,
    "lat" DECIMAL(65,30) NOT NULL,
    "long" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "airports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "airlines" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "icao" TEXT NOT NULL,
    "iata" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "airlines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aircrafts" (
    "id" TEXT NOT NULL,
    "aircraft_id" TEXT NOT NULL,
    "reg" TEXT NOT NULL,
    "hex_icao" TEXT,
    "model_code" TEXT,
    "age" DECIMAL(65,30),
    "first_flight_date" TIMESTAMP(3),
    "delivery_date" TIMESTAMP(3),
    "type_name" TEXT,
    "is_freighter" BOOLEAN NOT NULL,
    "image" TEXT,
    "attribution" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "aircrafts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flights" (
    "id" TEXT NOT NULL,
    "airline" JSONB NOT NULL,
    "arrival" JSONB NOT NULL,
    "codeshared" JSONB,
    "departure" JSONB NOT NULL,
    "flight" JSONB NOT NULL,
    "type" "FlightType" NOT NULL,
    "status" "FlightStatus",
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "flights_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "great_circle_distance" (
    "id" TEXT NOT NULL,
    "meter" DECIMAL(65,30) NOT NULL,
    "km" DECIMAL(65,30) NOT NULL,
    "mile" DECIMAL(65,30) NOT NULL,
    "nm" DECIMAL(65,30) NOT NULL,
    "feet" DECIMAL(65,30) NOT NULL,
    "flight_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "great_circle_distance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flight" (
    "id" TEXT NOT NULL,
    "flight_no" TEXT NOT NULL,
    "aircraft" JSONB NOT NULL,
    "airline" JSONB NOT NULL,
    "arrival" JSONB NOT NULL,
    "departure" JSONB NOT NULL,
    "cargo" BOOLEAN NOT NULL DEFAULT false,
    "date" TIMESTAMP(3) NOT NULL,
    "call_sign" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "flight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aircraft_registrations" (
    "id" TEXT NOT NULL,
    "reg" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "hex_icao" TEXT,
    "airline_name" TEXT,
    "registration_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "aircraft_id" TEXT,

    CONSTRAINT "aircraft_registrations_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "airports_id_key" ON "airports"("id");

-- CreateIndex
CREATE UNIQUE INDEX "airlines_id_key" ON "airlines"("id");

-- CreateIndex
CREATE UNIQUE INDEX "aircrafts_id_key" ON "aircrafts"("id");

-- CreateIndex
CREATE UNIQUE INDEX "flights_id_key" ON "flights"("id");

-- CreateIndex
CREATE UNIQUE INDEX "great_circle_distance_id_key" ON "great_circle_distance"("id");

-- CreateIndex
CREATE UNIQUE INDEX "great_circle_distance_flight_id_key" ON "great_circle_distance"("flight_id");

-- CreateIndex
CREATE UNIQUE INDEX "flight_id_key" ON "flight"("id");

-- CreateIndex
CREATE UNIQUE INDEX "aircraft_registrations_id_key" ON "aircraft_registrations"("id");

-- AddForeignKey
ALTER TABLE "great_circle_distance" ADD CONSTRAINT "great_circle_distance_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flight"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aircraft_registrations" ADD CONSTRAINT "aircraft_registrations_aircraft_id_fkey" FOREIGN KEY ("aircraft_id") REFERENCES "aircrafts"("id") ON DELETE SET NULL ON UPDATE CASCADE;
