import { join } from 'path';

import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ServeStaticModule } from '@nestjs/serve-static';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthMiddleware } from './middlewares/auth/auth.middleware';
import { AirlinesModule } from './resources/airlines/airlines.module';
import { AirportsModule } from './resources/airports/airports.module';
import { AuthModule } from './resources/auth/auth.module';
import { FlightsModule } from './resources/flights/flights.module';
import { FlightModule } from './resources/flight/flight.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    AirportsModule,
    AirlinesModule,
    FlightsModule,
    FlightModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('/v(.*)/auth/(login|register)')
      .exclude('/v(.*)/airports')
      .exclude('/v(.*)/airlines')
      .exclude('/static/(.*)')
      .forRoutes('*');
  }
}
