import { chromium, firefox } from "playwright";

export async function scrapeAirlines() {
  // Launch browser
  const browser = await chromium.launch({
    headless: false, // Set to false for debugging
    timeout: 0,
  });

  try {
    // Create new page
    const page = await browser.newPage();

    /**
     * USE THIS AT YOUR OWN RISK
     */
    // Navigate to airlines page
    await page.goto("https://www.flightradar24.com/data/airlines", {
      waitUntil: "domcontentloaded",
    });

    // Wait for the table to load
    await page.waitForSelector("table");

    // Extract airline data
    const airlines = await page.evaluate(() => {
      const rows = document.querySelectorAll("table tr");
      return Array.from(rows)
        .map((row) => {
          const cells = row.querySelectorAll("td");
          if (cells.length < 3) return null;

          // Extract airline info
          const nameLink = cells[1].querySelector("a");
          return {
            name: cells[2]?.textContent?.trim() || "",
            code: cells[2]?.textContent?.trim() || "",
            fleet: cells[3]?.textContent?.trim() || "",
          };
        })
        .filter((airline) => airline !== null && airline.fleet.length > 3);
    });

    // Output results
    console.log("Found airlines:", airlines.length);
    Bun.write("data.json", JSON.stringify(airlines, null, 4));

    return airlines;
  } catch (error) {
    console.error("Error scraping airlines:", error);
    throw error;
  } finally {
    // Always close browser
    await browser.close();
  }
}
