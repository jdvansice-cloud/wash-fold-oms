import { supabase } from '@/lib/supabase';

export interface Machine {
  id: string;
  store_id: string;
  name: string;
  machine_type: 'washer' | 'dryer';
  cycle_time: number | null;
  cycle_count: number;
  maintenance_interval: number | null;
  last_service_at: string | null;
  last_service_cycle: number;
  notes: string | null;
  is_active: boolean;
}

/** Cycles run since the last service, and whether maintenance is due. */
export function cyclesSinceService(m: Machine): number {
  return Math.max(0, (m.cycle_count || 0) - (m.last_service_cycle || 0));
}
export function maintenanceDue(m: Machine): boolean {
  return !!m.maintenance_interval && cyclesSinceService(m) >= m.maintenance_interval;
}

export async function fetchMachines(storeId: string): Promise<Machine[]> {
  const { data, error } = await supabase
    .from('machines')
    .select('*')
    .eq('store_id', storeId)
    .order('machine_type')
    .order('name');
  if (error) throw error;
  return (data as Machine[]) || [];
}

/** Active machines of a type (for POS assignment). */
export async function fetchActiveMachines(storeId: string, type?: 'washer' | 'dryer'): Promise<Machine[]> {
  let q = supabase.from('machines').select('*').eq('store_id', storeId).eq('is_active', true);
  if (type) q = q.eq('machine_type', type);
  const { data, error } = await q.order('name');
  if (error) throw error;
  return (data as Machine[]) || [];
}

export async function createMachine(input: {
  store_id: string;
  name: string;
  machine_type: 'washer' | 'dryer';
  maintenance_interval?: number | null;
  cycle_time?: number | null;
}): Promise<Machine> {
  const { data, error } = await supabase.from('machines').insert(input).select().single();
  if (error) throw error;
  return data as Machine;
}

export async function updateMachine(id: string, updates: Partial<Machine>): Promise<void> {
  const { error } = await supabase
    .from('machines')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id);
  if (error) throw error;
}

export async function deleteMachine(id: string): Promise<void> {
  const { error } = await supabase.from('machines').update({ is_active: false }).eq('id', id);
  if (error) throw error;
}

/** Log a service — records it and resets the since-service counter. */
export async function logMaintenance(machineId: string, notes?: string, userId?: string | null): Promise<void> {
  const { error } = await supabase.rpc('log_machine_maintenance', {
    p_machine_id: machineId,
    p_notes: notes || null,
    p_user: userId || null,
  });
  if (error) throw error;
}

export interface MaintenanceLog {
  id: string;
  serviced_at: string;
  cycle_count_at: number;
  notes: string | null;
}
export async function fetchMaintenanceLog(machineId: string): Promise<MaintenanceLog[]> {
  const { data, error } = await supabase
    .from('machine_maintenance')
    .select('id, serviced_at, cycle_count_at, notes')
    .eq('machine_id', machineId)
    .order('serviced_at', { ascending: false })
    .limit(20);
  if (error) throw error;
  return (data as MaintenanceLog[]) || [];
}

/** Record machine cycles for a sale (atomic insert + counter bump). */
export async function recordMachineUsage(machineId: string, orderId: string | null, cycles: number, userId?: string | null): Promise<void> {
  const { error } = await supabase.rpc('record_machine_usage', {
    p_machine_id: machineId,
    p_order_id: orderId,
    p_cycles: cycles,
    p_user: userId || null,
  });
  if (error) throw error;
}
