import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { PaymentMethod } from '@/types';

async function fetchPaymentMethods(storeId: string): Promise<PaymentMethod[]> {
  const { data, error } = await supabase
    .from('payment_methods')
    .select('*')
    .eq('store_id', storeId)
    .order('display_order', { ascending: true });

  if (error) throw error;
  return (data as PaymentMethod[]) || [];
}

export function usePaymentMethods(storeId: string | undefined) {
  return useQuery({
    queryKey: ['paymentMethods', storeId],
    queryFn: () => fetchPaymentMethods(storeId!),
    enabled: !!storeId,
  });
}
