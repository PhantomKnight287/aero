<div align="center">

<img src="./landing/public/icons/0-1.png" width="96" alt="Aero app icon">

# Aero

A flight tracker for people who want all the details.

[![Flutter](https://img.shields.io/badge/Flutter-3.6+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![NestJS](https://img.shields.io/badge/NestJS-10-E0234E?logo=nestjs&logoColor=white)](https://nestjs.com)
[![Wear OS](https://img.shields.io/badge/Wear%20OS-Compose-4285F4?logo=wearos&logoColor=white)](https://developer.android.com/wear)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](./LICENSE)

<br>

<img src="./landing/public/screens/hero_live.webp" width="260" alt="UA1581 from Los Angeles to Newark on the live map">

</div>

> [!NOTE]
> I have added every feature I had planned for this app. There won't be any big new features, but I might still add a few things here and there.

## What is Aero?

Most flight trackers show you the flight number, a time and a dot on a map. I wanted more than that, so I built Aero. It shows both IATA and ICAO codes, gate and runway times, the actual aircraft and where it flew in from, and the weather at both airports.

Aero is heavily inspired by [Flighty](https://flighty.com).

It runs on Android, and there's a Wear OS app for the watch. It's free, has no ads, and you can host it yourself.

## Screenshots

<table>
<tr>
<td align="center"><img src="./landing/public/screens/tracking.webp" width="220"><br><sub>Flight details</sub></td>
<td align="center"><img src="./landing/public/screens/live_on_map.webp" width="220"><br><sub>Live map</sub></td>
<td align="center"><img src="./landing/public/screens/aircraft_details.webp" width="220"><br><sub>Aircraft</sub></td>
</tr>
<tr>
<td align="center"><img src="./landing/public/screens/airport_weather.webp" width="220"><br><sub>Airport weather</sub></td>
<td align="center"><img src="./landing/public/screens/stats.webp" width="220"><br><sub>Stats</sub></td>
<td align="center"><img src="./landing/public/screens/hero_live.webp" width="220"><br><sub>In flight</sub></td>
</tr>
</table>

## Features

**Flights.** Search by flight number or by route. You get gate, terminal and baggage belt at both ends, scheduled and actual times (green if early, red if late), codeshares, and the time zone change.

**Live map.** The plane's position, altitude, speed and heading update every few seconds, and the path it has flown so far is drawn behind it.

**The aircraft.** Registration, Mode S code, age, delivery date and a photo of that exact plane. Aero also shows the plane's previous flight, so if the inbound is running late you'll know before the airline tells you.

**Weather.** Live METAR and TAF for any airport, decoded into plain English. Tap a value to change its unit (hPa or inHg, °C or °F, and so on). The change applies on every screen.

**Stats.** Every flight you've taken: countries, airports, distance, hours in the air, time lost to delays, and which aircraft types you fly most. Your routes are also drawn on a map.

**Share cards.** Turn a flight into an image to share. There are four styles: story, card, boarding pass and departures board.

<table>
<tr>
<td width="34%" align="center" valign="top"><img src="./landing/public/cards/story.webp"><br><sub>Story</sub></td>
<td width="38%" align="center" valign="top"><img src="./landing/public/cards/card.webp"><br><sub>Card</sub></td>
<td width="28%" align="center" valign="top">
<img src="./landing/public/cards/pass.webp"><br><sub>Pass</sub><br><br>
<img src="./landing/public/cards/board.webp"><br><sub>Board</sub>
</td>
</tr>
</table>

**Wear OS.** The watch app gets your flights from the phone. It has a tile, a complication and an ambient screen, and it buzzes when the gate or belt changes or the flight is delayed, cancelled or diverted.

**Other things.** A home screen widget and 12 app icons to pick from.

<p align="center">
<img src="./landing/public/icons/0-1.png" width="48">
<img src="./landing/public/icons/0-2.png" width="48">
<img src="./landing/public/icons/0-3.png" width="48">
<img src="./landing/public/icons/0-4.png" width="48">
<img src="./landing/public/icons/0-5.png" width="48">
<img src="./landing/public/icons/0-6.png" width="48">
<img src="./landing/public/icons/1-1.png" width="48">
<img src="./landing/public/icons/1-2.png" width="48">
<img src="./landing/public/icons/1-3.png" width="48">
<img src="./landing/public/icons/1-4.png" width="48">
<img src="./landing/public/icons/1-5.png" width="48">
<img src="./landing/public/icons/1-6.png" width="48">
</p>

## Repo layout

| Folder | What's in it |
| --- | --- |
| `api/` | NestJS API (Prisma, PostgreSQL, Redis). It also serves the landing page from `api/web`. |
| `app/` | The Flutter app |
| `wearos/` | The Wear OS app (Kotlin, Compose) |
| `landing/` | The landing page (React, Vite, Tailwind) |
| `openapi/` | Dart API client, generated from the API's OpenAPI spec |
| `scraper/` | Playwright scraper for airline data |
| `scripts/` | Scripts for data and migrations |
| `backend/` | Old PocketBase backend from the first version. It isn't maintained. |

Flight data comes from AeroDataBox (through RapidAPI), FlightAware and Aviationstack. If you host Aero yourself, you need your own keys for these.

## Running it

You need Bun, Flutter 3.6 or later, PostgreSQL, Redis, and Android Studio.

### API

```bash
cd api
bun install
cp .env.example .env   # fill in the database URL and API keys
bunx prisma migrate dev
bun run start:dev
```

The API runs on `http://localhost:3000`. Swagger docs are at `/docs`, and the Scalar reference is at `/reference`.

### App

Create `app/.env` with `API_URL_DEBUG`, `API_URL_PRODUCTION`, `MAPBOX_API_KEY` and `ONESIGNAL_APP_ID`, then run:

```bash
cd app
flutter pub get
flutter run --dart-define-from-file=.env
```

> [!IMPORTANT]
> This application uses `<activity-alias>`, so building for Android without a build cache fails, even in debug mode. To fix it, open the `android` folder in Android Studio and run a build there once. After that, the flutter commands work fine.
>
> I have only done the native setup for Android.

### Wear OS

Open `wearos/` in Android Studio and run it on a watch paired with a phone that has the app.

### Landing page

```bash
cd landing
bun install
bun run dev
```

To deploy, run `bun run build`, then copy `dist/` into `api/web`.

### Regenerating the API client

```bash
./generate-openapi-client.sh
```

## License

[CC BY-NC 4.0](./LICENSE). You can use and change it, but not for commercial use.

---

Bonus for scrolling so far. Here is the image of my favourite liveries.

![ANA181](https://cdn.jetphotos.com/full/6/1035944_1762190738.jpg)

Copyright: TommyNGB

Link: https://www.jetphotos.com/photo/11888246

![D-ABYN](https://cdn.jetphotos.com/full/5/2186584_1773921865.jpg)

Copyright: Sebastian Sowa

Link: https://www.jetphotos.com/photo/12049542
