export interface LoyaltySettings {
  id: string;
  store_id: string;
  punch_card_enabled: boolean;
  wash_punches_required: number;
  dry_punches_required: number;
  punch_card_expiry_days: number;
  points_enabled: boolean;
  points_per_dollar: number;
  min_redemption_amount: number;
  points_expiry_days: number;
}

export interface CustomerLoyalty {
  id: string;
  customer_id: string;
  store_id: string;
  wash_punches: number;
  dry_punches: number;
  pending_free_washes: number;
  pending_free_drys: number;
  total_free_washes_earned: number;
  total_free_drys_earned: number;
  total_free_washes_redeemed: number;
  total_free_drys_redeemed: number;
  points_balance: number;
  total_points_earned: number;
  total_points_redeemed: number;
  last_punch_date?: string;
  last_points_date?: string;
}

export type LoyaltyTransactionType =
  | 'punch_wash'
  | 'punch_dry'
  | 'free_wash_earned'
  | 'free_dry_earned'
  | 'redeem_free_wash'
  | 'redeem_free_dry'
  | 'points_earned'
  | 'points_redeemed'
  | 'points_expired'
  | 'punches_expired'
  | 'manual_adjustment';

export interface LoyaltyTransaction {
  id: string;
  customer_id: string;
  store_id: string;
  order_id?: string;
  transaction_type: LoyaltyTransactionType;
  punch_count: number;
  punches_before: number;
  punches_after: number;
  points_amount: number;
  balance_before: number;
  balance_after: number;
  order_subtotal: number;
  notes?: string;
  created_by?: string;
  created_at: string;
}
