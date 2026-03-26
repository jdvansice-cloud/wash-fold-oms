export interface CustomerLocation {
  id: string;
  customer_id: string;
  label: string;
  address_line: string;
  district?: string;
  city?: string;
  latitude?: number;
  longitude?: number;
  is_default: boolean;
  notes?: string;
  created_at: string;
  updated_at: string;
}

export interface CreateCustomerLocationInput {
  customer_id: string;
  label: string;
  address_line: string;
  district?: string;
  city?: string;
  latitude?: number;
  longitude?: number;
  is_default?: boolean;
  notes?: string;
}

export type PickupRouteStatus = 'planned' | 'in_progress' | 'completed';

export interface PickupRoute {
  id: string;
  store_id: string;
  route_date: string;
  driver_name?: string;
  status: PickupRouteStatus;
  route_order: string[]; // array of pickup_request IDs
  notes?: string;
  created_by?: string;
  created_at: string;
  updated_at: string;
}
