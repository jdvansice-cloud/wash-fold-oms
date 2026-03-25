import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Order, OrderWithDetails, OrderStatus, CreateOrderInput } from '@/types';

// --- Queries ---

interface OrdersFilter {
  storeId: string;
  status?: OrderStatus;
  startDate?: string;
  endDate?: string;
  limit?: number;
}

async function fetchOrders(filter: OrdersFilter): Promise<Order[]> {
  let query = supabase
    .from('orders')
    .select('*')
    .eq('store_id', filter.storeId)
    .order('created_at', { ascending: false })
    .limit(filter.limit || 500);

  if (filter.status) {
    query = query.eq('status', filter.status);
  }
  if (filter.startDate) {
    query = query.gte('created_at', filter.startDate);
  }
  if (filter.endDate) {
    query = query.lte('created_at', filter.endDate);
  }

  const { data, error } = await query;
  if (error) throw error;
  return (data as Order[]) || [];
}

async function fetchOrderDetails(orderId: string): Promise<OrderWithDetails> {
  const { data, error } = await supabase
    .from('orders')
    .select('*, order_items(*), payments(*)')
    .eq('id', orderId)
    .single();

  if (error) throw error;
  return data as OrderWithDetails;
}

async function searchOrders(storeId: string, query: string): Promise<Order[]> {
  // Search by order number or customer name
  const { data, error } = await supabase
    .from('orders')
    .select('*')
    .eq('store_id', storeId)
    .or(`order_number.eq.${query},customer_name.ilike.%${query}%,legacy_order_number.ilike.%${query}%`)
    .order('created_at', { ascending: false })
    .limit(100);

  if (error) throw error;
  return (data as Order[]) || [];
}

export function useOrders(filter: OrdersFilter | undefined) {
  return useQuery({
    queryKey: ['orders', filter],
    queryFn: () => fetchOrders(filter!),
    enabled: !!filter?.storeId,
  });
}

export function useOrderDetails(orderId: string | undefined) {
  return useQuery({
    queryKey: ['order', orderId],
    queryFn: () => fetchOrderDetails(orderId!),
    enabled: !!orderId,
  });
}

export function useSearchOrders(storeId: string | undefined, query: string) {
  return useQuery({
    queryKey: ['orders', 'search', storeId, query],
    queryFn: () => searchOrders(storeId!, query),
    enabled: !!storeId && query.length >= 2,
  });
}

// --- Mutations ---

export function useCreateOrder() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (input: CreateOrderInput) => {
      // Get next order number
      const { data: maxOrder } = await supabase
        .from('orders')
        .select('order_number')
        .eq('store_id', input.store_id)
        .order('order_number', { ascending: false })
        .limit(1)
        .single();

      const orderNumber = (maxOrder?.order_number || 0) + 1;

      // Create order
      const { items, payments, ...orderData } = input;
      const { data: order, error: orderError } = await supabase
        .from('orders')
        .insert({ ...orderData, order_number: orderNumber, status: 'pending' })
        .select()
        .single();

      if (orderError) throw orderError;

      // Create order items
      if (items.length > 0) {
        const { error: itemsError } = await supabase
          .from('order_items')
          .insert(items.map((item) => ({ ...item, order_id: order.id })));
        if (itemsError) throw itemsError;
      }

      // Create payments
      if (payments.length > 0) {
        const { error: paymentsError } = await supabase
          .from('payments')
          .insert(payments.map((p) => ({ ...p, order_id: order.id })));
        if (paymentsError) throw paymentsError;
      }

      return order as Order;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['orders'] });
    },
  });
}

export function useUpdateOrderStatus() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ orderId, status }: { orderId: string; status: OrderStatus }) => {
      const updates: Record<string, unknown> = { status, updated_at: new Date().toISOString() };
      if (status === 'completed') {
        updates.completed_at = new Date().toISOString();
      }
      const { error } = await supabase.from('orders').update(updates).eq('id', orderId);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['orders'] });
    },
  });
}
