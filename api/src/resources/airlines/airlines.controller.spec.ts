import { Test, TestingModule } from '@nestjs/testing';
import { AirlinesController } from './airlines.controller';
import { AirlinesService } from './airlines.service';

describe('AirlinesController', () => {
  let controller: AirlinesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AirlinesController],
      providers: [AirlinesService],
    }).compile();

    controller = module.get<AirlinesController>(AirlinesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
