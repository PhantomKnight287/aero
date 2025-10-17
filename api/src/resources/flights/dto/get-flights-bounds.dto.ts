import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';

export class GetFlightsBoundsDTO {
  @ApiProperty({
    description: 'Minimum latitude of the bounding box',
    example: 40.0,
    minimum: -90,
    maximum: 90,
  })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  minLat: number;

  @ApiProperty({
    description: 'Maximum latitude of the bounding box',
    example: 50.0,
    minimum: -90,
    maximum: 90,
  })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  maxLat: number;

  @ApiProperty({
    description: 'Minimum longitude of the bounding box',
    example: -10.0,
    minimum: -180,
    maximum: 180,
  })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  minLng: number;

  @ApiProperty({
    description: 'Maximum longitude of the bounding box',
    example: 10.0,
    minimum: -180,
    maximum: 180,
  })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  maxLng: number;
}
