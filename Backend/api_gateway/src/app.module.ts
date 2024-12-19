import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { AuthController } from './controllers/auth/auth.controller';

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET || 'default_secret',
      signOptions: { expiresIn: process.env.JWT_EXPIRES_IN || '100d' },
    }),
    ClientsModule.register([
      {
        name: 'auth_service',
        transport: Transport.TCP,
        options: { port: 3001, host: 'auth_service' },
      },
      {
        name: 'companies_service',
        transport: Transport.TCP,
        options: { port: 3002, host: 'user_service' },
      },
      {
        name: 'customers_service',
        transport: Transport.TCP,
        options: { port: 3002, host: 'customers_service' },
      },
      {
        name: 'invoices_service',
        transport: Transport.TCP,
        options: { port: 3006, host: 'invoices_service' },
      },
      {
        name: 'kpi_service',
        transport: Transport.TCP,
        options: { port: 3009, host: 'kpi_service' },
      },
      {
        name: 'notifications_service',
        transport: Transport.TCP,
        options: { port: 3008, host: 'notifications_service' },
      },
      {
        name: 'orders_service',
        transport: Transport.TCP,
        options: { port: 3004, host: 'orders_service' },
      },
      {
        name: 'products_service',
        transport: Transport.TCP,
        options: { port: 3003, host: 'products_service' },
      },
      {
        name: 'shipments_service',
        transport: Transport.TCP,
        options: { port: 3006, host: 'shipments_service' },
      },
    ]),
  ],
  providers: [JwtAuthGuard],
  controllers: [AuthController],
})
export class AppModule {}
