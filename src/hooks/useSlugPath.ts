import { useCallback } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useTenant } from './useTenant';

/**
 * Returns a path builder that prepends the current tenant slug.
 * Usage: const p = useSlugPath(); p('/orders') → '/app/my-laundry/orders'
 */
export function useSlugPath() {
  const { slug } = useTenant();
  const location = useLocation();
  const isPortal = location.pathname.includes('/portal/');
  const prefix = isPortal ? `/portal/${slug}` : `/app/${slug}`;

  return useCallback(
    (path: string) => `${prefix}${path.startsWith('/') ? path : `/${path}`}`,
    [prefix],
  );
}

/**
 * Slug-aware navigate. Usage: const nav = useSlugNavigate(); nav('/orders')
 */
export function useSlugNavigate() {
  const buildPath = useSlugPath();
  const navigate = useNavigate();

  return useCallback(
    (path: string, options?: { replace?: boolean }) => navigate(buildPath(path), options),
    [buildPath, navigate],
  );
}
