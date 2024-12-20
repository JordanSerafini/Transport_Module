import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { AuthController } from './controllers/auth/auth.controller';
import { TrucksController } from './controllers/shipments/trucks.controller';
import { DriversController } from './controllers/shipments/drivers.controller';
import { ShipmentsController } from './controllers/shipments/shipments.controller';
import { RoutesController } from './controllers/shipments/routes.controller';
import { OrdersController } from './controllers/orders/orders.controller';

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET || 'mdp',
      signOptions: { expiresIn: process.env.JWT_EXPIRES_IN || '100d' },
    }),
    ClientsModule.register([
      {
        name: 'auth_service',
        transport: Transport.TCP,
        options: { port: 3001, host: 'auth_service' },
      },
      {
        name: 'orders_service',
        transport: Transport.TCP,
        options: { port: 3007, host: 'orders_service' },
      },
      {
        name: 'shipments_service',
        transport: Transport.TCP,
        options: { port: 3009, host: 'shipments_service' },
      },
    ]),
  ],
  providers: [JwtAuthGuard],
  controllers: [
    AuthController,
    TrucksController,
    DriversController,
    ShipmentsController,
    RoutesController,
    OrdersController,
  ],
})
export class AppModule {}
