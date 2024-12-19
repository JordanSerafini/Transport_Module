import { Module } from '@nestjs/common';
import { TrucksService } from './trucks.service';
import { TrucksController } from './trucks.controller';
import { PgConnectionModule } from 'pool_package';

@Module({
  imports: [PgConnectionModule],
  providers: [TrucksService],
  controllers: [TrucksController],
})
export class TrucksModule {}
