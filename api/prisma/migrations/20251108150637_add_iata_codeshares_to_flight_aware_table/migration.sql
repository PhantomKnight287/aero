-- AlterTable
ALTER TABLE "flight_aware_data" ADD COLUMN     "codeshares_icao" TEXT[] DEFAULT ARRAY[]::TEXT[],
ALTER COLUMN "codeshares_iata" SET DEFAULT ARRAY[]::TEXT[];
