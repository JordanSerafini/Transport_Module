import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Inject,
} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { Observable } from 'rxjs';

@Controller('trucks')
export class TrucksController {
  constructor(
    @Inject('shipments_service') private readonly shipmentsService: ClientProxy,
  ) {}

  @Get('health')
  healthCheck(): Observable<any> {
    return this.shipmentsService.send({ cmd: 'health_trucks' }, {});
  }

  // Obtenir tous les camions pour une entreprise
  @Get()
  async getAllTrucks() {
    return await this.shipmentsService
      .send({ cmd: 'get_all_trucks' }, {})
      .toPromise();
  }

  // Obtenir les détails d'un camion spécifique
  @Get(':truck_id')
  getTruckById(@Param('truck_id') truck_id: number): Observable<any> {
    return this.shipmentsService.send({ cmd: 'get_truck_by_id' }, { truck_id });
  }

  // Créer un nouveau camion
  @Post()
  createTruck(
    @Body()
    body: {
      company_id: number;
      license_plate: string;
      capacity: number;
      model: string;
    },
  ): Observable<any> {
    return this.shipmentsService.send({ cmd: 'create_truck' }, body);
  }

  // Mettre à jour un camion existant
  @Put(':truck_id')
  updateTruck(
    @Param('truck_id') truck_id: number,
    @Body() body: { license_plate?: string; capacity?: number; model?: string },
  ): Observable<any> {
    console.log('Sending to service:', { truck_id, updates: body });

    return this.shipmentsService.send(
      { cmd: 'update_truck' },
      { truck_id, updates: body },
    );
  }

  // Supprimer un camion (soft delete)
  @Delete(':truck_id')
  deleteTruck(@Param('truck_id') truck_id: number): Observable<any> {
    return this.shipmentsService.send({ cmd: 'delete_truck' }, { truck_id });
  }

  // Maintenance des camions
  @Get(':truck_id/maintenances')
  getTruckMaintenances(@Param('truck_id') truck_id: number): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'get_truck_maintenances' },
      { truck_id },
    );
  }

  @Post(':truck_id/maintenances')
  addTruckMaintenance(
    @Param('truck_id') truck_id: number,
    @Body()
    body: { description: string; cost: number; maintenanceDate?: string },
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'add_truck_maintenance' },
      { truck_id, ...body },
    );
  }

  @Put(':truck_id/maintenances/:maintenance_id')
  updateTruckMaintenance(
    @Param('truck_id') truck_id: number,
    @Param('maintenance_id') maintenance_id: number,
    @Body()
    body: { description?: string; cost?: number; maintenanceDate?: string },
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'update_truck_maintenance' },
      {
        truck_id,
        maintenance_id,
        updates: { ...body },
      },
    );
  }

  @Delete(':truck_id/maintenances/:maintenance_id')
  deleteTruckMaintenance(
    @Param('truck_id') truck_id: number,
    @Param('maintenance_id') maintenance_id: number,
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'delete_truck_maintenance' },
      { truck_id, maintenance_id },
    );
  }
}
