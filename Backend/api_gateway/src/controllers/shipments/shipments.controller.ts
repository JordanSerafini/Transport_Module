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

@Controller('shipments')
export class ShipmentsController {
  constructor(
    @Inject('shipments_service')
    private readonly shipmentsServiceClient: ClientProxy,
  ) {}

  // Vérification de la santé du microservice
  @Get('/health')
  async healthCheck() {
    return this.shipmentsServiceClient.send({ cmd: 'health_shipments' }, {});
  }

  // Obtenir toutes les expéditions (avec pagination et recherche facultative)
  @Get()
  async getAllShipments(
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('searchQuery') searchQuery?: string,
  ) {
    return this.shipmentsServiceClient.send(
      { cmd: 'get_all_shipments' },
      { page, limit, searchQuery },
    );
  }

  // Obtenir une expédition spécifique par ID
  @Get(':shipment_id')
  async getShipmentById(@Param('shipment_id') shipment_id: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'get_shipment_by_id' },
      { shipment_id },
    );
  }

  // Créer une nouvelle expédition
  @Post()
  async createShipment(
    @Body()
    body: {
      order_id: number;
      truck_id?: number;
      driver_id?: number;
      route_id?: number;
      status_id?: number;
    },
  ) {
    return this.shipmentsServiceClient.send({ cmd: 'create_shipment' }, body);
  }

  // Mettre à jour une expédition
  @Put(':shipment_id')
  async updateShipment(
    @Param('shipment_id') shipment_id: number,
    @Body()
    body: {
      truck_id?: number;
      driver_id?: number;
      route_id?: number;
      status_id?: number;
    },
  ) {
    console.log('Payload:', { shipment_id, ...body });
    return this.shipmentsServiceClient.send(
      { cmd: 'update_shipment' },
      { shipment_id, ...body },
    );
  }

  // Supprimer une expédition (soft delete)
  @Delete(':shipment_id')
  async deleteShipment(@Param('shipment_id') shipment_id: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'delete_shipment' },
      { shipment_id },
    );
  }

  // Obtenir tous les événements d'une expédition
  @Get(':shipment_id/events')
  async getShipmentEvents(@Param('shipment_id') shipment_id: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'get_shipment_events' },
      { shipment_id },
    );
  }

  // Ajouter un événement à une expédition
  @Post(':shipment_id/events')
  async addShipmentEvent(
    @Param('shipment_id') shipment_id: number,
    @Body()
    body: {
      event_status_id: number;
      comment?: string;
      event_time?: string;
    },
  ) {
    return this.shipmentsServiceClient.send(
      { cmd: 'add_shipment_event' },
      { shipment_id, ...body },
    );
  }

  @Delete(':shipment_id/events/:event_id')
  async deleteShipmentEvent(
    @Param('shipment_id') shipment_id: number,
    @Param('event_id') event_id: number,
  ) {
    return this.shipmentsServiceClient.send(
      { cmd: 'delete_shipment_event' },
      { shipment_id, event_id },
    );
  }

  @Put(':shipment_id/events/:event_id')
  async updateShipmentEvent(
    @Param('shipment_id') shipment_id: number,
    @Param('event_id') event_id: number,
    @Body()
    body: {
      event_status_id?: number;
      comment?: string;
      event_time?: string;
    },
  ) {
    return this.shipmentsServiceClient.send(
      { cmd: 'update_shipment_event' },
      { shipment_id, event_id, ...body },
    );
  }
}
