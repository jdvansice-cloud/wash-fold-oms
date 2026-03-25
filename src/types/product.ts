export type ProductType = 'service' | 'retail' | 'delivery';
export type PricingType = 'weight' | 'quantity';

export interface Product {
  id: string;
  store_id: string;
  section_id?: string;
  parent_id?: string;
  name: string;
  icon?: string;
  product_type: ProductType;
  pricing_type: PricingType;
  price: number;
  express_price: number;
  cost: number;
  sku?: string;
  stock: number;
  min_stock: number;
  pieces: number;
  min_quantity: number;
  extra_days: number;
  is_active: boolean;
  is_online: boolean;
  is_taxable: boolean;
  has_children: boolean;
  display_order: number;
  created_at: string;
  updated_at: string;
}

export interface Section {
  id: string;
  store_id: string;
  name: string;
  color: string;
  display_order: number;
  is_active: boolean;
  is_online: boolean;
  created_at: string;
  updated_at: string;
}
