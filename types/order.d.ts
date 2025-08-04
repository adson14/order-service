export interface orderData {
  orderId?: string;
  customerName: string;
  items: Array<{
    itemId: string;
    quantity: number;
    price: number;
  }>;
  totalAmount: number;
  orderDate: Date;
}
