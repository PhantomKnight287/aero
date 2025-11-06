-- CreateIndex
CREATE INDEX "airlines_name_idx" ON "airlines"("name");

-- CreateIndex
CREATE INDEX "airlines_icao_idx" ON "airlines"("icao");

-- CreateIndex
CREATE INDEX "airlines_iata_idx" ON "airlines"("iata");

-- CreateIndex
CREATE INDEX "airports_ident_idx" ON "airports"("ident");

-- CreateIndex
CREATE INDEX "airports_municipality_idx" ON "airports"("municipality");

-- CreateIndex
CREATE INDEX "airports_gps_code_idx" ON "airports"("gps_code");

-- CreateIndex
CREATE INDEX "airports_iata_code_idx" ON "airports"("iata_code");

-- CreateIndex
CREATE INDEX "airports_name_idx" ON "airports"("name");
