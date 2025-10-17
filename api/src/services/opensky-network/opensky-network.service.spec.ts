import { Test, TestingModule } from '@nestjs/testing';
import { OpenskyNetworkService } from './opensky-network.service';

describe('OpenskyNetworkService', () => {
  let service: OpenskyNetworkService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [OpenskyNetworkService],
    }).compile();

    service = module.get<OpenskyNetworkService>(OpenskyNetworkService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
