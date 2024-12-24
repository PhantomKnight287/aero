import { scrapeAirlines } from "./scraper";

await scrapeAirlines().catch(console.error);
