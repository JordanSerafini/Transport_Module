import { Truck } from "../../../../../../Transport_Database/types/frontend/truck";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const trucksService = {
  // Obtenir tous les camions pour une entreprise
  getAll: async (): Promise<Truck[]> => {
    try {
      const response = await fetch(`${url.current}/trucks`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });  
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
  
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des camions :", error);
      throw new Error("Error while fetching trucks");
    }
  },
  

  // Obtenir les détails d'un camion spécifique
  getById: async (truck_id: number): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks/${truck_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération du camion :", error);
      throw new Error("Error while fetching truck details");
    }
  },

  // Créer un nouveau camion
  create: async (truck: {
    company_id: number;
    license_plate: string;
    capacity: number;
    model: string;
  }): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(truck),
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la création du camion :", error);
      throw new Error("Error while creating truck");
    }
  },

  // Mettre à jour un camion existant
  update: async (
    truck_id: number,
    updates: { license_plate?: string; capacity?: number; model?: string }
  ): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks/${truck_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(updates),
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour du camion :", error);
      throw new Error("Error while updating truck");
    }
  },

  // Supprimer un camion (soft delete)
  delete: async (truck_id: number): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks/${truck_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la suppression du camion :", error);
      throw new Error("Error while deleting truck");
    }
  },

  // Obtenir les maintenances d'un camion
  getMaintenances: async (truck_id: number): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks/${truck_id}/maintenances`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error(
        "Erreur lors de la récupération des maintenances du camion :",
        error
      );
      throw new Error("Error while fetching truck maintenances");
    }
  },

  // Ajouter une maintenance pour un camion
  addMaintenance: async (
    truck_id: number,
    maintenance: { description: string; cost: number; maintenanceDate?: string }
  ): Promise<Truck> => {
    try {
      const response = await fetch(`${url}/trucks/${truck_id}/maintenances`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(maintenance),
      });
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error(
        "Erreur lors de l'ajout d'une maintenance pour le camion :",
        error
      );
      throw new Error("Error while adding truck maintenance");
    }
  },

  // Mettre à jour une maintenance
  updateMaintenance: async (
    truck_id: number,
    maintenance_id: number,
    updates: { description?: string; cost?: number; maintenanceDate?: string }
  ): Promise<Truck> => {
    try {
      const response = await fetch(
        `${url}/trucks/${truck_id}/maintenances/${maintenance_id}`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify(updates),
        }
      );
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour d'une maintenance :", error);
      throw new Error("Error while updating truck maintenance");
    }
  },

  // Supprimer une maintenance
  deleteMaintenance: async (
    truck_id: number,
    maintenance_id: number
  ): Promise<Truck> => {
    try {
      const response = await fetch(
        `${url}/trucks/${truck_id}/maintenances/${maintenance_id}`,
        {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      if (!response.ok)
        throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la suppression d'une maintenance :", error);
      throw new Error("Error while deleting truck maintenance");
    }
  },
};
