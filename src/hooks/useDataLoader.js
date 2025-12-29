import { useEffect, useState } from 'react';
import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { loadFromLocalStorage, saveToLocalStorage } from '../data/sampleData';
import { useApp } from '../context/AppContext';

export function useDataLoader() {
  const { actions } = useApp();
  const [isLoading, setIsLoading] = useState(true);
  const [dataSource, setDataSource] = useState(null); // 'supabase' or 'localStorage'
  const [error, setError] = useState(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    setIsLoading(true);
    setError(null);

    // Try Supabase first if configured
    if (isSupabaseConfigured && supabase) {
      try {
        console.log('Attempting to load data from Supabase...');
        
        const [
          { data: sections, error: sectionsError },
          { data: products, error: productsError },
          { data: customers, error: customersError },
          { data: orders, error: ordersError },
          { data: paymentMethods, error: pmError },
        ] = await Promise.all([
          supabase.from('sections').select('*').order('display_order'),
          supabase.from('products').select('*').order('name'),
          supabase.from('customers').select('*').order('first_name'),
          supabase.from('orders').select('*').order('created_at', { ascending: false }),
          supabase.from('payment_methods').select('*').eq('is_active', true),
        ]);

        if (sectionsError || productsError || customersError || ordersError || pmError) {
          throw new Error('Error loading from Supabase');
        }

        actions.setSections(sections || []);
        actions.setProducts(products || []);
        actions.setCustomers(customers || []);
        actions.setOrders(orders || []);
        actions.setPaymentMethods(paymentMethods || []);
        
        setDataSource('supabase');
        console.log('Data loaded from Supabase');
        
      } catch (err) {
        console.warn('Supabase load failed, falling back to localStorage:', err.message);
        loadFromLocal();
      }
    } else {
      console.log('Supabase not configured, using localStorage');
      loadFromLocal();
    }

    setIsLoading(false);
  };

  const loadFromLocal = () => {
    try {
      const data = loadFromLocalStorage();
      
      actions.setSections(data.sections);
      actions.setProducts(data.products);
      actions.setCustomers(data.customers);
      actions.setOrders(data.orders);
      actions.setPaymentMethods(data.paymentMethods);
      
      setDataSource('localStorage');
      console.log('Data loaded from localStorage');
    } catch (err) {
      setError('Failed to load data');
      console.error('localStorage load failed:', err);
    }
  };

  // Save functions that work with either backend
  const saveData = async (type, data) => {
    if (dataSource === 'supabase' && supabase) {
      try {
        const { error } = await supabase.from(type).upsert(data);
        if (error) throw error;
      } catch (err) {
        console.error(`Failed to save ${type} to Supabase:`, err);
        // Fallback to localStorage
        saveToLocalStorage(type, data);
      }
    } else {
      saveToLocalStorage(type, data);
    }
  };

  const addRecord = async (type, record) => {
    if (dataSource === 'supabase' && supabase) {
      try {
        const { data, error } = await supabase.from(type).insert(record).select().single();
        if (error) throw error;
        return data;
      } catch (err) {
        console.error(`Failed to add ${type} to Supabase:`, err);
        return record; // Return original for localStorage fallback
      }
    }
    return record;
  };

  const updateRecord = async (type, id, updates) => {
    if (dataSource === 'supabase' && supabase) {
      try {
        const { data, error } = await supabase.from(type).update(updates).eq('id', id).select().single();
        if (error) throw error;
        return data;
      } catch (err) {
        console.error(`Failed to update ${type} in Supabase:`, err);
        return { id, ...updates };
      }
    }
    return { id, ...updates };
  };

  const deleteRecord = async (type, id) => {
    if (dataSource === 'supabase' && supabase) {
      try {
        const { error } = await supabase.from(type).delete().eq('id', id);
        if (error) throw error;
        return true;
      } catch (err) {
        console.error(`Failed to delete ${type} from Supabase:`, err);
        return false;
      }
    }
    return true;
  };

  return {
    isLoading,
    dataSource,
    error,
    reload: loadData,
    saveData,
    addRecord,
    updateRecord,
    deleteRecord,
    isSupabase: dataSource === 'supabase',
    isLocalStorage: dataSource === 'localStorage',
  };
}

export default useDataLoader;
