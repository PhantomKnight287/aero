import { ApiProperty } from '@nestjs/swagger';
import {
  StatsFlightSummaryEntity,
  YearCountEntity,
} from 'src/resources/profile/entities/stats-sections.entity';

export class FlightHistoryResponseEntity {
  @ApiProperty({ type: [StatsFlightSummaryEntity] }) items: StatsFlightSummaryEntity[];
  @ApiProperty({ type: String, nullable: true }) nextCursor: string | null;
  @ApiProperty({ type: [YearCountEntity], description: 'All years, desc' }) yearCounts: YearCountEntity[];
}

export class RouteHistoryEntity {
  @ApiProperty() flightCount: number;
  @ApiProperty() distanceKm: number;
  @ApiProperty() blockMinutes: number;
  @ApiProperty({ type: [StatsFlightSummaryEntity], description: 'Up to 3, newest first' }) recent: StatsFlightSummaryEntity[];
}
