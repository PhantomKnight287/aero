import { ApiProperty } from "@nestjs/swagger";

export class UserEntity {
    @ApiProperty()
    name: string;

    @ApiProperty()
    id:string
  }