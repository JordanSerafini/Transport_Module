import { Controller } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { RoutesService } from './routes.service';

@Controller()
export class RoutesController {
  constructor(private readonly routesService: RoutesService) {}

  @MessagePattern({ cmd: 'health_routes' })
  healthCheck() {
    return { status: 'ok' };
  }

  @MessagePattern({ cmd: 'get_all_routes' })
  getAllRoutes(
    @Payload() data: { page: number; limit: number; searchQuery?: string },
  ) {
    return this.routesService.getAllRoutes(
      data.page,
      data.limit,
      data.searchQuery,
    );
  }

  @MessagePattern({ cmd: 'get_route_by_id' })
  getRouteById(@Payload() data: { routeId: number }) {
    return this.routesService.getRouteById(data.routeId);
  }

  @MessagePattern({ cmd: 'create_route' })
  createRoute(
    @Payload()
    data: {
      company_id: number;
      name: string;
      start_warehouse_id?: number;
      end_warehouse_id?: number;
    },
  ) {
    return this.routesService.createRoute(data);
  }

  @MessagePattern({ cmd: 'update_route' })
  updateRoute(
    @Payload()
    data: {
      routeId: number;
      company_id?: number;
      name?: string;
      start_warehouse_id?: number;
      end_warehouse_id?: number;
    },
  ) {
    console.log('Received data:', data); // Debug log
    return this.routesService.updateRoute(data.routeId, data);
  }

  @MessagePattern({ cmd: 'delete_route' })
  deleteRoute(@Payload() data: { routeId: number }) {
    return this.routesService.deleteRoute(data.routeId);
  }

  @MessagePattern({ cmd: 'get_route_stops' })
  getRouteStops(@Payload() data: { routeId: number }) {
    return this.routesService.getRouteStops(data.routeId);
  }

  @MessagePattern({ cmd: 'add_route_stop' })
  addRouteStop(
    @Payload()
    data: {
      routeId: number;
      warehouse_id: number;
      stop_order: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    return this.routesService.addRouteStop(data.routeId, data);
  }

  @MessagePattern({ cmd: 'update_route_stop' })
  updateRouteStop(
    @Payload()
    data: {
      routeId: number;
      stopId: number;
      warehouse_id?: number;
      stop_order?: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    return this.routesService.updateRouteStop(data.routeId, data.stopId, data);
  }

  @MessagePattern({ cmd: 'delete_route_stop' })
  deleteRouteStop(@Payload() data: { routeId: number; stopId: number }) {
    return this.routesService.deleteRouteStop(data.routeId, data.stopId);
  }
}
