export interface Driver {
    id: number;
    company_id: number;
    name: string;
    license_number?: string;
    license_expiry_date?: string; // ISO date string
    phone?: string;
    driver_status: string;
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  