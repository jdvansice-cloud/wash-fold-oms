import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { PickupSchedule, PickupBlockedDate, TimeSlot, DayAvailability } from '@/types';

// --- Fetch functions ---

async function fetchPickupSchedules(storeId: string): Promise<PickupSchedule[]> {
  const { data, error } = await supabase
    .from('pickup_schedules')
    .select('*')
    .eq('store_id', storeId)
    .eq('is_active', true)
    .order('day_of_week', { ascending: true });

  if (error) throw error;
  return (data as PickupSchedule[]) || [];
}

async function fetchBlockedDates(
  storeId: string,
  startDate: string,
  endDate: string,
): Promise<PickupBlockedDate[]> {
  const { data, error } = await supabase
    .from('pickup_blocked_dates')
    .select('*')
    .eq('store_id', storeId)
    .gte('blocked_date', startDate)
    .lte('blocked_date', endDate);

  if (error) throw error;
  return (data as PickupBlockedDate[]) || [];
}

async function fetchSlotBookings(
  storeId: string,
  date: string,
): Promise<Record<string, number>> {
  const { data, error } = await supabase
    .from('pickup_requests')
    .select('requested_time_slot')
    .eq('store_id', storeId)
    .eq('requested_date', date)
    .in('status', ['pending', 'confirmed']);

  if (error) throw error;

  // Count bookings per time slot
  const counts: Record<string, number> = {};
  (data || []).forEach((row: { requested_time_slot: string }) => {
    counts[row.requested_time_slot] = (counts[row.requested_time_slot] || 0) + 1;
  });
  return counts;
}

// --- Hooks ---

export function usePickupSchedules(storeId: string | undefined) {
  return useQuery({
    queryKey: ['pickupSchedules', storeId],
    queryFn: () => fetchPickupSchedules(storeId!),
    enabled: !!storeId,
    staleTime: 5 * 60_000,
  });
}

export function useBlockedDates(
  storeId: string | undefined,
  startDate: string,
  endDate: string,
) {
  return useQuery({
    queryKey: ['blockedDates', storeId, startDate, endDate],
    queryFn: () => fetchBlockedDates(storeId!, startDate, endDate),
    enabled: !!storeId,
    staleTime: 5 * 60_000,
  });
}

/**
 * Compute available time slots for a specific date.
 * Combines schedule config + booking counts to determine availability.
 */
export function useSlotAvailability(storeId: string | undefined, date: string | undefined) {
  const dayOfWeek = date ? new Date(date + 'T12:00:00').getDay() : -1;

  const { data: schedules } = usePickupSchedules(storeId);
  const { data: bookings, isLoading } = useQuery({
    queryKey: ['slotBookings', storeId, date],
    queryFn: () => fetchSlotBookings(storeId!, date!),
    enabled: !!storeId && !!date,
  });

  const schedule = schedules?.find((s) => s.day_of_week === dayOfWeek);

  if (!schedule || !date) {
    return { data: [] as TimeSlot[], isLoading };
  }

  const slots = generateTimeSlots(
    schedule.start_time,
    schedule.end_time,
    schedule.slot_duration_minutes,
    schedule.max_pickups_per_slot,
    bookings || {},
    date,
  );

  return { data: slots, isLoading };
}

/**
 * Compute 14-day availability calendar.
 */
export function useDayAvailability(storeId: string | undefined) {
  const today = new Date();
  const endDate = new Date(today);
  endDate.setDate(endDate.getDate() + 13);

  const startStr = formatDateStr(today);
  const endStr = formatDateStr(endDate);

  const { data: schedules, isLoading: schedulesLoading } = usePickupSchedules(storeId);
  const { data: blocked, isLoading: blockedLoading } = useBlockedDates(storeId, startStr, endStr);

  const isLoading = schedulesLoading || blockedLoading;

  if (!schedules) {
    return { data: [] as DayAvailability[], isLoading };
  }

  const blockedSet = new Set((blocked || []).map((b) => b.blocked_date));
  const blockedReasons: Record<string, string> = {};
  (blocked || []).forEach((b) => {
    if (b.reason) blockedReasons[b.blocked_date] = b.reason;
  });

  const days: DayAvailability[] = [];
  for (let i = 0; i < 14; i++) {
    const d = new Date(today);
    d.setDate(d.getDate() + i);
    const dateStr = formatDateStr(d);
    const dow = d.getDay();
    const schedule = schedules.find((s) => s.day_of_week === dow);
    const isBlocked = blockedSet.has(dateStr);

    days.push({
      date: dateStr,
      dayOfWeek: dow,
      isOpen: !!schedule,
      isBlocked,
      blockedReason: blockedReasons[dateStr],
      hasAvailableSlots: !!schedule && !isBlocked,
      totalSlots: schedule
        ? countSlots(schedule.start_time, schedule.end_time, schedule.slot_duration_minutes)
        : 0,
      bookedSlots: 0, // Will be updated when specific date is selected
    });
  }

  return { data: days, isLoading };
}

// --- Utility functions ---

function generateTimeSlots(
  startTime: string,
  endTime: string,
  durationMinutes: number,
  maxPerSlot: number,
  bookings: Record<string, number>,
  date: string,
): TimeSlot[] {
  const slots: TimeSlot[] = [];
  const [startH, startM] = startTime.split(':').map(Number);
  const [endH, endM] = endTime.split(':').map(Number);
  const startMinutes = startH * 60 + startM;
  const endMinutes = endH * 60 + endM;

  const now = new Date();
  const isToday = formatDateStr(now) === date;

  for (let m = startMinutes; m + durationMinutes <= endMinutes; m += durationMinutes) {
    const hours = Math.floor(m / 60);
    const mins = m % 60;
    const time = `${String(hours).padStart(2, '0')}:${String(mins).padStart(2, '0')}`;

    const endSlotM = m + durationMinutes;
    const endHours = Math.floor(endSlotM / 60);
    const endMins = endSlotM % 60;
    const slotEndTime = `${String(endHours).padStart(2, '0')}:${String(endMins).padStart(2, '0')}`;

    const bookingCount = bookings[time + ':00'] || bookings[time] || 0;

    // If today, filter out past slots
    if (isToday) {
      const slotDate = new Date(`${date}T${time}:00`);
      if (slotDate <= now) continue;
    }

    slots.push({
      time,
      endTime: slotEndTime,
      available: bookingCount < maxPerSlot,
      bookingCount,
      maxCapacity: maxPerSlot,
    });
  }

  return slots;
}

function countSlots(startTime: string, endTime: string, durationMinutes: number): number {
  const [startH, startM] = startTime.split(':').map(Number);
  const [endH, endM] = endTime.split(':').map(Number);
  return Math.floor(((endH * 60 + endM) - (startH * 60 + startM)) / durationMinutes);
}

function formatDateStr(d: Date): string {
  return d.toISOString().split('T')[0];
}
