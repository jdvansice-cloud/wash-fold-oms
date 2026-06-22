// DGI / efacturapty enumerations and the defaults the builder applies.

/** tipoDocumento */
export const DOC_TYPE = {
  FACTURA: '01',
  NOTA_CREDITO: '06',
  NOTA_DEBITO: '07',
} as const;
export type DocType = (typeof DOC_TYPE)[keyof typeof DOC_TYPE];

/** tipoReceptorFe */
export const RECEPTOR_TYPE = {
  CONTRIBUYENTE: '01',
  CONSUMIDOR_FINAL: '02',
  GOBIERNO: '03',
  EXTRANJERO: '04',
} as const;

/** tasaITBMSAplicable */
export const ITBMS_RATE_CODE = {
  EXENTO: '00',
  SEVEN: '01', // 7%  — the standard rate
  TEN: '02', // 10%
  FIFTEEN: '03', // 15%
} as const;

/** tipoContribuyente for an RUC receptor. */
export const TIPO_CONTRIBUYENTE = {
  NATURAL: 1,
  JURIDICO: 2,
} as const;

/**
 * Fixed datosGenerales values for a normal internal-operation sale.
 * (tipoOperacion=venta, destinoOperacion=Panamá, generación CAFE estándar.)
 */
export const DATOS_GENERALES_DEFAULTS = {
  tipoEmision: '01', // emisión normal
  naturalezaOperacion: '01', // venta
  tipoOperacion: 1,
  destinoOperacion: 1, // Panamá
  formatoGeneracionCafe: 1,
  maneraEntregaCafe: 1,
  envioContenedorReceptor: 1,
  procesoGeneracionFe: 1,
} as const;

export const DEFAULT_PUNTO_FACTURACION = '001';
export const DEFAULT_PAIS = 'PA';

/** tiempoPago: 1 = contado (paid immediately). */
export const TIEMPO_PAGO_CONTADO = 1;

/**
 * Maps an app payment-method name (or an already-valid DGI code) to a DGI
 * `formaPago` code. Unknown methods fall back to "99" (otro).
 */
const PAYMENT_FORMA_BY_KEYWORD: Array<[RegExp, string]> = [
  [/efectivo|cash/i, '02'],
  [/d[eé]bito|debit/i, '04'],
  [/cr[eé]dito a plazo|a plazo|por cobrar|fiado/i, '01'],
  [/tarjeta|card|visa|master|clave/i, '03'],
  [/cheque|check/i, '05'],
];

export function mapPaymentForma(method: string | undefined | null): string {
  const value = (method ?? '').trim();
  if (/^\d{2}$/.test(value)) return value; // already a DGI code
  for (const [re, code] of PAYMENT_FORMA_BY_KEYWORD) {
    if (re.test(value)) return code;
  }
  return '99';
}

/** Maps an ITBMS percentage rate to its DGI code. */
export function itbmsRateCode(ratePercent: number): string {
  switch (Math.round(ratePercent)) {
    case 0:
      return ITBMS_RATE_CODE.EXENTO;
    case 7:
      return ITBMS_RATE_CODE.SEVEN;
    case 10:
      return ITBMS_RATE_CODE.TEN;
    case 15:
      return ITBMS_RATE_CODE.FIFTEEN;
    default:
      return ITBMS_RATE_CODE.SEVEN;
  }
}
