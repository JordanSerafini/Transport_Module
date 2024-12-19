export interface Route {
    id: number;
    company_id: number;
    name?: string;
    start_warehouse_id?: number;
    end_warehouse_id?: number;
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }

  export interface RouteStop {
    id: number;
    route_id: number;
    warehouse_id?: number;
    stop_order: number;
    stop_type?: string;
    arrival_eta?: string; // ISO date string
    departure_eta?: string; // ISO date string
    actual_arrival?: string; // ISO date string
    actual_departure?: string; // ISO date string
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  