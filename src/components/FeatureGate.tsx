import React from 'react';
import { Link } from 'react-router-dom';
import { Lock, ArrowRight, Sparkles } from 'lucide-react';
import { useFeature } from '../hooks/useFeature';
import { useTenant } from '../hooks/useTenant';

interface FeatureGateProps {
  feature: string;
  children: React.ReactNode;
  /** If true, renders nothing instead of the upgrade prompt */
  hideIfLocked?: boolean;
}

const FEATURE_LABELS: Record<string, string> = {
  portal: 'Portal del Cliente',
  pickups: 'Recogidas a Domicilio',
  loyalty: 'Programa de Lealtad',
  gift_cards: 'Tarjetas Regalo',
  promotions: 'Promociones',
  invoices: 'Facturacion',
  multi_store: 'Multi-Tienda',
  custom_branding: 'Branding Personalizado',
  api_access: 'Acceso API',
};

const PLAN_LABELS: Record<string, string> = {
  starter: 'Starter',
  pro: 'Pro',
  enterprise: 'Enterprise',
};

function getRequiredPlan(feature: string): string {
  if (['portal', 'pickups', 'loyalty', 'gift_cards', 'promotions', 'invoices'].includes(feature)) return 'pro';
  if (['multi_store', 'custom_branding', 'api_access'].includes(feature)) return 'enterprise';
  return 'starter';
}

export function FeatureGate({ feature, children, hideIfLocked = false }: FeatureGateProps) {
  const allowed = useFeature(feature);
  const { plan, slug } = useTenant();

  if (allowed) return <>{children}</>;
  if (hideIfLocked) return null;

  const requiredPlan = getRequiredPlan(feature);
  const featureLabel = FEATURE_LABELS[feature] || feature;
  const planLabel = PLAN_LABELS[requiredPlan] || requiredPlan;

  return (
    <div className="flex items-center justify-center py-16 px-4">
      <div className="max-w-sm text-center">
        <div className="w-14 h-14 bg-amber-100 rounded-2xl flex items-center justify-center mx-auto mb-4">
          <Lock size={24} className="text-amber-600" />
        </div>
        <h2 className="text-lg font-semibold text-slate-900 mb-2">
          {featureLabel}
        </h2>
        <p className="text-sm text-slate-500 mb-6">
          Esta funcion esta disponible en el plan <strong className="text-slate-700">{planLabel}</strong>.
          Tu plan actual es <strong className="text-slate-700">{PLAN_LABELS[plan] || plan}</strong>.
        </p>
        <Link
          to={`/app/${slug}/settings`}
          className="inline-flex items-center gap-2 px-5 py-2.5 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 transition-colors"
        >
          <Sparkles size={16} />
          Mejorar plan
          <ArrowRight size={14} />
        </Link>
      </div>
    </div>
  );
}
