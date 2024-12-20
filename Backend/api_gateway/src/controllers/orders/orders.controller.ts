import { Controller, Get, Param } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { Inject } from '@nestjs/common';

@Controller('orders')
export class OrdersController {
  constructor(
    @Inject('orders_service')
    private readonly ordersServiceClient: ClientProxy,
  ) {}

  @Get('/health')
  async healthCheck() {
    return { code: 200 };
  }

  @Get('')
  async getOrders() {
    return this.ordersServiceClient.send({ cmd: 'get_all_orders' }, {});
  }

  @Get('/customer/:customer_id')
  async getOrdersByCustomer(@Param('customer_id') customer_id: string) {
    return this.ordersServiceClient.send(
      { cmd: 'get_ordersByCustomer' },
      { customer_id },
    );
  }

  @Get('/shipment/:order_id')
  async getOrdersByShipment(@Param('order_id') order_id: string) {
    return this.ordersServiceClient.send({ cmd: 'get_byId' }, { order_id });
  }
}
