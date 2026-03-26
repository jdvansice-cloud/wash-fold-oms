import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabasePortal } from '@/lib/supabase';
import type { CustomerLocation, CreateCustomerLocationInput } from '@/types';

export function useMyLocations(customerId: string | undefined) {
  return useQuery({
    queryKey: ['myLocations', customerId],
    queryFn: async () => {
      const { data, error } = await supabasePortal
        .from('customer_locations')
        .select('*')
        .eq('customer_id', customerId!)
        .order('is_default', { ascending: false })
        .order('created_at', { ascending: false });
      if (error) throw error;
      return (data as CustomerLocation[]) || [];
    },
    enabled: !!customerId,
  });
}

export function useCreateLocation() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: CreateCustomerLocationInput) => {
      // If setting as default, clear other defaults first
      if (input.is_default) {
        await supabasePortal
          .from('customer_locations')
          .update({ is_default: false })
          .eq('customer_id', input.customer_id)
          .eq('is_default', true);
      }
      const { data, error } = await supabasePortal
        .from('customer_locations')
        .insert(input)
        .select()
        .single();
      if (error) throw error;
      return data as CustomerLocation;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['myLocations', variables.customer_id] });
    },
  });
}

export function useUpdateLocation() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, customerId, ...updates }: Partial<CustomerLocation> & { id: string; customerId: string }) => {
      if (updates.is_default) {
        await supabasePortal
          .from('customer_locations')
          .update({ is_default: false })
          .eq('customer_id', customerId)
          .eq('is_default', true);
      }
      const { error } = await supabasePortal
        .from('customer_locations')
        .update({ ...updates, updated_at: new Date().toISOString() })
        .eq('id', id);
      if (error) throw error;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['myLocations', variables.customerId] });
    },
  });
}

export function useDeleteLocation() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, customerId }: { id: string; customerId: string }) => {
      const { error } = await supabasePortal
        .from('customer_locations')
        .delete()
        .eq('id', id);
      if (error) throw error;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['myLocations', variables.customerId] });
    },
  });
}
