import { useEffect, useState } from "react";
import { ShipmentsService } from "../../../utils/functions/shipments_service/shipments.function";
import { Shipment } from "../../../../../../Transport_Database/types/frontend/shipment";

function ShipmentsPage() {
  const [shipments, setShipments] = useState<Shipment[]>([]);
  const [limit] = useState<number>(100);
  const [page] = useState<number>(1);


  const getShipments = async () => {
    try {
      const shipments = await ShipmentsService.getAll(page, limit);
      setShipments(shipments);
    } catch (err) {
      console.error("Erreur lors de la récupération des expéditions :", err);
    }
  };

  useEffect(() => {
    getShipments();
  }, []);

  return (
    <div>
      <h1>Shipments Page</h1>
      {shipments.length === 0 ? (
        <p>Aucune expédition trouvée.</p>
      ) : (
        <ul>
          {shipments.map((shipment) => (
            <li key={shipment.id}>
              <strong>ID:</strong> {shipment.id} - <strong>Nom:</strong> {shipment.driver_id}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default ShipmentsPage;
