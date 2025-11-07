import { Controller, Get } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { ProfileService } from './profile.service';
import { ProfileStatsResponseEntity } from './entities/profile-stats.entity';
import { GenericErrorEntity } from 'src/common/entites/generic-error.entity';
import { Auth } from 'src/decorators/auth/auth.decorator';
import { User } from '@prisma/client';

@Controller('profile')
@ApiTags('Profile')
@ApiBearerAuth('JWT-auth')
export class ProfileController {
  constructor(private readonly profileService: ProfileService) {}

  @Get('@me')
  @ApiOperation({
    summary: 'Get profile stats',
    description: 'Returns comprehensive statistics about tracked flights including passport data, aircraft stats, airlines, airports, and routes',
  })
  @ApiOkResponse({
    type: ProfileStatsResponseEntity,
    description: 'Profile statistics including passport data and flight analytics',
  })
  @ApiUnauthorizedResponse({ type: GenericErrorEntity })
  async getProfileStats(@Auth() auth: User) {
    return await this.profileService.getProfileStats(auth.id);
  }
}
