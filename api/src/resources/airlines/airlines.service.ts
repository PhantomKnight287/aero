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
                name: { search: query.search },
              },
              {
                icao: { search: query.search },
              },
              {
                iata: { search: query.search },
              },
              {
                iata: {
                  search: query.search.substring(0, 2),
                },
              },
              {
                icao: {
                  search: query.search.substring(0, 3),
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
