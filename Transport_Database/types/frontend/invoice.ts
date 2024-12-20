export interface Invoice {
    id: number;
    order_id: number;
    invoice_number: string;
    amount: number;
    currency: 'EUR' | 'USD' | 'GBP';
    issued_at: string; // ISO date string
    paid_at?: string; // ISO date string
    due_date?: string; // ISO date string
    status: 'PENDING' | 'PAID' | 'OVERDUE';
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  