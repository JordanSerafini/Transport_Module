export class User {
  id: number;
  companyId: number;
  email: string;
  passwordHash: string;
  name: string | null;
  role: string;
  createdAt: Date;
  updatedAt: Date | null;
  deletedAt: Date | null;
}
