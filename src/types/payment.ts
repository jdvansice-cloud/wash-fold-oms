export type PaymentMethodType = 'cash' | 'card' | 'other' | 'pickup' | 'credit';

export interface PaymentMethod {
  id: string;
  store_id: string;
  name: string;
  icon?: string;
  /** Drives the POS payment screen: cash (denominations+change), card
   * (amount+reference), other (generic amount), pickup (pay-on-pickup, creates
   * an unpaid order gated on payment) or credit ("Factura", B2B-only, charges
   * the order to the customer's account for later consolidated billing). */
  payment_type: PaymentMethodType;
  is_active: boolean;
  display_order: number;
  created_at: string;
}
