import fs from 'node:fs';
import { parse } from 'csv-parse';
import { pb } from './pb';
const __dirname = new URL('.', import.meta.url).pathname;

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
            local_code: record[10],
            long, lat
        })
    }
    return records;
};

(async () => {
    const records = await processFile();
    for (const record of records) {
        try {
            // await pb.collection("airports").create(record, { requestKey: null });
        }
        catch (e) {
            console.log(e)
            console.log(`Failed at:`)
            console.log(record)
        }
    }
    console.log("Done")
})();