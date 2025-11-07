-- AlterTable
ALTER TABLE "flight" ADD COLUMN     "userId" TEXT;

-- AddForeignKey
ALTER TABLE "flight" ADD CONSTRAINT "flight_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
