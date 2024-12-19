import { Module } from '@nestjs/common';
import { DriversService } from './drivers.service';
import { DriversController } from './drivers.controller';
import { PgConnectionModule } from 'pool_package';

@Module({
  imports: [PgConnectionModule],
  providers: [DriversService],
  controllers: [DriversController],
})
export class DriversModule {}
