import { Order } from "../../../../../../Transport_Database/types/frontend/order";
import url from "../../url";
import Cookies from "js-cookie";

const token = Cookies.get("token");

export const ordersService = {
  // Obtenir tous les camions pour une entreprise
  getAll: async (): Promise<Order[]> => {
    try {
      const response = await fetch(`${url.current}/orders`, {
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
      throw new Error("Error while fetching orders");
    }
  },
};