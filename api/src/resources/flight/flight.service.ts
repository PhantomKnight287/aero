import { prisma } from 'src/db';

import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createId } from '@paralleldrive/cuid2';
import { Aircraft } from '@prisma/client';

import { AircraftEntity } from './entities/flight.entity';

interface GetFlightParams {
  iata: string;
  icao: string;
  date?: string;
}

@Injectable()
export class FlightService {
  constructor(private readonly configService: ConfigService) {}

  async getFlight({ iata, icao, date }: GetFlightParams) {
    const searchDate = new Date(date ?? Date.now());
    searchDate.setUTCHours(0, 0, 0, 0);

    const nextDate = new Date(searchDate);
    nextDate.setDate(searchDate.getDate() + 1);

    // First check in database
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
      },
    });
    const aircraft = existingFlight?.aircraft
      ? await prisma.aircraft.findFirst({
          where: { hexIcao: existingFlight.aircraft['regS'] },
          include: {
            _count: {
              select: {
                registrations: true,
              },
            },
          },
        })
      : null;
    if (existingFlight) {
      return {
        ...existingFlight,
        aircraft: aircraft
          ? ({
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
            } satisfies AircraftEntity)
          : {
              //@ts-expect-error
              ...existingFlight.aircraft,
              registrataion: existingFlight.aircraft['reg'],
            },
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

      return newFlight;
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
}
