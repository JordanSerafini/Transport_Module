export interface Company {
    id: number;
    name: string;
    email?: string;
    phone?: string;
    address_id?: number;
    timezone: string;
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  