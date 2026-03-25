import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Customer, CreateCustomerInput, UpdateCustomerInput } from '@/types';

// --- Queries ---

async function fetchCustomers(storeId: string): Promise<Customer[]> {
  const { data, error } = await supabase
    .from('customers')
    .select('*, customer_loyalty(*)')
    .eq('store_id', storeId)
    .eq('is_active', true)
    .order('first_name', { ascending: true });

  if (error) throw error;
  return (data as Customer[]) || [];
}

export function useCustomers(storeId: string | undefined) {
  return useQuery({
    queryKey: ['customers', storeId],
    queryFn: () => fetchCustomers(storeId!),
    enabled: !!storeId,
  });
}

// --- Mutations ---

export function useCreateCustomer() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: CreateCustomerInput) => {
      const { data, error } = await supabase.from('customers').insert(input).select().single();
      if (error) throw error;
      return data as Customer;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['customers', variables.store_id] });
    },
  });
}

export function useUpdateCustomer() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, ...updates }: UpdateCustomerInput) => {
      const { data, error } = await supabase
        .from('customers')
        .update(updates)
        .eq('id', id)
        .select()
        .single();
      if (error) throw error;
      return data as Customer;
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ['customers', data.store_id] });
    },
  });
}
