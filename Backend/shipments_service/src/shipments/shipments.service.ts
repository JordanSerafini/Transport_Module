import {
  Injectable,
  Inject,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class ShipmentsService {
  constructor(@Inject('PG_CONNECTION') private readonly pool: Pool) {}

  async getAllShipments(page: number, limit: number, searchQuery?: string) {
    const offset = (page - 1) * limit;
    const searchFilter = searchQuery
      ? `AND (CAST(order_id AS TEXT) LIKE $3 OR LOWER(status_id::TEXT) LIKE $3)`
      : '';

    const query = `
      SELECT *
      FROM shipments
      WHERE deleted_at IS NULL
      ${searchFilter}
      ORDER BY created_at DESC
      LIMIT $1 OFFSET $2
    `;
    const values = searchQuery
      ? [limit, offset, `%${searchQuery.toLowerCase()}%`]
      : [limit, offset];

    try {
      const result = await this.pool.query(query, values);
      return result.rows;
    } catch (error) {
      throw new BadRequestException('Failed to fetch shipments.', error);
    }
  }

  async getShipmentById(shipment_id: number) {
    const query = `
      SELECT *
      FROM shipments
      WHERE id = $1 AND deleted_at IS NULL
    `;
    try {
      const result = await this.pool.query(query, [shipment_id]);
      if (result.rows.length === 0) {
        throw new BadRequestException('Shipment not found.');
      }
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to fetch shipment.', error);
    }
  }

  async createShipment(data: {
    order_id: number;
    truck_id?: number;
    driver_id?: number;
    route_id?: number;
    status_id?: number;
  }) {
    const query = `
      INSERT INTO shipments (order_id, truck_id, driver_id, route_id, status_id, created_at)
      VALUES ($1, $2, $3, $4, $5, NOW())
      RETURNING *
    `;
    const values = [
      data.order_id,
      data.truck_id || null,
      data.driver_id || null,
      data.route_id || null,
      data.status_id || null,
    ];

    try {
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to create shipment.', error);
    }
  }

  async updateShipment(
    shipment_id: number,
    updates: Partial<{
      order_id: number;
      truck_id: number;
      driver_id: number;
      route_id: number;
      status_id: number;
    }>,
  ) {
    if (Object.keys(updates).length === 0) {
      throw new BadRequestException('No fields provided to update.');
    }

    // Filtrer les clés valides (exclure `shipment_id` ou autres champs invalides)
    const filteredUpdates = Object.fromEntries(
      Object.entries(updates).filter(([key]) => key !== 'shipment_id'),
    );

    const fields = Object.keys(filteredUpdates)
      .map((key, index) => `${key} = $${index + 2}`) // À partir de $2 car $1 est pour shipment_id
      .join(', ');

    const query = `
      UPDATE shipments
      SET ${fields}, updated_at = NOW()
      WHERE id = $1 AND deleted_at IS NULL
      RETURNING *
    `;
    const values = [shipment_id, ...Object.values(filteredUpdates)];

    console.log('SQL Query:', query); // Déboguer la requête SQL
    console.log('SQL Values:', values); // Déboguer les valeurs

    try {
      const result = await this.pool.query(query, values);
      if (result.rows.length === 0) {
        throw new NotFoundException('Shipment not found or already deleted.');
      }
      return result.rows[0];
    } catch (error) {
      console.error('SQL Error:', error.message); // Déboguer les erreurs SQL
      throw new BadRequestException('Failed to update shipment.', error);
    }
  }

  async deleteShipment(shipment_id: number) {
    const query = `
      UPDATE shipments
      SET deleted_at = NOW()
      WHERE id = $1
      RETURNING *
    `;
    try {
      const result = await this.pool.query(query, [shipment_id]);
      if (result.rows.length === 0) {
        throw new BadRequestException('Shipment not found or already deleted.');
      }
      return { message: 'Shipment deleted successfully.' };
    } catch (error) {
      throw new BadRequestException('Failed to delete shipment.', error);
    }
  }

  async getShipmentEvents(shipment_id: number) {
    const query = `
      SELECT *
      FROM shipment_events
      WHERE shipment_id = $1 AND deleted_at IS NULL
      ORDER BY event_time ASC
    `;
    try {
      const result = await this.pool.query(query, [shipment_id]);
      return result.rows;
    } catch (error) {
      throw new BadRequestException('Failed to fetch shipment events.', error);
    }
  }

  async addShipmentEvent(
    shipment_id: number,
    data: { event_status_id: number; comment?: string; event_time?: string },
  ) {
    const query = `
      INSERT INTO shipment_events (shipment_id, event_status_id, comment, event_time, created_at)
      VALUES ($1, $2, $3, $4, NOW())
      RETURNING *
    `;
    const values = [
      shipment_id,
      data.event_status_id,
      data.comment || null,
      data.event_time || new Date(),
    ];

    try {
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to add shipment event.', error);
    }
  }

  async deleteShipmentEvent(shipment_id: number, event_id: number) {
    const query = `
      UPDATE shipment_events
      SET deleted_at = NOW()
      WHERE shipment_id = $1 AND id = $2
      RETURNING *
    `;
    try {
      const result = await this.pool.query(query, [shipment_id, event_id]);
      if (result.rows.length === 0) {
        throw new BadRequestException(
          'Shipment event not found or already deleted.',
        );
      }
      return { message: 'Shipment event deleted successfully.' };
    } catch (error) {
      throw new BadRequestException('Failed to delete shipment event.', error);
    }
  }

  async updateShipmentEvent(data: {
    shipment_id: number;
    event_id: number;
    event_status_id?: number;
    comment?: string;
    event_time?: string;
  }) {
    const { shipment_id, event_id, ...updates } = data;

    // Vérifier qu'il y a au moins un champ à mettre à jour
    if (Object.keys(updates).length === 0) {
      throw new BadRequestException('No fields to update.');
    }

    // Générer les champs à mettre à jour dans la requête SQL
    const fields = Object.keys(updates)
      .map((key, index) => `${key} = $${index + 3}`)
      .join(', ');

    const query = `
      UPDATE shipment_events
      SET ${fields}, updated_at = NOW()
      WHERE id = $2 AND shipment_id = $1 AND deleted_at IS NULL
      RETURNING *
    `;

    const values = [shipment_id, event_id, ...Object.values(updates)];

    console.log('SQL Query:', query);
    console.log('SQL Values:', values);

    try {
      const result = await this.pool.query(query, values);

      // Si aucun événement n'a été mis à jour, lever une exception
      if (result.rows.length === 0) {
        throw new NotFoundException(
          'Shipment event not found or already deleted.',
        );
      }

      return result.rows[0]; // Retourner l'événement mis à jour
    } catch (error) {
      console.error('SQL Error:', error.message);
      throw new BadRequestException('Failed to update shipment event.', error);
    }
  }
}
