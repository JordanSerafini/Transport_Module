import {  useEffect, useState } from "react";
import ShipmentCard from "./ShipmentCard";

import { ShipmentsService } from "../../../utils/functions/shipments_service/shipments.function";
import { driversService } from "../../../utils/functions/shipments_service/drivers.function";
import { ordersService } from "../../../utils/functions/orders_service/orders.function";
import { routesService } from "../../../utils/functions/shipments_service/routes.function";
import { trucksService } from "../../../utils/functions/shipments_service/trucks.function";

import { Shipment } from "../../../../../../Transport_Database/types/frontend/shipment";
import { Driver } from "../../../../../../Transport_Database/types/frontend/driver";
import { Route } from "../../../../../../Transport_Database/types/frontend/route";
import { Truck } from "../../../../../../Transport_Database/types/frontend/truck";
import { Order } from "../../../../../../Transport_Database/types/frontend/order";

function ShipmentsPage() {
  const [shipments, setShipments] = useState<Shipment[]>([]);
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [orders, setOrders] = useState<Order[]>([]);
  const [routes, setRoutes] = useState<Route[]>([]);
  const [trucks, setTrucks] = useState<Truck[]>([]);

  const [limit] = useState<number>(10);
  const [page] = useState<number>(1);

  const getShipments = async () => {
    try {
      const shipments = await ShipmentsService.getAll(page, limit);
      setShipments(shipments);
    } catch (err) {
      console.error("Erreur lors de la récupération des expéditions :", err);
    }
  };

  const getDrivers = async () => {
    try {
      const drivers = await driversService.getAll(page, limit);
      setDrivers(drivers);
    } catch (err) {
      console.error("Erreur lors de la récupération des chauffeurs :", err);
    }
  };

  const getOrders = async () => {
    try {
      const orders = await ordersService.getAll(page, limit);
      setOrders(orders);
    } catch (err) {
      console.error("Erreur lors de la récupération des commandes :", err);
    }
  };

  const getRoutes = async () => {
    try {
      const routes = await routesService.getAll(page, limit);
      setRoutes(routes);
    } catch (err) {
      console.error("Erreur lors de la récupération des itinéraires :", err);
    }
  };

  const getTrucks = async () => {
    try {
      const trucks = await trucksService.getAll(page, limit);
      setTrucks(trucks);
    } catch (err) {
      console.error("Erreur lors de la récupération des camions :", err);
    }
  };


  useEffect(() => {
    getShipments();
    getDrivers();
    getOrders();
    getRoutes();
    getTrucks();
  }, []);



  const enrichedShipments = shipments.map((shipment) => ({
    ...shipment,
    id: shipment.id,
    driver: drivers.find((driver) => driver.id === shipment.driver_id) || { name: "Non assigné", id: -1, company_id: -1, driver_status: "", created_at: "" },
    order: orders.find((order) => order.id === shipment.order_id) || { description: "Non spécifiée", id: -1, company_id: -1, created_at: "" },
    route: routes.find((route) => route.id === shipment.route_id) || { name: "Non spécifié", id: -1, company_id: -1, created_at: "" },
    truck: trucks.find((truck) => truck.id === shipment.truck_id) || { model: "Non spécifié", id: -1, company_id: -1, license_plate: "", created_at: "" },
  }));

  return (
    <div className="w-screen h-screen flex flex-col justify-start items-start gap-4 p-4">
      {shipments.length === 0 ? (
        <p>Aucune expédition trouvée.</p>
      ) : (
        <div className="overflow-auto flex flex-wrap justify-start items-start gap-4">
          {enrichedShipments.map((shipment) => (
            <ShipmentCard
              key={shipment.id}
              id={shipment.id}
              driver={shipment.driver}
              order={shipment.order}
              route={shipment.route}
              truck={shipment.truck}
              createdAt={shipment.created_at}
            />
          ))}
        </div>
      )}
    </div>
  );
}

export default ShipmentsPage;

