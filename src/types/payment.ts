export type PaymentMethodType = 'cash' | 'card' | 'other';

export interface PaymentMethod {
  id: string;
  store_id: string;
  name: string;
  icon?: string;
  /** Drives the POS payment screen: cash (denominations+change), card
   * (amount+reference) or other (generic amount). */
  payment_type: PaymentMethodType;
  is_active: boolean;
  display_order: number;
  created_at: string;
}
