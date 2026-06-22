// Domain types for the Panama E-Factura integration.
// These mirror the `company_efactura_config` and `electronic_invoices` tables
// (see supabase-efactura-migration.sql).

export type EFacturaEnvironment = 'test' | 'prod';

export interface CompanyEFacturaConfig {
  company_id: string;
  /** efacturapty API key. Only ever read server-side; never expose to clients. */
  api_key?: string;
  environment: EFacturaEnvironment;
  punto_facturacion: string;
  default_cpbs_code?: number;
  default_cpbs_code_short?: number;
  enabled: boolean;
  created_at: string;
  updated_at: string;
}

export type EInvoiceStatus =
  | 'pending'
  | 'emitting'
  | 'authorized'
  | 'rejected'
  | 'cancelled';

/** tipoDocumento */
export type EInvoiceDocType = '01' | '06' | '07';

export interface ElectronicInvoice {
  id: string;
  store_id: string;
  order_id?: string;
  refund_id?: string;
  doc_type: EInvoiceDocType;
  environment: EFacturaEnvironment;
  status: EInvoiceStatus;
  cufe?: string;
  protocolo_autorizacion?: string;
  fecha_autorizacion?: string;
  qr_content?: string;
  cafe_pdf_path?: string;
  referenced_cufe?: string;
  request_payload?: unknown;
  response_payload?: unknown;
  error?: string;
  attempts: number;
  emitted_at?: string;
  created_at: string;
  updated_at: string;
}
