import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Query,
  Param,
  Body,
} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { Inject } from '@nestjs/common';

@Controller('drivers')
export class DriversController {
  constructor(
    @Inject('shipments_service')
    private readonly driversServiceClient: ClientProxy,
  ) {}

  @Get('/health')
  async healthCheck() {
    return this.driversServiceClient.send({ cmd: 'health_drivers' }, {});
  }

  // Récupérer tous les chauffeurs (avec pagination, limite, et recherche)
  @Get()
  async getAllDrivers(
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('searchQuery') searchQuery?: string,
  ) {
    return this.driversServiceClient.send(
      { cmd: 'get_all_drivers' },
      { page, limit, searchQuery },
    );
  }

  // Récupérer un chauffeur spécifique par ID
  @Get(':driverId')
  async getDriverById(@Param('driverId') driverId: number) {
    return this.driversServiceClient.send(
      { cmd: 'get_driver_by_id' },
      { driverId },
    );
  }

  // Créer un chauffeur
  @Post()
  async createDriver(
    @Body()
    body: {
      company_id: number;
      name: string;
      license_number: string;
      license_expiryDate: string;
      phone: string;
      driverStatus?: string;
    },
  ) {
    return this.driversServiceClient.send({ cmd: 'create_driver' }, body);
  }

  // Mettre à jour un chauffeur
  @Put(':driverId')
  async updateDriver(
    @Param('driverId') driverId: number,
    @Body()
    body: {
      name?: string;
      license_number?: string;
      license_expiry_date?: string;
      phone?: string;
      driver_status?: string;
    },
  ) {
    console.log('API Gateway - Payload:', { driverId, ...body });
    return this.driversServiceClient.send(
      { cmd: 'update_driver' },
      { driverId, ...body },
    );
  }

  // Supprimer un chauffeur (soft delete)
  @Delete(':driverId')
  async deleteDriver(@Param('driverId') driverId: number) {
    return this.driversServiceClient.send(
      { cmd: 'delete_driver' },
      { driverId },
    );
  }
}
