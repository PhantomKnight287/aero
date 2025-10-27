/*
  Warnings:

  - You are about to drop the column `fa_flight_id` on the `flights` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "flight_positions" DROP CONSTRAINT "flight_positions_flight_id_fkey";

-- AlterTable
ALTER TABLE "flights" DROP COLUMN "fa_flight_id";

-- AddForeignKey
ALTER TABLE "flight_positions" ADD CONSTRAINT "flight_positions_flight_id_fkey" FOREIGN KEY ("flight_id") REFERENCES "flight"("id") ON DELETE SET NULL ON UPDATE CASCADE;
