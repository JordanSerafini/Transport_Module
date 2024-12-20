export interface User {
    id: number;
    company_id: number;
    email: string;
    password_hash: string;
    name?: string;
    role: 'ADMIN' | 'MANAGER' | 'USER';
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  