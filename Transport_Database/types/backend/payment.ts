export class Payment {
  id: number;
  invoiceId: number;
  paymentMethod: string;
  amount: number;
  paidAt: Date;
  note: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
