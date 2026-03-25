import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';
import type { Product, Section } from '@/types';

// --- Queries ---

async function fetchProducts(storeId: string): Promise<Product[]> {
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .eq('store_id', storeId)
    .order('display_order', { ascending: true });

  if (error) throw error;
  return (data as Product[]) || [];
}

async function fetchSections(storeId: string): Promise<Section[]> {
  const { data, error } = await supabase
    .from('sections')
    .select('*')
    .eq('store_id', storeId)
    .order('display_order', { ascending: true });

  if (error) throw error;
  return (data as Section[]) || [];
}

export function useProducts(storeId: string | undefined) {
  return useQuery({
    queryKey: ['products', storeId],
    queryFn: () => fetchProducts(storeId!),
    enabled: !!storeId,
  });
}

export function useSections(storeId: string | undefined) {
  return useQuery({
    queryKey: ['sections', storeId],
    queryFn: () => fetchSections(storeId!),
    enabled: !!storeId,
  });
}

// --- Mutations ---

export function useCreateProduct() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (product: Partial<Product>) => {
      const { data, error } = await supabase.from('products').insert(product).select().single();
      if (error) throw error;
      return data as Product;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['products', variables.store_id] });
    },
  });
}

export function useUpdateProduct() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, ...updates }: Partial<Product> & { id: string }) => {
      const { data, error } = await supabase
        .from('products')
        .update(updates)
        .eq('id', id)
        .select()
        .single();
      if (error) throw error;
      return data as Product;
    },
    onSuccess: (_data, variables) => {
      queryClient.invalidateQueries({ queryKey: ['products', variables.store_id] });
    },
  });
}

export function useDeleteProduct() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async ({ id, storeId }: { id: string; storeId: string }) => {
      const { error } = await supabase.from('products').delete().eq('id', id);
      if (error) throw error;
      return storeId;
    },
    onSuccess: (storeId) => {
      queryClient.invalidateQueries({ queryKey: ['products', storeId] });
    },
  });
}
