export class Route {
  id: number;
  companyId: number;
  name: string | null;
  startWarehouseId: number | null;
  endWarehouseId: number | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}

export class RouteStop {
  id: number;
  routeId: number;
  warehouseId: number | null;
  stopOrder: number;
  stopType: string;
  arrivalEta: Date | null;
  departureEta: Date | null;
  actualArrival: Date | null;
  actualDeparture: Date | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
