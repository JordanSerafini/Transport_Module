export class Shipment {
  id: number;
  orderId: number;
  truckId: number | null;
  driverId: number | null;
  routeId: number | null;
  statusId: number | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}

export class ShipmentEvent {
  id: number;
  shipmentId: number;
  eventStatusId: number | null;
  eventTime: Date;
  comment: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}

