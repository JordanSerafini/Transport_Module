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
  @Get(':shipmentId')
  async getShipmentById(@Param('shipmentId') shipmentId: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'get_shipment_by_id' },
      { shipmentId },
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
  @Put(':shipmentId')
  async updateShipment(
    @Param('shipmentId') shipmentId: number,
    @Body()
    body: {
      truck_id?: number;
      driver_id?: number;
      route_id?: number;
      status_id?: number;
    },
  ) {
    console.log('Payload:', { shipmentId, ...body });
    return this.shipmentsServiceClient.send(
      { cmd: 'update_shipment' },
      { shipmentId, ...body },
    );
  }

  // Supprimer une expédition (soft delete)
  @Delete(':shipmentId')
  async deleteShipment(@Param('shipmentId') shipmentId: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'delete_shipment' },
      { shipmentId },
    );
  }

  // Obtenir tous les événements d'une expédition
  @Get(':shipmentId/events')
  async getShipmentEvents(@Param('shipmentId') shipmentId: number) {
    return this.shipmentsServiceClient.send(
      { cmd: 'get_shipment_events' },
      { shipmentId },
    );
  }

  // Ajouter un événement à une expédition
  @Post(':shipmentId/events')
  async addShipmentEvent(
    @Param('shipmentId') shipmentId: number,
    @Body()
    body: {
      event_status_id: number;
      comment?: string;
      event_time?: string;
    },
  ) {
    return this.shipmentsServiceClient.send(
      { cmd: 'add_shipment_event' },
      { shipmentId, ...body },
    );
  }
}
