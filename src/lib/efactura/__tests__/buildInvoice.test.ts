import { describe, it, expect } from 'vitest';
import {
  buildInvoiceRequest,
  buildReceptor,
  EInvoiceReconciliationError,
  formatPanamaDateTime,
  type BuildInvoiceInput,
  type EInvoiceLine,
} from '../buildInvoice';
import { distributeCents } from '../money';
import { mapPaymentForma, DOC_TYPE, RECEPTOR_TYPE } from '../constants';

const config = { itbmsRate: 7 };
const fixedNow = new Date('2026-06-21T19:05:05.000Z'); // 14:05:05 Panamá

function line(overrides: Partial<EInvoiceLine> = {}): EInvoiceLine {
  return { description: 'Lavado y doblado', quantity: 1, unitPrice: 10, ...overrides };
}

function build(overrides: Partial<BuildInvoiceInput> = {}) {
  return buildInvoiceRequest({
    order: { tax_amount: 0.7, total: 10.7 },
    items: [line()],
    config,
    now: fixedNow,
    ...overrides,
  });
}

describe('formatPanamaDateTime', () => {
  it('renders Panama wall-clock time with a -05:00 offset', () => {
    expect(formatPanamaDateTime(fixedNow)).toBe('2026-06-21T14:05:05-05:00');
  });
});

describe('mapPaymentForma', () => {
  it('maps known methods and passes through DGI codes', () => {
    expect(mapPaymentForma('Efectivo')).toBe('02');
    expect(mapPaymentForma('Tarjeta')).toBe('03');
    expect(mapPaymentForma('Tarjeta de débito')).toBe('04');
    expect(mapPaymentForma('Cheque')).toBe('05');
    expect(mapPaymentForma('02')).toBe('02');
    expect(mapPaymentForma('Yappy')).toBe('99');
    expect(mapPaymentForma('')).toBe('99');
  });
});

describe('distributeCents', () => {
  it('sums exactly to the total with largest-remainder allocation', () => {
    expect(distributeCents(100, [1, 1, 1]).reduce((a, b) => a + b, 0)).toBe(100);
    expect(distributeCents(100, [1, 1, 1])).toEqual([34, 33, 33]);
  });

  it('falls back to the last bucket when all weights are zero', () => {
    expect(distributeCents(50, [0, 0, 0])).toEqual([0, 0, 50]);
  });
});

describe('buildReceptor', () => {
  it('defaults to consumidor final for a walk-in', () => {
    const r = buildReceptor(null);
    expect(r.tipoReceptorFe).toBe(RECEPTOR_TYPE.CONSUMIDOR_FINAL);
    expect(r.paisReceptor).toBe('PA');
    expect(r.nombreRazonReceptor).toBeUndefined();
  });

  it('keeps the name for a named consumidor final (cédula, no RUC)', () => {
    const r = buildReceptor({ first_name: 'Dilia', last_name: 'Valdés', id_type: 'cedula' });
    expect(r.tipoReceptorFe).toBe(RECEPTOR_TYPE.CONSUMIDOR_FINAL);
    expect(r.nombreRazonReceptor).toBe('Dilia Valdés');
  });

  it('builds an RUC contribuyente receptor (jurídico when company set)', () => {
    const r = buildReceptor({
      company_name: 'Lavandería S.A.',
      ruc: '155737034-2-2023',
      dv: '38',
      address_street: 'Calle 50',
      address_province: 'Panamá',
      email: 'pagos@lav.com',
    });
    expect(r.tipoReceptorFe).toBe(RECEPTOR_TYPE.CONTRIBUYENTE);
    expect(r.datosRucReceptor).toEqual({
      tipoContribuyente: 2,
      rucReceptor: '155737034-2-2023',
      digitoVerificador: '38',
    });
    expect(r.nombreRazonReceptor).toBe('Lavandería S.A.');
    expect(r.direccionReceptor).toBe('Calle 50');
    expect(r.ubicacionReceptor?.provincia).toBe('Panamá');
    expect(r.correoElectronicoReceptor).toBe('pagos@lav.com');
  });

  it('uses natural contribuyente when no company name', () => {
    const r = buildReceptor({ first_name: 'Juan', ruc: '8-123-456', dv: '12' });
    expect(r.datosRucReceptor?.tipoContribuyente).toBe(1);
  });

  it('builds a foreign receptor from a passport', () => {
    const r = buildReceptor({ first_name: 'John', id_type: 'passport', id_number: 'X123' });
    expect(r.tipoReceptorFe).toBe(RECEPTOR_TYPE.EXTRANJERO);
    expect(r.grupoIdentificacionExtranjera?.pasaportNumeroIdentificacionExtranjera).toBe('X123');
  });
});

describe('buildInvoiceRequest — structure & defaults', () => {
  it('emits a factura with PAC-owned numbering omitted', () => {
    const inv = build();
    expect(inv.datosGenerales.tipoDocumento).toBe(DOC_TYPE.FACTURA);
    expect(inv.datosGenerales.numeroDocumento).toBeUndefined();
    expect(inv.datosGenerales.puntoFacturacion).toBe('001');
    expect(inv.datosGenerales.fechaEmision).toBe('2026-06-21T14:05:05-05:00');
    expect(inv.datosGenerales.tipoEmision).toBe('01');
  });

  it('defaults to a single cash payment for the full total when none given', () => {
    const inv = build();
    expect(inv.totales.grupoFormasPago).toEqual([{ formaPago: '02', valorCuotaPagada: 10.7 }]);
    expect(inv.totales.sumaValoresRecibidos).toBe(10.7);
  });

  it('supports credit notes via docType', () => {
    const inv = build({ docType: DOC_TYPE.NOTA_CREDITO });
    expect(inv.datosGenerales.tipoDocumento).toBe('06');
  });
});

describe('buildInvoiceRequest — totals reconcile (matches gobierno.json shape)', () => {
  it('two taxable items, no discount', () => {
    const inv = buildInvoiceRequest({
      order: { tax_amount: 7, total: 107 },
      items: [
        line({ description: 'PRODUCTO #1', unitPrice: 5, quantity: 10, lineTotal: 50 }),
        line({ description: 'PRODUCTO #2', unitPrice: 50, quantity: 1, lineTotal: 50 }),
      ],
      config,
      now: fixedNow,
    });
    expect(inv.listaItems[0].grupoPrecios).toMatchObject({
      precioUnitarioTransferencia: 5,
      precioItem: 50,
      sumaPrecioItem: 53.5,
    });
    expect(inv.listaItems[0].grupoITBMS).toEqual({ tasaITBMSAplicable: '01', montoITBMS: 3.5 });
    expect(inv.totales).toMatchObject({
      totalNeto: 100,
      totalITBMS: 7,
      totalGravado: 7,
      valorTotalFactura: 107,
      numeroTotalItems: 2,
      totalTodosItems: 107,
    });
  });
});

describe('buildInvoiceRequest — penny-accurate distribution', () => {
  it('odd ITBMS splits so per-line montos sum to order.tax_amount', () => {
    // Three equal taxable lines, tax 1.00 -> 0.34 / 0.33 / 0.33
    const inv = buildInvoiceRequest({
      order: { tax_amount: 1.0, total: 16.0 },
      items: [
        line({ unitPrice: 5, quantity: 1, lineTotal: 5 }),
        line({ unitPrice: 5, quantity: 1, lineTotal: 5 }),
        line({ unitPrice: 5, quantity: 1, lineTotal: 5 }),
      ],
      config,
      now: fixedNow,
    });
    const montos = inv.listaItems.map((i) => i.grupoITBMS.montoITBMS);
    expect(montos).toEqual([0.34, 0.33, 0.33]);
    expect(montos.reduce((a, b) => a + b, 0)).toBeCloseTo(1.0, 5);
    expect(inv.totales.totalITBMS).toBe(1.0);
  });

  it('exempt lines get tasa 00 and all tax lands on the taxable line', () => {
    const inv = buildInvoiceRequest({
      order: { tax_amount: 0.7, total: 30.7 },
      items: [
        line({ description: 'Servicio gravado', unitPrice: 10, lineTotal: 10, isTaxable: true }),
        line({ description: 'Gift card', unitPrice: 20, lineTotal: 20, isTaxable: false }),
      ],
      config,
      now: fixedNow,
    });
    expect(inv.listaItems[0].grupoITBMS).toEqual({ tasaITBMSAplicable: '01', montoITBMS: 0.7 });
    expect(inv.listaItems[1].grupoITBMS).toEqual({ tasaITBMSAplicable: '00', montoITBMS: 0 });
    expect(inv.totales.valorTotalFactura).toBe(30.7);
  });
});

describe('buildInvoiceRequest — discount distribution', () => {
  it('splits an order discount across lines and records per-unit descuento', () => {
    // gross 50 + 50 = 100, discount 50 -> net 50, tax on net (7% = 3.5), total 53.5
    const inv = buildInvoiceRequest({
      order: { discount_amount: 50, tax_amount: 3.5, total: 53.5 },
      items: [
        line({ unitPrice: 5, quantity: 10, lineTotal: 50 }),
        line({ unitPrice: 50, quantity: 1, lineTotal: 50 }),
      ],
      config,
      now: fixedNow,
    });
    expect(inv.totales.totalNeto).toBe(50);
    expect(inv.totales.totalDescuento).toBeUndefined(); // per-item discount model
    expect(inv.totales.valorTotalFactura).toBe(53.5);
    // Each line discounted by 25 -> net 25
    expect(inv.listaItems[0].grupoPrecios.precioItem).toBe(25);
    expect(inv.listaItems[0].grupoPrecios.descuento).toBe(2.5); // 25 / 10 units
    expect(inv.listaItems[1].grupoPrecios.descuento).toBe(25); // 25 / 1 unit
  });
});

describe('buildInvoiceRequest — absorbs sub-cent rounding drift', () => {
  it('reconciles an order whose subtotal+tax differs from total by a cent (order #3498)', () => {
    // Real case: gross 5.61 + 9.35, discount 1.50 -> net 13.46, tax 0.94,
    // but total was charged as 14.41 (13.46 + 0.94 = 14.40). Total is king.
    const inv = buildInvoiceRequest({
      order: { discount_amount: 1.5, tax_amount: 0.94, total: 14.41 },
      items: [
        line({ description: 'Gorras', unitPrice: 5.61, quantity: 1, lineTotal: 5.61 }),
        line({ description: 'Zapatillas', unitPrice: 9.35, quantity: 1, lineTotal: 9.35 }),
      ],
      payments: [{ method: 'Efectivo', amount: 14.41, change: 5.59 }], // tendered 20.00
      config,
      now: fixedNow,
    });
    expect(inv.totales.valorTotalFactura).toBe(14.41);
    expect(inv.totales.totalNeto + (inv.totales.totalITBMS ?? 0)).toBeCloseTo(14.41, 5);
    // DGI vuelto invariant holds even with the absorbed rounding cent.
    expect(inv.totales.vueltoEntregado).toBeCloseTo(
      inv.totales.sumaValoresRecibidos - inv.totales.valorTotalFactura,
      5,
    );
    // Each line stays self-consistent: precioItem == unitPrice - descuento (qty 1).
    for (const it of inv.listaItems) {
      const desc = it.grupoPrecios.descuento ?? 0;
      expect(it.grupoPrecios.precioItem).toBeCloseTo(
        it.grupoPrecios.precioUnitarioTransferencia - desc * it.cantidadProductoServicio,
        5,
      );
      expect(it.grupoPrecios.sumaPrecioItem).toBeCloseTo(
        it.grupoPrecios.precioItem + it.grupoITBMS.montoITBMS,
        5,
      );
    }
  });
});

describe('buildInvoiceRequest — weight-priced line (cantidad = weight)', () => {
  it('derives a per-kg unit price so DGI rule 2053 holds (order #3501 item)', () => {
    // Lava y Dobla: 1.40 kg @ 2.34/kg = 3.28. cantidad is the weight, not bags.
    const inv = buildInvoiceRequest({
      order: { tax_amount: 0.23, total: 3.51 },
      items: [line({ description: 'Lava y Dobla', quantity: 1.4, unitPrice: 2.34, lineTotal: 3.28 })],
      config,
      now: fixedNow,
    });
    const it0 = inv.listaItems[0];
    expect(it0.cantidadProductoServicio).toBe(1.4);
    // Unit price is the 2-decimal per-kg rate.
    expect(it0.grupoPrecios.precioUnitarioTransferencia).toBe(2.34);
    expect(it0.grupoPrecios.precioUnitarioTransferencia * 1.4).toBeCloseTo(3.28, 2);
    // DGI 2053: precioItem === (precioUnitario − descuento) × cantidad.
    const desc = it0.grupoPrecios.descuento ?? 0;
    expect(it0.grupoPrecios.precioItem).toBeCloseTo(
      (it0.grupoPrecios.precioUnitarioTransferencia - desc) * it0.cantidadProductoServicio,
      2,
    );
  });
});

describe('buildInvoiceRequest — guards', () => {
  it('throws when items do not reconcile to order.total', () => {
    expect(() =>
      buildInvoiceRequest({
        order: { tax_amount: 0.7, total: 99.99 }, // total ignores the line
        items: [line({ unitPrice: 10, lineTotal: 10 })],
        config,
        now: fixedNow,
      }),
    ).toThrow(EInvoiceReconciliationError);
  });

  it('throws on an empty item list', () => {
    expect(() =>
      buildInvoiceRequest({ order: { tax_amount: 0, total: 0 }, items: [], config, now: fixedNow }),
    ).toThrow(EInvoiceReconciliationError);
  });
});

describe('buildInvoiceRequest — payments', () => {
  it('reports tendered value and change per the DGI vuelto rule', () => {
    // Applied 10.70, customer tendered 20.00 (change 9.30).
    const inv = buildInvoiceRequest({
      order: { tax_amount: 0.7, total: 10.7 },
      items: [line()],
      payments: [{ method: 'Efectivo', amount: 10.7, change: 9.3 }],
      config,
      now: fixedNow,
    });
    expect(inv.totales.grupoFormasPago).toEqual([{ formaPago: '02', valorCuotaPagada: 20 }]);
    expect(inv.totales.sumaValoresRecibidos).toBe(20);
    expect(inv.totales.vueltoEntregado).toBe(9.3);
    // DGI invariant: dVuelto === dTotRec − dVTot
    expect(inv.totales.vueltoEntregado).toBeCloseTo(
      inv.totales.sumaValoresRecibidos - inv.totales.valorTotalFactura,
      5,
    );
  });

  it('reports no change when the exact amount is tendered', () => {
    const inv = build({ payments: [{ method: 'Tarjeta', amount: 10.7 }] });
    expect(inv.totales.sumaValoresRecibidos).toBe(10.7);
    expect(inv.totales.vueltoEntregado).toBeUndefined();
  });
});
