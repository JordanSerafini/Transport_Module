import {
  Controller,
  Post,
  Body,
  Inject,
  HttpStatus,
  HttpException,
  Get,
} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';

@Controller('')
export class AuthController {
  constructor(
    @Inject('auth_service')
    private readonly authServiceClient: ClientProxy,
  ) {}

  @Get('health')
  async healthCheck() {
    return { status: 200 };
  }

  @Post('login')
  async login(@Body() loginDto: { email: string; password: string }) {
    return this.authServiceClient.send({ cmd: 'login' }, loginDto).toPromise();
  }

  @Post('register')
  async register(
    @Body()
    registerDto: {
      email: string;
      password: string;
      name: string;
      role: string;
    },
  ) {
    return this.authServiceClient
      .send({ cmd: 'register' }, registerDto)
      .toPromise();
  }

  @Post('logout')
  async logout(@Body() logoutDto: { user: { id: string; email: string } }) {
    try {
      const result = await this.authServiceClient
        .send({ cmd: 'logout' }, logoutDto)
        .toPromise();
      return result;
    } catch (error) {
      console.error('Logout failed:', error);
      throw new HttpException(
        'Logout failed',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}