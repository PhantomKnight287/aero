import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { UserEntity } from './user.entity';


export class LoginEntity {
  @ApiProperty({
    description: 'JWT token which will be used for all other requests',
  })
  token: string;

  @ApiProperty({})
  @Type(() => UserEntity)
  user: UserEntity;
}