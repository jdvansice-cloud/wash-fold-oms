import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { CustomerLoyalty, LoyaltySettings, LoyaltyTransaction } from '@/types';

async function fetchLoyaltySettings(storeId: string): Promise<LoyaltySettings | null> {
  const { data, error } = await supabase
    .from('loyalty_settings')
    .select('*')
    .eq('store_id', storeId)
    .single();

  if (error && error.code !== 'PGRST116') throw error; // PGRST116 = not found
  return data as LoyaltySettings | null;
}

async function fetchCustomerLoyalty(customerId: string): Promise<CustomerLoyalty | null> {
  const { data, error } = await supabase
    .from('customer_loyalty')
    .select('*')
    .eq('customer_id', customerId)
    .single();

  if (error && error.code !== 'PGRST116') throw error;
  return data as CustomerLoyalty | null;
}

async function fetchLoyaltyTransactions(customerId: string): Promise<LoyaltyTransaction[]> {
  const { data, error } = await supabase
    .from('loyalty_transactions')
    .select('*')
    .eq('customer_id', customerId)
    .order('created_at', { ascending: false })
    .limit(50);

  if (error) throw error;
  return (data as LoyaltyTransaction[]) || [];
}

export function useLoyaltySettings(storeId: string | undefined) {
  return useQuery({
    queryKey: ['loyaltySettings', storeId],
    queryFn: () => fetchLoyaltySettings(storeId!),
    enabled: !!storeId,
    staleTime: 5 * 60_000,
  });
}

export function useCustomerLoyalty(customerId: string | undefined) {
  return useQuery({
    queryKey: ['loyalty', customerId],
    queryFn: () => fetchCustomerLoyalty(customerId!),
    enabled: !!customerId,
  });
}

export function useLoyaltyTransactions(customerId: string | undefined) {
  return useQuery({
    queryKey: ['loyaltyTransactions', customerId],
    queryFn: () => fetchLoyaltyTransactions(customerId!),
    enabled: !!customerId,
  });
}
