/**
 * Formate une date ISO en une chaîne lisible.
 * @param isoDate - La date au format ISO (par ex. "2026-08-25T00:00:00.000Z").
 * @returns Une chaîne lisible (par ex. "25 août 2026").
 */
export function formatDate(isoDate: string): string {
    const date = new Date(isoDate);
  
    // Options pour le formatage de la date
    const options: Intl.DateTimeFormatOptions = {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    };
  
    // Formatage avec l'API Intl.DateTimeFormat
    return date.toLocaleDateString("fr-FR", options);
  }
  