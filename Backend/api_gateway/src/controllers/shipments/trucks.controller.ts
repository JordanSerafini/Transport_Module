import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
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
  getAllTrucks(@Query('companyId') companyId: number): Observable<any> {
    return this.shipmentsService.send({ cmd: 'get_all_trucks' }, { companyId });
  }

  // Obtenir les détails d'un camion spécifique
  @Get(':truckId')
  getTruckById(@Param('truckId') truckId: number): Observable<any> {
    return this.shipmentsService.send({ cmd: 'get_truck_by_id' }, { truckId });
  }

  // Créer un nouveau camion
  @Post()
  createTruck(
    @Body()
    body: {
      companyId: number;
      license_plate: string;
      capacity: number;
      model: string;
    },
  ): Observable<any> {
    return this.shipmentsService.send({ cmd: 'create_truck' }, body);
  }

  // Mettre à jour un camion existant
  @Put(':truckId')
  updateTruck(
    @Param('truckId') truckId: number,
    @Body() body: { license_plate?: string; capacity?: number; model?: string },
  ): Observable<any> {
    console.log('Sending to service:', { truckId, updates: body });

    return this.shipmentsService.send(
      { cmd: 'update_truck' },
      { truckId, updates: body },
    );
  }

  // Supprimer un camion (soft delete)
  @Delete(':truckId')
  deleteTruck(@Param('truckId') truckId: number): Observable<any> {
    return this.shipmentsService.send({ cmd: 'delete_truck' }, { truckId });
  }

  // Maintenance des camions
  @Get(':truckId/maintenances')
  getTruckMaintenances(@Param('truckId') truckId: number): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'get_truck_maintenances' },
      { truckId },
    );
  }

  @Post(':truckId/maintenances')
  addTruckMaintenance(
    @Param('truckId') truckId: number,
    @Body()
    body: { description: string; cost: number; maintenanceDate?: string },
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'add_truck_maintenance' },
      { truckId, ...body },
    );
  }

  @Put(':truckId/maintenances/:maintenanceId')
  updateTruckMaintenance(
    @Param('truckId') truckId: number,
    @Param('maintenanceId') maintenanceId: number,
    @Body()
    body: { description?: string; cost?: number; maintenanceDate?: string },
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'update_truck_maintenance' },
      {
        truckId,
        maintenanceId,
        updates: { ...body }, // Crée un objet `updates` compatible avec le microservice
      },
    );
  }

  @Delete(':truckId/maintenances/:maintenanceId')
  deleteTruckMaintenance(
    @Param('truckId') truckId: number,
    @Param('maintenanceId') maintenanceId: number,
  ): Observable<any> {
    return this.shipmentsService.send(
      { cmd: 'delete_truck_maintenance' },
      { truckId, maintenanceId },
    );
  }
}
