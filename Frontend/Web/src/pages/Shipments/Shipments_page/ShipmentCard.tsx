import { useEffect, useState, useContext } from "react";
import GlobalContext from "../../../../context/GlobalContext";

import { Driver } from "../../../../../../Transport_Database/types/frontend/driver";
import { Order } from "../../../../../../Transport_Database/types/frontend/order";
import { Route } from "../../../../../../Transport_Database/types/frontend/route";
import { ShipmentStatus } from "../../../../../../Transport_Database/types/frontend/shipment";
import { Truck } from "../../../../../../Transport_Database/types/frontend/truck";

import { ShipmentsService } from "../../../utils/functions/shipments_service/shipments.function";
import { driversService } from "../../../utils/functions/shipments_service/drivers.function";
import { formatDate } from "../../../utils/functions/function";

import avatar_1 from "/avatar_1.jpg";

interface ShipmentCardProps {
  id: number;
  driver: Driver;
  order: Order;
  route: Route;
  truck: Truck;
  createdAt: string;
}

function ShipmentCard({
  id,
  driver,
  order,
  route,
  truck,
  createdAt,
}: ShipmentCardProps) {
  const [status, setStatus] = useState<ShipmentStatus | null>(null);
  const globalContext = useContext(GlobalContext);

  if (!globalContext) {
    throw new Error("GlobalContext must be used within a GlobalProvider");
  }

  const { openModal, closeModal } = globalContext;

  const getStatus = async (id: number) => {
    try {
      const status = await ShipmentsService.getStatus(id);
      setStatus(status);
    } catch (err) {
      console.error(
        "Erreur lors de la récupération du status de l'expédition :",
        err
      );
    }
  };

  const handleDriverClick = async () => {
    try {
      const fetchedDriver = await driversService.getById(driver.id);

      openModal({
        content: (
          <div className="flex flex-col justify-evenly gap-2 ">
            <div className="flex w-full justify-center gap-4 items-center">
              <p className="text-2xl font-bold">{fetchedDriver.name}</p>
              <img
                src={avatar_1}
                alt="avatar_logo"
                className="w-20 h-20 self-end"
              />
            </div>
            <p>
              <strong>Numéro de permis :</strong>{" "}
              {fetchedDriver.license_number || "Non spécifié"}
            </p>
            <p className="flex items-center gap-2">
              <strong>Date d'expiration du permis :</strong>
              <p className="tracking-widest">{formatDate(fetchedDriver.license_expiry_date || "") || "Non spécifiée"}</p>
            </p>
            <p>
              <strong>Téléphone :</strong>{" "}
              {fetchedDriver.phone || "Non spécifié"}
            </p>
            <p>
              <strong>Statut :</strong> {fetchedDriver.driver_status}
            </p>
          </div>
        ),
        actions: (
          <div className="flex justify-end gap-2">
            <button
              onClick={closeModal}
              className="px-4 py-2 bg-gray-200 text-gray-800 rounded hover:bg-gray-300"
            >
              Fermer
            </button>
          </div>
        ),
      });
    } catch (err) {
      console.error(
        "Erreur lors de la récupération des informations du chauffeur :",
        err
      );
    }
  };

  useEffect(() => {
    getStatus(id);
  }, [id]);


  return (
    <div className="border flex flex-col w-3/10 p-2">
      <h3>EXP000{id}</h3>
      <p>
        Chauffeur :{" "}
        <span
          onClick={handleDriverClick}
          className="text-blue-500 underline cursor-pointer"
        >
          {driver?.name || "Non assigné"}
        </span>
      </p>
      <p>Commande : {order?.id || "Non spécifiée"}</p>
      <p>Itinéraire : {route?.name || "Non spécifié"}</p>
      <p>Camion : {truck?.model || "Non spécifié"}</p>
      {status && <p>Status : {status.label}</p>}
      <p>Créé le : {new Date(createdAt).toLocaleDateString()}</p>
    </div>
  );
}

export default ShipmentCard;
