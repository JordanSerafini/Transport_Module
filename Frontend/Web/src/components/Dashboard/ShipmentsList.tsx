import { useEffect, useState } from "react";
import { ShipmentsService } from "../../utils/functions/shipments_service/shipments.function"
import { Shipment } from "../../../../../Transport_Database/types/frontend/shipment";
import ShipmentsCard from "../Shipments/ShipmentsCard";

function ShipmentsList() {
    const [shipments, setShipments] = useState<Shipment[]>([]);

    const getShipments = async () => {
        const shipments = await ShipmentsService.getAll();
        setShipments(shipments);
    }

    useEffect(() => {
        getShipments();
    }, []);


  return (
    <div className="w-full h-10/10 rounded-3xl p-4 bg-white">
        {shipments.map((shipment, index) => (
            <ShipmentsCard key={index} shipment={shipment} />
        ))}
    </div>
  )
}

export default ShipmentsList