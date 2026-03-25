export type OrderStatus =
  | 'pending'
  | 'washing'
  | 'drying'
  | 'folding'
  | 'ready'
  | 'completed'
  | 'cancelled'
  | 'refunded'
  | 'refund';

export interface WeightEntry {
  weight: number;
  pieces?: number;
  notes?: string;
  isWetWeight?: boolean;
}

export interface Order {
  id: string;
  store_id: string;
  customer_id?: string;
  order_number: number;
  legacy_order_number?: string;
  customer_name?: string;
  is_walk_in: boolean;
  status: OrderStatus;
  is_express: boolean;
  subtotal: number;
  discount_amount: number;
  delivery_charge: number;
  tax_amount: number;
  total: number;
  total_weight: number;
  total_bags: number;
  total_pieces: number;
  notes?: string;
  promised_date?: string;
  completed_at?: string;
  refund_for_order_id?: string;
  receipt_path?: string;
  created_by?: string;
  created_at: string;
  updated_at: string;
}

export interface OrderItem {
  id: string;
  order_id: string;
  product_id?: string;
  product_name?: string;
  quantity: number;
  total_weight: number;
  bags: number;
  pieces: number;
  unit_price: number;
  line_total: number;
  weight_entries?: WeightEntry[];
  notes?: string;
  created_at: string;
}

export interface Payment {
  id: string;
  order_id: string;
  payment_method_id?: string;
  payment_method: string;
  amount: number;
  reference?: string;
  change_amount: number;
  created_by?: string;
  created_at: string;
}

export interface OrderWithDetails extends Order {
  order_items?: OrderItem[];
  payments?: Payment[];
}

export interface CreateOrderInput {
  store_id: string;
  customer_id?: string;
  customer_name?: string;
  is_walk_in: boolean;
  is_express: boolean;
  subtotal: number;
  discount_amount: number;
  delivery_charge: number;
  tax_amount: number;
  total: number;
  total_weight: number;
  total_bags: number;
  total_pieces: number;
  notes?: string;
  promised_date?: string;
  created_by?: string;
  items: Omit<OrderItem, 'id' | 'order_id' | 'created_at'>[];
  payments: Omit<Payment, 'id' | 'order_id' | 'created_at'>[];
}

export interface Refund {
  id: string;
  store_id: string;
  order_id?: string;
  order_number?: number;
  customer_name?: string;
  amount: number;
  refund_type: 'full' | 'partial';
  reason?: string;
  notes?: string;
  processed_by?: string;
  created_at: string;
}
