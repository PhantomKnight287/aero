import 'dotenv/config'
import { parse } from 'csv-parse';
import fs from 'node:fs';
import { prisma } from 'src/db';

const CONCURRENCY = 50;

const processFile = async () => {
    const records = [];
    const parser = fs
        .createReadStream(`${__dirname}/airport-codes.csv`)
        .pipe(parse({

        }));
    for await (const record of parser) {
        if (record[0].startsWith("ident")) continue
        const [lat, long] = record[record.length - 1].split(", ")
        records.push({
            ident: record[0],
            type: record[1],
            name: record[2],
            elevation: record[3],
            continent: record[4],
            iso_country: record[5],
            iso_region: record[6],
            municipality: record[7],
            gps_code: record[8],
            iata_code: record[9],
            long, lat
        })
    }
    return records;
};

async function upsertAirport(record: Record<string, string>) {
    const existingAirport = await prisma.airport.findFirst({
        where: { ident: record.ident }
    })
    const { iso_country: isoCountry, iso_region: isoRegion, gps_code: gpsCode, iata_code: iataCode, ...rest } = record;

    const data = { ...rest, isoCountry, isoRegion, gpsCode, iataCode };

    if (existingAirport) {
        await prisma.airport.update({ where: { id: existingAirport.id }, data })
    } else {
        //@ts-expect-error shush
        await prisma.airport.create({ data })
    }
}

(async () => {
    const records = await processFile();
    const failures: Record<string, string>[] = [];
    let done = 0;

    // Process in batches of CONCURRENCY
    for (let i = 0; i < records.length; i += CONCURRENCY) {
        const batch = records.slice(i, i + CONCURRENCY);
        const results = await Promise.allSettled(
            batch.map((record) => upsertAirport(record))
        );
        results.forEach((result, idx) => {
            if (result.status === 'rejected') {
                console.error(`Failed: ${batch[idx].ident} - ${result.reason}`);
                failures.push(batch[idx]);
            }
        });
        done += batch.length;
        console.log(`Progress: ${done}/${records.length}`);
    }

    if (failures.length > 0) {
        const headers = Object.keys(failures[0]);
        const csvLines = [
            headers.join(','),
            ...failures.map(f => headers.map(h => `"${(f[h] ?? '').replace(/"/g, '""')}"`).join(','))
        ];
        const outPath = `${__dirname}/failed-airports.csv`;
        fs.writeFileSync(outPath, csvLines.join('\n'));
        console.log(`${failures.length} failures written to ${outPath}`);
    } else {
        console.log("All airports imported successfully");
    }

    console.log("Done")
})();
