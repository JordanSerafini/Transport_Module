import { Controller } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { ShipmentsService } from './shipments.service';

@Controller('shipments')
export class ShipmentsController {
  constructor(private readonly shipmentsService: ShipmentsService) {}

  @MessagePattern({ cmd: 'health_shipments' })
  healthCheck() {
    return { status: 'Shipments service is healthy' };
  }

  @MessagePattern({ cmd: 'get_all_shipments' })
  getAllShipments(
    @Payload()
    data: {
      page?: number;
      limit?: number;
      searchQuery?: string;
    },
  ) {
    const { page = 1, limit = 10, searchQuery } = data;
    return this.shipmentsService.getAllShipments(page, limit, searchQuery);
  }

  @MessagePattern({ cmd: 'get_shipment_by_id' })
  getShipmentById(@Payload() data: { shipment_id: number }) {
    return this.shipmentsService.getShipmentById(data.shipment_id);
  }

  @MessagePattern({ cmd: 'get_shipment_by_truck_id' })
  getShipmentByTruckId(@Payload() data: { truck_id: number }) {
    return this.shipmentsService.getShipmentByTruckId(data.truck_id);
  }

  @MessagePattern({ cmd: 'create_shipment' })
  createShipment(
    @Payload()
    data: {
      order_id: number;
      truck_id?: number;
      driver_id?: number;
      route_id?: number;
      status_id?: number;
    },
  ) {
    return this.shipmentsService.createShipment(data);
  }

  @MessagePattern({ cmd: 'update_shipment' })
  updateShipment(
    @Payload()
    data: {
      shipment_id: number;
      truck_id?: number;
      driver_id?: number;
      route_id?: number;
      status_id?: number;
    },
  ) {
    return this.shipmentsService.updateShipment(data.shipment_id, data);
  }

  @MessagePattern({ cmd: 'delete_shipment' })
  deleteShipment(@Payload() data: { shipment_id: number }) {
    return this.shipmentsService.deleteShipment(data.shipment_id);
  }

  @MessagePattern({ cmd: 'get_shipment_events' })
  getShipmentEvents(@Payload() data: { shipment_id: number }) {
    return this.shipmentsService.getShipmentEvents(data.shipment_id);
  }

  @MessagePattern({ cmd: 'add_shipment_event' })
  addShipmentEvent(
    @Payload()
    data: {
      shipment_id: number;
      event_status_id: number;
      comment?: string;
      event_time?: string;
    },
  ) {
    return this.shipmentsService.addShipmentEvent(data.shipment_id, data);
  }

  @MessagePattern({ cmd: 'delete_shipment_event' })
  deleteShipmentEvent(
    @Payload() data: { shipment_id: number; event_id: number },
  ) {
    return this.shipmentsService.deleteShipmentEvent(
      data.shipment_id,
      data.event_id,
    );
  }

  @MessagePattern({ cmd: 'update_shipment_event' })
  updateShipmentEvent(
    @Payload()
    data: {
      shipment_id: number;
      event_id: number;
      event_status_id?: number;
      comment?: string;
      event_time?: string;
    },
  ) {
    return this.shipmentsService.updateShipmentEvent(data);
  }

  // Gestion des dates de début et de fin de livraison prévue
  @MessagePattern({ cmd: 'get_delivery_dates' })
  async getDeliveryDates(payload: { shipment_id: number }) {
    const { shipment_id } = payload;
    return this.shipmentsService.getDeliveryDates(shipment_id);
  }

  // Gestion des étapes intermédiaires (stops) d'une expédition
  @MessagePattern({ cmd: 'get_shipment_stops' })
  async getShipmentStops(payload: { shipment_id: number }) {
    const { shipment_id } = payload;
    return this.shipmentsService.getShipmentStops(shipment_id);
  }

  @MessagePattern({ cmd: 'get_shipment_status' })
  async getShipmentStatus(payload: { shipment_id: number }) {
    const { shipment_id } = payload;
    return this.shipmentsService.getShipmentStatus(shipment_id);
  }
}
