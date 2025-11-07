import { RedisModule } from '@liaoliaots/nestjs-redis';
import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthMiddleware } from './middlewares/auth/auth.middleware';
import { AirlinesModule } from './resources/airlines/airlines.module';
import { AirportsModule } from './resources/airports/airports.module';
import { AuthModule } from './resources/auth/auth.module';
import { FlightModule } from './resources/flight/flight.module';
import { FlightsModule } from './resources/flights/flights.module';
import { AlertsModule } from './resources/alerts/alerts.module';
import { ProfileModule } from './resources/profile/profile.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    RedisModule.forRootAsync({
      useFactory: (configService: ConfigService) => {
        const redisUrl = new URL(
          configService.get('REDIS_URL') || 'redis://localhost:6379',
        );
        return {
          config: {
            host: redisUrl.hostname,
            port: parseInt(redisUrl.port, 10),
            password: redisUrl.password || undefined,
            db: redisUrl.pathname
              ? parseInt(redisUrl.pathname.slice(1), 10)
              : 0,
            family: 0,
          },
        };
      },
      inject: [ConfigService],
    }),
    AuthModule,
    AirportsModule,
    AirlinesModule,
    FlightsModule,
    FlightModule,
    AlertsModule,
    ProfileModule,
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
      .exclude(`/alerts/(.*)`)
      .forRoutes('*');
  }
}
