// Application constants for Wash & Fold OMS

export interface ServiceSettings {
  default_completion_days: number;
  express_completion_days: number;
  itbms_rate: number;
}

export const defaultServiceSettings: ServiceSettings = {
  default_completion_days: 1,
  express_completion_days: 0,
  itbms_rate: 7.0,
};

export interface StatusInfo {
  label: string;
  color: string;
  bgClass: string;
  textClass: string;
}

export const statusConfig: Record<string, StatusInfo> = {
  pending: { label: 'Pendiente', color: 'amber', bgClass: 'bg-amber-100', textClass: 'text-amber-700' },
  washing: { label: 'Lavando', color: 'blue', bgClass: 'bg-blue-100', textClass: 'text-blue-700' },
  drying: { label: 'Secando', color: 'cyan', bgClass: 'bg-cyan-100', textClass: 'text-cyan-700' },
  folding: { label: 'Doblando', color: 'indigo', bgClass: 'bg-indigo-100', textClass: 'text-indigo-700' },
  ready: { label: 'Listo', color: 'emerald', bgClass: 'bg-emerald-100', textClass: 'text-emerald-700' },
  completed: { label: 'Completado', color: 'slate', bgClass: 'bg-slate-100', textClass: 'text-slate-600' },
  cancelled: { label: 'Cancelado', color: 'red', bgClass: 'bg-red-100', textClass: 'text-red-700' },
  refunded: { label: 'Reembolsado', color: 'red', bgClass: 'bg-red-100', textClass: 'text-red-700' },
  refund: { label: 'Reembolso', color: 'rose', bgClass: 'bg-rose-100', textClass: 'text-rose-700' },
};

export interface WorkflowStage {
  id: string;
  name: string;
  statuses: string[];
}

export const workflowStages: WorkflowStage[] = [
  { id: 'pending', name: 'Por Hacer', statuses: ['pending'] },
  { id: 'washing', name: 'Lavadoras', statuses: ['washing'] },
  { id: 'drying', name: 'Secadoras', statuses: ['drying'] },
  { id: 'folding', name: 'Doblado', statuses: ['folding'] },
  { id: 'ready', name: 'Completada', statuses: ['ready', 'completed'] },
];
