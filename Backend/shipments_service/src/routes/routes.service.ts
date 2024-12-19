import {
  Injectable,
  NotFoundException,
  BadRequestException,
  Inject,
} from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class RoutesService {
  constructor(@Inject('PG_CONNECTION') private readonly pool: Pool) {}

  // Récupérer toutes les routes avec pagination et recherche
  async getAllRoutes(page: number, limit: number, searchQuery?: string) {
    const offset = (page - 1) * limit;
    const searchFilter = searchQuery ? `AND LOWER(name) LIKE $3` : '';

    const query = `
      SELECT *
      FROM routes
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
      throw new BadRequestException('Failed to fetch routes.', error);
    }
  }

  // Récupérer une route par ID
  async getRouteById(routeId: number) {
    const query = `
      SELECT *
      FROM routes
      WHERE id = $1 AND deleted_at IS NULL
    `;

    try {
      const result = await this.pool.query(query, [routeId]);
      if (result.rows.length === 0) {
        throw new NotFoundException('Route not found.');
      }
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to fetch route.', error);
    }
  }

  // Créer une nouvelle route
  async createRoute(data: {
    company_id: number;
    name: string;
    start_warehouse_id?: number;
    end_warehouse_id?: number;
  }) {
    const query = `
      INSERT INTO routes (company_id, name, start_warehouse_id, end_warehouse_id, created_at)
      VALUES ($1, $2, $3, $4, NOW())
      RETURNING *
    `;
    const values = [
      data.company_id,
      data.name,
      data.start_warehouse_id || null,
      data.end_warehouse_id || null,
    ];

    try {
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to create route.', error);
    }
  }

  // Mettre à jour une route
  async updateRoute(
    routeId: number,
    updates: {
      company_id?: number;
      name?: string;
      start_warehouse_id?: number;
      end_warehouse_id?: number;
    },
  ) {
    // Validation stricte : suppression de toute clé invalide
    delete updates['routeId'];

    // Vérification : au moins un champ à mettre à jour
    if (!updates || Object.keys(updates).length === 0) {
      throw new BadRequestException('No fields to update.');
    }

    // Génération des champs SQL pour la mise à jour
    const fields = Object.keys(updates)
      .map((key, index) => `${key} = $${index + 2}`)
      .join(', ');

    const query = `
      UPDATE routes
      SET ${fields}, updated_at = NOW()
      WHERE id = $1 AND deleted_at IS NULL
      RETURNING *
    `;
    const values = [routeId, ...Object.values(updates)];

    // console.log('SQL Query:', query);
    // console.log('SQL Values:', values);

    try {
      const result = await this.pool.query(query, values);
      if (result.rows.length === 0) {
        throw new NotFoundException('Route not found or already deleted.');
      }
      return result.rows[0];
    } catch (error) {
      console.error('SQL Error:', error.message);
      throw new BadRequestException('Failed to update route.', error);
    }
  }

  // Supprimer une route (soft delete)
  async deleteRoute(routeId: number) {
    const query = `
      UPDATE routes
      SET deleted_at = NOW()
      WHERE id = $1
      RETURNING *
    `;

    try {
      const result = await this.pool.query(query, [routeId]);
      if (result.rows.length === 0) {
        throw new NotFoundException('Route not found.');
      }
      return { message: 'Route deleted successfully.' };
    } catch (error) {
      throw new BadRequestException('Failed to delete route.', error);
    }
  }

  // Récupérer les stops d'une route
  async getRouteStops(routeId: number) {
    const query = `
      SELECT *
      FROM route_stops
      WHERE route_id = $1 AND deleted_at IS NULL
      ORDER BY stop_order ASC
    `;

    try {
      const result = await this.pool.query(query, [routeId]);
      return result.rows;
    } catch (error) {
      throw new BadRequestException('Failed to fetch route stops.', error);
    }
  }

  // Ajouter un stop à une route
  async addRouteStop(
    routeId: number,
    data: {
      warehouse_id: number;
      stop_order: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    const query = `
      INSERT INTO route_stops (route_id, warehouse_id, stop_order, stop_type, arrival_eta, departure_eta, created_at)
      VALUES ($1, $2, $3, $4, $5, $6, NOW())
      RETURNING *
    `;
    const values = [
      routeId,
      data.warehouse_id,
      data.stop_order,
      data.stop_type || 'WAREHOUSE',
      data.arrival_eta || null,
      data.departure_eta || null,
    ];

    try {
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to add route stop.', error);
    }
  }

  // Mettre à jour un stop
  async updateRouteStop(
    routeId: number,
    stopId: number,
    updates: {
      warehouse_id?: number;
      stop_order?: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    const fields = Object.keys(updates)
      .map((key, index) => `${key} = $${index + 3}`)
      .join(', ');

    const query = `
      UPDATE route_stops
      SET ${fields}, updated_at = NOW()
      WHERE id = $2 AND route_id = $1 AND deleted_at IS NULL
      RETURNING *
    `;
    const values = [routeId, stopId, ...Object.values(updates)];

    try {
      const result = await this.pool.query(query, values);
      if (result.rows.length === 0) {
        throw new NotFoundException('Route stop not found.');
      }
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to update route stop.', error);
    }
  }

  // Supprimer un stop
  async deleteRouteStop(routeId: number, stopId: number) {
    const query = `
      UPDATE route_stops
      SET deleted_at = NOW()
      WHERE id = $2 AND route_id = $1
      RETURNING *
    `;

    try {
      const result = await this.pool.query(query, [routeId, stopId]);
      if (result.rows.length === 0) {
        throw new NotFoundException('Route stop not found.');
      }
      return { message: 'Route stop deleted successfully.' };
    } catch (error) {
      throw new BadRequestException('Failed to delete route stop.', error);
    }
  }
}
