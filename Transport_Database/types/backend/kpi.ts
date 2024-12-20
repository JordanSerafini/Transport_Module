export class Kpi {
    id: number;
    companyId: number;
    periodStart: Date;
    periodEnd: Date;
    totalOrders: number;
    onTimeDeliveries: number;
    lateDeliveries: number;
    totalRevenue: number;
    totalCosts: number;
    createdAt: Date;
}
