export class Order {
  id: number;
  companyId: number;
  customerId: number | null;
  warehouseId: number | null;
  totalWeight: number;
  statusId: number | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}

export class OrderItem {
  id: number;
  orderId: number;
  productId: number | null;
  quantity: number;
  unitWeight: number;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
