import { join } from 'path';

import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ServeStaticModule } from '@nestjs/serve-static';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthMiddleware } from './middlewares/auth/auth.middleware';
import { AirlinesModule } from './resources/airlines/airlines.module';
import { AirportsModule } from './resources/airports/airports.module';
import { AlertsModule } from './resources/alerts/alerts.module';
import { AuthModule } from './resources/auth/auth.module';
import { FlightModule } from './resources/flight/flight.module';
import { FlightsModule } from './resources/flights/flights.module';
import { ProfileModule } from './resources/profile/profile.module';
import { RedisService } from './services/redis/redis.service';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    AirportsModule,
    AirlinesModule,
    FlightsModule,
    FlightModule,
    AlertsModule,
    ProfileModule,
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'web'),
      exclude: ['/v*', '/docs*', '/alerts*', '/.well-known*'],
    }),
  ],
  controllers: [AppController],
  providers: [AppService, RedisService],
  exports: [RedisService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('/v(.*)/auth/(login|register)')
      .exclude('/v(.*)/airports')
      .exclude('/v(.*)/airlines')
      .exclude('/static/(.*)')
      .exclude('/assets/(.*)')
      .exclude('/features/(.*)')
      .exclude('/icons/(.*)')
      .exclude(`/alerts/(.*)`)
      .forRoutes('*');
  }
}
