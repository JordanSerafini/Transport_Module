import { Shipment, ShipmentEvent } from "../../../../../../Transport_Database/types/frontend/shipment";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const ShipmentsService = {
  // Obtenir toutes les expéditions avec pagination et recherche
  getAll: async (page = 1, limit = 10, searchQuery?: string): Promise<Shipment[]> => {
    try {
      const query = new URLSearchParams({ page: String(page), limit: String(limit), ...(searchQuery && { searchQuery }) });
      const response = await fetch(`${url.current}/shipments?${query.toString()}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des expéditions :", error);
      throw new Error("Error while fetching shipments");
    }
  },

  // Vérification de la santé du microservice
  healthCheck: async (): Promise<{ status: string }> => {
    try {
      const response = await fetch(`${url.current}/shipments/health`, {
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

  // Obtenir une expédition par ID
  getById: async (shipment_id: number): Promise<Shipment> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération de l'expédition :", error);
      throw new Error("Error while fetching shipment by ID");
    }
  },

  // Obtenir les expéditions par truck ID
  getBytruck_id: async (truck_id: number): Promise<Shipment[]> => {
    try {
      const response = await fetch(`${url.current}/shipments/truck/${truck_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des expéditions par camion :", error);
      throw new Error("Error while fetching shipments by truck ID");
    }
  },

  // Créer une nouvelle expédition
  create: async (shipment_data: Partial<Shipment>): Promise<Shipment> => {
    try {
      const response = await fetch(`${url.current}/shipments`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(shipment_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la création de l'expédition :", error);
      throw new Error("Error while creating shipment");
    }
  },

  // Mettre à jour une expédition
  update: async (shipment_id: number, shipment_data: Partial<Shipment>): Promise<Shipment> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(shipment_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour de l'expédition :", error);
      throw new Error("Error while updating shipment");
    }
  },

  // Supprimer une expédition
  delete: async (shipment_id: number): Promise<void> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    } catch (error) {
      console.error("Erreur lors de la suppression de l'expédition :", error);
      throw new Error("Error while deleting shipment");
    }
  },

  // Obtenir tous les événements d'une expédition
  getEvents: async (shipment_id: number): Promise<ShipmentEvent[]> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/events`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des événements :", error);
      throw new Error("Error while fetching shipment events");
    }
  },

  // Ajouter un événement à une expédition
  addEvent: async (shipment_id: number, event_data: Partial<ShipmentEvent>): Promise<ShipmentEvent> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/events`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(event_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de l'ajout d'un événement :", error);
      throw new Error("Error while adding shipment event");
    }
  },

  // Supprimer un événement d'une expédition
  deleteEvent: async (shipment_id: number, event_id: number): Promise<void> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/events/${event_id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    } catch (error) {
      console.error("Erreur lors de la suppression d'un événement :", error);
      throw new Error("Error while deleting shipment event");
    }
  },

  // Mettre à jour un événement d'une expédition
  updateEvent: async (shipment_id: number, event_id: number, event_data: Partial<ShipmentEvent>): Promise<ShipmentEvent> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/events/${event_id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(event_data),
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la mise à jour d'un événement :", error);
      throw new Error("Error while updating shipment event");
    }
  },

  // Obtenir date de départ et d'arrivée d'une expédition
  getDates: async (shipment_id: number): Promise<{ departure_date: string; arrival_date: string }> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/delivery-dates`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des dates de départ et d'arrivée :", error);
      throw new Error("Error while fetching shipment dates");
    }
  },

  getStops: async (shipment_id: number): Promise<{ stop_id: number; stop_name: string }[]> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/stops`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des arrêts :", error);
      throw new Error("Error while fetching shipment stops");
    }
  },

  getStatus: async (shipment_id: number): Promise<{ status: string }> => {
    try {
      const response = await fetch(`${url.current}/shipments/${shipment_id}/status`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération du statut de l'expédition :", error);
      throw new Error("Error while fetching shipment status");
    }
  }

};
