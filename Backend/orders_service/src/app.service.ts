import { Inject, Injectable } from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class AppService {
  constructor(@Inject('PG_CONNECTION') private readonly pool: Pool) {}

  async getAll(): Promise<any> {
    const query = `
      SELECT * 
      FROM orders 
      WHERE deleted_at IS NULL
    `;
    const { rows } = await this.pool.query(query);
    return rows;
  }

  async getOrdersByCustomer(customer_id: string): Promise<any> {
    const query = `
      SELECT * 
      FROM orders 
      WHERE customer_id = $1
        AND deleted_at IS NULL
    `;
    const rows = await this.pool.query(query, [customer_id]);
    return rows;
  }

  async getOrdersByShipment(shipment_id: string): Promise<any> {
    const query = `
      SELECT * 
      FROM shipments 
      WHERE order_id = $1
        AND deleted_at IS NULL
    `;
    const rows = await this.pool.query(query, [shipment_id]);
    return rows.fields;
  }
}
