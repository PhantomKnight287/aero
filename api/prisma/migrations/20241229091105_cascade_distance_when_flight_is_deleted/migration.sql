-- DropForeignKey
ALTER TABLE "great_circle_distance" DROP CONSTRAINT "great_circle_distance_flight_id_fkey";

-- AddForeignKey
ALTER TABLE "great_circle_distance" ADD CONSTRAINT "great_circle_distance_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flight"("id") ON DELETE CASCADE ON UPDATE CASCADE;
