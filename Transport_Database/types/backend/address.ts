export class Address {
  id: number;
  street: string | null;
  city: string;
  state: string | null;
  country: string;
  postalCode: string | null;
  latitude: number | null;
  longitude: number | null;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
