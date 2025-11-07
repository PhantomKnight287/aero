import Redis from 'ioredis';
import { DateTime, IANAZone } from 'luxon';
import { prisma } from 'src/db';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

import { RedisService } from '@liaoliaots/nestjs-redis';
import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createId } from '@paralleldrive/cuid2';
import { Aircraft } from '@prisma/client';

import { GetFlightTrackDTO } from './dto/get-flight-track.dto';
import { GetFlightDTO } from './dto/get-flight.dto';
import { AircraftEntity } from './entities/flight.entity';

@Injectable()
export class FlightService {
  private redis: Redis;

  constructor(
    private readonly configService: ConfigService,
    private readonly flightAwareService: FlightAwareService,
    private readonly redisService: RedisService,
  ) {
    this.redis = this.redisService.getOrNil();
  }

  /**
   * Converts a date string (e.g., "2025-11-04") interpreted as midnight in the user's timezone
   * to UTC Date objects for database queries
   */
  private parseDateInTimezone(
    dateString: string,
    timezone: string,
  ): {
    startOfDayUtc: Date;
    endOfDayUtc: Date;
  } {
    // Validate date format (YYYY-MM-DD)
    const dateParts = dateString.split('-');
    if (dateParts.length !== 3) {
      throw new BadRequestException('Invalid date format. Expected YYYY-MM-DD');
    }

    // Map common abbreviations to representative IANA zones (handles DST correctly)
    const mapAbbrevToIana = (abbr: string): string | null => {
      const A = abbr.toUpperCase();
      const table: Record<string, string> = {
        UTC: 'UTC',
        GMT: 'Etc/UTC',
        BST: 'Europe/London',
        CET: 'Europe/Berlin',
        CEST: 'Europe/Berlin',
        EET: 'Europe/Athens',
        EEST: 'Europe/Athens',
        IST: 'Asia/Kolkata', // India Standard Time
        PKT: 'Asia/Karachi',
        MSK: 'Europe/Moscow',
        AST: 'America/Halifax',
        ADT: 'America/Halifax',
        EST: 'America/New_York',
        EDT: 'America/New_York',
        CST: 'America/Chicago',
        CDT: 'America/Chicago',
        MST: 'America/Denver',
        MDT: 'America/Denver',
        PST: 'America/Los_Angeles',
        PDT: 'America/Los_Angeles',
        AKST: 'America/Anchorage',
        AKDT: 'America/Anchorage',
        HST: 'Pacific/Honolulu',
        JST: 'Asia/Tokyo',
        KST: 'Asia/Seoul',
        AEST: 'Australia/Sydney',
        AEDT: 'Australia/Sydney',
        ACST: 'Australia/Adelaide',
        ACDT: 'Australia/Adelaide',
        AWST: 'Australia/Perth',
      };
      return table[A] ?? null;
    };

    // Resolve a Luxon zone: prefer valid IANA; otherwise use mapping for abbreviations; fallback UTC
    const resolveZone = (tz: string): string => {
      if (tz && tz.includes('/') && IANAZone.isValidZone(tz)) return tz;
      const mapped = tz ? mapAbbrevToIana(tz) : null;
      if (mapped && IANAZone.isValidZone(mapped)) return mapped;
      return 'UTC';
    };

    const zone = resolveZone(timezone);
    const start = DateTime.fromISO(dateString, { zone }).startOf('day').toUTC();
    const end = start.plus({ days: 1 });

    return {
      startOfDayUtc: start.toJSDate(),
      endOfDayUtc: end.toJSDate(),
    };
  }

  async getFlight(
    { iata, icao, date, timezone, forceUpdate }: GetFlightDTO,
    userId: string,
  ) {
    // Parse date with timezone consideration
    const dateToUse = date ?? new Date().toISOString().split('T')[0];
    const { startOfDayUtc: searchDate, endOfDayUtc: nextDate } =
      this.parseDateInTimezone(dateToUse, timezone);

    const existingFlight = await prisma.flight.findFirst({
      where: {
        OR: [
          { callSign: iata },
          { flightNo: iata },
          { callSign: icao },
          { flightNo: icao },
        ],
        date: {
          gte: searchDate,
          lt: nextDate,
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
      include: {
        greatCircleDistance: true,
        flightAwareData: true,
      },
    });

    // If forceUpdate is not specified and flight exists, return it
    if (!forceUpdate && existingFlight) {
      let aircraft: Aircraft | null = null;
      if (existingFlight?.aircraft) {
        const stored = existingFlight.aircraft as any;
        const hexCandidate: string | undefined = stored?.modeS ?? stored?.hexIcao;
        const regCandidate: string | undefined =
          stored?.reg ?? stored?.registration ?? stored?.registrataion;
        if (hexCandidate) {
          aircraft = await prisma.aircraft.findFirst({
            where: { hexIcao: hexCandidate },
          });
        }
        if (!aircraft && regCandidate) {
          aircraft = await prisma.aircraft.findFirst({
            where: { reg: regCandidate },
          });
        }
      }
      const stored = existingFlight.aircraft as any | undefined;
      const normalizedFromStored: AircraftEntity | undefined = stored
        ? ({
            modeS: stored.modeS ?? stored.hexIcao,
            age: (stored.ageYears ?? stored.age)?.toString(),
            image: stored.image?.url ?? stored.image,
            attribution:
              stored.attribution ?? stored.image?.htmlAttributions?.join(' '),
            isFreighter: stored.isFreighter ?? false,
            model: stored.typeName ?? stored.modelCode ?? stored.model,
            registration:
              stored.reg ?? stored.registration ?? stored.registrataion,
            aircraft_id: stored.aircraft_id ?? stored.id?.toString(),
            payload: stored.payload,
            deliveryDate:
              stored.deliveryDate ??
              (stored.deliveryDate
                ? new Date(stored.deliveryDate).toISOString()
                : undefined),
            firstFlightDate:
              stored.firstFlightDate ??
              (stored.firstFlightDate
                ? new Date(stored.firstFlightDate).toISOString()
                : undefined),
          } as AircraftEntity)
        : undefined;

      return {
        ...existingFlight,
        aircraft: aircraft
          ? ({
              modeS: aircraft.hexIcao,
              age: aircraft.age?.toString(),
              image: aircraft.image,
              attribution: aircraft.attribution,
              isFreighter: aircraft.isFreighter,
              model: aircraft.typeName,
              registration: aircraft.reg,
              aircraft_id: aircraft.aircraft_id,
              deliveryDate: aircraft.deliveryDate?.toISOString(),
              firstFlightDate: aircraft.firstFlightDate?.toISOString(),
              payload: aircraft.payload as any,
            } satisfies AircraftEntity)
          : normalizedFromStored,
      };
    }

    // Fetch flight data from FlightAware API only
    try {
      let flightAwareResponse: any;
      let faFlight: any;

      // If forceUpdate is true and we have an existing flight with fa_flight_id, use that
      if (forceUpdate && existingFlight?.flightAwareData?.faFlightId) {
        const faFlightId = existingFlight.flightAwareData.faFlightId;
        console.log(
          `Force update: Using existing fa_flight_id ${faFlightId} to fetch from FlightAware`,
        );
        flightAwareResponse =
          await this.flightAwareService.searchFlightsByIdent(faFlightId);

        if (!flightAwareResponse || !flightAwareResponse.flights?.length) {
          throw new BadRequestException('Flight not found');
        }

        // When using fa_flight_id, we get exactly 1 flight in the array
        faFlight = flightAwareResponse.flights[0];
      } else {
        // Normal flow: use iata/icao identifier
        const flightAwareIdent = icao || iata;
        if (!flightAwareIdent) {
          throw new BadRequestException('Flight identifier required');
        }

        flightAwareResponse =
          await this.flightAwareService.searchFlightsByIdent(flightAwareIdent);

        if (!flightAwareResponse || !flightAwareResponse.flights?.length) {
          throw new BadRequestException('Flight not found');
        }

        // Use the first flight or try to match by date
        faFlight = flightAwareResponse.flights[0];

        // Try to find a flight matching the search date
        if (flightAwareResponse.flights.length > 1) {
          const matchedFlight = flightAwareResponse.flights.find((flight) => {
            const flightDate = flight.scheduled_out
              ? new Date(flight.scheduled_out)
              : flight.scheduled_off
                ? new Date(flight.scheduled_off)
                : null;

            if (flightDate) {
              // Check if flight date falls within the UTC date range for the user's timezone date
              return flightDate >= searchDate && flightDate < nextDate;
            }
            return false;
          });

          if (matchedFlight) {
            faFlight = matchedFlight;
            console.log(
              `Matched FlightAware flight by date: ${faFlight.fa_flight_id}`,
            );
          } else {
            console.log(
              `No date match found, using first flight: ${faFlight.fa_flight_id}`,
            );
          }
        }
      }

      // Calculate great circle distance (approximate)
      const greatCircleDistance = faFlight.route_distance
        ? {
            meter: Math.round(faFlight.route_distance * 1852).toString(),
            km: (faFlight.route_distance * 1.852).toFixed(0),
            mile: (faFlight.route_distance * 1.15078).toFixed(0),
            nm: faFlight.route_distance.toString(),
            feet: Math.round(faFlight.route_distance * 6076.12).toString(),
          }
        : null;

      // Resolve airport coordinates from DB using IATA/ICAO
      const depIata = faFlight.origin?.code_iata ?? undefined;
      const depIcao =
        faFlight.origin?.code_icao ?? faFlight.origin?.code ?? undefined;
      const arrIata = faFlight.destination?.code_iata ?? undefined;
      const arrIcao =
        faFlight.destination?.code_icao ??
        faFlight.destination?.code ??
        undefined;

      const [depAirport, arrAirport] = await Promise.all([
        prisma.airport.findFirst({
          where: {
            OR: [
              depIata ? { iataCode: depIata } : undefined,
              depIcao
                ? { OR: [{ gpsCode: depIcao }, { ident: depIcao }] }
                : undefined,
            ].filter(Boolean),
          },
        }),
        prisma.airport.findFirst({
          where: {
            OR: [
              arrIata ? { iataCode: arrIata } : undefined,
              arrIcao
                ? { OR: [{ gpsCode: arrIcao }, { ident: arrIcao }] }
                : undefined,
            ].filter(Boolean),
          },
        }),
      ]);

      const flightData = {
        userId,
        flightNo: faFlight.ident.replace(/ /g, ''),
        callSign: faFlight.ident,
        aircraft: {
          registration: faFlight.registration,
          type: faFlight.aircraft_type,
        },
        airline: {
          name: faFlight.operator ?? faFlight.operator_iata ?? 'Unknown',
          iata: faFlight.operator_iata,
          icao: faFlight.operator_icao,
        },
        arrival: {
          airport: {
            icao:
              faFlight.destination?.code_icao ?? faFlight.destination?.code,
            iata: faFlight.destination?.code_iata,
            name: faFlight.destination?.name ?? 'Unknown',
            municipalityName: faFlight.destination?.city ?? 'Unknown',
            location: {
              lat: arrAirport ? Number(arrAirport.lat) : 0, // fallback 0 if not found
              lon: arrAirport ? Number(arrAirport.long) : 0,
            },
            countryCode:
              faFlight.destination?.code_icao?.substring(0, 2) ?? 'XX',
            timeZone: faFlight.destination?.timezone ?? 'UTC',
            shortName: faFlight?.destination?.name ?? 'Unknown',
          },
          scheduledTime: {
            utc: faFlight.scheduled_on ?? faFlight.scheduled_in,
            local: faFlight.scheduled_on ?? faFlight.scheduled_in,
          },
          revisedTime: faFlight.estimated_on
            ? {
                utc: faFlight.estimated_on,
                local: faFlight.estimated_on,
              }
            : null,
          actualTime: faFlight.actual_on
            ? {
                utc: faFlight.actual_on,
                local: faFlight.actual_on,
              }
            : null,
          terminal: faFlight.terminal_destination,
          gate: faFlight.gate_destination,
        },
        cargo: false,
        date: searchDate,
        departure: {
          airport: {
            shortName: faFlight?.origin?.name ?? 'Unknown',
            icao: faFlight.origin?.code_icao ?? faFlight.origin?.code,
            iata: faFlight.origin?.code_iata,
            name: faFlight.origin?.name ?? 'Unknown',
            municipalityName: faFlight.origin?.city ?? 'Unknown',
            location: {
              lat: depAirport ? Number(depAirport.lat) : 0,
              lon: depAirport ? Number(depAirport.long) : 0,
            },
            countryCode: faFlight.origin?.code_icao?.substring(0, 2) ?? 'XX',
            timeZone: faFlight.origin?.timezone ?? 'UTC',
          },
          scheduledTime: {
            utc: faFlight.scheduled_out ?? faFlight.scheduled_off,
            local: faFlight.scheduled_out ?? faFlight.scheduled_off,
          },
          revisedTime: faFlight.estimated_out
            ? {
                utc: faFlight.estimated_out,
                local: faFlight.estimated_out,
              }
            : null,
          actualTime: faFlight.actual_out
            ? {
                utc: faFlight.actual_out,
                local: faFlight.actual_out,
              }
            : null,
          terminal: faFlight.terminal_origin,
          gate: faFlight.gate_origin,
        },
      };

      // Update existing flight if forceUpdate is true, otherwise create new
      const newFlight = forceUpdate && existingFlight
        ? await prisma.flight.update({
            where: { id: existingFlight.id },
            data: flightData,
            include: {
              greatCircleDistance: true,
            },
          })
        : await prisma.flight.create({
            data: {
              ...flightData,
              id: `flight_${createId()}`,
            },
            include: {
              greatCircleDistance: true,
            },
          });

      // Handle greatCircleDistance separately (upsert)
      if (greatCircleDistance) {
        await prisma.greatCircleDistance.upsert({
          where: { flightId: newFlight.id },
          update: greatCircleDistance,
          create: {
            ...greatCircleDistance,
            flightId: newFlight.id,
          },
        });
      }

      console.log(
        forceUpdate && existingFlight
          ? `Updated flight from FlightAware: ${faFlight.fa_flight_id}`
          : `Created flight from FlightAware: ${faFlight.fa_flight_id}`,
      );

      // Upsert FlightAwareData (update if exists, create if not)
      const flightAwareDataPayload = {
        ident: faFlight.ident,
        identIcao: faFlight.ident_icao ?? null,
        identIata: faFlight.ident_iata ?? null,
        actualRunwayOff: faFlight.actual_runway_off ?? null,
        actualRunwayOn: faFlight.actual_runway_on ?? null,
        operator: faFlight.operator ?? null,
        operatorIcao: faFlight.operator_icao ?? null,
        operatorIata: faFlight.operator_iata ?? null,
        flightNumber: faFlight.flight_number ?? null,
        registration: faFlight.registration ?? null,
        atcIdent: faFlight.atc_ident ?? null,
        inboundFaFlightId: faFlight.inbound_fa_flight_id ?? null,
        codesharesIata: faFlight.codeshares_iata ?? [],
        departureDelay: faFlight.departure_delay ?? null,
        arrivalDelay: faFlight.arrival_delay ?? null,
        filedEte: faFlight.filed_ete ?? null,
        progressPercent: faFlight.progress_percent ?? null,
        status: faFlight.status,
        aircraftType: faFlight.aircraft_type ?? null,
        routeDistance: faFlight.route_distance ?? null,
        filedAirspeed: faFlight.filed_airspeed ?? null,
        filedAltitude: faFlight.filed_altitude ?? null,
        route: faFlight.route ?? null,
        baggageClaim: faFlight.baggage_claim ?? null,
        seatsCabinBusiness: faFlight.seats_cabin_business ?? null,
        seatsCabinCoach: faFlight.seats_cabin_coach ?? null,
        seatsCabinFirst: faFlight.seats_cabin_first ?? null,
        gateOrigin: faFlight.gate_origin ?? null,
        gateDestination: faFlight.gate_destination ?? null,
        terminalOrigin: faFlight.terminal_origin ?? null,
        terminalDestination: faFlight.terminal_destination ?? null,
        scheduledOut: faFlight.scheduled_out
          ? new Date(faFlight.scheduled_out)
          : null,
        estimatedOut: faFlight.estimated_out
          ? new Date(faFlight.estimated_out)
          : null,
        actualOut: faFlight.actual_out ? new Date(faFlight.actual_out) : null,
        scheduledOff: faFlight.scheduled_off
          ? new Date(faFlight.scheduled_off)
          : null,
        estimatedOff: faFlight.estimated_off
          ? new Date(faFlight.estimated_off)
          : null,
        actualOff: faFlight.actual_off ? new Date(faFlight.actual_off) : null,
        scheduledOn: faFlight.scheduled_on
          ? new Date(faFlight.scheduled_on)
          : null,
        estimatedOn: faFlight.estimated_on
          ? new Date(faFlight.estimated_on)
          : null,
        actualOn: faFlight.actual_on ? new Date(faFlight.actual_on) : null,
        scheduledIn: faFlight.scheduled_in
          ? new Date(faFlight.scheduled_in)
          : null,
        estimatedIn: faFlight.estimated_in
          ? new Date(faFlight.estimated_in)
          : null,
        actualIn: faFlight.actual_in ? new Date(faFlight.actual_in) : null,
        foresightPredictionsAvailable:
          faFlight.foresight_predictions_available ?? false,
        blocked: faFlight.blocked ?? false,
        diverted: faFlight.diverted ?? false,
        cancelled: faFlight.cancelled ?? false,
        positionOnly: faFlight.position_only ?? false,
        originCode: faFlight?.origin?.code ?? 'Unknown',
        originCodeIcao: faFlight?.origin?.code_icao ?? null,
        originCodeIata: faFlight?.origin?.code_iata ?? null,
        originCodeLid: faFlight?.origin?.code_lid ?? null,
        originTimezone: faFlight?.origin?.timezone ?? null,
        originName: faFlight?.origin?.name ?? null,
        originCity: faFlight?.origin?.city ?? null,
        destinationCode: faFlight?.destination?.code ?? 'Unknown',
        destinationCodeIcao: faFlight?.destination?.code_icao ?? null,
        destinationCodeIata: faFlight?.destination?.code_iata ?? null,
        destinationCodeLid: faFlight?.destination?.code_lid ?? null,
        destinationTimezone: faFlight?.destination?.timezone ?? null,
        destinationName: faFlight?.destination?.name ?? null,
        destinationCity: faFlight?.destination?.city ?? null,
        flightId: newFlight.id,
      };

      // Update or create FlightAwareData
      // If forceUpdate is true and we have an existing flight, we know FlightAwareData exists
      if (forceUpdate && existingFlight?.flightAwareData) {
        // Update existing FlightAwareData to avoid unique constraint failure
        await prisma.flightAwareData.update({
          where: { id: existingFlight.flightAwareData.id },
          data: flightAwareDataPayload,
        });
      } else {
        // Check if FlightAwareData exists, then update or create
        const existingFlightAwareData =
          await prisma.flightAwareData.findFirst({
            where: { faFlightId: faFlight.fa_flight_id },
          });

        if (existingFlightAwareData) {
          await prisma.flightAwareData.update({
            where: { id: existingFlightAwareData.id },
            data: flightAwareDataPayload,
          });
        } else {
          await prisma.flightAwareData.create({
            data: {
              faFlightId: faFlight.fa_flight_id,
              ...flightAwareDataPayload,
            },
          });
        }
      }

      // Handle aircraft information using AeroDataBox
      let normalizedAircraft: AircraftEntity | undefined;
      const registration = faFlight.registration;
      const apiKey = this.configService.get<string>('RAPID_API_KEY');

      if (registration) {
        // Check if aircraft already exists in database
        let aircraft = await prisma.aircraft.findFirst({
          where: {
            reg: registration,
          },
        });

        if (aircraft) {
          normalizedAircraft = {
            modeS: aircraft.hexIcao,
            age: aircraft.age?.toString(),
            image: aircraft.image,
            attribution: aircraft.attribution,
            isFreighter: aircraft.isFreighter,
            model: aircraft.typeName,
            registration: aircraft.reg,
            aircraft_id: aircraft.aircraft_id,
            deliveryDate: aircraft.deliveryDate?.toISOString(),
            firstFlightDate: aircraft.firstFlightDate?.toISOString(),
            payload: aircraft.payload as any,
          } satisfies AircraftEntity;
        } else if (apiKey) {
          // Fetch aircraft details from AeroDataBox
          try {
            const aeroDataBoxRes = await fetch(
              `https://aerodatabox.p.rapidapi.com/aircrafts/reg/${registration}?withImage=true&withRegistrations=true`,
              {
                headers: {
                  'X-RapidAPI-Key': apiKey,
                  'X-RapidAPI-Host': 'aerodatabox.p.rapidapi.com',
                },
              },
            );

            if (aeroDataBoxRes.ok) {
              const json = await aeroDataBoxRes.json();

              // Create aircraft record with AeroDataBox data
              aircraft = await prisma.aircraft.create({
                data: {
                  aircraft_id: String(json.id),
                  payload: json,
                  reg: json.reg,
                  hexIcao: json.hexIcao,
                  modelCode: json.modelCode,
                  firstFlightDate: json.firstFlightDate
                    ? new Date(json.firstFlightDate as string)
                    : null,
                  deliveryDate: json.deliveryDate
                    ? new Date(json.deliveryDate as string)
                    : null,
                  typeName: json.typeName,
                  isFreighter: json.isFreighter ?? false,
                  age: json.ageYears,
                  image: json?.image?.url,
                  attribution: json?.image?.htmlAttributions
                    ? `${json.image.htmlAttributions[0]} ${json.image.htmlAttributions[1] ?? ''}`
                    : null,
                  registrations: json.registrations
                    ? {
                        createMany: {
                          data: json.registrations.map((data: any) => ({
                            id: `registration_${createId()}`,
                            active: data.active ?? true,
                            reg: data.reg,
                            airlineName: data.airlineName,
                            registrationDate: data.registrationDate
                              ? new Date(data.registrationDate)
                              : null,
                            hexIcao: data.hexIcao,
                          })),
                          skipDuplicates: true,
                        },
                      }
                    : undefined,
                },
              });

              normalizedAircraft = {
                modeS: aircraft.hexIcao,
                age: aircraft.age?.toString(),
                image: aircraft.image,
                attribution: aircraft.attribution,
                isFreighter: aircraft.isFreighter,
                model: aircraft.typeName,
                registration: aircraft.reg,
                aircraft_id: aircraft.aircraft_id,
                deliveryDate: aircraft.deliveryDate?.toISOString(),
                firstFlightDate: aircraft.firstFlightDate?.toISOString(),
                payload: aircraft.payload as any,
              } satisfies AircraftEntity;

              console.log(
                `Fetched aircraft data from AeroDataBox for ${registration}`,
              );
            } else {
              throw new Error('AeroDataBox request failed');
            }
          } catch (error) {
            console.error('Error fetching from AeroDataBox:', error);

            // Fallback to Planespotters for image only
            let planespotterImage: string | null = null;
            let planespotterAttribution: string | null = null;

            try {
              const planespotterRes = await fetch(
                `https://api.planespotters.net/pub/photos/reg/${registration}`,
              );
              if (planespotterRes.ok) {
                const planespotterData = await planespotterRes.json();
                if (
                  planespotterData.photos &&
                  planespotterData.photos.length > 0
                ) {
                  planespotterImage =
                    planespotterData.photos[0].thumbnail_large.src;
                  planespotterAttribution = `Photo by ${planespotterData.photos[0].photographer}`;
                }
              }
            } catch (e) {
              console.error('Error fetching from Planespotters:', e);
            }

            // Create minimal aircraft record with Planespotters image
            aircraft = await prisma.aircraft.create({
              data: {
                aircraft_id: `aircraft_${createId()}`,
                reg: registration,
                hexIcao: '',
                typeName: faFlight.aircraft_type ?? 'Unknown',
                modelCode: faFlight.aircraft_type ?? 'Unknown',
                isFreighter: false,
                age: 0,
                image: planespotterImage,
                attribution: planespotterAttribution,
                payload: {},
              },
            });

            normalizedAircraft = {
              modeS: aircraft.hexIcao,
              age: aircraft.age?.toString(),
              image: aircraft.image,
              attribution: aircraft.attribution,
              isFreighter: aircraft.isFreighter,
              model: aircraft.typeName,
              registration: aircraft.reg,
              aircraft_id: aircraft.aircraft_id,
              deliveryDate: aircraft.deliveryDate?.toISOString(),
              firstFlightDate: aircraft.firstFlightDate?.toISOString(),
              payload: aircraft.payload as any,
            } satisfies AircraftEntity;
          }
        } else {
          // No API key, create minimal record
          normalizedAircraft = {
            //@ts-expect-error
            ...newFlight.aircraft,
            registration: registration,
            model: faFlight.aircraft_type ?? 'Unknown',
          };
        }
      } else {
        // No registration available, use basic aircraft info from flight data
        normalizedAircraft = {
          //@ts-expect-error
          ...newFlight.aircraft,
          registration: faFlight.registration ?? 'Unknown',
          model: faFlight.aircraft_type ?? 'Unknown',
        };
      }

      // Reload flight with FlightAware data to include it in response
      const flightWithAwareData = await prisma.flight.findUnique({
        where: { id: newFlight.id },
        include: {
          greatCircleDistance: true,
          flightAwareData: {
            omit: {
              faFlightId: true,
            },
          },
        },
      });

      // Preserve the normalized aircraft data in the response
      if (flightWithAwareData && normalizedAircraft) {
        return {
          ...flightWithAwareData,
          aircraft: normalizedAircraft,
        };
      }

      return flightWithAwareData ?? newFlight;
    } catch (error) {
      if (
        error instanceof UnauthorizedException ||
        error instanceof BadRequestException
      ) {
        throw error;
      }
      console.error('Error fetching flight data:', error);
      throw new InternalServerErrorException('Failed to fetch flight data');
    }
  }

  async getFlightTrack(
    { iata, icao, date, timezone }: GetFlightTrackDTO,
    userId: string,
  ) {
    const dateToUse = date ?? new Date().toISOString().split('T')[0];
    const tz = timezone ?? 'UTC';
    const { startOfDayUtc: searchDate, endOfDayUtc: nextDate } =
      this.parseDateInTimezone(dateToUse, tz);

    const existingFlight = await prisma.flight.findFirst({
      where: {
        OR: [
          { callSign: iata },
          { flightNo: iata },
          { callSign: icao },
          { flightNo: icao },
        ],
        userId,
        date: {
          gte: searchDate,
          lte: nextDate,
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
      include: {
        flightAwareData: true,
      },
    });
    if (!existingFlight) {
      throw new HttpException(
        'Flight not found in database',
        HttpStatus.NOT_FOUND,
      );
    }

    if (!existingFlight.flightAwareData?.faFlightId) {
      throw new HttpException(
        'FlightAware data not available for this flight',
        HttpStatus.NOT_FOUND,
      );
    }

    const faFlightId = existingFlight.flightAwareData.faFlightId;
    const cacheKey = `flight:track:${faFlightId}`;
    const cacheTTL = 30; // 30 seconds

    // Check if flight has concluded (landed more than 2 hours ago)
    const flightAwareData = existingFlight.flightAwareData;
    const hasLanded =
      flightAwareData.actualOn ||
      flightAwareData.actualIn ||
      flightAwareData.estimatedOn;

    let isFlightConcluded = false;
    if (hasLanded) {
      const landingTimeValue =
        flightAwareData.actualOn ||
        flightAwareData.actualIn ||
        flightAwareData.estimatedOn;
      const landingTime = new Date(landingTimeValue as Date);
      const now = new Date();
      const hoursSinceLanding =
        (now.getTime() - landingTime.getTime()) / (1000 * 60 * 60);

      // Consider flight concluded if it landed more than 2 hours ago
      isFlightConcluded = hoursSinceLanding > 2;
    }

    // If flight is concluded, check if we have positions in database
    if (isFlightConcluded) {
      console.log(
        `Flight ${faFlightId} has concluded. Checking database for track data.`,
      );

      const existingPositions = await prisma.flightPositions.findMany({
        where: {
          flightId: existingFlight.id,
        },
        orderBy: {
          timestamp: 'asc',
        },
      });

      if (existingPositions.length > 0) {
        console.log(
          `FlightTrack: Returning ${existingPositions.length} positions from database for concluded flight ${faFlightId}`,
        );

        // Calculate actual distance if available
        let actualDistance = null;
        if (existingPositions.length >= 2) {
          // Simple distance calculation (you could improve this)
          const first = existingPositions[0];
          const last = existingPositions[existingPositions.length - 1];
          const R = 3440.065; // Earth radius in nautical miles
          const firstLat = Number(first.latitude);
          const firstLon = Number(first.longitude);
          const lastLat = Number(last.latitude);
          const lastLon = Number(last.longitude);
          const dLat = ((lastLat - firstLat) * Math.PI) / 180;
          const dLon = ((lastLon - firstLon) * Math.PI) / 180;
          const a =
            Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos((firstLat * Math.PI) / 180) *
              Math.cos((lastLat * Math.PI) / 180) *
              Math.sin(dLon / 2) *
              Math.sin(dLon / 2);
          const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
          actualDistance = R * c;
        }

        return {
          actual_distance: actualDistance,
          positions: existingPositions.map((pos) => ({
            fa_flight_id: faFlightId,
            altitude: pos.altitude,
            altitude_change:
              pos.altitudeChange === 'Climb'
                ? 'C'
                : pos.altitudeChange === 'Descend'
                  ? 'D'
                  : '-',
            groundspeed: pos.groundSpeed,
            heading: pos.heading ?? null,
            // Prisma Decimal values get stringified; ensure numbers in API response
            latitude: Number(pos.latitude),
            longitude: Number(pos.longitude),
            timestamp: pos.timestamp.toISOString(),
            update_type:
              pos.updatedType === 'Projected'
                ? 'P'
                : pos.updatedType === 'Oceanic'
                  ? 'O'
                  : pos.updatedType === 'Radar'
                    ? 'Z'
                    : pos.updatedType === 'ADSB'
                      ? 'A'
                      : pos.updatedType === 'Multilateration'
                        ? 'M'
                        : pos.updatedType === 'Datalink'
                          ? 'D'
                          : pos.updatedType === 'Surface_And_Near_Surface'
                            ? 'X'
                            : pos.updatedType === 'Spaced_Based'
                              ? 'S'
                              : pos.updatedType === 'Virtual_Event'
                                ? 'V'
                                : null,
          })),
        };
      }
    }

    // Check Redis cache first for active flights
    try {
      if (this.redis) {
        const cached = await this.redis.get(cacheKey);
        if (cached) {
          console.log(
            `FlightTrack: Returning cached data for ${faFlightId} from application cache`,
          );
          return JSON.parse(cached);
        }
      }
    } catch (error) {
      console.warn('Redis cache read error in flight service:', error);
    }

    // Fetch track data from FlightAware API (only for active/recent flights)
    console.log(
      `FlightTrack: Fetching live data from FlightAware for ${faFlightId}`,
    );
    const trackData = await this.flightAwareService.getFlightTrack(faFlightId);

    if (!trackData || !trackData.positions) {
      throw new InternalServerErrorException(
        'Failed to fetch flight track data',
      );
    }

    // Map altitude_change from API format to Prisma enum
    const mapAltitudeChange = (
      change: string,
    ): 'Climb' | 'Descend' | 'None' => {
      switch (change) {
        case 'C':
          return 'Climb';
        case 'D':
          return 'Descend';
        case '-':
        default:
          return 'None';
      }
    };

    // Map update_type from API format to Prisma enum
    const mapUpdateType = (
      type: string,
    ):
      | 'Projected'
      | 'Oceanic'
      | 'Radar'
      | 'ADSB'
      | 'Multilateration'
      | 'Datalink'
      | 'Surface_And_Near_Surface'
      | 'Spaced_Based'
      | 'Virtual_Event' => {
      switch (type) {
        case 'P':
          return 'Projected';
        case 'O':
          return 'Oceanic';
        case 'Z':
          return 'Radar';
        case 'A':
          return 'ADSB';
        case 'M':
          return 'Multilateration';
        case 'D':
          return 'Datalink';
        case 'X':
          return 'Surface_And_Near_Surface';
        case 'S':
          return 'Spaced_Based';
        case 'V':
          return 'Virtual_Event';
        default:
          return 'ADSB'; // Default to ADSB if unknown
      }
    };

    // UPSERT positions in the database
    // Use a transaction to ensure atomicity
    await prisma.$transaction(
      async (tx) => {
        for (const pos of trackData.positions) {
          const positionId = `${existingFlight.id}_${new Date(pos.timestamp).getTime()}_${pos.latitude}_${pos.longitude}`;

          await tx.flightPositions.upsert({
            where: {
              id: positionId,
            },
            update: {
              altitude: pos.altitude,
              altitudeChange: mapAltitudeChange(pos.altitude_change || '-'),
              groundSpeed: pos.groundspeed,
              heading: pos.heading ?? null,
              latitude: pos.latitude,
              longitude: pos.longitude,
              timestamp: new Date(pos.timestamp),
              updatedType: mapUpdateType(pos.update_type || 'A'),
            },
            create: {
              id: positionId,
              altitude: pos.altitude,
              altitudeChange: mapAltitudeChange(pos.altitude_change || '-'),
              groundSpeed: pos.groundspeed,
              heading: pos.heading ?? null,
              latitude: pos.latitude,
              longitude: pos.longitude,
              timestamp: new Date(pos.timestamp),
              updatedType: mapUpdateType(pos.update_type || 'A'),
              flightId: existingFlight.id,
            },
          });
        }
      },
      { timeout: 60000 },
    );

    // Prepare response data
    const responseData = {
      actual_distance: trackData.actual_distance ?? null,
      positions: trackData.positions.map((pos: any) => ({
        fa_flight_id: pos.fa_flight_id ?? null,
        altitude: pos.altitude,
        altitude_change: pos.altitude_change || '-',
        groundspeed: pos.groundspeed,
        heading: pos.heading ?? null,
        latitude: pos.latitude,
        longitude: pos.longitude,
        timestamp: pos.timestamp,
        update_type: pos.update_type ?? null,
      })),
    };

    // Cache the response in Redis for 30 seconds
    try {
      if (this.redis) {
        await this.redis.setex(
          cacheKey,
          cacheTTL,
          JSON.stringify(responseData),
        );
        console.log(
          `FlightTrack: Cached track data for ${faFlightId} for ${cacheTTL} seconds`,
        );
      }
    } catch (error) {
      console.warn('Redis cache write error in flight service:', error);
    }

    return responseData;
  }
}
