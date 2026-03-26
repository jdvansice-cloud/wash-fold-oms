import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabaseStaff, supabasePortal } from '@/lib/supabase';
import type { PickupRequest, CreatePickupRequestInput, PickupRequestStatus } from '@/types';

// --- Fetch functions ---

async function fetchMyPickupRequests(customerId: string): Promise<PickupRequest[]> {
  const { data, error } = await supabasePortal
    .from('pickup_requests')
    .select('*')
    .eq('customer_id', customerId)
    .order('created_at', { ascending: false })
    .limit(50);

  if (error) throw error;
  return (data as PickupRequest[]) || [];
}

async function fetchStorePickupRequests(
  storeId: string,
  filters?: { status?: PickupRequestStatus; startDate?: string; endDate?: string },
): Promise<PickupRequest[]> {
  let query = supabaseStaff
    .from('pickup_requests')
    .select('*, customer:customers(first_name, last_name, phone)')
    .eq('store_id', storeId)
    .order('requested_date', { ascending: true })
    .order('requested_time_slot', { ascending: true });

  if (filters?.status) {
    query = query.eq('status', filters.status);
  }
  if (filters?.startDate) {
    query = query.gte('requested_date', filters.startDate);
  }
  if (filters?.endDate) {
    query = query.lte('requested_date', filters.endDate);
  }

  const { data, error } = await query.limit(100);
  if (error) {
    console.error('fetchStorePickupRequests error:', error);
    throw error;
  }
  console.log('fetchStorePickupRequests:', storeId, filters, 'results:', data?.length);
  return (data as PickupRequest[]) || [];
}

// --- Customer Hooks ---

export function useMyPickupRequests(customerId: string | undefined) {
  return useQuery({
    queryKey: ['myPickupRequests', customerId],
    queryFn: () => fetchMyPickupRequests(customerId!),
    enabled: !!customerId,
  });
}

export function useCreatePickupRequest() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: CreatePickupRequestInput) => {
      const { data, error } = await supabasePortal
        .from('pickup_requests')
        .insert(input)
        .select()
        .single();
      if (error) throw error;
      return data as PickupRequest;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['myPickupRequests', variables.customer_id] });
      queryClient.invalidateQueries({ queryKey: ['slotBookings'] });
    },
  });
}

export function useCancelPickupRequest() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, reason }: { id: string; reason?: string }) => {
      const { error } = await supabasePortal
        .from('pickup_requests')
        .update({ status: 'cancelled', cancelled_reason: reason, updated_at: new Date().toISOString() })
        .eq('id', id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['myPickupRequests'] });
      queryClient.invalidateQueries({ queryKey: ['slotBookings'] });
      queryClient.invalidateQueries({ queryKey: ['storePickupRequests'] });
    },
  });
}

// --- Staff Hooks ---

export function useStorePickupRequests(
  storeId: string | undefined,
  filters?: { status?: PickupRequestStatus; startDate?: string; endDate?: string },
) {
  return useQuery({
    queryKey: ['storePickupRequests', storeId, filters],
    queryFn: () => fetchStorePickupRequests(storeId!, filters),
    enabled: !!storeId,
  });
}

export function useUpdatePickupStatus() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({
      id,
      status,
      confirmedBy,
      orderId,
      cancelledReason,
    }: {
      id: string;
      status: PickupRequestStatus;
      confirmedBy?: string;
      orderId?: string;
      cancelledReason?: string;
    }) => {
      const updates: Record<string, unknown> = {
        status,
        updated_at: new Date().toISOString(),
      };
      if (confirmedBy) updates.confirmed_by = confirmedBy;
      if (orderId) updates.order_id = orderId;
      if (cancelledReason) updates.cancelled_reason = cancelledReason;

      const { error } = await supabaseStaff.from('pickup_requests').update(updates).eq('id', id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['storePickupRequests'] });
      queryClient.invalidateQueries({ queryKey: ['myPickupRequests'] });
      queryClient.invalidateQueries({ queryKey: ['slotBookings'] });
    },
  });
}
