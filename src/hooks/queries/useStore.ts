import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Store, Company } from '@/types';

export interface StoreWithCompany extends Store {
  company: Company;
}

async function fetchStore(): Promise<StoreWithCompany | null> {
  const { data, error } = await supabase
    .from('stores')
    .select('*, company:companies(*)')
    .eq('is_active', true)
    .limit(1)
    .single();

  if (error) throw error;
  return data as StoreWithCompany | null;
}

export function useStore() {
  return useQuery({
    queryKey: ['store'],
    queryFn: fetchStore,
    staleTime: 5 * 60_000, // Store data rarely changes
  });
}
