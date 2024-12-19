import { Module } from '@nestjs/common';
import { TrucksModule } from './trucks/trucks.module';
import { DriversModule } from './drivers/drivers.module';
import { ShipmentsModule } from './shipments/shipments.module';
import { RoutesModule } from './routes/routes.module';
// import { TrucksController } from './trucks/trucks.controller';
// import { TrucksService } from './trucks/trucks.service';
// import { DriversController } from './drivers/drivers.controller';
// import { DriversService } from './drivers/drivers.service';

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
  // controllers: [TrucksController, DriversController],
  // providers: [TrucksService, DriversService],
})
export class AppModule {}
