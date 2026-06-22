import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/lib/supabase';

export interface TimeEntry {
  id: string;
  user_id: string;
  store_id: string | null;
  clock_in: string;
  clock_out: string | null;
}

// Degrades gracefully (returns null) if the time_entries table doesn't exist
// yet — i.e. before the supabase-time-attendance.sql migration is applied.
async function fetchOpenEntry(userId: string): Promise<TimeEntry | null> {
  const { data, error } = await supabase
    .from('time_entries')
    .select('id, user_id, store_id, clock_in, clock_out')
    .eq('user_id', userId)
    .is('clock_out', null)
    .order('clock_in', { ascending: false })
    .limit(1)
    .maybeSingle();
  if (error) return null;
  return (data as TimeEntry) || null;
}

export function useOpenTimeEntry(userId?: string) {
  return useQuery({
    queryKey: ['time-entry-open', userId],
    queryFn: () => fetchOpenEntry(userId as string),
    enabled: !!userId,
    staleTime: 30_000,
  });
}

export function useClockToggle(userId?: string, storeId?: string | null) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: async (openEntry: TimeEntry | null) => {
      if (openEntry) {
        const { error } = await supabase
          .from('time_entries')
          .update({ clock_out: new Date().toISOString() })
          .eq('id', openEntry.id);
        if (error) throw error;
        return 'out' as const;
      }
      const { error } = await supabase
        .from('time_entries')
        .insert({ user_id: userId, store_id: storeId || null });
      if (error) throw error;
      return 'in' as const;
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ['time-entry-open', userId] }),
  });
}

/** All time entries for a store on a given local day (for EOD). */
export interface TimeEntryWithUser extends TimeEntry {
  users?: { full_name: string | null; weekly_hours?: Record<string, number> } | null;
}

export async function fetchStoreDayEntries(
  storeId: string,
  dayStartISO: string,
  dayEndISO: string,
): Promise<TimeEntryWithUser[]> {
  const { data, error } = await supabase
    .from('time_entries')
    .select('id, user_id, store_id, clock_in, clock_out, users(full_name, weekly_hours)')
    .eq('store_id', storeId)
    .gte('clock_in', dayStartISO)
    .lte('clock_in', dayEndISO)
    .order('clock_in', { ascending: true });
  if (error) return [];
  return ((data as unknown) as TimeEntryWithUser[]) || [];
}

/** Worked minutes for an entry (open entries count up to now). */
export function workedMinutes(e: TimeEntry, now = new Date()): number {
  const start = new Date(e.clock_in).getTime();
  const end = e.clock_out ? new Date(e.clock_out).getTime() : now.getTime();
  return Math.max(0, Math.round((end - start) / 60000));
}
