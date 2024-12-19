import { Module } from '@nestjs/common';
import { ShipmentsService } from './shipments.service';
import { ShipmentsController } from './shipments.controller';
import { PgConnectionModule } from 'pool_package';

@Module({
  imports: [PgConnectionModule],
  providers: [ShipmentsService],
  controllers: [ShipmentsController],
})
export class ShipmentsModule {}
