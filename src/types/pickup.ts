export type PickupRequestStatus = 'pending' | 'confirmed' | 'picked_up' | 'cancelled';

export interface PickupSchedule {
  id: string;
  store_id: string;
  day_of_week: number; // 0=Sunday, 6=Saturday
  start_time: string; // HH:MM format
  end_time: string;
  slot_duration_minutes: number;
  max_pickups_per_slot: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface PickupBlockedDate {
  id: string;
  store_id: string;
  blocked_date: string; // YYYY-MM-DD
  reason?: string;
  created_at: string;
}

export interface PickupRequest {
  id: string;
  store_id: string;
  customer_id: string;
  order_id?: string;
  requested_date: string; // YYYY-MM-DD
  requested_time_slot: string; // HH:MM
  status: PickupRequestStatus;
  address_line?: string;
  district?: string;
  city?: string;
  notes?: string;
  cancelled_reason?: string;
  confirmed_by?: string;
  created_at: string;
  updated_at: string;
}

export interface CreatePickupRequestInput {
  store_id: string;
  customer_id: string;
  requested_date: string;
  requested_time_slot: string;
  address_line?: string;
  district?: string;
  city?: string;
  notes?: string;
}

export interface TimeSlot {
  time: string; // HH:MM
  endTime: string; // HH:MM
  available: boolean;
  bookingCount: number;
  maxCapacity: number;
}

export interface DayAvailability {
  date: string; // YYYY-MM-DD
  dayOfWeek: number;
  isOpen: boolean;
  isBlocked: boolean;
  blockedReason?: string;
  hasAvailableSlots: boolean;
  totalSlots: number;
  bookedSlots: number;
}
