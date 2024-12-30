import { IsString } from 'class-validator';

import { ApiProperty } from '@nestjs/swagger';

export class GetAirlineDTO {
  @IsString()
  @ApiProperty({ description: 'The search query, like 6E9920' })
  search: string;
}
