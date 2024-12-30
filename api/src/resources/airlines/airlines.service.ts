import { prisma } from 'src/db';

import { Injectable } from '@nestjs/common';

@Injectable()
export class AirlinesService {
  async getAirlines(query: { search?: string }) {
    return await prisma.airline.findMany({
      where: query.search
        ? {
            OR: [
              {
                name: { contains: query.search, mode: 'insensitive' },
              },
              {
                icao: { contains: query.search, mode: 'insensitive' },
              },
              {
                iata: { contains: query.search, mode: 'insensitive' },
              },
              {
                iata: {
                  equals: query.search.substring(0, 2),
                  mode: 'insensitive',
                },
              },
              {
                icao: {
                  equals: query.search.substring(0, 3),
                  mode: 'insensitive',
                },
              },
            ],
          }
        : undefined,
      omit: {
        createdAt: true,
        updatedAt: true,
      },
    });
  }
}
