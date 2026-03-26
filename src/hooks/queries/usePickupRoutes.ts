import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabaseStaff } from '@/lib/supabase';
import type { PickupRoute, PickupRouteStatus } from '@/types';

export function useStorePickupRoutes(storeId: string | undefined, date?: string) {
  return useQuery({
    queryKey: ['pickupRoutes', storeId, date],
    queryFn: async () => {
      let query = supabaseStaff
        .from('pickup_routes')
        .select('*')
        .eq('store_id', storeId!)
        .order('created_at', { ascending: false });

      if (date) {
        query = query.eq('route_date', date);
      }

      const { data, error } = await query.limit(50);
      if (error) throw error;
      return (data as PickupRoute[]) || [];
    },
    enabled: !!storeId,
  });
}

export function useCreateRoute() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: {
      store_id: string;
      route_date: string;
      driver_name?: string;
      route_order: string[];
      created_by?: string;
      notes?: string;
    }) => {
      const { data, error } = await supabaseStaff
        .from('pickup_routes')
        .insert(input)
        .select()
        .single();
      if (error) throw error;

      // Link pickup requests to this route
      if (input.route_order.length > 0) {
        await supabaseStaff
          .from('pickup_requests')
          .update({ route_id: data.id })
          .in('id', input.route_order);
      }

      return data as PickupRoute;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pickupRoutes'] });
      queryClient.invalidateQueries({ queryKey: ['storePickupRequests'] });
    },
  });
}

export function useUpdateRoute() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({
      id,
      ...updates
    }: {
      id: string;
      status?: PickupRouteStatus;
      route_order?: string[];
      driver_name?: string;
      notes?: string;
    }) => {
      const { error } = await supabaseStaff
        .from('pickup_routes')
        .update({ ...updates, updated_at: new Date().toISOString() })
        .eq('id', id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pickupRoutes'] });
    },
  });
}
