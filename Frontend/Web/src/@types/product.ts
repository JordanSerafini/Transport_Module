export interface Product {
    id: number;
    company_id: number;
    name: string;
    weight: number;
    unit_id?: number;
    description?: string;
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  