// Consolidated formatting utilities for Wash & Fold OMS
// Merges functions from helpers.js and formatters.js into a single source of truth

/**
 * Format currency in Panamanian Balboas (B/)
 */
export function formatCurrency(amount: number | null | undefined): string {
  if (typeof amount !== 'number' || isNaN(amount)) {
    return 'B/0.00';
  }
  return `B/${amount.toFixed(2)}`;
}

/**
 * Format date for display using es-PA locale
 */
export function formatDate(
  dateStr: string | Date | null | undefined,
  options: Intl.DateTimeFormatOptions = {},
): string {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return '';
  const defaultOptions: Intl.DateTimeFormatOptions = {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    ...options,
  };
  return new Intl.DateTimeFormat('es-PA', defaultOptions).format(date);
}

/**
 * Format time for display
 */
export function formatTime(dateStr: string | Date): string {
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return '';
  return new Intl.DateTimeFormat('es-PA', {
    hour: '2-digit',
    minute: '2-digit',
  }).format(date);
}

/**
 * Format date and time together
 */
export function formatDateTime(dateStr: string | Date): string {
  return `${formatDate(dateStr)} ${formatTime(dateStr)}`;
}

/**
 * Format relative time in Spanish (e.g., "hace 2 horas")
 */
export function formatRelativeTime(dateStr: string | Date | null | undefined): string {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return '';
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffMins = Math.floor(diffMs / 60000);
  const diffHours = Math.floor(diffMins / 60);
  const diffDays = Math.floor(diffHours / 24);

  if (diffMins < 1) return 'Ahora';
  if (diffMins < 60) return `Hace ${diffMins} min`;
  if (diffHours < 24) return `Hace ${diffHours}h`;
  if (diffDays === 1) return 'Ayer';
  if (diffDays < 7) return `Hace ${diffDays}d`;
  return formatDate(dateStr);
}

/**
 * Format phone number for Panama (XXXX-XXXX format)
 */
export function formatPhone(countryCode: string | null | undefined, phone: string | null | undefined): string {
  if (!phone) return '';
  const code = countryCode || '+507';
  const cleaned = phone.replace(/\D/g, '');
  if (cleaned.length === 8) {
    return `${code} ${cleaned.slice(0, 4)}-${cleaned.slice(4)}`;
  }
  return `${code} ${phone}`;
}

/**
 * Format weight in kilograms
 */
export function formatWeight(weight: number | null | undefined): string {
  if (typeof weight !== 'number' || isNaN(weight)) {
    return '0.00 kg';
  }
  return `${weight.toFixed(2)} kg`;
}

/**
 * Format percentage
 */
export function formatPercentage(value: number | null | undefined, decimals = 0): string {
  if (typeof value !== 'number' || isNaN(value)) {
    return '0%';
  }
  return `${value.toFixed(decimals)}%`;
}

/**
 * Format order number for display
 */
export function formatOrderNumber(orderNumber: number | string): string {
  return `#${orderNumber}`;
}

/**
 * Truncate text with ellipsis
 */
export function truncateText(text: string | null | undefined, maxLength = 50): string {
  if (!text || text.length <= maxLength) return text || '';
  return text.slice(0, maxLength) + '...';
}

/**
 * Get initials from a full name string
 */
export function getInitials(name: string | null | undefined): string {
  if (!name) return '?';
  return name
    .split(' ')
    .map((part) => part[0])
    .filter(Boolean)
    .join('')
    .toUpperCase()
    .slice(0, 2);
}

/**
 * Get initials from separate first/last name
 */
export function getInitialsFromParts(firstName?: string | null, lastName?: string | null): string {
  const first = firstName?.[0]?.toUpperCase() || '';
  const last = lastName?.[0]?.toUpperCase() || '';
  return `${first}${last}` || '?';
}

/**
 * Calculate hours until a date (positive = future, negative = past)
 */
export function hoursUntil(dateStr: string | Date | null | undefined): number | null {
  if (!dateStr) return null;
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return null;
  const now = new Date();
  const diffMs = date.getTime() - now.getTime();
  return Math.round((diffMs / (1000 * 60 * 60)) * 10) / 10;
}

/**
 * Check if a date is in the past (overdue)
 */
export function isOverdue(dateStr: string | Date | null | undefined): boolean {
  if (!dateStr) return false;
  return new Date() > new Date(dateStr);
}
