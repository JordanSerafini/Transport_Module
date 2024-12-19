import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
  Query,
  Inject,
} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';

@Controller('routes')
export class RoutesController {
  constructor(
    @Inject('shipments_service')
    private readonly routesServiceClient: ClientProxy,
  ) {}

  // Vérification de la santé du microservice
  @Get('/health')
  async healthCheck() {
    return this.routesServiceClient.send({ cmd: 'health_routes' }, {});
  }

  // Obtenir toutes les routes (avec pagination et recherche facultative)
  @Get()
  async getAllRoutes(
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('searchQuery') searchQuery?: string,
  ) {
    return this.routesServiceClient.send(
      { cmd: 'get_all_routes' },
      { page, limit, searchQuery },
    );
  }

  // Obtenir une route spécifique par ID
  @Get(':routeId')
  async getRouteById(@Param('routeId') routeId: number) {
    return this.routesServiceClient.send(
      { cmd: 'get_route_by_id' },
      { routeId },
    );
  }

  // Créer une nouvelle route
  @Post()
  async createRoute(
    @Body()
    body: {
      company_id: number;
      name: string;
      start_warehouse_id?: number;
      end_warehouse_id?: number;
    },
  ) {
    return this.routesServiceClient.send({ cmd: 'create_route' }, body);
  }

  // Mettre à jour une route
  @Put(':routeId')
  async updateRoute(
    @Param('routeId') routeId: string,
    @Body()
    body: {
      company_id?: number;
      name?: string;
      start_warehouse_id?: number;
      end_warehouse_id?: number;
    },
  ) {
    const payload = { routeId: parseInt(routeId, 10), ...body };
    //console.log('Sending to service:', payload); // Debug
    return this.routesServiceClient.send({ cmd: 'update_route' }, payload);
  }

  // Supprimer une route (soft delete)
  @Delete(':routeId')
  async deleteRoute(@Param('routeId') routeId: number) {
    return this.routesServiceClient.send({ cmd: 'delete_route' }, { routeId });
  }

  // Obtenir toutes les étapes intermédiaires (stops) d'une route
  @Get(':routeId/stops')
  async getRouteStops(@Param('routeId') routeId: number) {
    return this.routesServiceClient.send(
      { cmd: 'get_route_stops' },
      { routeId },
    );
  }

  // Ajouter une étape intermédiaire (stop) à une route
  @Post(':routeId/stops')
  async addRouteStop(
    @Param('routeId') routeId: number,
    @Body()
    body: {
      warehouse_id: number;
      stop_order: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    return this.routesServiceClient.send(
      { cmd: 'add_route_stop' },
      { routeId, ...body },
    );
  }

  // Mettre à jour une étape intermédiaire (stop) d'une route
  @Put(':routeId/stops/:stopId')
  async updateRouteStop(
    @Param('routeId') routeId: number,
    @Param('stopId') stopId: number,
    @Body()
    body: {
      warehouse_id?: number;
      stop_order?: number;
      stop_type?: string;
      arrival_eta?: string;
      departure_eta?: string;
    },
  ) {
    return this.routesServiceClient.send(
      { cmd: 'update_route_stop' },
      { routeId, stopId, ...body },
    );
  }

  // Supprimer une étape intermédiaire (stop) d'une route
  @Delete(':routeId/stops/:stopId')
  async deleteRouteStop(
    @Param('routeId') routeId: number,
    @Param('stopId') stopId: number,
  ) {
    return this.routesServiceClient.send(
      { cmd: 'delete_route_stop' },
      { routeId, stopId },
    );
  }
}
