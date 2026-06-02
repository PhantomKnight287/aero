import { Test, TestingModule } from '@nestjs/testing';

import { FlightAwareService } from 'src/services/flightaware/flightaware.service';

import { AirportsService } from './airports.service';

describe('AirportsService', () => {
  let service: AirportsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AirportsService,
        { provide: FlightAwareService, useValue: {} },
      ],
    }).compile();

    service = module.get<AirportsService>(AirportsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
