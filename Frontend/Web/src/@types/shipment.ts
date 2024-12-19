export interface Shipment {
  id: number;
  order_id: number;
  truck_id?: number;
  driver_id?: number;
  route_id?: number;
  status_id?: number;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}

export interface ShipmentEvent {
  id: number;
  shipment_id: number;
  event_status_id?: number;
  event_time?: string; // ISO date string
  comment?: string;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}
