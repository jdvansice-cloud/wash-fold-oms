// POST /api/orders/create
//
// Server-authoritative order creation. The POS posts the assembled cart; the
// server re-validates every line's unit price + line total against the catalog
// (anti-tamper) and applies aggregate sanity bounds, then inserts the order via
// the service-role key. order_number is assigned by the DB (SERIAL). Auth and
// company/store ownership are derived from the session — never the body.
//
// Why validate-not-recompute: the exact total depends on order-level inputs
// (free services, promotions) that don't round-trip losslessly, so a full
// re-derivation risks rejecting legitimate sales. Validating that prices and
// line totals match the catalog (the realistic staff attack) is strict and
// false-positive-free.

import {
  authenticateStaff,
  assertStoreInCompany,
  getAdmin,
  sendError,
  HttpError,
} from '../efactura/_shared.js';

const round2 = (n: number) => Math.round((Number(n) || 0) * 100) / 100;

export default async function handler(req: any, res: any) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const admin = getAdmin();
    const { companyId } = await authenticateStaff(admin, req);
    const o = req.body || {};
    if (!o.store_id) throw new HttpError(400, 'Missing store_id');
    await assertStoreInCompany(admin, o.store_id, companyId);

    const items: any[] = Array.isArray(o.items) ? o.items : [];
    if (items.length === 0) throw new HttpError(400, 'Order has no items');

    // --- Authoritative product prices ---
    const productIds = [...new Set(items.map((i) => i.product?.id).filter(Boolean))];
    const priceById = new Map<string, { price: number; express_price: number; pricing_type: string; product_type: string; is_taxable: boolean }>();
    if (productIds.length) {
      const { data: products } = await admin
        .from('products')
        .select('id, price, express_price, pricing_type, product_type, is_taxable, store_id')
        .in('id', productIds)
        .eq('store_id', o.store_id);
      for (const p of products || []) {
        priceById.set(p.id, {
          price: Number(p.price) || 0,
          express_price: Number(p.express_price) || 0,
          pricing_type: p.pricing_type || 'quantity',
          product_type: p.product_type || 'service',
          is_taxable: p.is_taxable !== false,
        });
      }
    }

    const isExpress = !!o.is_express;
    const PRICE_TOL = 0.011;
    const LINE_TOL = 0.02;
    let grossProducts = 0;
    let grossDelivery = 0;

    for (const it of items) {
      const pid = it.product?.id;
      const meta = pid ? priceById.get(pid) : undefined;
      const qty = Number(it.quantity) || 0;
      const weight = Number(it.totalWeight) || 0;
      const unit = Number(it.unitPrice) || 0;
      const line = Number(it.lineTotal) || 0;

      if (meta) {
        // Unit price must match the catalog (regular or express).
        const expectedUnit = isExpress && meta.express_price ? meta.express_price : meta.price;
        if (Math.abs(unit - expectedUnit) > PRICE_TOL) {
          throw new HttpError(409, `Precio del ítem alterado (esperado B/.${expectedUnit.toFixed(2)})`);
        }
        // Line total must match unit × (weight | quantity).
        const basisQty = meta.pricing_type === 'weight' && weight > 0 ? weight : qty;
        const expectedLine = round2(expectedUnit * basisQty);
        if (Math.abs(line - expectedLine) > LINE_TOL) {
          throw new HttpError(409, `Total de línea alterado (esperado B/.${expectedLine.toFixed(2)})`);
        }
        if (meta.product_type === 'delivery') grossDelivery += line;
        else grossProducts += line;
      } else {
        // No catalog product (legacy/manual line) — trust but still bound below.
        grossProducts += line;
      }
    }

    // --- Aggregate sanity bounds (catch absurd forged totals) ---
    const subtotal = round2(o.subtotal);
    const discount = round2(o.discount_amount);
    const tax = round2(o.tax_amount);
    const total = round2(o.total);
    const delivery = round2(o.delivery_charge);
    const grossAll = round2(grossProducts + (grossDelivery || delivery));

    const { data: company } = await admin.from('companies').select('itbms_rate').eq('id', companyId).maybeSingle();
    const maxRate = (Number(company?.itbms_rate) || 7) / 100;

    if (discount < -0.01 || tax < -0.01 || total < -0.01) {
      throw new HttpError(409, 'Totales inválidos (negativos)');
    }
    // Total can never exceed gross + delivery + max tax (discounts only reduce).
    if (total > grossAll * (1 + maxRate) + 0.02) {
      throw new HttpError(409, 'Total excede el máximo permitido para estos artículos');
    }
    // Tax cannot exceed the max rate on the gross.
    if (tax > grossAll * maxRate + 0.02) {
      throw new HttpError(409, 'ITBMS excede la tasa máxima');
    }
    // Pay-on-pickup orders are created UNPAID (collected at pickup), so they
    // legitimately carry no payments. Every other order's tenders must cover it.
    const paymentStatus = o.payment_status === 'unpaid' ? 'unpaid' : 'paid';
    if (paymentStatus !== 'unpaid') {
      const paid = (Array.isArray(o.payments) ? o.payments : []).reduce((s: number, p: any) => s + (Number(p.amount) || 0), 0);
      if (round2(paid) + 0.02 < total) {
        throw new HttpError(409, 'Los pagos no cubren el total');
      }
    }

    // --- Insert (service-role). order_number from SERIAL. ---
    const { data: order, error: orderErr } = await admin
      .from('orders')
      .insert({
        store_id: o.store_id,
        customer_id: o.customer_id || null,
        customer_name: o.customer_name || null,
        is_walk_in: !!o.is_walk_in,
        status: 'pending',
        is_express: isExpress,
        subtotal, discount_amount: discount, delivery_charge: delivery,
        tax_amount: tax, total,
        total_weight: round2(o.total_weight), total_bags: o.total_bags || 0, total_pieces: o.total_pieces || 0,
        notes: o.notes || null,
        promised_date: o.promised_date || null,
        payment_status: paymentStatus,
        billing_type: ['immediate', 'pickup', 'account'].includes(o.billing_type) ? o.billing_type : 'immediate',
      })
      .select()
      .single();
    if (orderErr || !order) throw new HttpError(500, `No se pudo crear la orden: ${orderErr?.message}`);

    try {
      if (items.length) {
        const rows = items.map((it) => ({
          order_id: order.id,
          product_id: it.product?.id || null,
          product_name: it.product?.name || null,
          quantity: it.quantity,
          total_weight: it.totalWeight || 0,
          bags: it.bags || 0,
          pieces: it.pieces || 0,
          unit_price: it.unitPrice,
          line_total: it.lineTotal,
          weight_entries: it.weightEntries || [],
          // Persisted per line for generic (product_id NULL) items — the factura
          // has no product row to read the tax flag from.
          is_taxable: it.product?.is_taxable !== false,
        }));
        const { error } = await admin.from('order_items').insert(rows);
        if (error) throw error;
      }
      const payments = (Array.isArray(o.payments) ? o.payments : []).map((p: any) => ({
        order_id: order.id,
        payment_method: p.method,
        amount: p.amount,
        reference: p.reference || null,
        change_amount: p.changeGiven || 0,
      }));
      if (payments.length) {
        const { error } = await admin.from('payments').insert(payments);
        if (error) throw error;
      }
    } catch (childErr: any) {
      // Best-effort cleanup so we don't leave an order without its lines/payments.
      await admin.from('orders').delete().eq('id', order.id);
      throw new HttpError(500, `No se pudieron guardar los detalles: ${childErr?.message}`);
    }

    return res.status(200).json({ success: true, order });
  } catch (err) {
    sendError(res, err);
  }
}
