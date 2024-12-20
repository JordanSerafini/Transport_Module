export class Warehouse {
  id: number;
  companyId: number;
  name: string;
  addressId: number | null;
  capacity: number;
  warehouseType: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
