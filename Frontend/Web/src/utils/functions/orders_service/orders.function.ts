import { Order } from "../../../../../../Transport_Database/types/frontend/order";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const ordersService = {
  // Obtenir tous les camions pour une entreprise
  getAll: async (page = 1, limit = 10, searchQuery?: string): Promise<Order[]> => {
    try {
      const query = new URLSearchParams({ page: String(page), limit: String(limit), ...(searchQuery && { searchQuery }) });
      const response = await fetch(`${url.current}/orders?${query.toString()}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des commandes :", error);
      throw new Error("Error while fetching drivers");
    }
  },

  getByShipmentId: async (shipment_id: number): Promise<Order[]> => {
    try {
      const response = await fetch(`${url.current}/orders/shipment/${shipment_id}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

      return await response.json();
    } catch (error) {
      console.error("Erreur lors de la récupération des commandes :", error);
      throw new Error("Error while fetching drivers");
    }
  }
  
};