import { Module } from '@nestjs/common';
import { TrucksModule } from './trucks/trucks.module';
import { DriversModule } from './drivers/drivers.module';
import { ShipmentsModule } from './shipments/shipments.module';
import { RoutesModule } from './routes/routes.module';

import { PgConnectionModule } from 'pool_package';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PgConnectionModule,
    TrucksModule,
    DriversModule,
    ShipmentsModule,
    RoutesModule,
  ],
})
export class AppModule {}
