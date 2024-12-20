export class Notification {
    id: number;
    companyId: number;
    userId: number | null;
    notificationType: string | null;
    message: string | null;
    isRead: boolean;
    createdAt: Date;
    updatedAt: Date | null;
    deletedAt: Date | null;
}
