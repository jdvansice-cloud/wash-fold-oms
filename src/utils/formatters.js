// Formatting utilities for Wash & Fold OMS

/**
 * Format currency in Panamanian Balboas
 */
export const formatCurrency = (amount) => {
  if (typeof amount !== 'number' || isNaN(amount)) {
    return 'B/0.00';
  }
  return `B/${amount.toFixed(2)}`;
};

/**
 * Format date for display
 */
export const formatDate = (dateStr, options = {}) => {
  const date = new Date(dateStr);
  const defaultOptions = {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    ...options,
  };
  return new Intl.DateTimeFormat('es-PA', defaultOptions).format(date);
};

/**
 * Format time for display
 */
export const formatTime = (dateStr) => {
  const date = new Date(dateStr);
  return new Intl.DateTimeFormat('es-PA', {
    hour: '2-digit',
    minute: '2-digit',
  }).format(date);
};

/**
 * Format date and time together
 */
export const formatDateTime = (dateStr) => {
  return `${formatDate(dateStr)} ${formatTime(dateStr)}`;
};

/**
 * Format relative time (e.g., "2 hours ago")
 */
export const formatRelativeTime = (dateStr) => {
  const date = new Date(dateStr);
  const now = new Date();
  const diffMs = now - date;
  const diffMins = Math.floor(diffMs / (1000 * 60));
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
  
  if (diffMins < 1) return 'Ahora';
  if (diffMins < 60) return `Hace ${diffMins} min`;
  if (diffHours < 24) return `Hace ${diffHours}h`;
  if (diffDays === 1) return 'Ayer';
  return formatDate(dateStr);
};

/**
 * Format phone number for Panama
 */
export const formatPhoneNumber = (countryCode, phone) => {
  if (!phone) return '';
  // Format as XXXX-XXXX for Panama numbers
  const cleaned = phone.replace(/\D/g, '');
  if (cleaned.length === 8) {
    return `${countryCode} ${cleaned.slice(0, 4)}-${cleaned.slice(4)}`;
  }
  return `${countryCode} ${phone}`;
};

/**
 * Format weight in kg
 */
export const formatWeight = (weight) => {
  if (typeof weight !== 'number' || isNaN(weight)) {
    return '0.00 kg';
  }
  return `${weight.toFixed(2)} kg`;
};

/**
 * Format percentage
 */
export const formatPercentage = (value, decimals = 0) => {
  if (typeof value !== 'number' || isNaN(value)) {
    return '0%';
  }
  return `${value.toFixed(decimals)}%`;
};

/**
 * Generate order number display
 */
export const formatOrderNumber = (orderNumber) => {
  return `#${orderNumber}`;
};

/**
 * Truncate text with ellipsis
 */
export const truncateText = (text, maxLength = 50) => {
  if (!text || text.length <= maxLength) return text;
  return text.slice(0, maxLength) + '...';
};

/**
 * Get initials from name
 */
export const getInitials = (firstName, lastName) => {
  const first = firstName?.[0]?.toUpperCase() || '';
  const last = lastName?.[0]?.toUpperCase() || '';
  return `${first}${last}`;
};

/**
 * Validate Panama cedula format
 */
export const isValidCedula = (cedula) => {
  // Basic validation for Panama cedula formats
  // Examples: 8-123-4567, PE-12-3456, E-12-34567
  const patterns = [
    /^\d{1,2}-\d{1,4}-\d{1,6}$/, // Regular: 8-123-4567
    /^PE-\d{1,4}-\d{1,6}$/i,     // Panama Este: PE-12-3456
    /^E-\d{1,4}-\d{1,6}$/i,      // Extranjero: E-12-34567
    /^N-\d{1,4}-\d{1,6}$/i,      // Naturalizado: N-12-34567
    /^[A-Z]{1,2}-\d{1,4}-\d{1,6}$/i, // Other prefixes
  ];
  
  return patterns.some(pattern => pattern.test(cedula));
};

/**
 * Validate Panama RUC format
 */
export const isValidRUC = (ruc) => {
  // Basic RUC validation
  // Example: 155737034-2-2023
  const pattern = /^\d+-\d+-\d+$/;
  return pattern.test(ruc);
};

/**
 * Calculate hours until a date
 */
export const hoursUntil = (dateStr) => {
  const date = new Date(dateStr);
  const now = new Date();
  return (date - now) / (1000 * 60 * 60);
};

/**
 * Generate a simple unique ID
 */
export const generateId = (prefix = 'id') => {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
};
