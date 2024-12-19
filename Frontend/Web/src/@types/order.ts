export interface Order {
  id: number;
  company_id: number;
  customer_id?: number;
  warehouse_id?: number;
  total_weight?: number;
  status_id?: number;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}

export interface OrderItem {
  id: number;
  order_id: number;
  product_id?: number;
  quantity: number;
  unit_weight: number;
  created_at: string; // ISO date string
  updated_at?: string; // ISO date string
  deleted_at?: string; // ISO date string
}
