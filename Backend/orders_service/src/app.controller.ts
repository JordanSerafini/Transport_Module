import { Controller } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern({ cmd: 'get_all_orders' })
  getAll() {
    return this.appService.getAll();
  }

  @MessagePattern({ cmd: 'get_ordersByCustomer' })
  getOrdersByCustomer(data: { customer_id: string }) {
    return this.appService.getOrdersByCustomer(data.customer_id);
  }

  @MessagePattern({ cmd: 'get_ordersByShipment' })
  getOrdersByShipment(data: { shipment_id: string }) {
    return this.appService.getOrdersByShipment(data.shipment_id);
  }
}
