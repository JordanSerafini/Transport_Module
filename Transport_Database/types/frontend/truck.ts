export interface Truck {
  id: number;
  company_id: number;
  license_plate: string;
  capacity?: number;
  model?: string;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}
  
export interface TruckMaintenance {
  id: number;
  truck_id: number;
  maintenance_date: string; // ISO date string
  description?: string;
  cost: number;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}
