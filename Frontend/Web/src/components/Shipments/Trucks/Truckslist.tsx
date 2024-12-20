import { useEffect, useState } from "react";
import { Truck } from "../../../../../../Transport_Database/types/frontend/truck";
import { trucksService } from "../../../utils/functions/shipments_service/trucks.function";
import TrucktListCard from "../../Transport/truckListCard";

function Truckslist() {
  const [trucksList, setTrucksList] = useState<Truck[]>([]);

  const fetchTrucks = async () => {
    try {
      const trucks = await trucksService.getAll();
      setTrucksList(trucks);
    } catch (error) {
      console.error("Erreur lors du fetch des camions :", error);
    }
  };

  useEffect(() => {
    fetchTrucks();
  }, []);
console.log(trucksList)
  return (
    <div>
      {trucksList.map((truck) => (
        <div key={truck.id}>{truck.license_plate}</div>
      ))}
      < TrucktListCard title="Truck" datetime="2021-09-01" available="100/200" shipmentNumber="123456" truckModel="Model" />
    </div>
  );
}

export default Truckslist;
