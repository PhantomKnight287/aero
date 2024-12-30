import { ApiProperty } from '@nestjs/swagger';

export class GenericErrorEntity {
  @ApiProperty()
  message: string;
}