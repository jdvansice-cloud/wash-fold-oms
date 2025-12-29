import { useEffect, useState, useCallback } from 'react';
import { supabase, isConfigured, getDefaultStoreId, getDefaultUser } from '../lib/supabase';
import { useApp } from '../context/AppContext';

export function useDataLoader() {
  const { actions } = useApp();
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [storeId, setStoreId] = useState(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    setIsLoading(true);
    setError(null);

    // Check if Supabase is configured
    if (!isConfigured) {
      setError({
        type: 'config',
        message: 'Supabase no está configurado',
        details: 'Configura las variables de entorno SUPABASE_URL y SUPABASE_ANON_KEY'
      });
      setIsLoading(false);
      return;
    }

    try {
      // Get default store
      const storeId = await getDefaultStoreId();
      if (!storeId) {
        setError({
          type: 'data',
          message: 'No se encontró una tienda activa',
          details: 'Ejecuta el script SQL de schema para crear los datos iniciales'
        });
        setIsLoading(false);
        return;
      }
      setStoreId(storeId);

      // Get default user
      const user = await getDefaultUser();
      if (user) {
        actions.setUser(user);
      }

      // Load all data in parallel
      const [
        { data: sections, error: sectionsError },
        { data: products, error: productsError },
        { data: customers, error: customersError },
        { data: orders, error: ordersError },
        { data: paymentMethods, error: pmError },
      ] = await Promise.all([
        supabase.from('sections').select('*').eq('store_id', storeId).order('display_order'),
        supabase.from('products').select('*').eq('store_id', storeId).eq('is_active', true).order('display_order'),
        supabase.from('customers').select('*').eq('store_id', storeId).eq('is_active', true).order('first_name'),
        supabase.from('orders').select('*').eq('store_id', storeId).order('created_at', { ascending: false }).limit(100),
        supabase.from('payment_methods').select('*').eq('store_id', storeId).eq('is_active', true).order('display_order'),
      ]);

      // Check for errors
      if (sectionsError) throw new Error(`Sections: ${sectionsError.message}`);
      if (productsError) throw new Error(`Products: ${productsError.message}`);
      if (customersError) throw new Error(`Customers: ${customersError.message}`);
      if (ordersError) throw new Error(`Orders: ${ordersError.message}`);
      if (pmError) throw new Error(`Payment Methods: ${pmError.message}`);

      // Set data in context
      actions.setSections(sections || []);
      actions.setProducts(products || []);
      actions.setCustomers(customers || []);
      actions.setOrders(orders || []);
      actions.setPaymentMethods(paymentMethods || []);
      actions.setStore({ id: storeId });
      
      console.log('Data loaded from Supabase:', {
        sections: sections?.length,
        products: products?.length,
        customers: customers?.length,
        orders: orders?.length,
        paymentMethods: paymentMethods?.length,
      });

    } catch (err) {
      console.error('Error loading data:', err);
      setError({
        type: 'connection',
        message: 'Error de conexión',
        details: err.message
      });
    }

    setIsLoading(false);
  };

  // CRUD Operations
  const addOrder = async (orderData) => {
    try {
      // Insert order
      const { data: order, error: orderError } = await supabase
        .from('orders')
        .insert({
          store_id: storeId,
          customer_id: orderData.customer_id,
          customer_name: orderData.customer_name,
          is_walk_in: orderData.is_walk_in,
          status: 'pending',
          is_express: orderData.is_express,
          subtotal: orderData.subtotal,
          discount_amount: orderData.discount_amount,
          delivery_charge: orderData.delivery_charge,
          tax_amount: orderData.tax_amount,
          total: orderData.total,
          total_weight: orderData.total_weight,
          total_bags: orderData.total_bags,
          total_pieces: orderData.total_pieces,
          notes: orderData.notes,
          promised_date: orderData.promised_date,
        })
        .select()
        .single();

      if (orderError) throw orderError;

      // Insert order items
      if (orderData.items && orderData.items.length > 0) {
        const itemsToInsert = orderData.items.map(item => ({
          order_id: order.id,
          product_id: item.product?.id,
          product_name: item.product?.name,
          quantity: item.quantity,
          total_weight: item.totalWeight || 0,
          bags: item.bags || 0,
          pieces: item.pieces || 0,
          unit_price: item.unitPrice,
          line_total: item.lineTotal,
          weight_entries: item.weightEntries || [],
        }));

        const { error: itemsError } = await supabase
          .from('order_items')
          .insert(itemsToInsert);

        if (itemsError) throw itemsError;
      }

      // Insert payment
      if (orderData.payment) {
        const { error: paymentError } = await supabase
          .from('payments')
          .insert({
            order_id: order.id,
            payment_method: orderData.payment.method,
            amount: orderData.payment.amount,
            change_amount: orderData.payment.change || 0,
          });

        if (paymentError) throw paymentError;
      }

      // Add to local state
      actions.addOrder(order);
      
      return order;
    } catch (err) {
      console.error('Error creating order:', err);
      throw err;
    }
  };

  const updateOrderStatus = async (orderId, newStatus) => {
    try {
      const updates = { 
        status: newStatus,
        updated_at: new Date().toISOString()
      };
      
      if (newStatus === 'completed') {
        updates.completed_at = new Date().toISOString();
      }

      const { error } = await supabase
        .from('orders')
        .update(updates)
        .eq('id', orderId);

      if (error) throw error;

      actions.updateOrderStatus(orderId, newStatus);
      return true;
    } catch (err) {
      console.error('Error updating order status:', err);
      throw err;
    }
  };

  const addCustomer = async (customerData) => {
    try {
      const { data, error } = await supabase
        .from('customers')
        .insert({
          store_id: storeId,
          ...customerData
        })
        .select()
        .single();

      if (error) throw error;

      actions.addCustomer(data);
      return data;
    } catch (err) {
      console.error('Error creating customer:', err);
      throw err;
    }
  };

  const updateCustomer = async (customerId, updates) => {
    try {
      const { data, error } = await supabase
        .from('customers')
        .update({ ...updates, updated_at: new Date().toISOString() })
        .eq('id', customerId)
        .select()
        .single();

      if (error) throw error;

      actions.updateCustomer(data);
      return data;
    } catch (err) {
      console.error('Error updating customer:', err);
      throw err;
    }
  };

  const updateProductsOrder = async (updates) => {
    // OPTIMISTIC UPDATE: Update local state immediately for instant UI feedback
    actions.updateProductsOrder(updates);
    
    try {
      // Update database in parallel (much faster than sequential)
      await Promise.all(
        updates.map(update =>
          supabase
            .from('products')
            .update({ display_order: update.display_order, updated_at: new Date().toISOString() })
            .eq('id', update.id)
        )
      );
      
      return true;
    } catch (err) {
      console.error('Error updating products order:', err);
      // On error, reload data to sync with server
      loadData();
      throw err;
    }
  };

  return {
    isLoading,
    error,
    storeId,
    reload: loadData,
    addOrder,
    updateOrderStatus,
    addCustomer,
    updateCustomer,
    updateProductsOrder,
  };
}

export default useDataLoader;
