import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class RegisterDTO {
  @ApiProperty({})
  @IsString()
  email: string;

  @ApiProperty({})
  @IsString()
  password: string;

  @IsString()
  @ApiProperty({})
  name: string;
}
