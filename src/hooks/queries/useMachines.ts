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

/** Machine ids a product is restricted to (empty = any machine of its type). */
export async function fetchProductMachines(productId: string): Promise<string[]> {
  const { data, error } = await supabase
    .from('product_machines')
    .select('machine_id')
    .eq('product_id', productId);
  if (error) throw error;
  return (data || []).map((r: any) => r.machine_id);
}

/** product_id -> Set(machine_id) for a set of products (POS assignment). */
export async function fetchProductMachineMap(productIds: string[]): Promise<Record<string, string[]>> {
  if (!productIds.length) return {};
  const { data, error } = await supabase
    .from('product_machines')
    .select('product_id, machine_id')
    .in('product_id', productIds);
  if (error) throw error;
  const map: Record<string, string[]> = {};
  for (const r of (data as any[]) || []) {
    (map[r.product_id] ||= []).push(r.machine_id);
  }
  return map;
}

/** Replace a product's allowed machines. */
export async function setProductMachines(productId: string, machineIds: string[]): Promise<void> {
  const { error: delErr } = await supabase.from('product_machines').delete().eq('product_id', productId);
  if (delErr) throw delErr;
  if (machineIds.length) {
    const rows = machineIds.map((machine_id) => ({ product_id: productId, machine_id }));
    const { error } = await supabase.from('product_machines').insert(rows);
    if (error) throw error;
  }
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
