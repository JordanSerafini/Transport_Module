export class Invoice {
  id: number;
  orderId: number;
  invoiceNumber: string;
  amount: number;
  currency: string;
  issuedAt: Date;
  paidAt: Date | null;
  dueDate: Date | null;
  status: string;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
