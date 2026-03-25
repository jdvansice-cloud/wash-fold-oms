// Consolidated validators for Wash & Fold OMS

/**
 * Validate Panama cedula format
 * Supports: 8-123-4567, PE-12-3456, E-12-34567, N-12-34567, AV-12-34567
 */
export function isValidCedula(cedula: string | null | undefined): boolean {
  if (!cedula) return false;
  const patterns = [
    /^\d{1,2}-\d{1,4}-\d{1,6}$/, // Regular: 8-123-4567
    /^PE-\d{1,4}-\d{1,6}$/i, // Panama Este
    /^E-\d{1,4}-\d{1,6}$/i, // Extranjero
    /^N-\d{1,4}-\d{1,6}$/i, // Naturalizado
    /^[A-Z]{1,2}-\d{1,4}-\d{1,6}$/i, // Other prefixes
  ];
  return patterns.some((pattern) => pattern.test(cedula));
}

/**
 * Validate Panama RUC format (e.g., 155737034-2-2023)
 */
export function isValidRUC(ruc: string | null | undefined): boolean {
  if (!ruc) return false;
  return /^\d+-\d+-\d+$/.test(ruc);
}

/**
 * Validate Panama mobile phone number (8 digits, starts with 5 or 6)
 */
export function isValidPanamaPhone(phone: string | null | undefined): boolean {
  if (!phone) return false;
  const cleaned = phone.replace(/\D/g, '');
  return cleaned.length === 8 && (cleaned.startsWith('6') || cleaned.startsWith('5'));
}

/**
 * Basic email validation
 */
export function isValidEmail(email: string | null | undefined): boolean {
  if (!email) return false;
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

/**
 * Generate a temporary unique ID (for client-side use before Supabase insert)
 */
export function generateId(prefix = 'id'): string {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
}
