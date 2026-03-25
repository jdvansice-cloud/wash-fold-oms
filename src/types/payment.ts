export interface PaymentMethod {
  id: string;
  store_id: string;
  name: string;
  icon?: string;
  is_active: boolean;
  display_order: number;
  created_at: string;
}
