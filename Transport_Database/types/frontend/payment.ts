export interface Payment {
    id: number;
    invoice_id: number;
    payment_method: 'CARD' | 'BANK_TRANSFER' | 'CASH';
    amount: number;
    paid_at: string; // ISO date string
    note?: string;
    created_at: string; // ISO date string
    updated_at?: string; // ISO date string
    deleted_at?: string; // ISO date string
  }
  