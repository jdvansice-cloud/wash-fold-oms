import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import {
  Sparkles, ShoppingCart, Truck, Star, BarChart3, Users,
  Shield, Zap, Globe, Check, ArrowRight, Package, LogIn,
  Search, MapPin, X, Building, Navigation, Loader2
} from 'lucide-react';
import { supabaseStaff } from '../lib/supabase';

const FEATURES = [
  { icon: ShoppingCart, title: 'Punto de Venta', desc: 'POS completo para ordenes de lavanderia con peso, piezas y precios por kilo o unidad.' },
  { icon: Package, title: 'Gestion de Ordenes', desc: 'Flujo completo: pendiente, lavando, secando, listo, completado. Notificaciones al cliente.' },
  { icon: Truck, title: 'Recogidas a Domicilio', desc: 'Tus clientes programan recogidas online. Mapa GPS y optimizacion de rutas para conductores.' },
  { icon: Star, title: 'Programa de Lealtad', desc: 'Tarjeta de sellos y puntos canjeables. Fideliza a tus clientes automaticamente.' },
  { icon: BarChart3, title: 'Analiticas y Reportes', desc: 'Dashboard con ventas, tickets promedio, peso total. Cierre de caja diario.' },
  { icon: Users, title: 'Portal del Cliente', desc: 'Tus clientes ven sus pedidos, puntos de lealtad y programan recogidas desde su celular.' },
];

const PLANS = [
  {
    name: 'Starter',
    price: '29',
    period: '/mes',
    desc: 'Para lavanderias que inician',
    features: ['POS completo', 'Gestion de ordenes', 'Clientes ilimitados', 'Reportes basicos', 'Cierre de caja', '1 tienda'],
    cta: 'Comenzar',
    popular: false,
  },
  {
    name: 'Pro',
    price: '59',
    period: '/mes',
    desc: 'Todo lo que necesitas para crecer',
    features: ['Todo en Starter', 'Portal del cliente', 'Recogidas a domicilio', 'Mapa y rutas GPS', 'Programa de lealtad', 'Gift cards', 'Facturas', 'Promociones'],
    cta: 'Comenzar con Pro',
    popular: true,
  },
  {
    name: 'Enterprise',
    price: '99',
    period: '/mes',
    desc: 'Para cadenas y operaciones grandes',
    features: ['Todo en Pro', 'Multi-tienda', 'Branding personalizado', 'Acceso API', 'Soporte prioritario', 'Usuarios ilimitados'],
    cta: 'Contactar ventas',
    popular: false,
  },
];

interface OrgResult {
  id: string;
  name: string;
  slug: string;
  address?: string;
  stores?: { name: string; address?: string; geolocation?: { lat: number; lng: number } }[];
}

function OrgSearchModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const navigate = useNavigate();
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<OrgResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [locating, setLocating] = useState(false);
  const [userLocation, setUserLocation] = useState<{ lat: number; lng: number } | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  const debounceRef = useRef<ReturnType<typeof setTimeout>>();

  useEffect(() => {
    if (open) {
      setTimeout(() => inputRef.current?.focus(), 100);
      // Try to get user location on open
      if (!userLocation && navigator.geolocation) {
        setLocating(true);
        navigator.geolocation.getCurrentPosition(
          (pos) => {
            setUserLocation({ lat: pos.coords.latitude, lng: pos.coords.longitude });
            setLocating(false);
          },
          () => setLocating(false),
          { enableHighAccuracy: false, timeout: 5000 },
        );
      }
    }
  }, [open]);

  const searchOrgs = async (q: string) => {
    if (q.length < 2) {
      setResults([]);
      return;
    }
    setSearching(true);
    try {
      const url = import.meta.env.SUPABASE_URL;
      const key = import.meta.env.SUPABASE_ANON_KEY;
      if (!url || !key) {
        console.error('Missing Supabase config for org search');
        setResults([]);
        setSearching(false);
        return;
      }
      // PostgREST ilike filter: name=ilike.%25search%25
      const encoded = encodeURIComponent(q);
      const apiUrl = `${url}/rest/v1/companies?select=id,name,slug,address&name=ilike.%25${encoded}%25&limit=8`;
      console.log('Searching orgs:', apiUrl);
      const response = await fetch(apiUrl, {
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Accept': 'application/json',
        },
      });
      console.log('Search response:', response.status);
      if (response.ok) {
        const data = await response.json();
        console.log('Search results:', data);
        setResults((data as OrgResult[]) || []);
      } else {
        const text = await response.text();
        console.error('Search error:', response.status, text);
        setResults([]);
      }
    } catch (err) {
      console.error('Search exception:', err);
      setResults([]);
    } finally {
      setSearching(false);
    }
  };

  const handleInputChange = (value: string) => {
    setQuery(value);
    clearTimeout(debounceRef.current);
    debounceRef.current = setTimeout(() => searchOrgs(value), 300);
  };

  // Calculate distance in km using Haversine
  const getDistance = (lat1: number, lng1: number, lat2: number, lng2: number): number => {
    const R = 6371;
    const dLat = ((lat2 - lat1) * Math.PI) / 180;
    const dLng = ((lng2 - lng1) * Math.PI) / 180;
    const a = Math.sin(dLat / 2) ** 2 + Math.cos((lat1 * Math.PI) / 180) * Math.cos((lat2 * Math.PI) / 180) * Math.sin(dLng / 2) ** 2;
    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  };

  const handleSelectOrg = (org: OrgResult, type: 'staff' | 'portal') => {
    onClose();
    navigate(type === 'staff' ? `/app/${org.slug}/login` : `/portal/${org.slug}/login`);
  };

  // Sort results by distance if user location is available
  const sortedResults = userLocation
    ? [...results].sort((a, b) => {
        const aGeo = a.stores?.[0]?.geolocation;
        const bGeo = b.stores?.[0]?.geolocation;
        const aDist = aGeo ? getDistance(userLocation.lat, userLocation.lng, aGeo.lat, aGeo.lng) : Infinity;
        const bDist = bGeo ? getDistance(userLocation.lat, userLocation.lng, bGeo.lat, bGeo.lng) : Infinity;
        return aDist - bDist;
      })
    : results;

  if (!open) return null;

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-[100] flex items-start justify-center pt-[15vh] px-4" onClick={onClose}>
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden" onClick={(e) => e.stopPropagation()}>
        {/* Search Header */}
        <div className="p-4 border-b border-slate-100">
          <div className="flex items-center gap-3">
            <Search size={18} className="text-slate-400 shrink-0" />
            <input
              ref={inputRef}
              type="text"
              value={query}
              onChange={(e) => handleInputChange(e.target.value)}
              className="flex-1 text-base text-slate-900 outline-none placeholder:text-slate-400"
              placeholder="Buscar tu organizacion..."
            />
            {searching && <Loader2 size={16} className="text-slate-400 animate-spin" />}
            <button onClick={onClose} className="p-1 hover:bg-slate-100 rounded-lg text-slate-400">
              <X size={18} />
            </button>
          </div>
          {locating && (
            <div className="flex items-center gap-1.5 mt-2 text-xs text-primary-600">
              <Navigation size={12} className="animate-pulse" />
              Detectando tu ubicacion...
            </div>
          )}
          {userLocation && !locating && (
            <div className="flex items-center gap-1.5 mt-2 text-xs text-emerald-600">
              <MapPin size={12} />
              Mostrando resultados cercanos primero
            </div>
          )}
        </div>

        {/* Results */}
        <div className="max-h-[50vh] overflow-y-auto">
          {query.length < 2 ? (
            <div className="p-6 text-center">
              <Building size={28} className="mx-auto mb-2 text-slate-300" />
              <p className="text-sm text-slate-500">Escribe el nombre de tu lavanderia</p>
              <p className="text-xs text-slate-400 mt-1">Ej: "American Laundry", "Clean Express"</p>
            </div>
          ) : sortedResults.length === 0 && !searching ? (
            <div className="p-6 text-center">
              <Search size={28} className="mx-auto mb-2 text-slate-300" />
              <p className="text-sm text-slate-500">No se encontraron resultados</p>
              <p className="text-xs text-slate-400 mt-1">Verifica el nombre o contacta a tu administrador</p>
            </div>
          ) : (
            <div className="py-2">
              {sortedResults.map((org) => {
                const storeGeo = org.stores?.[0]?.geolocation;
                const distance = userLocation && storeGeo
                  ? getDistance(userLocation.lat, userLocation.lng, storeGeo.lat, storeGeo.lng)
                  : null;

                return (
                  <div key={org.id} className="px-4 py-3 hover:bg-slate-50 transition-colors">
                    <div className="flex items-start gap-3">
                      <div className="bg-primary-50 rounded-lg p-2 mt-0.5 shrink-0">
                        <Building size={16} className="text-primary-500" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <h4 className="text-sm font-semibold text-slate-900">{org.name}</h4>
                        {org.stores?.[0]?.address && (
                          <p className="text-xs text-slate-500 mt-0.5 truncate">{org.stores[0].address}</p>
                        )}
                        {distance !== null && distance < 100 && (
                          <p className="text-[10px] text-emerald-600 mt-0.5 flex items-center gap-1">
                            <MapPin size={10} /> {distance < 1 ? `${Math.round(distance * 1000)}m` : `${distance.toFixed(1)}km`}
                          </p>
                        )}
                        <div className="flex gap-2 mt-2">
                          <button
                            onClick={() => handleSelectOrg(org, 'staff')}
                            className="px-3 py-1.5 bg-primary-500 text-white text-xs font-medium rounded-lg hover:bg-primary-600 transition-colors flex items-center gap-1"
                          >
                            <LogIn size={12} /> Staff
                          </button>
                          <button
                            onClick={() => handleSelectOrg(org, 'portal')}
                            className="px-3 py-1.5 bg-slate-100 text-slate-700 text-xs font-medium rounded-lg hover:bg-slate-200 transition-colors flex items-center gap-1"
                          >
                            <Users size={12} /> Cliente
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default function LandingPage() {
  const [showOrgSearch, setShowOrgSearch] = useState(false);

  return (
    <div className="min-h-screen bg-white">
      {/* Org Search Modal */}
      <OrgSearchModal open={showOrgSearch} onClose={() => setShowOrgSearch(false)} />

      {/* Nav */}
      <header className="fixed top-0 left-0 right-0 bg-white/90 backdrop-blur-sm border-b border-slate-100 z-50">
        <div className="max-w-6xl mx-auto px-4 h-16 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Sparkles className="w-6 h-6 text-primary-500" />
            <span className="text-xl font-bold text-slate-900">Wash<span className="text-primary-500">Pro</span></span>
          </div>
          <nav className="hidden md:flex items-center gap-6 text-sm text-slate-600">
            <a href="#features" className="hover:text-slate-900 transition-colors">Funciones</a>
            <a href="#pricing" className="hover:text-slate-900 transition-colors">Precios</a>
          </nav>
          <div className="flex items-center gap-3">
            <button
              onClick={() => setShowOrgSearch(true)}
              className="px-4 py-2 bg-slate-100 text-slate-700 rounded-lg text-sm font-medium hover:bg-slate-200 transition-colors flex items-center gap-2"
            >
              <LogIn size={16} />
              Iniciar Sesion
            </button>
            <Link
              to="/signup"
              className="px-4 py-2 bg-primary-500 text-white rounded-lg text-sm font-medium hover:bg-primary-600 transition-colors"
            >
              Registrarse
            </Link>
          </div>
        </div>
      </header>

      {/* Hero */}
      <section className="pt-32 pb-20 px-4">
        <div className="max-w-4xl mx-auto text-center">
          <div className="inline-flex items-center gap-2 px-3 py-1.5 bg-primary-50 text-primary-700 rounded-full text-xs font-medium mb-6">
            <Zap size={14} />
            Plataforma #1 para lavanderias en Latinoamerica
          </div>
          <h1 className="text-4xl md:text-6xl font-bold text-slate-900 leading-tight mb-6">
            Tu lavanderia,
            <br />
            <span className="text-primary-500">100% digital</span>
          </h1>
          <p className="text-lg md:text-xl text-slate-500 max-w-2xl mx-auto mb-10">
            Sistema completo de gestion para lavanderias: punto de venta, portal del cliente,
            recogidas a domicilio, lealtad y mas. Todo desde una sola plataforma.
          </p>
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
            <Link
              to="/signup"
              className="px-8 py-3.5 bg-primary-500 text-white rounded-xl text-base font-semibold hover:bg-primary-600 transition-colors flex items-center gap-2 shadow-lg shadow-primary-500/20"
            >
              Prueba gratis 14 dias <ArrowRight size={18} />
            </Link>
            <a
              href="#features"
              className="px-8 py-3.5 bg-slate-100 text-slate-700 rounded-xl text-base font-semibold hover:bg-slate-200 transition-colors"
            >
              Ver funciones
            </a>
          </div>
          <p className="text-xs text-slate-400 mt-4">Sin tarjeta de credito. Configura en 5 minutos.</p>
        </div>
      </section>

      {/* Trust bar */}
      <section className="py-8 bg-slate-50 border-y border-slate-100">
        <div className="max-w-4xl mx-auto px-4 flex flex-wrap items-center justify-center gap-8 text-sm text-slate-500">
          <div className="flex items-center gap-2"><Shield size={16} className="text-emerald-500" /> Datos seguros con Supabase</div>
          <div className="flex items-center gap-2"><Globe size={16} className="text-primary-500" /> Funciona en cualquier dispositivo</div>
          <div className="flex items-center gap-2"><Zap size={16} className="text-amber-500" /> Setup en 5 minutos</div>
        </div>
      </section>

      {/* Features */}
      <section id="features" className="py-20 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-14">
            <h2 className="text-3xl font-bold text-slate-900 mb-3">Todo lo que tu lavanderia necesita</h2>
            <p className="text-slate-500 max-w-xl mx-auto">
              Desde el punto de venta hasta la recogida a domicilio, WashPro tiene cada proceso cubierto.
            </p>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {FEATURES.map(({ icon: Icon, title, desc }) => (
              <div key={title} className="bg-white rounded-2xl border border-slate-200 p-6 hover:shadow-lg hover:border-primary-200 transition-all">
                <div className="w-10 h-10 bg-primary-50 rounded-xl flex items-center justify-center mb-4">
                  <Icon size={20} className="text-primary-500" />
                </div>
                <h3 className="text-lg font-semibold text-slate-900 mb-2">{title}</h3>
                <p className="text-sm text-slate-500 leading-relaxed">{desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Pricing */}
      <section id="pricing" className="py-20 px-4 bg-slate-50">
        <div className="max-w-5xl mx-auto">
          <div className="text-center mb-14">
            <h2 className="text-3xl font-bold text-slate-900 mb-3">Planes simples, sin sorpresas</h2>
            <p className="text-slate-500">Elige el plan que mejor se adapte a tu negocio. Cambia en cualquier momento.</p>
          </div>
          <div className="grid md:grid-cols-3 gap-6">
            {PLANS.map((plan) => (
              <div
                key={plan.name}
                className={`bg-white rounded-2xl p-6 relative ${
                  plan.popular
                    ? 'border-2 border-primary-500 shadow-lg shadow-primary-500/10'
                    : 'border border-slate-200'
                }`}
              >
                {plan.popular && (
                  <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-primary-500 text-white text-xs font-semibold rounded-full">
                    Mas popular
                  </div>
                )}
                <h3 className="text-lg font-semibold text-slate-900">{plan.name}</h3>
                <p className="text-sm text-slate-500 mt-1">{plan.desc}</p>
                <div className="mt-4 mb-6">
                  <span className="text-4xl font-bold text-slate-900">${plan.price}</span>
                  <span className="text-slate-500 text-sm">{plan.period}</span>
                </div>
                <Link
                  to="/signup"
                  className={`block text-center py-2.5 rounded-lg text-sm font-medium transition-colors ${
                    plan.popular
                      ? 'bg-primary-500 text-white hover:bg-primary-600'
                      : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
                  }`}
                >
                  {plan.cta}
                </Link>
                <ul className="mt-6 space-y-2.5">
                  {plan.features.map((f) => (
                    <li key={f} className="flex items-start gap-2 text-sm text-slate-600">
                      <Check size={16} className="text-emerald-500 mt-0.5 shrink-0" />
                      {f}
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-20 px-4">
        <div className="max-w-3xl mx-auto text-center">
          <h2 className="text-3xl font-bold text-slate-900 mb-4">
            Digitaliza tu lavanderia hoy
          </h2>
          <p className="text-slate-500 mb-8">
            Unete a las lavanderias que ya usan WashPro para gestionar su negocio de forma eficiente.
          </p>
          <Link
            to="/signup"
            className="inline-flex items-center gap-2 px-8 py-3.5 bg-primary-500 text-white rounded-xl text-base font-semibold hover:bg-primary-600 transition-colors shadow-lg shadow-primary-500/20"
          >
            Comenzar gratis <ArrowRight size={18} />
          </Link>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-slate-200 py-8 px-4">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
          <div className="flex items-center gap-2">
            <Sparkles className="w-5 h-5 text-primary-500" />
            <span className="font-bold text-slate-800">WashPro</span>
          </div>
          <p className="text-sm text-slate-400">&copy; 2025 WashPro. Todos los derechos reservados.</p>
        </div>
      </footer>
    </div>
  );
}
