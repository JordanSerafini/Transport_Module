import {
  Injectable,
  BadRequestException,
  Inject,
  NotFoundException,
} from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class DriversService {
  constructor(@Inject('PG_CONNECTION') private readonly pool: Pool) {}
  async getAllDrivers(page: number, limit: number, searchQuery?: string) {
    const offset = (page - 1) * limit;

    const searchFilter = searchQuery
      ? `AND (LOWER(name) LIKE $3 OR LOWER(phone) LIKE $3 OR LOWER(license_number) LIKE $3)`
      : '';

    const query = `
      SELECT *
      FROM drivers
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
      console.error('Error fetching drivers:', error.message);
      throw new BadRequestException('Failed to fetch drivers.', error);
    }
  }

  async getDriverById(driverId: number) {
    const query = `
      SELECT *
      FROM drivers
      WHERE id = $1 AND deleted_at IS NULL
    `;

    try {
      const result = await this.pool.query(query, [driverId]);
      if (result.rows.length === 0) {
        throw new BadRequestException('Driver not found.');
      }
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to fetch driver.', error);
    }
  }

  async createDriver(data: {
    company_id: number;
    name: string;
    license_number: string;
    license_expiry_date: string;
    phone: string;
    driverStatus?: string;
  }) {
    const query = `
      INSERT INTO drivers (company_id, name, license_number, license_expiry_date, phone, driver_status)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;

    const values = [
      data.company_id,
      data.name,
      data.license_number,
      data.license_expiry_date,
      data.phone,
      data.driverStatus || 'ACTIVE',
    ];

    try {
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw new BadRequestException('Failed to create driver.', error);
    }
  }

  async updateDriver(
    driverId: number,
    data: Partial<{
      name: string;
      license_number: string;
      license_expiry_date: string;
      phone: string;
      driver_status: string;
    }>,
  ) {
    if (Object.keys(data).length === 0) {
      throw new BadRequestException('No fields provided to update.');
    }

    // Mappage explicite pour éviter les fautes de frappe ou incohérences
    const fields = Object.keys(data)
      .map((key, index) => `${key} = $${index + 2}`)
      .join(', ');

    const query = `
      UPDATE drivers
      SET ${fields}, updated_at = NOW()
      WHERE id = $1 AND deleted_at IS NULL
      RETURNING *
    `;

    const values = [driverId, ...Object.values(data)];

    console.log('Generated Query:', query);
    console.log('Query Values:', values);

    try {
      const result = await this.pool.query(query, values);
      if (result.rows.length === 0) {
        throw new NotFoundException('Driver not found or already deleted.');
      }
      return result.rows[0];
    } catch (error) {
      console.error('SQL Execution Error:', error.message);
      throw new BadRequestException('Failed to update driver.', error);
    }
  }

  async deleteDriver(driverId: number) {
    const query = `
      UPDATE drivers
      SET deleted_at = NOW()
      WHERE id = $1 AND deleted_at IS NULL
      RETURNING *
    `;

    try {
      const result = await this.pool.query(query, [driverId]);
      if (result.rows.length === 0) {
        throw new BadRequestException('Driver not found or already deleted.');
      }
      return { message: 'Driver deleted successfully.' };
    } catch (error) {
      throw new BadRequestException('Failed to delete driver.', error);
    }
  }
}
