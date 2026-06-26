export type IdType = 'cedula' | 'passport' | 'ruc';

/** Reason a customer is ITBMS-exempt (exonerado). */
export type TaxExemptReason = 'diplomatic' | 'public_entity' | 'ngo' | 'other';

export interface CustomerPreferences {
  scent?: string;
  softener?: string;
}

/** A scanned proof document attached to a customer (e.g. exemption credential). */
export interface CustomerDocument {
  id: string;
  customer_id: string;
  store_id?: string;
  path: string;
  label?: string;
  doc_type?: string;
  uploaded_by?: string;
  created_at: string;
}

export interface Customer {
  id: string;
  store_id: string;
  first_name: string;
  last_name?: string;
  email?: string;
  phone?: string;
  phone_country?: string;
  address_street?: string;
  address_building?: string;
  address_corregimiento?: string;
  address_district?: string;
  address_province?: string;
  id_type?: IdType;
  id_number?: string;
  company_name?: string;
  ruc?: string;
  dv?: string;
  can_be_invoiced: boolean;
  /** ITBMS-exempt (exonerado). Zeroes tax on this customer's orders. */
  tax_exempt?: boolean;
  tax_exempt_reason?: TaxExemptReason;
  /** Número de oficio / resolución / nota de exoneración. */
  tax_exempt_doc_number?: string;
  /** Issuing authority (MIRE/Cancillería for diplomats, MEF/DGI for entities). */
  tax_exempt_authority?: string;
  tax_exempt_issued_at?: string;
  tax_exempt_expires_at?: string;
  account_balance: number;
  preferences?: CustomerPreferences;
  notes?: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface CreateCustomerInput {
  store_id: string;
  first_name: string;
  last_name: string;
  phone: string;
  phone_country?: string;
  email?: string;
  address_street?: string;
  address_building?: string;
  address_corregimiento?: string;
  address_district?: string;
  address_province?: string;
  id_type?: IdType;
  id_number?: string;
  company_name?: string;
  ruc?: string;
  dv?: string;
  tax_exempt?: boolean;
  tax_exempt_reason?: TaxExemptReason;
  tax_exempt_doc_number?: string;
  tax_exempt_authority?: string;
  tax_exempt_issued_at?: string;
  tax_exempt_expires_at?: string;
  notes?: string;
  preferences?: CustomerPreferences;
}

export type UpdateCustomerInput = Partial<CreateCustomerInput> & { id: string };
