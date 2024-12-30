import { Module } from '@nestjs/common';
import { AirlinesService } from './airlines.service';
import { AirlinesController } from './airlines.controller';

@Module({
  controllers: [AirlinesController],
  providers: [AirlinesService],
})
export class AirlinesModule {}
