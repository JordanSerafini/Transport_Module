import { Injectable, Inject, NotFoundException } from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class TrucksService {
  constructor(@Inject('PG_CONNECTION') private readonly pool: Pool) {}

  // Récupérer tous les camions pour une entreprise
  async getAllTrucks() {
    const query = `
      SELECT * 
      FROM trucks 
      WHERE deleted_at IS NULL
    `;
    const { rows } = await this.pool.query(query);
    return rows;
  }

  // Récupérer un camion par son ID
  async getTruckById(truckId: number) {
    const query = `
      SELECT * 
      FROM trucks 
      WHERE id = $1 AND deleted_at IS NULL
    `;
    const { rows } = await this.pool.query(query, [truckId]);
    if (rows.length === 0) {
      throw new NotFoundException(`Truck with ID ${truckId} not found`);
    }
    return rows[0];
  }

  // Créer un nouveau camion
  async createTruck(data: {
    companyId: number;
    license_plate: string;
    capacity: number;
    model: string;
  }) {
    const query = `
      INSERT INTO trucks (company_id, license_plate, capacity, model, created_at) 
      VALUES ($1, $2, $3, $4, NOW())
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [
      data.companyId,
      data.license_plate,
      data.capacity,
      data.model,
    ]);
    return rows[0];
  }

  // Mettre à jour un camion
  async updateTruck(
    truckId: number,
    updates: { license_plate?: string; capacity?: number; model?: string },
  ) {
    const query = `
      UPDATE trucks 
      SET 
        license_plate = COALESCE($1, license_plate),
        capacity = COALESCE($2, capacity),
        model = COALESCE($3, model),
        updated_at = NOW()
      WHERE id = $4 AND deleted_at IS NULL
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [
      updates.license_plate,
      updates.capacity,
      updates.model,
      truckId,
    ]);
    if (rows.length === 0) {
      throw new NotFoundException(`Truck with ID ${truckId} not found`);
    }
    return rows[0];
  }

  // Supprimer un camion (soft delete)
  async deleteTruck(truckId: number) {
    const query = `
      UPDATE trucks 
      SET deleted_at = NOW() 
      WHERE id = $1
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [truckId]);
    if (rows.length === 0) {
      throw new NotFoundException(`Truck with ID ${truckId} not found`);
    }
    return { message: `Truck ${truckId} soft-deleted.` };
  }

  // Récupérer les maintenances pour un camion
  async getTruckMaintenances(truckId: number) {
    const query = `
      SELECT * 
      FROM truck_maintenances 
      WHERE truck_id = $1 AND deleted_at IS NULL
    `;
    const { rows } = await this.pool.query(query, [truckId]);
    return rows;
  }

  // Ajouter une maintenance à un camion
  async addTruckMaintenance(
    truckId: number,
    data: { description: string; cost: number; maintenanceDate?: string },
  ) {
    const query = `
      INSERT INTO truck_maintenances (truck_id, description, cost, maintenance_date, created_at) 
      VALUES ($1, $2, $3, $4, NOW())
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [
      truckId,
      data.description,
      data.cost,
      data.maintenanceDate || new Date(),
    ]);
    return rows[0];
  }

  // Mettre à jour une maintenance
  async updateTruckMaintenance(
    truckId: number,
    maintenanceId: number,
    updates: { description?: string; cost?: number; maintenanceDate?: string },
  ) {
    const query = `
      UPDATE truck_maintenances 
      SET 
        description = COALESCE($1, description),
        cost = COALESCE($2, cost),
        maintenance_date = COALESCE($3, maintenance_date),
        updated_at = NOW()
      WHERE id = $4 AND truck_id = $5 AND deleted_at IS NULL
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [
      updates.description,
      updates.cost,
      updates.maintenanceDate,
      maintenanceId,
      truckId,
    ]);
    if (rows.length === 0) {
      throw new NotFoundException(
        `Maintenance with ID ${maintenanceId} not found for truck ${truckId}`,
      );
    }
    return rows[0];
  }

  // Supprimer une maintenance (soft delete)
  async deleteTruckMaintenance(truckId: number, maintenanceId: number) {
    const query = `
      UPDATE truck_maintenances 
      SET deleted_at = NOW() 
      WHERE id = $1 AND truck_id = $2
      RETURNING *
    `;
    const { rows } = await this.pool.query(query, [maintenanceId, truckId]);
    if (rows.length === 0) {
      throw new NotFoundException(
        `Maintenance with ID ${maintenanceId} not found for truck ${truckId}`,
      );
    }
    return {
      message: `Maintenance ${maintenanceId} soft-deleted for truck ${truckId}.`,
    };
  }
}
