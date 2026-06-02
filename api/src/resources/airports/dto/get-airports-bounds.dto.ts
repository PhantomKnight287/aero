import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNumber, Max, Min } from 'class-validator';

export class GetAirportsBoundsDTO {
  @ApiProperty({
    description: 'Minimum latitude of the bounding box',
    example: 28.0,
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
    example: 29.0,
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
    example: 76.0,
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
    example: 77.0,
    minimum: -180,
    maximum: 180,
  })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  maxLng: number;
}
