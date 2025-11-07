/*
  Warnings:

  - Made the column `userId` on table `flight` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "flight" DROP CONSTRAINT "flight_userId_fkey";

-- AlterTable
ALTER TABLE "flight" ALTER COLUMN "userId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "flight" ADD CONSTRAINT "flight_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
