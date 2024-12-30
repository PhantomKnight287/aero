import { Test, TestingModule } from '@nestjs/testing';
import { AirlinesService } from './airlines.service';

describe('AirlinesService', () => {
  let service: AirlinesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AirlinesService],
    }).compile();

    service = module.get<AirlinesService>(AirlinesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
