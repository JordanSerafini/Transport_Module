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
  getTruckById(@Payload() data: { truck_id: number }) {
    return this.trucksService.getTruckById(data.truck_id);
  }

  // Créer un nouveau camion
  @MessagePattern({ cmd: 'create_truck' })
  createTruck(
    @Payload()
    data: {
      company_id: number;
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
      truck_id: number;
      updates: { license_plate?: string; capacity?: number; model?: string };
    },
  ) {
    return this.trucksService.updateTruck(data.truck_id, data.updates);
  }

  // Supprimer un camion (soft delete)
  @MessagePattern({ cmd: 'delete_truck' })
  deleteTruck(@Payload() data: { truck_id: number }) {
    return this.trucksService.deleteTruck(data.truck_id);
  }

  // Récupérer les maintenances d'un camion
  @MessagePattern({ cmd: 'get_truck_maintenances' })
  getTruckMaintenances(@Payload() data: { truck_id: number }) {
    console.log('Getting maintenances for truck:', data.truck_id);
    return this.trucksService.getTruckMaintenances(data.truck_id);
  }

  // Ajouter une maintenance à un camion
  @MessagePattern({ cmd: 'add_truck_maintenance' })
  addTruckMaintenance(
    @Payload()
    data: {
      truck_id: number;
      description: string;
      cost: number;
      maintenance_date?: string;
    },
  ) {
    return this.trucksService.addTruckMaintenance(data.truck_id, data);
  }

  // Mettre à jour une maintenance d'un camion
  @MessagePattern({ cmd: 'update_truck_maintenance' })
  updateTruckMaintenance(
    @Payload()
    data: {
      truck_id: number;
      maintenance_id: number;
      updates: {
        description?: string;
        cost?: number;
        maintenance_date?: string;
      };
    },
  ) {
    return this.trucksService.updateTruckMaintenance(
      data.truck_id,
      data.maintenance_id,
      data.updates,
    );
  }

  // Supprimer une maintenance (soft delete)
  @MessagePattern({ cmd: 'delete_truck_maintenance' })
  deleteTruckMaintenance(
    @Payload()
    data: {
      truck_id: number;
      maintenance_id: number;
    },
  ) {
    return this.trucksService.deleteTruckMaintenance(
      data.truck_id,
      data.maintenance_id,
    );
  }
}
