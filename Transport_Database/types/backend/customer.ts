export class Customer {
  id: number;
  companyId: number;
  name: string;
  email: string | null;
  phone: string | null;
  addressId: number | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
