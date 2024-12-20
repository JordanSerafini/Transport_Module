export class Driver {
  id: number;
  companyId: number;
  name: string;
  licenseNumber: string | null;
  licenseExpiryDate: Date | null;
  phone: string | null;
  driverStatus: string;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
