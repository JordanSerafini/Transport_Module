import { useEffect, useState } from "react";

import { trucksService } from "../../utils/functions/shipments_service/trucks.function";
import { ordersService } from "../../utils/functions/orders_service/orders.function";
import { routesService } from "../../utils/functions/shipments_service/routes.function";

import { Order } from "../../../../../Transport_Database/types/frontend/order";
import { Route } from "../../../../../Transport_Database/types/frontend/route";
import { Truck } from "../../../../../Transport_Database/types/frontend/truck";
import { Shipment } from "../../../../../Transport_Database/types/frontend/shipment";

interface ShipmentCardProps {
    shipment: Shipment;
    }

function ShipmentsCard({ shipment }: ShipmentCardProps) {

    const [truck, setTruck] = useState<Truck | undefined>(undefined);
    const [order, setOrder] = useState<Order[] | undefined>(undefined);
    const [route, setRoute] = useState<Route | undefined>(undefined);

    const getTruck = async (id: number) => {
        const truck = await trucksService.getById(id);
        setTruck(truck);
    }

    const getOrder = async (id: number) => {
        const orders = await ordersService.getByShipmentId(id);
        setOrder(orders);
    }

    const getRoute = async (id: number) => {
        const route = await routesService.getById(id);
        setRoute(route);
    }

    useEffect(() => {
        if (shipment.truck_id !== undefined) {
            getTruck(shipment.truck_id);
        }
        getOrder(shipment.id);
        if (shipment.route_id !== undefined) {
            getRoute(shipment.route_id);
        }
    }, [shipment]);

    console.log(truck);

  return (
    <div>ShipmentsCard</div>
  )
}

export default ShipmentsCard