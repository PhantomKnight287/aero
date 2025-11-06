import { existsSync, mkdirSync, writeFileSync } from 'fs';
import { join } from 'path';

import { Body, Controller, Headers, Param, Post } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';

import { AlertsService } from './alerts.service';

@Controller('alerts')
@ApiExcludeController()
export class AlertsController {
  constructor(private readonly alertsService: AlertsService) {}

  @Post(':id')
  async handleFlightawareALerts(
    @Body() body: any,
    @Headers() headers: HeadersInit,
    @Param(':id') id: string,
  ) {
    const folderPath = join(process.cwd(), 'alerts', id);
    if (!existsSync(folderPath)) {
      mkdirSync(folderPath, { recursive: true });
    }
    writeFileSync(
      join(folderPath, `${new Date().getTime()}.json`),
      JSON.stringify(
        {
          headers,
          body,
        },
        null,
        2,
      ),
    );

    return {
      ok: true,
    };
  }
}
