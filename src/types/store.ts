export interface Company {
  id: string;
  name: string;
  ruc?: string;
  dv?: string;
  address?: string;
  phone?: string;
  logo_url?: string;
  itbms_rate: number;
  default_completion_days: number;
  express_completion_days: number;
  smtp_host?: string;
  smtp_port?: number;
  smtp_user?: string;
  smtp_pass?: string;
  smtp_from_name?: string;
  smtp_from_email?: string;
  smtp_secure?: boolean;
  created_at: string;
  updated_at: string;
}

export interface OpeningHours {
  [day: string]: {
    open: string;
    close: string;
    closed?: boolean;
  };
}

export interface Store {
  id: string;
  company_id: string;
  name: string;
  address?: string;
  phone?: string;
  geolocation?: { lat: number; lng: number };
  opening_hours?: OpeningHours;
  is_active: boolean;
  created_at: string;
  updated_at: string;
  company?: Company;
}
