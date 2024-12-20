import { Driver } from "../../../../../../Transport_Database/types/frontend/driver";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const driversService = {
  // Vérification de la santé du microservice
  healthCheck: async (): Promise<{ status: string }> => {
    try {
      const response = await fetch(`${url.current}/drivers/health`, {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la vérification de la santé du service :", error);
      throw new Error("Error while checking service health");
    }
  },

  // Obtenir tous les chauffeurs avec pagination et recherche
  getAll: async (page = 1, limit = 10, searchQuery?: string): Promise<Driver[]> => {
    try {
      const query = new URLSearchParams({ page: String(page), limit: String(limit), ...(searchQuery && { searchQuery }) });
      const response = await fetch(`${url.current}/drivers?${query.toString()}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des chauffeurs :", error);
      throw new Error("Error while fetching drivers");
    }
  },

  // Obtenir un chauffeur par ID
  getById: async (driver_id: number): Promise<Driver> => {
    try {
      const response = await fetch(`${url.current}/drivers/${driver_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération du chauffeur :", error);
      throw new Error("Error while fetching driver by ID");
    }
  },

  // Créer un nouveau chauffeur
  create: async (driver_data: Partial<Driver>): Promise<Driver> => {
    try {
      const response = await fetch(`${url.current}/drivers`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(driver_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la création du chauffeur :", error);
      throw new Error("Error while creating driver");
    }
  },

  // Mettre à jour un chauffeur
  update: async (driver_id: number, driver_data: Partial<Driver>): Promise<Driver> => {
    try {
      const response = await fetch(`${url.current}/drivers/${driver_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(driver_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour du chauffeur :", error);
      throw new Error("Error while updating driver");
    }
  },

  // Supprimer un chauffeur (soft delete)
  delete: async (driver_id: number): Promise<void> => {
    try {
      const response = await fetch(`${url.current}/drivers/${driver_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    } catch (error) {
      console.error("Erreur lors de la suppression du chauffeur :", error);
      throw new Error("Error while deleting driver");
    }
  },
};
