export type IdType = 'cedula' | 'passport' | 'ruc';

export interface CustomerPreferences {
  scent?: string;
  softener?: string;
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
  notes?: string;
  preferences?: CustomerPreferences;
}

export type UpdateCustomerInput = Partial<CreateCustomerInput> & { id: string };
