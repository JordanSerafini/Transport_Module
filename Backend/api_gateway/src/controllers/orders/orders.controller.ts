import { Controller, Get } from '@nestjs/common';
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
  async getOrdersByCustomer(customer_id: string) {
    return this.ordersServiceClient.send(
      { cmd: 'get_ordersByCustomer' },
      { customer_id },
    );
  }
}
