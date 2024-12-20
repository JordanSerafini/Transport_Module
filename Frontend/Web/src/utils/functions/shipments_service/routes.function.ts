import { Route, RouteStop } from "../../../../../../Transport_Database/types/frontend/route";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const routesService = {
  // Vérification de la santé du microservice
  healthCheck: async (): Promise<{ status: string }> => {
    try {
      const response = await fetch(`${url.current}/routes/health`, {
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

  // Obtenir toutes les routes avec pagination et recherche
  getAll: async (page = 1, limit = 10, searchQuery?: string): Promise<Route[]> => {
    try {
      const query = new URLSearchParams({ page: String(page), limit: String(limit), ...(searchQuery && { searchQuery }) });
      const response = await fetch(`${url.current}/routes?${query.toString()}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des routes :", error);
      throw new Error("Error while fetching routes");
    }
  },

  // Obtenir une route par ID
  getById: async (route_id: number): Promise<Route> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération de la route :", error);
      throw new Error("Error while fetching route by ID");
    }
  },

  // Créer une nouvelle route
  create: async (route_data: Partial<Route>): Promise<Route> => {
    try {
      const response = await fetch(`${url.current}/routes`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(route_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la création de la route :", error);
      throw new Error("Error while creating route");
    }
  },

  // Mettre à jour une route
  update: async (route_id: number, route_data: Partial<Route>): Promise<Route> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(route_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour de la route :", error);
      throw new Error("Error while updating route");
    }
  },

  // Supprimer une route (soft delete)
  delete: async (route_id: number): Promise<void> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    } catch (error) {
      console.error("Erreur lors de la suppression de la route :", error);
      throw new Error("Error while deleting route");
    }
  },

  // Obtenir toutes les étapes intermédiaires (stops) d'une route
  getStops: async (route_id: number): Promise<RouteStop[]> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}/stops`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des étapes d'une route :", error);
      throw new Error("Error while fetching route stops");
    }
  },

  // Ajouter une étape intermédiaire (stop) à une route
  addStop: async (route_id: number, stop_data: Partial<RouteStop>): Promise<RouteStop> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}/stops`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(stop_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de l'ajout d'une étape :", error);
      throw new Error("Error while adding route stop");
    }
  },

  // Mettre à jour une étape intermédiaire (stop) d'une route
  updateStop: async (route_id: number, stop_id: number, stop_data: Partial<RouteStop>): Promise<RouteStop> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}/stops/${stop_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(stop_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour d'une étape :", error);
      throw new Error("Error while updating route stop");
    }
  },

  // Supprimer une étape intermédiaire (stop) d'une route
  deleteStop: async (route_id: number, stop_id: number): Promise<void> => {
    try {
      const response = await fetch(`${url.current}/routes/${route_id}/stops/${stop_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    } catch (error) {
      console.error("Erreur lors de la suppression d'une étape :", error);
      throw new Error("Error while deleting route stop");
    }
  },
};
