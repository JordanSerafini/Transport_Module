import { useEffect, useState, useContext } from "react";
import { driversService } from "../../utils/functions/shipments_service/drivers.function";
import { Driver } from "../../../../../Transport_Database/types/frontend/driver";
import GlobalContext from "../../../context/GlobalContext";
import avatar_1 from "/avatar_1.jpg";
import DriverLogo from "/driver.png";
import { formatDate } from "../../utils/functions/function";

function DriversList() {
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [driverStatusSelected, setDriverStatusSelected] = useState<string>("");
  const [limit] = useState<number>(20);
  const [page] = useState<number>(1);

  const globalContext = useContext(GlobalContext);

  if (!globalContext) {
    throw new Error("GlobalContext must be used within a GlobalProvider");
  }

  const { openModal, closeModal } = globalContext;

  // Fonction pour récupérer les chauffeurs
  const fetchDrivers = async () => {
    try {
      const drivers = await driversService.getAll(page, limit);
      setDrivers(drivers);
    } catch (error) {
      console.error("Erreur lors de la récupération des chauffeurs :", error);
    }
  };

  const fetchDriversByStatus = async (status: string) => {
    try {
      const drivers = await driversService.getByStatus(status, page, limit);
      setDrivers([]);
      setDrivers(drivers);
    } catch (error) {
      console.error(
        "Erreur lors de la récupération des chauffeurs par statut :",
        error
      );
    }
  };

  useEffect(() => {
    if (driverStatusSelected) {
      fetchDriversByStatus(driverStatusSelected);
    } else {
      fetchDrivers();
    }
  }, [driverStatusSelected]);

  const handleDriverClick = async (driverId: number) => {
    try {
      const fetchedDriver = await driversService.getById(driverId);

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
              <span className="tracking-widest">
                {formatDate(fetchedDriver.license_expiry_date || "") ||
                  "Non spécifiée"}
              </span>
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

  const getColor = (status: string) => {
    switch (status) {
      case "AVAILABLE":
        return "bg-green-500";
      case "ACTIVE":
        return "bg-yellow-500";
      default:
        return "bg-gray-500";
    }
  };
  return (
    <div className="">
      <div className="flex flex-col items-center justify-between px-4">
        <div className="flex items-center justify-center gap-2 w-8/10 border-b  border-gray-800 mb-4 pb-4 pt-2">
          <img src={DriverLogo} alt="driver_logo" className="h-8" />
          <h3 className="italic font-bold text-xl pr-4">Chauffeurs: </h3>
          <div className="">
            <select
              className="border border-gray-800 p-1 rounded bg-gray-100 w-fit"
              onChange={(e) => setDriverStatusSelected(e.target.value)}
            >
              <option value="">Tous les statuts</option>
              <option value="AVAILABLE">Disponible</option>
              <option value="ACTIVE">Actif</option>
              <option value="INACTIVE">Inactif</option>
            </select>
          </div>
        </div>
      </div>

      <div className="h-96 overflow-auto flex flex-col gap-4">
        {drivers.map((driver) => (
          <div key={driver.id} className="border-b pb-2 ">
            <div className="flex justify-between">
              <div
                className="cursor-pointer"
                onClick={() => handleDriverClick(driver.id)}
              >
                {driver.name}
              </div>
              <div
                className={`${getColor(
                  driver.driver_status
                )} px-3 py-1 rounded-full text-white `}
              >
                {driver.driver_status}
              </div>
            </div>
            <div className="pl-2">
              <a
                href={`tel:${driver.phone}`}
                className=""
              >
                {driver.phone}
              </a>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default DriversList;
