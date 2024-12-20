import { Controller } from '@nestjs/common';
import { DriversService } from './drivers.service';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller('drivers')
export class DriversController {
  constructor(private readonly driversService: DriversService) {}

  @MessagePattern({ cmd: 'health_drivers' })
  healthCheck() {
    return 200;
  }

  @MessagePattern({ cmd: 'get_all_drivers' })
  getAllDrivers(
    @Payload()
    data: {
      page?: number;
      limit?: number;
      searchQuery?: string;
    },
  ) {
    const { page = 1, limit = 10, searchQuery } = data;
    return this.driversService.getAllDrivers(page, limit, searchQuery);
  }

  @MessagePattern({ cmd: 'get_driver_by_id' })
  getDriverById(@Payload() data: { driver_id: number }) {
    return this.driversService.getDriverById(data.driver_id);
  }

  @MessagePattern({ cmd: 'get_drivers_by_status' })
  async getDriversByStatus(
    @Payload() data: { driver_status: string; page?: number; limit?: number },
  ) {
    const { driver_status, page = 1, limit = 10 } = data;

    const results = await this.driversService.getDriversByStatus(
      driver_status,
      page,
      limit,
    );
    return results;
  }

  @MessagePattern({ cmd: 'create_driver' })
  createDriver(
    @Payload()
    data: {
      company_id: number;
      name: string;
      license_number: string;
      license_expiry_date: string;
      phone: string;
      driverStatus?: string;
    },
  ) {
    try {
      return this.driversService.createDriver(data);
    } catch (error) {
      return error;
    }
  }

  @MessagePattern({ cmd: 'update_driver' })
  updateDriver(
    @Payload()
    data: {
      driverId: number;
      name?: string;
      license_number?: string;
      license_expiry_date?: string;
      phone?: string;
      driver_status?: string;
    },
  ) {
    console.log('Microservice - Received Data:', data);

    // Mappage explicite pour éviter les erreurs dues à des noms incohérents
    const updates = {
      name: data.name,
      license_number: data.license_number,
      license_expiry_date: data.license_expiry_date,
      phone: data.phone,
      driver_status: data.driver_status,
    };

    // Supprimez les champs non définis
    const filteredUpdates = Object.fromEntries(
      Object.entries(updates).filter(([value]) => value !== undefined),
    );

    return this.driversService.updateDriver(data.driverId, filteredUpdates);
  }

  @MessagePattern({ cmd: 'delete_driver' })
  deleteDriver(@Payload() data: { driverId: number }) {
    return this.driversService.deleteDriver(data.driverId);
  }
}
