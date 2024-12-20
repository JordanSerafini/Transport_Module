export interface Driver {
    id: number;
    company_id: number;
    name: string;
    license_number?: string;
    license_expiry_date?: string;
    phone?: string;
    driver_status: string;
    created_at: string;
    updated_at?: string;
    deleted_at?: string;
  }
  