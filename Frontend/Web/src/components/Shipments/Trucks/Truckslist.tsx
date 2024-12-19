import { useEffect, useState } from "react";
import { Truck } from "../../../@types/truck";
import { trucksService } from "../../../utils/functions/shipments_service/trucks.function";

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
  console.log(trucksList);
  return (
    <div>
      {trucksList.map((truck) => (
        <div key={truck.id}>{truck.license_plate}</div>
      ))}
    </div>
  );
}

export default Truckslist;
