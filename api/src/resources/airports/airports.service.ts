import { prisma } from 'src/db';

import { Injectable } from '@nestjs/common';
import { createId } from '@paralleldrive/cuid2';

@Injectable()
export class AirportsService {
  async getAirports({ search }: { search: string }) {
    const res = await prisma.airport.findMany({
      omit: { createdAt: true, updatedAt: true },
      where: {
        type: { not: 'closed' },
        iataCode: { not: null },
        ...(search
          ? {
              OR: [
                {
                  name: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  ident: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  iataCode: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
                {
                  municipality: {
                    contains: search,
                    mode: 'insensitive',
                  },
                },
              ],
            }
          : undefined),
      },
    });
    return res;
  }

  async createAirport(body: any) {
    return await prisma.airport.create({
      data: { ...body, id: `airport_${createId()}` },
    });
  }
}
