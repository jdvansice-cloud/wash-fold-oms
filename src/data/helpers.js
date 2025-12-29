// Helpers and Configuration for Wash & Fold OMS
// NO sample data - all data comes from Supabase

// ============================================
// SERVICE SETTINGS (defaults, loaded from Supabase)
// ============================================
export const defaultServiceSettings = {
  default_completion_days: 1,
  express_completion_days: 0,
  itbms_rate: 7.00,
};

// ============================================
// STATUS CONFIGURATION (UI display)
// ============================================
export const statusConfig = {
  pending: { label: 'Pendiente', color: 'amber', bgClass: 'bg-amber-100', textClass: 'text-amber-700' },
  washing: { label: 'Lavando', color: 'blue', bgClass: 'bg-blue-100', textClass: 'text-blue-700' },
  drying: { label: 'Secando', color: 'cyan', bgClass: 'bg-cyan-100', textClass: 'text-cyan-700' },
  folding: { label: 'Doblando', color: 'indigo', bgClass: 'bg-indigo-100', textClass: 'text-indigo-700' },
  ready: { label: 'Listo', color: 'emerald', bgClass: 'bg-emerald-100', textClass: 'text-emerald-700' },
  completed: { label: 'Completado', color: 'slate', bgClass: 'bg-slate-100', textClass: 'text-slate-600' },
  cancelled: { label: 'Cancelado', color: 'red', bgClass: 'bg-red-100', textClass: 'text-red-700' },
};

// ============================================
// KANBAN WORKFLOW STAGES
// ============================================
export const workflowStages = [
  { id: 'pending', name: 'Por Hacer', statuses: ['pending'] },
  { id: 'washing', name: 'Lavadoras', statuses: ['washing'] },
  { id: 'drying', name: 'Secadoras', statuses: ['drying'] },
  { id: 'folding', name: 'Doblado', statuses: ['folding'] },
  { id: 'ready', name: 'Completada', statuses: ['ready', 'completed'] },
];

// ============================================
// HELPER FUNCTIONS
// ============================================

// Calculate promised date based on express flag
export const calculatePromisedDate = (isExpress = false, settings = defaultServiceSettings) => {
  const date = new Date();
  const daysToAdd = isExpress ? settings.express_completion_days : settings.default_completion_days;
  date.setDate(date.getDate() + daysToAdd);
  date.setHours(12, 0, 0, 0);
  return date;
};

// Generate unique ID (temporary until Supabase handles this)
export const generateId = (prefix = 'id') => {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
};

// Format currency for Panama (Balboa)
export const formatCurrency = (amount) => {
  return `B/${(amount || 0).toFixed(2)}`;
};

// Format phone number for Panama
export const formatPhone = (countryCode, phone) => {
  if (!phone) return '';
  return `${countryCode || '+507'} ${phone}`;
};

// Format date for display
export const formatDate = (dateStr, options = {}) => {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  return new Intl.DateTimeFormat('es-PA', {
    day: '2-digit',
    month: 'short',
    year: options.includeYear ? 'numeric' : undefined,
    hour: options.includeTime ? '2-digit' : undefined,
    minute: options.includeTime ? '2-digit' : undefined,
    ...options,
  }).format(date);
};

// Format relative time (e.g., "hace 2 horas")
export const formatRelativeTime = (dateStr) => {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  const now = new Date();
  const diffMs = now - date;
  const diffMins = Math.floor(diffMs / 60000);
  const diffHours = Math.floor(diffMins / 60);
  const diffDays = Math.floor(diffHours / 24);
  
  if (diffMins < 1) return 'ahora';
  if (diffMins < 60) return `hace ${diffMins} min`;
  if (diffHours < 24) return `hace ${diffHours}h`;
  if (diffDays < 7) return `hace ${diffDays}d`;
  return formatDate(dateStr);
};

// Calculate hours until promised date
export const getHoursUntilDue = (promisedDate) => {
  if (!promisedDate) return null;
  const now = new Date();
  const due = new Date(promisedDate);
  const diffMs = due - now;
  return Math.round(diffMs / (1000 * 60 * 60) * 10) / 10; // 1 decimal place
};

// Check if order is overdue
export const isOverdue = (promisedDate) => {
  if (!promisedDate) return false;
  return new Date() > new Date(promisedDate);
};

// Get initials from name
export const getInitials = (name) => {
  if (!name) return '?';
  return name
    .split(' ')
    .map(part => part[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);
};

// Validate Panama phone number
export const isValidPanamaPhone = (phone) => {
  if (!phone) return false;
  const cleaned = phone.replace(/\D/g, '');
  return cleaned.length === 8 && (cleaned.startsWith('6') || cleaned.startsWith('5'));
};

// Validate Panama cedula format
export const isValidCedula = (cedula) => {
  if (!cedula) return false;
  // Format: X-XXX-XXXX or XX-XXX-XXXX or PE-XXX-XXXX etc.
  const pattern = /^[A-Z0-9]{1,4}-\d{1,4}-\d{1,6}$/i;
  return pattern.test(cedula);
};

// Validate RUC format
export const isValidRUC = (ruc) => {
  if (!ruc) return false;
  // Format: XXXXXXXXXX-X-XXXX
  const pattern = /^\d+-\d+-\d+$/;
  return pattern.test(ruc);
};
