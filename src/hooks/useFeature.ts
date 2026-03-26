import { useTenant } from './useTenant';
import { hasFeature } from '../lib/features';

export function useFeature(feature: string): boolean {
  const { plan } = useTenant();
  return hasFeature(plan, feature);
}

export function useFeatures(): { has: (feature: string) => boolean; plan: string } {
  const { plan } = useTenant();
  return {
    has: (feature: string) => hasFeature(plan, feature),
    plan,
  };
}
