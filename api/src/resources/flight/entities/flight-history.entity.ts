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
