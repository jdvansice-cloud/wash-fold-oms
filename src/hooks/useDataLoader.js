import { useEffect, useState, useCallback, useRef } from 'react';
import { supabase, isConfigured, getDefaultUser } from '../lib/supabase';
import { useApp } from '../context/AppContext';
import { emitInvoice } from '../lib/efactura/client';
import { sanitizeSearchTerm } from '../lib/validation';

// Build PostgREST auth headers. The Authorization bearer MUST be the
// logged-in user's access token (not the anon key) so RLS can scope rows
// to the user's company. Falls back to the anon key only when there is no
// session (pre-login).
const authHeaders = async () => {
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  const { data: { session } } = await supabase.auth.getSession();
  return {
    apikey: key,
    Authorization: `Bearer ${session?.access_token || key}`,
  };
};

// Raw fetch helper for Supabase REST API
const supabaseFetch = async (table, options = {}) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;

  if (!url || !key) {
    return { data: null, error: { message: 'Missing Supabase config' } };
  }

  try {
    // Build query string
    const params = new URLSearchParams();
    params.append('select', options.select || '*');
    
    if (options.eq) {
      Object.entries(options.eq).forEach(([col, val]) => {
        params.append(col, `eq.${val}`);
      });
    }
    
    if (options.order) {
      const dir = options.ascending === false ? 'desc' : 'asc';
      params.append('order', `${options.order}.${dir}`);
    }
    
    if (options.limit) {
      params.append('limit', options.limit);
    }
    
    const fetchUrl = `${url}/rest/v1/${table}?${params.toString()}`;

    const response = await fetch(fetchUrl, {
      method: 'GET',
      headers: {
        ...(await authHeaders()),
        'Content-Type': 'application/json',
      }
    });
    
    if (!response.ok) {
      const text = await response.text();
      return { data: null, error: { message: `HTTP ${response.status}: ${text}` } };
    }
    
    const data = await response.json();
    
    // Handle single option
    if (options.single) {
      if (data.length === 0) {
        return { data: null, error: { message: 'No rows found' } };
      }
      return { data: data[0], error: null };
    }
    
    return { data, error: null };
  } catch (err) {
    console.error(`Fetch error for ${table}:`, err);
    return { data: null, error: { message: err.message } };
  }
};

export function useDataLoader() {
  const { actions } = useApp();
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [storeId, setStoreId] = useState(null);
  const loadedRef = useRef(false);

  useEffect(() => {
    // Prevent double loading in strict mode
    if (loadedRef.current) return;
    loadedRef.current = true;
    loadData();
  }, []);

  const loadData = async () => {
    setIsLoading(true);
    setError(null);

    console.log('=== DATA LOADER START (raw fetch) ===', new Date().toISOString());
    console.log('Supabase configured:', isConfigured);

    // Check if Supabase is configured
    if (!isConfigured) {
      console.log('Supabase NOT configured');
      setError({
        type: 'config',
        message: 'Supabase no está configurado',
        details: 'Configura las variables de entorno SUPABASE_URL y SUPABASE_PUBLISHABLE_KEY en Vercel'
      });
      setIsLoading(false);
      return;
    }

    try {
      const startTime = Date.now();
      
      // Fetch the active store. Honor the store chosen via the top-bar switcher
      // (TenantContext persists it under tenant-store-<slug>); else the first.
      console.log('1. Fetching store...');
      const slug = (() => {
        const seg = window.location.pathname.split('/').filter(Boolean);
        return seg[0] === 'app' ? seg[1] : seg[0];
      })();
      const savedStoreId = slug ? localStorage.getItem(`tenant-store-${slug}`) : null;
      const { data: storesData } = await supabaseFetch('stores', {
        eq: { is_active: true },
        order: 'name',
      });
      const storeList = Array.isArray(storesData) ? storesData : storesData ? [storesData] : [];
      const storeData = storeList.find((s) => s.id === savedStoreId) || storeList[0] || null;
      const storeError = storeData ? null : { message: 'No se encontró una tienda activa' };
      console.log('1. Store query completed in', Date.now() - startTime, 'ms', '| store:', storeData?.name);
      
      if (storeError || !storeData) {
        console.error('Store error:', storeError);
        setError({
          type: 'data',
          message: 'No se encontró una tienda activa',
          details: storeError?.message || 'Ejecuta el script SQL de schema'
        });
        setIsLoading(false);
        return;
      }
      
      console.log('2. Store loaded:', storeData.name);
      const currentStoreId = storeData.id;
      setStoreId(currentStoreId);

      // Fetch company if needed
      let companyData = null;
      if (storeData.company_id) {
        console.log('2b. Fetching company...');
        const { data: company } = await supabaseFetch('companies', {
          eq: { id: storeData.company_id },
          single: true
        });
        if (company) {
          companyData = company;
          console.log('2b. Company loaded:', company.name);
        }
      }

      // Get default user (non-blocking, uses Supabase client which works for simple queries)
      getDefaultUser().then(user => {
        if (user) actions.setUser(user);
      }).catch(err => console.error('User load error:', err));

      console.log('3. Loading app data...');
      const dataStartTime = Date.now();
      
      // Load all data in parallel using raw fetch
      const [
        sectionsResult,
        productsResult,
        customersResult,
        ordersResult,
        paymentMethodsResult,
      ] = await Promise.all([
        supabaseFetch('sections', { eq: { store_id: currentStoreId }, order: 'display_order' }),
        supabaseFetch('products', { eq: { store_id: currentStoreId }, order: 'display_order' }),
        // Only the most recent customers are kept in memory (the working set for
        // quick-select + the Clientes landing view). Older customers are reached
        // via server-side searchCustomers(), so we don't ship the whole table.
        supabaseFetch('customers', { eq: { store_id: currentStoreId, is_active: true }, order: 'created_at', ascending: false, limit: 200 }),
        supabaseFetch('orders', { eq: { store_id: currentStoreId }, order: 'created_at', ascending: false, limit: 500 }),
        supabaseFetch('payment_methods', { eq: { store_id: currentStoreId, is_active: true }, order: 'display_order' }),
      ]);

      console.log('3. Data queries completed in', Date.now() - dataStartTime, 'ms');

      const { data: sections, error: sectionsError } = sectionsResult;
      const { data: products, error: productsError } = productsResult;
      const { data: customers, error: customersError } = customersResult;
      const { data: orders, error: ordersError } = ordersResult;
      const { data: paymentMethods, error: pmError } = paymentMethodsResult;

      // Log errors but don't fail completely
      if (sectionsError) console.error('Sections error:', sectionsError);
      if (productsError) console.error('Products error:', productsError);
      if (customersError) console.error('Customers error:', customersError);
      if (ordersError) console.error('Orders error:', ordersError);
      if (pmError) console.error('Payment Methods error:', pmError);

      // Set data in context (use empty arrays if errors)
      actions.setSections(sections || []);
      actions.setProducts(products || []);
      actions.setCustomers(customers || []);
      actions.setOrders(orders || []);
      actions.setPaymentMethods(paymentMethods || []);
      actions.setStore(storeData);
      actions.setCompany(companyData);
      
      // Set settings from company data
      if (companyData) {
        actions.setSettings({
          itbms_rate: companyData.itbms_rate || 7,
          default_completion_days: companyData.default_completion_days || 1,
          express_completion_days: companyData.express_completion_days || 0,
        });
      }
      
      console.log('=== DATA LOADER SUCCESS ===', {
        store: storeData.name,
        company: companyData?.name,
        sections: sections?.length || 0,
        products: products?.length || 0,
        customers: customers?.length || 0,
        orders: orders?.length || 0,
        paymentMethods: paymentMethods?.length || 0,
        totalTime: Date.now() - startTime + 'ms'
      });

    } catch (err) {
      console.error('=== DATA LOADER ERROR ===', err);
      setError({
        type: 'connection',
        message: 'Error de conexión',
        details: err.message
      });
    }

    setIsLoading(false);
    console.log('=== DATA LOADER END ===');
  };

  // Helper function to send notification emails
  const sendNotificationEmail = async (templateId, recipientEmail, variables) => {
    if (!recipientEmail) return;
    
    try {
      // Get company and store info
      const { data: companyData } = await supabase
        .from('companies')
        .select('id, name, logo_url')
        .limit(1)
        .single();

      // Skip if SMTP not configured for this company
      const { data: smtpData } = await supabase
        .from('company_smtp')
        .select('smtp_host')
        .eq('company_id', companyData?.id)
        .maybeSingle();
      if (!smtpData?.smtp_host) {
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
      const logoUrl = companyData?.logo_url || '';
      
      // Add company info to variables
      const allVariables = {
        ...variables,
        company_name: companyName,
        store_phone: storePhone,
        logo_url: logoUrl
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
      const { data: { session } } = await supabase.auth.getSession();
      const response = await fetch('/api/send-email', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session?.access_token || ''}`,
        },
        body: JSON.stringify({
          to: recipientEmail,
          subject,
          html,
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

  // Fallback used only when the /api/orders/create route is unavailable (local
  // dev without Vercel). Production always goes through the validating endpoint.
  const directInsertOrder = async (orderData) => {
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
        payment_status: orderData.payment_status || 'paid',
        billing_type: orderData.billing_type || 'immediate',
      })
      .select()
      .single();
    if (orderError) throw orderError;

    if (orderData.items?.length > 0) {
      const { error } = await supabase.from('order_items').insert(
        orderData.items.map(item => ({
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
        })),
      );
      if (error) throw error;
    }
    if (orderData.payments?.length > 0) {
      const { error } = await supabase.from('payments').insert(
        orderData.payments.map(payment => ({
          order_id: order.id,
          payment_method: payment.method,
          amount: payment.amount,
          reference: payment.reference || null,
          change_amount: payment.changeGiven || 0,
        })),
      );
      if (error) throw error;
    }
    return order;
  };

  // CRUD Operations
  const addOrder = async (orderData) => {
    try {
      // Create the order server-side: the API re-validates every line's unit
      // price + line total against the catalog and inserts with the service-role
      // key (order_number is assigned by the DB SERIAL).
      let order;
      try {
        const { data: { session } } = await supabase.auth.getSession();
        const response = await fetch('/api/orders/create', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session?.access_token || ''}`,
          },
          body: JSON.stringify({ ...orderData, store_id: storeId }),
        });
        // Under `vite dev` the /api route isn't served and returns the SPA HTML
        // (200, text/html); treat any non-JSON / 404 response as route-missing.
        const contentType = response.headers.get('content-type') || '';
        if (response.status === 404 || !contentType.includes('application/json')) {
          throw { routeMissing: true };
        }
        const result = await response.json().catch(() => ({}));
        if (!response.ok || !result?.success) {
          throw new Error(result?.error || `No se pudo crear la orden (HTTP ${response.status})`);
        }
        order = result.order;
      } catch (apiErr) {
        if (!apiErr?.routeMissing) throw apiErr;
        console.warn('Order API unavailable; using direct insert (dev fallback).');
        order = await directInsertOrder(orderData);
      }

      // Add to local state
      actions.addOrder(order);

      // Auto-emit the electronic invoice (factura electrónica) for paid sales.
      // Fire-and-forget so it never blocks checkout; the /api/efactura/retry
      // cron re-emits if the PAC is unavailable, and it no-ops when E-Factura
      // is not enabled for the company. Pay-on-pickup sales are deferred (money
      // collected at pickup), so no invoice is emitted now — it's billed when
      // the order is actually paid. The emit endpoint enforces this too.
      // Gift cards are prepayment, not a sale, and B2B credit (account) bills via
      // the consolidated factura — neither auto-emits a per-order factura. (The
      // emit endpoint enforces both server-side; this just avoids the round-trip.)
      const giftCardOnly =
        (orderData.items?.length ?? 0) > 0 &&
        orderData.items.every((i) => i.product?.product_type === 'gift_card');
      const isAccount = (orderData.billing_type || order.billing_type) === 'account';
      const isUnpaid = (orderData.payment_status || order.payment_status) === 'unpaid';
      if (!isUnpaid && !giftCardOnly && !isAccount && (order.total ?? 0) > 0) {
        emitInvoice(order.id).catch((err) =>
          console.warn('E-Factura auto-emit deferred:', err?.message || err),
        );
      }

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

  // Settle an unpaid (pay-on-pickup) order: record the payment(s), mark it paid,
  // and emit the electronic invoice now that money has actually been collected.
  const settleOrder = async (orderId, paymentInfo) => {
    try {
      const rows = (paymentInfo.payments || []).map((p) => ({
        order_id: orderId,
        payment_method: p.method,
        amount: p.amount,
        reference: p.reference || null,
        change_amount: p.changeGiven || 0,
      }));
      if (rows.length) {
        const { error } = await supabase.from('payments').insert(rows);
        if (error) throw error;
      }

      const { error: upErr } = await supabase
        .from('orders')
        .update({ payment_status: 'paid', updated_at: new Date().toISOString() })
        .eq('id', orderId);
      if (upErr) throw upErr;

      actions.updateOrder({ id: orderId, payment_status: 'paid' });

      // Now that it's paid, emit the invoice (fire-and-forget; retry cron covers
      // PAC outages; no-ops when e-factura isn't enabled).
      emitInvoice(orderId).catch((err) =>
        console.warn('E-Factura emit (settle) deferred:', err?.message || err),
      );

      return true;
    } catch (err) {
      console.error('Error settling order:', err);
      throw err;
    }
  };

  const updateOrderStatus = async (orderId, newStatus) => {
    try {
      // Gate: a pay-on-pickup order can't be handed to the customer (marked
      // "completed") until it's paid. B2B credit ("account") orders are
      // delivered on account, so they are NOT gated.
      if (newStatus === 'completed') {
        const { data: ord } = await supabase
          .from('orders')
          .select('payment_status, billing_type')
          .eq('id', orderId)
          .maybeSingle();
        if (ord?.payment_status === 'unpaid' && ord?.billing_type === 'pickup') {
          const e = new Error('La orden debe pagarse antes de entregarse al cliente.');
          e.code = 'PAYMENT_REQUIRED';
          throw e;
        }
      }

      const updates = {
        status: newStatus,
        updated_at: new Date().toISOString()
      };

      if (newStatus === 'completed') {
        updates.completed_at = new Date().toISOString();
      }
      // Stamp when it became ready (for the awaiting-pickup view + reminders);
      // clear the reminder so a re-ready order can be reminded again.
      if (newStatus === 'ready') {
        updates.ready_at = new Date().toISOString();
        updates.pickup_reminder_at = null;
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

  // Manually nudge a customer that their order is waiting for pickup. Reuses the
  // order_ready template and stamps pickup_reminder_at so the UI/cron know.
  const sendPickupReminder = async (order) => {
    try {
      let email = order.customer_email;
      if (!email && order.customer_id) {
        const { data: c } = await supabase
          .from('customers')
          .select('email, first_name, last_name')
          .eq('id', order.customer_id)
          .maybeSingle();
        email = c?.email;
      }
      if (email) {
        await sendNotificationEmail('order_ready', email, {
          customer_name: order.customer_name,
          order_number: order.order_number,
          total: order.total?.toFixed(2),
        });
      }
      const nowIso = new Date().toISOString();
      await supabase.from('orders').update({ pickup_reminder_at: nowIso }).eq('id', order.id);
      actions.updateOrder({ id: order.id, pickup_reminder_at: nowIso });
      return { sent: !!email };
    } catch (err) {
      console.error('Error sending pickup reminder:', err);
      throw err;
    }
  };

  const addCustomer = async (customerData) => {
    try {
      // Whitelist real DB columns and force the current store. This is the single
      // sanitization point: the POS inline form used to pass a fake `id`,
      // store_id:'store-001', and non-existent columns (phone_country_code,
      // address_city, loyalty_points) that made PostgREST reject the insert.
      const c = customerData || {};
      const ALLOWED = [
        'first_name', 'last_name', 'phone_country', 'phone', 'email',
        'address_street', 'address_building', 'address_corregimiento',
        'address_district', 'address_province', 'id_type', 'id_number',
        'company_name', 'ruc', 'dv', 'can_be_invoiced', 'account_balance',
        'preferences', 'notes',
      ];
      const row = { store_id: storeId };
      for (const k of ALLOWED) if (c[k] !== undefined) row[k] = c[k];
      if (row.can_be_invoiced === undefined) row.can_be_invoiced = c.id_type === 'ruc';

      const { data, error } = await supabase
        .from('customers')
        .insert(row)
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

  // Get full order details with items and payments
  const getOrderDetails = async (orderId) => {
    try {
      // Get order with items and payments
      const { data: order, error: orderError } = await supabase
        .from('orders')
        .select('*')
        .eq('id', orderId)
        .single();

      if (orderError) throw orderError;

      // Get order items
      const { data: items, error: itemsError } = await supabase
        .from('order_items')
        .select('*')
        .eq('order_id', orderId);

      if (itemsError) throw itemsError;

      // Get payments
      const { data: payments, error: paymentsError } = await supabase
        .from('payments')
        .select('*')
        .eq('order_id', orderId);

      if (paymentsError) throw paymentsError;

      // Get loyalty transactions for this order
      let loyaltyTransactions = [];
      try {
        const { data: loyaltyData, error: loyaltyError } = await supabase
          .from('loyalty_transactions')
          .select('*')
          .eq('order_id', orderId);
        
        if (!loyaltyError && loyaltyData) {
          loyaltyTransactions = loyaltyData;
        }
      } catch (loyaltyErr) {
        // Loyalty table might not exist yet, ignore error
        console.log('Loyalty transactions not available:', loyaltyErr);
      }

      return {
        ...order,
        items: items || [],
        payments: payments || [],
        loyaltyTransactions: loyaltyTransactions,
      };
    } catch (err) {
      console.error('Error getting order details:', err);
      throw err;
    }
  };

  // Create refund order
  const createRefund = async (originalOrder, refundReason) => {
    try {
      // 1. Create refund order (negative amounts, status: 'refund')
      const { data: refundOrder, error: refundError } = await supabase
        .from('orders')
        .insert({
          store_id: storeId,
          customer_id: originalOrder.customer_id,
          customer_name: originalOrder.customer_name,
          is_walk_in: originalOrder.is_walk_in,
          status: 'refund', // Special status for refunds
          is_express: false,
          subtotal: -Math.abs(originalOrder.subtotal || 0),
          discount_amount: -Math.abs(originalOrder.discount_amount || 0),
          delivery_charge: -Math.abs(originalOrder.delivery_charge || 0),
          tax_amount: -Math.abs(originalOrder.tax_amount || 0),
          total: -Math.abs(originalOrder.total || 0),
          total_weight: originalOrder.total_weight || 0,
          total_bags: originalOrder.total_bags || 0,
          total_pieces: originalOrder.total_pieces || 0,
          notes: `REEMBOLSO de Orden #${originalOrder.order_number}. ${refundReason || ''}`.trim(),
          promised_date: new Date().toISOString(), // Immediate
          refund_for_order_id: originalOrder.id, // Reference to original
        })
        .select()
        .single();

      if (refundError) throw refundError;

      // 2. Copy items as negative
      if (originalOrder.items && originalOrder.items.length > 0) {
        const refundItems = originalOrder.items.map(item => ({
          order_id: refundOrder.id,
          product_id: item.product_id,
          product_name: item.product_name,
          quantity: -Math.abs(item.quantity || 0),
          total_weight: item.total_weight || 0,
          bags: item.bags || 0,
          pieces: item.pieces || 0,
          unit_price: item.unit_price,
          line_total: -Math.abs(item.line_total || 0),
          weight_entries: item.weight_entries || [],
          notes: 'Reembolso',
        }));

        const { error: itemsError } = await supabase
          .from('order_items')
          .insert(refundItems);

        if (itemsError) throw itemsError;
      }

      // 3. Copy payments as negative (refund transactions)
      if (originalOrder.payments && originalOrder.payments.length > 0) {
        const refundPayments = originalOrder.payments.map(payment => ({
          order_id: refundOrder.id,
          payment_method: payment.payment_method,
          amount: -Math.abs(payment.amount || 0),
          reference: `REF-${payment.reference || originalOrder.order_number}`,
          change_amount: 0,
        }));

        const { error: paymentsError } = await supabase
          .from('payments')
          .insert(refundPayments);

        if (paymentsError) throw paymentsError;
      }

      // 4. Reverse loyalty transactions if customer has any
      if (originalOrder.customer_id && originalOrder.loyaltyTransactions?.length > 0) {
        try {
          await reverseLoyaltyTransactions(
            originalOrder.customer_id,
            originalOrder.loyaltyTransactions,
            refundOrder.id
          );
          console.log('Loyalty transactions reversed for refund');
        } catch (loyaltyErr) {
          console.error('Error reversing loyalty (refund still processed):', loyaltyErr);
        }
      }

      // 5. Update original order status to 'refunded'
      const { error: updateError } = await supabase
        .from('orders')
        .update({ 
          status: 'refunded',
          updated_at: new Date().toISOString(),
          notes: `${originalOrder.notes || ''}\n[REEMBOLSADO - Ver Orden #${refundOrder.order_number}]`.trim()
        })
        .eq('id', originalOrder.id);

      if (updateError) throw updateError;

      // 6. Create refund record
      const { error: refundRecordError } = await supabase
        .from('refunds')
        .insert({
          store_id: storeId,
          order_id: originalOrder.id,
          order_number: originalOrder.order_number,
          customer_name: originalOrder.customer_name,
          amount: Math.abs(originalOrder.total || 0),
          refund_type: 'full',
          reason: refundReason || 'Reembolso solicitado',
          notes: `Orden de reembolso: #${refundOrder.order_number}`,
        });

      if (refundRecordError) {
        console.warn('Could not create refund record:', refundRecordError);
        // Don't throw - refund order was created successfully
      }

      // 7. Emit a nota de crédito (factura electrónica tipo 06) for the refund,
      // referencing the original order's authorized factura. Fire-and-forget so
      // it never blocks the refund; the retry cron picks up failures.
      try {
        const { data: originalInvoice } = await supabase
          .from('electronic_invoices')
          .select('cufe')
          .eq('order_id', originalOrder.id)
          .eq('doc_type', '01')
          .eq('status', 'authorized')
          .maybeSingle();

        if (originalInvoice?.cufe) {
          emitInvoice(refundOrder.id, {
            docType: '06',
            referencedCufe: originalInvoice.cufe,
          }).catch((err) =>
            console.warn('E-Factura nota de crédito deferred:', err?.message || err),
          );
        }
      } catch (ncErr) {
        console.warn('Could not trigger nota de crédito:', ncErr);
      }

      // 8. Update local state
      actions.addOrder(refundOrder);
      actions.updateOrderStatus(originalOrder.id, 'refunded');

      return refundOrder;
    } catch (err) {
      console.error('Error creating refund:', err);
      throw err;
    }
  };

  // Helper to reverse loyalty transactions on refund
  const reverseLoyaltyTransactions = async (customerId, transactions, refundOrderId) => {
    // Calculate what needs to be reversed
    let pointsToRestore = 0;      // Points that were redeemed (add back)
    let pointsToSubtract = 0;     // Points that were earned (subtract)
    let washPunchesToSubtract = 0;
    let dryPunchesToSubtract = 0;
    let freeWashesToRestore = 0;  // Free washes that were used (add back)
    let freeDrysToRestore = 0;    // Free drys that were used (add back)
    let freeWashesToSubtract = 0; // Free washes that were earned (subtract)
    let freeDrysToSubtract = 0;   // Free drys that were earned (subtract)

    transactions.forEach(tx => {
      switch (tx.transaction_type) {
        case 'points_earned':
          pointsToSubtract += Math.abs(tx.points_amount || 0);
          break;
        case 'points_redeemed':
          pointsToRestore += Math.abs(tx.points_amount || 0);
          break;
        case 'punch_wash':
          washPunchesToSubtract += Math.abs(tx.punch_count || 0);
          break;
        case 'punch_dry':
          dryPunchesToSubtract += Math.abs(tx.punch_count || 0);
          break;
        case 'redeem_free_wash':
          freeWashesToRestore += Math.abs(tx.punch_count || 0);
          break;
        case 'redeem_free_dry':
          freeDrysToRestore += Math.abs(tx.punch_count || 0);
          break;
        case 'free_wash_earned':
          freeWashesToSubtract += Math.abs(tx.punch_count || 0);
          break;
        case 'free_dry_earned':
          freeDrysToSubtract += Math.abs(tx.punch_count || 0);
          break;
      }
    });

    // Get customer loyalty record
    const { data: loyaltyData, error: loyaltyError } = await supabase
      .from('customer_loyalty')
      .select('*')
      .eq('customer_id', customerId)
      .single();

    if (loyaltyError || !loyaltyData) {
      console.warn('No loyalty record found for customer');
      return;
    }

    const loyalty = loyaltyData;

    // Calculate new values
    const newPointsBalance = Math.max(0, (loyalty.points_balance || 0) - pointsToSubtract + pointsToRestore);
    const newTotalPointsEarned = Math.max(0, (loyalty.total_points_earned || 0) - pointsToSubtract);
    const newTotalPointsRedeemed = Math.max(0, (loyalty.total_points_redeemed || 0) - pointsToRestore);
    
    const newWashPunches = Math.max(0, (loyalty.wash_punches || 0) - washPunchesToSubtract);
    const newDryPunches = Math.max(0, (loyalty.dry_punches || 0) - dryPunchesToSubtract);
    
    const newPendingFreeWashes = Math.max(0, (loyalty.pending_free_washes || 0) - freeWashesToSubtract + freeWashesToRestore);
    const newPendingFreeDrys = Math.max(0, (loyalty.pending_free_drys || 0) - freeDrysToSubtract + freeDrysToRestore);
    
    const newTotalFreeWashesEarned = Math.max(0, (loyalty.total_free_washes_earned || 0) - freeWashesToSubtract);
    const newTotalFreeDrysEarned = Math.max(0, (loyalty.total_free_drys_earned || 0) - freeDrysToSubtract);
    const newTotalFreeWashesRedeemed = Math.max(0, (loyalty.total_free_washes_redeemed || 0) - freeWashesToRestore);
    const newTotalFreeDrysRedeemed = Math.max(0, (loyalty.total_free_drys_redeemed || 0) - freeDrysToRestore);

    // Update loyalty record
    const { error: updateError } = await supabase
      .from('customer_loyalty')
      .update({
        points_balance: newPointsBalance,
        total_points_earned: newTotalPointsEarned,
        total_points_redeemed: newTotalPointsRedeemed,
        wash_punches: newWashPunches,
        dry_punches: newDryPunches,
        pending_free_washes: newPendingFreeWashes,
        pending_free_drys: newPendingFreeDrys,
        total_free_washes_earned: newTotalFreeWashesEarned,
        total_free_drys_earned: newTotalFreeDrysEarned,
        total_free_washes_redeemed: newTotalFreeWashesRedeemed,
        total_free_drys_redeemed: newTotalFreeDrysRedeemed,
        updated_at: new Date().toISOString(),
      })
      .eq('id', loyalty.id);

    if (updateError) {
      console.error('Error updating loyalty record:', updateError);
      throw updateError;
    }

    // Log reversal transactions
    const reversalNotes = [];
    if (pointsToSubtract > 0) reversalNotes.push(`-B/${pointsToSubtract.toFixed(2)} puntos ganados`);
    if (pointsToRestore > 0) reversalNotes.push(`+B/${pointsToRestore.toFixed(2)} puntos restaurados`);
    if (washPunchesToSubtract > 0) reversalNotes.push(`-${washPunchesToSubtract} sellos lavado`);
    if (dryPunchesToSubtract > 0) reversalNotes.push(`-${dryPunchesToSubtract} sellos secado`);
    if (freeWashesToRestore > 0) reversalNotes.push(`+${freeWashesToRestore} lavados gratis restaurados`);
    if (freeDrysToRestore > 0) reversalNotes.push(`+${freeDrysToRestore} secados gratis restaurados`);
    if (freeWashesToSubtract > 0) reversalNotes.push(`-${freeWashesToSubtract} lavados gratis ganados`);
    if (freeDrysToSubtract > 0) reversalNotes.push(`-${freeDrysToSubtract} secados gratis ganados`);

    if (reversalNotes.length > 0) {
      await supabase
        .from('loyalty_transactions')
        .insert({
          customer_id: customerId,
          store_id: storeId,
          order_id: refundOrderId,
          transaction_type: 'manual_adjustment',
          points_amount: pointsToRestore - pointsToSubtract,
          punch_count: -(washPunchesToSubtract + dryPunchesToSubtract) + (freeWashesToRestore + freeDrysToRestore),
          balance_before: loyalty.points_balance,
          balance_after: newPointsBalance,
          notes: `REEMBOLSO: ${reversalNotes.join(', ')}`,
        });
    }

    console.log('Loyalty reversed:', {
      pointsSubtracted: pointsToSubtract,
      pointsRestored: pointsToRestore,
      washPunchesSubtracted: washPunchesToSubtract,
      dryPunchesSubtracted: dryPunchesToSubtract,
      freeWashesRestored: freeWashesToRestore,
      freeDrysRestored: freeDrysToRestore,
    });
  };

  // Search orders in database (for finding historical orders)
  const searchOrders = async (query, limit = 50) => {
    if (!storeId || !query || query.length < 2) return [];
    
    try {
      const url = import.meta.env.SUPABASE_URL;
      
      // Sanitize before interpolating into the PostgREST filter/URL (injection),
      // then URL-encode the value.
      const searchQuery = sanitizeSearchTerm(query).toLowerCase();
      if (!searchQuery) return [];
      const enc = encodeURIComponent(searchQuery);

      // Build the query - search legacy_order_number, order_number, or customer_name
      let fetchUrl = `${url}/rest/v1/orders?store_id=eq.${storeId}&order=created_at.desc&limit=${limit}`;

      // Use OR filter for multiple fields
      if (searchQuery.startsWith('cc')) {
        // Search legacy order numbers
        fetchUrl += `&legacy_order_number=ilike.*${enc}*`;
      } else if (/^\d+$/.test(searchQuery)) {
        // Search by order number
        fetchUrl += `&or=(order_number.eq.${enc},legacy_order_number.ilike.*${enc}*)`;
      } else {
        // Search by customer name
        fetchUrl += `&customer_name=ilike.*${enc}*`;
      }
      
      const response = await fetch(fetchUrl, {
        headers: await authHeaders()
      });
      
      if (response.ok) {
        return await response.json();
      }
      return [];
    } catch (err) {
      console.error('Error searching orders:', err);
      return [];
    }
  };

  // Server-side customer search (trgm-indexed). Replaces filtering the full
  // eagerly-loaded customer list in memory — only ~recent customers are kept in
  // state; this covers the whole table on demand.
  const searchCustomers = async (query, limit = 25) => {
    if (!storeId || !query || query.trim().length < 2) return [];
    const q = sanitizeSearchTerm(query).trim();
    if (!q) return [];
    try {
      // RPC matches the concatenated "first last company" + phone, so multi-word
      // full-name queries work (trgm-indexed). RLS still scopes to the store.
      const { data, error } = await supabase.rpc('search_customers', {
        p_store_id: storeId,
        p_q: q,
        p_limit: limit,
      });
      if (error) throw error;
      return data || [];
    } catch (err) {
      console.error('Error searching customers:', err);
      return [];
    }
  };

  // Load more orders (pagination) - returns orders for caller to merge
  const loadMoreOrders = async (offset = 0, limit = 500) => {
    if (!storeId) return [];
    
    try {
      const url = import.meta.env.SUPABASE_URL;
      
      const fetchUrl = `${url}/rest/v1/orders?store_id=eq.${storeId}&order=created_at.desc&limit=${limit}&offset=${offset}`;
      
      const response = await fetch(fetchUrl, {
        headers: await authHeaders()
      });
      
      if (response.ok) {
        return await response.json();
      }
      return [];
    } catch (err) {
      console.error('Error loading more orders:', err);
      return [];
    }
  };

  // Load orders for a specific customer (for customer history)
  const loadCustomerOrders = async (customerId, limit = 100) => {
    if (!storeId || !customerId) return [];
    
    try {
      const url = import.meta.env.SUPABASE_URL;
      
      const fetchUrl = `${url}/rest/v1/orders?store_id=eq.${storeId}&customer_id=eq.${customerId}&order=created_at.desc&limit=${limit}`;
      
      const response = await fetch(fetchUrl, {
        headers: await authHeaders()
      });
      
      if (response.ok) {
        return await response.json();
      }
      return [];
    } catch (err) {
      console.error('Error loading customer orders:', err);
      return [];
    }
  };

  return {
    isLoading,
    error,
    storeId,
    reload: () => {
      loadedRef.current = false;
      loadData();
    },
    addOrder,
    settleOrder,
    updateOrderStatus,
    sendPickupReminder,
    getOrderDetails,
    createRefund,
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
    // Order search and pagination
    searchOrders,
    searchCustomers,
    loadMoreOrders,
    loadCustomerOrders,
  };
}

export default useDataLoader;
