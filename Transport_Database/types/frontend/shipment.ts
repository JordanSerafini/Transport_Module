export interface Shipment {
  id: number;
  order_id: number;
  truck_id?: number;
  driver_id?: number;
  route_id?: number;
  status_id?: number;
  created_at: string;
  updated_at?: string;
  deleted_at?: string;
}

export interface ShipmentEvent {
  id: number;
  shipment_id: number;
  event_status_id?: number;
  event_time?: string;
  comment?: string;
  created_at: string;
  updated_at?: string;
  deleted_at?: string;
}

export interface ShipmentStatus {
  id: number;
  code: string;
  label: string;
  is_final: boolean;
}