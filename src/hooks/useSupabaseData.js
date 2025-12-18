import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';
import { useApp } from '../context/AppContext';

export function useSupabaseData() {
  const { actions } = useApp();
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadData() {
      try {
        setIsLoading(true);
        actions.setLoading({ initial: true });

        // First, get the store (for now, get the first active store)
        const { data: stores, error: storeError } = await supabase
          .from('stores')
          .select('*, company:companies(*)')
          .eq('is_active', true)
          .limit(1);

        if (storeError) throw storeError;

        if (!stores || stores.length === 0) {
          throw new Error('No active store found. Please set up a store first.');
        }

        const store = stores[0];
        const storeId = store.id;

        // Set store and company in state
        actions.setStore(store);
        actions.setCompany(store.company);
        
        // Set settings from company
        if (store.company) {
          actions.setSettings({
            itbms_rate: store.company.itbms_rate || 7,
            default_completion_days: 1,
            express_completion_days: 0,
          });
        }

        // Load sections for this store
        const { data: sections, error: sectionsError } = await supabase
          .from('sections')
          .select('*')
          .eq('store_id', storeId)
          .eq('is_active', true)
          .order('display_order', { ascending: true });

        if (sectionsError) throw sectionsError;
        actions.setSections(sections || []);

        // Load products for all sections of this store
        const sectionIds = (sections || []).map(s => s.id);
        
        if (sectionIds.length > 0) {
          const { data: products, error: productsError } = await supabase
            .from('products')
            .select('*')
            .in('section_id', sectionIds)
            .eq('is_active', true)
            .order('display_order', { ascending: true });

          if (productsError) throw productsError;
          
          // Mark products that have children
          const parentIds = new Set((products || []).filter(p => p.parent_id).map(p => p.parent_id));
          const productsWithChildren = (products || []).map(p => ({
            ...p,
            has_children: parentIds.has(p.id)
          }));
          
          actions.setProducts(productsWithChildren);
        } else {
          actions.setProducts([]);
        }

        // Load customers for this store
        const { data: customers, error: customersError } = await supabase
          .from('customers')
          .select('*')
          .eq('store_id', storeId)
          .eq('is_active', true)
          .order('last_name', { ascending: true });

        if (customersError) throw customersError;
        actions.setCustomers(customers || []);

        // Load recent orders for this store
        const { data: orders, error: ordersError } = await supabase
          .from('orders')
          .select('*, items:order_items(*)')
          .eq('store_id', storeId)
          .order('created_at', { ascending: false })
          .limit(100);

        if (ordersError) throw ordersError;
        actions.setOrders(orders || []);

        // Set a default user for now (until auth is implemented)
        actions.setUser({
          id: 'temp-user',
          full_name: 'Operador',
          initials: 'OP',
          role: 'operator',
          email: 'operador@americanlaundry.com'
        });

        console.log('✅ Data loaded successfully:', {
          store: store.name,
          sections: sections?.length || 0,
          products: sectionIds.length > 0 ? 'loaded' : 'no sections',
          customers: customers?.length || 0,
          orders: orders?.length || 0
        });

        setError(null);
      } catch (err) {
        console.error('❌ Error loading data:', err);
        setError(err.message);
        actions.setError(err.message);
      } finally {
        setIsLoading(false);
        actions.setLoading({ initial: false });
      }
    }

    loadData();
  }, []);

  return { isLoading, error };
}

export default useSupabaseData;
