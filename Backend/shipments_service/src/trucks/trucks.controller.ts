import { Controller } from '@nestjs/common';
import { TrucksService } from './trucks.service';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller()
export class TrucksController {
  constructor(private readonly trucksService: TrucksService) {}

  @MessagePattern({ cmd: 'health_trucks' })
  healthCheck() {
    return 200;
  }

  // Récupérer tous les camions pour une entreprise
  @MessagePattern({ cmd: 'get_all_trucks' })
  getAllTrucks() {
    return this.trucksService.getAllTrucks();
  }

  // Récupérer un camion spécifique
  @MessagePattern({ cmd: 'get_truck_by_id' })
  getTruckById(@Payload() data: { truckId: number }) {
    return this.trucksService.getTruckById(data.truckId);
  }

  // Créer un nouveau camion
  @MessagePattern({ cmd: 'create_truck' })
  createTruck(
    @Payload()
    data: {
      companyId: number;
      license_plate: string;
      capacity: number;
      model: string;
    },
  ) {
    return this.trucksService.createTruck(data);
  }

  // Mettre à jour un camion existant
  @MessagePattern({ cmd: 'update_truck' })
  updateTruck(
    @Payload()
    data: {
      truckId: number;
      updates: { license_plate?: string; capacity?: number; model?: string };
    },
  ) {
    return this.trucksService.updateTruck(data.truckId, data.updates);
  }

  // Supprimer un camion (soft delete)
  @MessagePattern({ cmd: 'delete_truck' })
  deleteTruck(@Payload() data: { truckId: number }) {
    return this.trucksService.deleteTruck(data.truckId);
  }

  // Récupérer les maintenances d'un camion
  @MessagePattern({ cmd: 'get_truck_maintenances' })
  getTruckMaintenances(@Payload() data: { truckId: number }) {
    console.log('Getting maintenances for truck:', data.truckId);
    return this.trucksService.getTruckMaintenances(data.truckId);
  }

  // Ajouter une maintenance à un camion
  @MessagePattern({ cmd: 'add_truck_maintenance' })
  addTruckMaintenance(
    @Payload()
    data: {
      truckId: number;
      description: string;
      cost: number;
      maintenanceDate?: string;
    },
  ) {
    return this.trucksService.addTruckMaintenance(data.truckId, data);
  }

  // Mettre à jour une maintenance d'un camion
  @MessagePattern({ cmd: 'update_truck_maintenance' })
  updateTruckMaintenance(
    @Payload()
    data: {
      truckId: number;
      maintenanceId: number;
      updates: {
        description?: string;
        cost?: number;
        maintenanceDate?: string;
      };
    },
  ) {
    return this.trucksService.updateTruckMaintenance(
      data.truckId,
      data.maintenanceId,
      data.updates,
    );
  }

  // Supprimer une maintenance (soft delete)
  @MessagePattern({ cmd: 'delete_truck_maintenance' })
  deleteTruckMaintenance(
    @Payload()
    data: {
      truckId: number;
      maintenanceId: number;
    },
  ) {
    return this.trucksService.deleteTruckMaintenance(
      data.truckId,
      data.maintenanceId,
    );
  }
}
