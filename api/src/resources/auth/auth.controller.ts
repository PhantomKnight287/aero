import { Body, Controller, Get, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDTO } from './dto/login.dto';
import { RegisterDTO } from './dto/register.dto';
import { ApiBearerAuth, ApiConflictResponse, ApiCreatedResponse, ApiNotFoundResponse, ApiOkResponse, ApiOperation, ApiTags, ApiUnauthorizedResponse } from '@nestjs/swagger';
import { LoginEntity } from './entity/login.entity';
import { RegisterEntity } from './entity/register.entity';
import { UserEntity } from './entity/user.entity';
import { GenericErrorEntity } from 'src/common/entites/generic-error.entity';
import { Auth } from 'src/decorators/auth/auth.decorator';
import { User } from '@prisma/client';

@Controller('auth')
@ApiTags("Authentication")
@ApiBearerAuth()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @ApiOperation({
    summary: 'Login',
    description: 'Login'
  })
  @ApiCreatedResponse({
    type:LoginEntity
  })
  @ApiNotFoundResponse({type:GenericErrorEntity})
  @ApiUnauthorizedResponse({type:GenericErrorEntity})
  async login(@Body() body: LoginDTO) {
    return await this.authService.login(body);
  }

  @ApiCreatedResponse({
    type:RegisterEntity
  })
  @ApiOperation({
    summary: 'Register',
    description: 'Create a new user'
  })
  @ApiConflictResponse({type:GenericErrorEntity})
  @Post('register')
  async register(@Body() body: RegisterDTO) {
    return await this.authService.register(body);
  }

  @ApiOperation({
    summary: 'Get current user',
    description: 'Get current user',
  })
  @ApiBearerAuth('JWT-auth')
  @Get('@me')
  @ApiNotFoundResponse({ type: GenericErrorEntity })
  @ApiOkResponse({
    type: UserEntity,
  })
  async getCurrentUser(@Auth() auth: User) {
    return this.authService.hydrate(auth.id);
  }
}