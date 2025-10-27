import Redis from 'ioredis';
import { prisma } from 'src/db';
import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

import { RedisService } from '@liaoliaots/nestjs-redis';
import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createId } from '@paralleldrive/cuid2';
import { Aircraft } from '@prisma/client';
import { JsonValue } from '@prisma/client/runtime/library';

import { AircraftEntity } from './entities/flight.entity';

interface GetFlightParams {
  iata: string;
  icao: string;
  date?: string;
}

interface GetFlightTrackParams {
  iata: string;
  icao: string;
  date?: string;
}

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

  async getFlight({ iata, icao, date }: GetFlightParams) {
    const searchDate = new Date(date ?? Date.now());
    searchDate.setUTCHours(0, 0, 0, 0);

    const nextDate = new Date(searchDate);
    nextDate.setDate(searchDate.getDate() + 1);

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
    if (existingFlight) {
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

    // If not in database, fetch from external API
    const apiKey = this.configService.get<string>('RAPID_API_KEY');
    if (!apiKey) {
      throw new InternalServerErrorException('Internal Server Error');
    }

    const url = `https://aerodatabox.p.rapidapi.com/flights/number/${iata}/${searchDate.toISOString().split('T')[0]}?withRegistrations=true&withImage=true`;
    try {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'aerodatabox.p.rapidapi.com',
        },
      });

      if (!response.ok) {
        if (response.status === 401) {
          throw new UnauthorizedException('API authentication failed');
        }
        throw new Error(`API request failed with status ${response.status}`);
      }

      const flightData = await response.json();

      if (
        !flightData ||
        !Array.isArray(flightData) ||
        flightData.length === 0
      ) {
        throw new BadRequestException('Flight not found');
      }

      const newFlight = await prisma.flight.create({
        data: {
          flightNo: flightData[0].number.replace(/ /g, ''),
          callSign:
            flightData[0].callSign ?? flightData[0].number.replace(/ /g, ''),
          aircraft: flightData[0].aircraft,
          airline: flightData[0].airline,
          arrival: flightData[0].arrival,
          cargo: flightData[0].isCargo,
          greatCircleDistance: { create: flightData[0].greatCircleDistance },
          date: searchDate,
          departure:
            flightData.length >= 2
              ? flightData[1].departure
              : flightData[0].departure,
          id: `flight_${createId()}`,
        },
        include: {
          greatCircleDistance: true,
        },
      });
      let aircraft: Aircraft;
      // If aircraft doesn't exist in our database, create it
      if (flightData[0].aircraft?.modeS) {
        const existingAircraft = await prisma.aircraft.findFirst({
          where: {
            hexIcao: flightData[0].aircraft.modeS,
          },
        });

        if (!existingAircraft) {
          const res = await fetch(
            `https://aerodatabox.p.rapidapi.com/aircrafts/icao24/${flightData[0].aircraft?.modeS}?withRegistrations=true&withImage=true`,
            {
              headers: {
                'X-RapidAPI-Key': apiKey,
                'X-RapidAPI-Host': 'aerodatabox.p.rapidapi.com',
              },
            },
          );
          const json = await res.json();
          if (res.ok) {
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
                image: json.image.url,
                attribution: `${json.image.htmlAttributions?.[0]} ${json.image.htmlAttributions?.[1]}`,
                registrations: {
                  createMany: {
                    data: json.registrations.map((data) => ({
                      id: `registration_${createId()}`,
                      active: data.active ?? true,
                      reg: data.reg,
                      airlineName: data.airlineName,
                      registrationDate: data.registrationDate
                        ? new Date(json.registrationDate)
                        : null,
                      hexIcao: data.hexIcao,
                    })),
                    skipDuplicates: true,
                  },
                },
              },
            });
            newFlight.aircraft = {
              modeS: aircraft.hexIcao,
              age: aircraft.age.toString(),
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
          } else {
            newFlight.aircraft = {
              //@ts-expect-error
              ...newFlight.aircraft,
              registration: newFlight.aircraft['reg'],
            };
          }
        } else {
          newFlight.aircraft = {
            modeS: existingAircraft.hexIcao,
            age: existingAircraft.age.toString(),
            image: existingAircraft.image,
            attribution: existingAircraft.attribution,
            isFreighter: existingAircraft.isFreighter,
            model: existingAircraft.typeName,
            registration: existingAircraft.reg,
            aircraft_id: existingAircraft.aircraft_id,
            deliveryDate: existingAircraft.deliveryDate?.toISOString(),
            firstFlightDate: existingAircraft.firstFlightDate?.toISOString(),
            payload: existingAircraft.payload as any,
          } satisfies AircraftEntity;
        }
      } else if (flightData[0].aircraft?.reg) {
        // If modeS is not available but reg is available, try to fetch aircraft by registration
        const existingAircraft = await prisma.aircraft.findFirst({
          where: {
            reg: flightData[0].aircraft.reg,
          },
        });

        if (!existingAircraft) {
          const res = await fetch(
            `https://aerodatabox.p.rapidapi.com/aircrafts/reg/${flightData[0].aircraft.reg}?withImage=true&withRegistrations=true`,
            {
              headers: {
                'X-RapidAPI-Key': apiKey,
                'X-RapidAPI-Host': 'aerodatabox.p.rapidapi.com',
              },
            },
          );
          const json = await res.json();
          if (res.ok) {
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
                attribution: `${json?.image?.htmlAttributions?.[0]} ${json?.image?.htmlAttributions?.[1]}`,
                registrations: {
                  createMany: {
                    data: json.registrations.map((data) => ({
                      id: `registration_${createId()}`,
                      active: data.active ?? true,
                      reg: data.reg,
                      airlineName: data.airlineName,
                      registrationDate: data.registrationDate
                        ? new Date(json.registrationDate)
                        : null,
                      hexIcao: data.hexIcao,
                    })),
                    skipDuplicates: true,
                  },
                },
              },
            });
            newFlight.aircraft = {
              modeS: aircraft.hexIcao,
              age: aircraft.age.toString(),
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
          } else {
            newFlight.aircraft = {
              //@ts-expect-error
              ...newFlight.aircraft,
              registration: newFlight.aircraft['reg'],
            };
          }
        } else {
          newFlight.aircraft = {
            modeS: existingAircraft.hexIcao,
            age: existingAircraft.age.toString(),
            image: existingAircraft.image,
            attribution: existingAircraft.attribution,
            isFreighter: existingAircraft.isFreighter,
            model: existingAircraft.typeName,
            registration: existingAircraft.reg,
            aircraft_id: existingAircraft.aircraft_id,
            deliveryDate: existingAircraft.deliveryDate?.toISOString(),
            firstFlightDate: existingAircraft.firstFlightDate?.toISOString(),
            payload: existingAircraft.payload as any,
          } satisfies AircraftEntity;
        }
      } else {
        newFlight.aircraft = {
          //@ts-expect-error
          ...newFlight.aircraft,
          registration:
            newFlight.aircraft['reg'] ?? newFlight.aircraft['model'],
        };
      }

      try {
        const flightAwareIdent = icao || iata;
        if (flightAwareIdent) {
          const flightAwareResponse =
            await this.flightAwareService.searchFlightsByIdent(
              flightAwareIdent,
            );
          if (flightAwareResponse && flightAwareResponse.flights?.length > 0) {
            // Get the scheduled departure time from AeroDataBox response
            const scheduledDepartureTime = flightData[0].departure
              ?.scheduledTime?.utc
              ? new Date(flightData[0].departure.scheduledTime.utc)
              : null;

            let matchedFlight = null;

            // If we have a scheduled time, try to match based on timing with 30-minute buffer
            if (scheduledDepartureTime) {
              const bufferMinutes = 30 * 60 * 1000; // 30 minutes in milliseconds

              for (const flight of flightAwareResponse.flights) {
                // Check both scheduled_out and scheduled_off times
                const faScheduledOut = flight.scheduled_out
                  ? new Date(flight.scheduled_out)
                  : null;
                const faScheduledOff = flight.scheduled_off
                  ? new Date(flight.scheduled_off)
                  : null;

                // Check if either scheduled_out or scheduled_off is within 30 minutes
                if (faScheduledOut) {
                  const timeDiff = Math.abs(
                    scheduledDepartureTime.getTime() - faScheduledOut.getTime(),
                  );
                  if (timeDiff <= bufferMinutes) {
                    matchedFlight = flight;
                    break;
                  }
                }

                if (!matchedFlight && faScheduledOff) {
                  const timeDiff = Math.abs(
                    scheduledDepartureTime.getTime() - faScheduledOff.getTime(),
                  );
                  if (timeDiff <= bufferMinutes) {
                    matchedFlight = flight;
                    break;
                  }
                }
              }
            }

            // If no match found by timing, fall back to first flight
            const faFlight = matchedFlight || flightAwareResponse.flights[0];

            if (matchedFlight) {
              console.log(
                `Matched FlightAware flight by scheduled time: ${faFlight.fa_flight_id}`,
              );
            } else {
              console.log(
                `No time match found, using first flight: ${faFlight.fa_flight_id}`,
              );
            }

            // Create FlightAwareData with all typed fields
            await prisma.flightAwareData.create({
              data: {
                faFlightId: faFlight.fa_flight_id,
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
                actualOut: faFlight.actual_out
                  ? new Date(faFlight.actual_out)
                  : null,
                scheduledOff: faFlight.scheduled_off
                  ? new Date(faFlight.scheduled_off)
                  : null,
                estimatedOff: faFlight.estimated_off
                  ? new Date(faFlight.estimated_off)
                  : null,
                actualOff: faFlight.actual_off
                  ? new Date(faFlight.actual_off)
                  : null,
                scheduledOn: faFlight.scheduled_on
                  ? new Date(faFlight.scheduled_on)
                  : null,
                estimatedOn: faFlight.estimated_on
                  ? new Date(faFlight.estimated_on)
                  : null,
                actualOn: faFlight.actual_on
                  ? new Date(faFlight.actual_on)
                  : null,
                scheduledIn: faFlight.scheduled_in
                  ? new Date(faFlight.scheduled_in)
                  : null,
                estimatedIn: faFlight.estimated_in
                  ? new Date(faFlight.estimated_in)
                  : null,
                actualIn: faFlight.actual_in
                  ? new Date(faFlight.actual_in)
                  : null,
                foresightPredictionsAvailable:
                  faFlight.foresight_predictions_available ?? false,
                blocked: faFlight.blocked ?? false,
                diverted: faFlight.diverted ?? false,
                cancelled: faFlight.cancelled ?? false,
                positionOnly: faFlight.position_only ?? false,
                originCode: faFlight.origin.code,
                originCodeIcao: faFlight.origin.code_icao ?? null,
                originCodeIata: faFlight.origin.code_iata ?? null,
                originCodeLid: faFlight.origin.code_lid ?? null,
                originTimezone: faFlight.origin.timezone ?? null,
                originName: faFlight.origin.name ?? null,
                originCity: faFlight.origin.city ?? null,
                destinationCode: faFlight.destination?.code ?? null,
                destinationCodeIcao: faFlight.destination?.code_icao ?? null,
                destinationCodeIata: faFlight.destination?.code_iata ?? null,
                destinationCodeLid: faFlight.destination?.code_lid ?? null,
                destinationTimezone: faFlight.destination?.timezone ?? null,
                destinationName: faFlight.destination?.name ?? null,
                destinationCity: faFlight.destination?.city ?? null,
                flightId: newFlight.id,
              },
            });
          }
        }
      } catch (error) {
        // Log error but don't fail the entire request
        console.error('Error fetching FlightAware data:', error);
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

  async getFlightTrack({ iata, icao, date }: GetFlightTrackParams) {
    const searchDate = new Date(date ?? Date.now());
    searchDate.setUTCHours(0, 0, 0, 0);

    const nextDate = new Date(searchDate);
    nextDate.setDate(searchDate.getDate() + 1);

    // Find the flight in the database
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
        flightAwareData: true,
      },
    });

    if (!existingFlight) {
      throw new BadRequestException('Flight not found in database');
    }

    if (!existingFlight.flightAwareData?.faFlightId) {
      throw new BadRequestException(
        'FlightAware data not available for this flight',
      );
    }

    const faFlightId = existingFlight.flightAwareData.faFlightId;
    const cacheKey = `flight:track:${faFlightId}`;
    const cacheTTL = 30; // 30 seconds

    // Check Redis cache first
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

    // Fetch track data from FlightAware API
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
