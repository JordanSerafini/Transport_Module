export class Truck {
  id: number;
  companyId: number;
  licensePlate: string;
  capacity: number;
  model: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}

export class TruckMaintenance {
  id: number;
  truckId: number;
  maintenanceDate: Date;
  description: string | null;
  cost: number;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
