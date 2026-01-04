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
      // Get default store with company info
      const { data: storeData, error: storeError } = await supabase
        .from('stores')
        .select('*, companies(*)')
        .eq('is_active', true)
        .limit(1)
        .single();
      
      if (storeError || !storeData) {
        setError({
          type: 'data',
          message: 'No se encontró una tienda activa',
          details: 'Ejecuta el script SQL de schema para crear los datos iniciales'
        });
        setIsLoading(false);
        return;
      }
      
      const storeId = storeData.id;
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
        supabase.from('products').select('*').eq('store_id', storeId).order('display_order'),
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
      actions.setStore(storeData);
      actions.setCompany(storeData.companies); // Set company from joined data
      
      // Set settings from company data
      if (storeData.companies) {
        actions.setSettings({
          itbms_rate: storeData.companies.itbms_rate || 7,
          default_completion_days: storeData.companies.default_completion_days || 1,
          express_completion_days: storeData.companies.express_completion_days || 0,
        });
      }
      
      console.log('Data loaded from Supabase:', {
        store: storeData.name,
        company: storeData.companies?.name,
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

  // Helper function to send notification emails
  const sendNotificationEmail = async (templateId, recipientEmail, variables) => {
    if (!recipientEmail) return;
    
    try {
      // Get company and store info
      const { data: companyData } = await supabase
        .from('companies')
        .select('id, name, smtp_from_name, smtp_host')
        .limit(1)
        .single();

      // Skip if SMTP not configured
      if (!companyData?.smtp_host) {
        console.log('SMTP not configured, skipping notification');
        return;
      }

      // Get store info for phone number
      const { data: storeData } = await supabase
        .from('stores')
        .select('phone')
        .limit(1)
        .single();

      // Check if notification is enabled (default to enabled if no record)
      const { data: settings } = await supabase
        .from('notification_settings')
        .select('enabled, subject, body_template')
        .eq('company_id', companyData.id)
        .eq('template_id', templateId)
        .maybeSingle();
      
      // If settings exist and explicitly disabled, skip
      if (settings && settings.enabled === false) {
        console.log(`Notification ${templateId} is disabled`);
        return;
      }

      // Build email content based on template
      const companyName = companyData?.name || 'Nuestra Lavandería';
      const storePhone = storeData?.phone || '';
      
      // Add company_name and store_phone to variables
      const allVariables = {
        ...variables,
        company_name: companyName,
        store_phone: storePhone
      };
      
      // Default templates (fallback if no custom template saved)
      const defaultTemplates = {
        welcome: {
          subject: `¡Bienvenido a ${companyName}!`,
          html: `<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
  <h1 style="color: #0891b2;">¡Bienvenido, {customer_name}!</h1>
  <p>Gracias por registrarte en <strong>{company_name}</strong>.</p>
  <p>Estamos aquí para hacer tu vida más fácil con nuestros servicios de lavandería profesional.</p>
  <p>¡Te esperamos pronto!</p>
  <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
  <p style="color: #64748b; font-size: 12px;">{company_name}<br>Este es un mensaje automático, por favor no responder.</p>
</div>`
        },
        order_created: {
          subject: `Tu orden #{order_number} ha sido recibida - ${companyName}`,
          html: `<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
  <h1 style="color: #0891b2;">¡Orden Recibida!</h1>
  <p>Hola {customer_name},</p>
  <p>Hemos recibido tu orden <strong>#{order_number}</strong>.</p>
  <table style="width: 100%; margin: 20px 0; border-collapse: collapse;">
    <tr><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;"><strong>Total:</strong></td><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;">B/{total}</td></tr>
    <tr><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;"><strong>Fecha estimada:</strong></td><td style="padding: 10px; border-bottom: 1px solid #e2e8f0;">{promised_date}</td></tr>
  </table>
  <p>Te notificaremos cuando tu orden esté lista.</p>
  <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
  <p style="color: #64748b; font-size: 12px;">{company_name} | {store_phone}</p>
</div>`
        },
        order_ready: {
          subject: `¡Tu orden #{order_number} está lista! - ${companyName}`,
          html: `<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
  <h1 style="color: #10b981;">¡Tu orden está lista!</h1>
  <p>Hola {customer_name},</p>
  <p>Tu orden <strong>#{order_number}</strong> está lista para recoger.</p>
  <div style="background: #f0fdf4; padding: 15px; border-radius: 8px; margin: 20px 0;">
    <p style="margin: 0; color: #166534;"><strong>✓ Lista para recoger</strong></p>
  </div>
  <p>Te esperamos en nuestra tienda.</p>
  <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
  <p style="color: #64748b; font-size: 12px;">{company_name} | {store_phone}</p>
</div>`
        },
        order_delivered: {
          subject: `Orden #{order_number} entregada - ${companyName}`,
          html: `<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
  <h1 style="color: #10b981;">¡Orden Entregada!</h1>
  <p>Hola {customer_name},</p>
  <p>Tu orden <strong>#{order_number}</strong> ha sido entregada exitosamente.</p>
  <div style="background: #f0fdf4; padding: 15px; border-radius: 8px; margin: 20px 0;">
    <p style="margin: 0; color: #166534;"><strong>✓ Entrega completada</strong></p>
  </div>
  <p>¡Gracias por confiar en nosotros!</p>
  <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
  <p style="color: #64748b; font-size: 12px;">{company_name}</p>
</div>`
        }
      };

      // Use custom template if exists, otherwise use default
      let subject = settings?.subject || defaultTemplates[templateId]?.subject || 'Notificación';
      let html = settings?.body_template || defaultTemplates[templateId]?.html || '';

      // Replace variables in templates
      Object.keys(allVariables).forEach(key => {
        const regex = new RegExp(`{${key}}`, 'g');
        subject = subject.replace(regex, allVariables[key] || '');
        html = html.replace(regex, allVariables[key] || '');
      });

      // Send email via API
      console.log(`Sending ${templateId} notification to ${recipientEmail}...`);
      const response = await fetch('/api/send-email', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          to: recipientEmail,
          subject,
          html,
          company_id: companyData.id
        })
      });

      const result = await response.json();
      if (result.success) {
        console.log(`✅ Notification ${templateId} sent to ${recipientEmail}`);
      } else {
        console.error(`❌ Failed to send ${templateId}:`, result.error);
      }
    } catch (err) {
      console.error(`Error sending notification ${templateId}:`, err);
    }
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
      
      // Send order_created notification if customer has email
      if (orderData.customer_id && !orderData.is_walk_in) {
        const { data: customer } = await supabase
          .from('customers')
          .select('email, first_name, last_name')
          .eq('id', orderData.customer_id)
          .single();
        
        if (customer?.email) {
          const promisedDateFormatted = order.promised_date 
            ? new Date(order.promised_date).toLocaleDateString('es-PA', { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
              })
            : 'Por confirmar';
            
          sendNotificationEmail('order_created', customer.email, {
            customer_name: `${customer.first_name} ${customer.last_name || ''}`.trim(),
            order_number: order.order_number,
            total: order.total?.toFixed(2),
            promised_date: promisedDateFormatted
          });
        }
      }
      
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
      
      // Send notifications for status changes
      if (newStatus === 'ready' || newStatus === 'completed') {
        // Get order and customer info
        const { data: order } = await supabase
          .from('orders')
          .select('*, customers(email, first_name, last_name)')
          .eq('id', orderId)
          .single();
        
        if (order?.customers?.email) {
          const templateId = newStatus === 'ready' ? 'order_ready' : 'order_delivered';
          sendNotificationEmail(templateId, order.customers.email, {
            customer_name: `${order.customers.first_name} ${order.customers.last_name || ''}`.trim(),
            order_number: order.order_number,
            total: order.total?.toFixed(2)
          });
        }
      }
      
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
      
      // Send welcome email if customer has email
      if (data.email) {
        sendNotificationEmail('welcome', data.email, {
          customer_name: `${data.first_name} ${data.last_name || ''}`.trim()
        });
      }

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

  // Product CRUD operations
  const addProduct = async (productData) => {
    try {
      const { data, error } = await supabase
        .from('products')
        .insert({
          store_id: storeId,
          ...productData
        })
        .select()
        .single();

      if (error) throw error;

      actions.addProduct(data);
      return data;
    } catch (err) {
      console.error('Error creating product:', err);
      throw err;
    }
  };

  const updateProduct = async (productId, updates) => {
    try {
      const { data, error } = await supabase
        .from('products')
        .update({ ...updates, updated_at: new Date().toISOString() })
        .eq('id', productId)
        .select()
        .single();

      if (error) throw error;

      actions.updateProduct(data);
      return data;
    } catch (err) {
      console.error('Error updating product:', err);
      throw err;
    }
  };

  const deleteProduct = async (productId) => {
    try {
      const { error } = await supabase
        .from('products')
        .delete()
        .eq('id', productId);

      if (error) throw error;

      actions.deleteProduct(productId);
      return true;
    } catch (err) {
      console.error('Error deleting product:', err);
      throw err;
    }
  };

  // Section CRUD operations
  const addSection = async (sectionData) => {
    try {
      const { data, error } = await supabase
        .from('sections')
        .insert({
          store_id: storeId,
          ...sectionData
        })
        .select()
        .single();

      if (error) throw error;

      actions.addSection(data);
      return data;
    } catch (err) {
      console.error('Error creating section:', err);
      throw err;
    }
  };

  const updateSection = async (sectionId, updates) => {
    try {
      const { data, error } = await supabase
        .from('sections')
        .update({ ...updates, updated_at: new Date().toISOString() })
        .eq('id', sectionId)
        .select()
        .single();

      if (error) throw error;

      actions.updateSection(data);
      return data;
    } catch (err) {
      console.error('Error updating section:', err);
      throw err;
    }
  };

  const deleteSection = async (sectionId) => {
    try {
      const { error } = await supabase
        .from('sections')
        .delete()
        .eq('id', sectionId);

      if (error) throw error;

      actions.deleteSection(sectionId);
      return true;
    } catch (err) {
      console.error('Error deleting section:', err);
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
    // Product CRUD
    addProduct,
    updateProduct,
    deleteProduct,
    // Section CRUD
    addSection,
    updateSection,
    deleteSection,
  };
}

export default useDataLoader;
