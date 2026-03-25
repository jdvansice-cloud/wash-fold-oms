import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Order, OrderWithDetails } from '@/types';

async function fetchMyOrders(
  customerId: string,
  status: 'active' | 'completed',
): Promise<Order[]> {
  let query = supabase
    .from('orders')
    .select('*')
    .eq('customer_id', customerId)
    .order('created_at', { ascending: false });

  if (status === 'active') {
    query = query.not('status', 'in', '("completed","cancelled")');
  } else {
    query = query.in('status', ['completed', 'cancelled']);
  }

  const { data, error } = await query.limit(status === 'active' ? 50 : 20);
  if (error) throw error;
  return (data as Order[]) || [];
}

async function fetchMyOrderDetails(orderId: string): Promise<OrderWithDetails> {
  const { data, error } = await supabase
    .from('orders')
    .select('*, order_items(*), payments(*)')
    .eq('id', orderId)
    .single();

  if (error) throw error;
  return data as OrderWithDetails;
}

export function useMyOrders(customerId: string | undefined, status: 'active' | 'completed') {
  return useQuery({
    queryKey: ['myOrders', customerId, status],
    queryFn: () => fetchMyOrders(customerId!, status),
    enabled: !!customerId,
  });
}

export function useMyOrderDetails(orderId: string | undefined) {
  return useQuery({
    queryKey: ['myOrder', orderId],
    queryFn: () => fetchMyOrderDetails(orderId!),
    enabled: !!orderId,
  });
}
