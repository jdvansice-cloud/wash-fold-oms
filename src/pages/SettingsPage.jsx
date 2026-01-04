import React, { useState, useRef, useEffect } from 'react';
import { 
  Building, Store, Users, CreditCard, Bell, Mail, Send,
  Gift, Tag, Package, Clock, Percent, Save,
  ChevronRight, Check, Settings as SettingsIcon,
  Plus, Edit2, Trash2, X, Scale, Hash, ChevronDown,
  GripVertical, Eye, EyeOff, Upload, MapPin, Image, Loader2
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useDataLoader } from '../hooks/useDataLoader';
import { supabase } from '../lib/supabase';

function SettingsPage() {
  const { state } = useApp();
  const [activeSection, setActiveSection] = useState('company');
  
  const menuItems = [
    { id: 'company', label: 'Empresa', icon: Building, description: 'Datos de la empresa' },
    { id: 'store', label: 'Tienda', icon: Store, description: 'Configuración de tienda' },
    { id: 'workflow', label: 'Flujo de Trabajo', icon: Clock, description: 'Tiempos de servicio' },
    { id: 'users', label: 'Usuarios', icon: Users, description: 'Gestión de usuarios' },
    { id: 'payments', label: 'Métodos de Pago', icon: CreditCard, description: 'Formas de pago' },
    { id: 'notifications', label: 'Notificaciones', icon: Bell, description: 'Plantillas de email' },
    { id: 'products', label: 'Productos', icon: Package, description: 'Gestión de productos' },
    { id: 'promotions', label: 'Promociones', icon: Tag, description: 'Descuentos y ofertas' },
    { id: 'giftcards', label: 'Tarjetas Regalo', icon: Gift, description: 'Gift cards' },
  ];

  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-display font-bold text-slate-800">Configuración</h1>
        <p className="text-sm text-slate-500">Administra la configuración de tu negocio</p>
      </div>
      
      <div className="flex gap-6">
        {/* Settings Menu */}
        <div className="w-72 flex-shrink-0">
          <div className="card p-2">
            {menuItems.map((item) => {
              const Icon = item.icon;
              const isActive = activeSection === item.id;
              
              return (
                <button
                  key={item.id}
                  onClick={() => setActiveSection(item.id)}
                  className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl text-left transition-colors ${
                    isActive 
                      ? 'bg-primary-50 text-primary-700' 
                      : 'hover:bg-slate-50 text-slate-700'
                  }`}
                >
                  <Icon className={`w-5 h-5 ${isActive ? 'text-primary-500' : 'text-slate-400'}`} />
                  <div className="flex-1">
                    <p className={`font-medium text-sm ${isActive ? 'text-primary-700' : 'text-slate-700'}`}>
                      {item.label}
                    </p>
                    <p className="text-xs text-slate-400">{item.description}</p>
                  </div>
                  {isActive && <ChevronRight className="w-4 h-4 text-primary-400" />}
                </button>
              );
            })}
          </div>
        </div>
        
        {/* Settings Content */}
        <div className="flex-1">
          {activeSection === 'company' && <CompanySettings />}
          {activeSection === 'store' && <StoreSettings />}
          {activeSection === 'workflow' && <WorkflowSettings />}
          {activeSection === 'users' && <UsersSettings />}
          {activeSection === 'payments' && <PaymentMethodsSettings />}
          {activeSection === 'notifications' && <NotificationsSettings />}
          {activeSection === 'products' && <ProductsSettings />}
          {activeSection === 'promotions' && <PromotionsSettings />}
          {activeSection === 'giftcards' && <GiftCardsSettings />}
        </div>
      </div>
    </div>
  );
}

// Company Settings Section
function CompanySettings() {
  const fileInputRef = useRef(null);
  const [loading, setLoading] = useState(true);
  const [companyId, setCompanyId] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    ruc: '',
    dv: '',
    address: '',
    phone: '',
    itbms_rate: 7,
    logo_url: '',
  });
  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState(null);
  const [saving, setSaving] = useState(false);

  // Load company data from database
  useEffect(() => {
    loadCompany();
  }, []);

  const loadCompany = async () => {
    setLoading(true);
    try {
      // Get company directly
      const { data: company, error: companyError } = await supabase
        .from('companies')
        .select('*')
        .limit(1)
        .single();

      if (companyError) {
        console.error('No company found:', companyError);
        setLoading(false);
        return;
      }

      setCompanyId(company.id);
      setFormData({
        name: company.name || '',
        ruc: company.ruc || '',
        dv: company.dv || '',
        address: company.address || '',
        phone: company.phone || '',
        itbms_rate: company.itbms_rate || 7,
        logo_url: company.logo_url || '',
      });
    } catch (err) {
      console.error('Error loading company:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleLogoUpload = async (event) => {
    const file = event.target.files?.[0];
    if (!file) return;

    // Validate file type
    const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
    if (!validTypes.includes(file.type)) {
      setUploadError('Solo se permiten archivos PNG o JPG');
      return;
    }

    // Validate file size (max 2MB)
    if (file.size > 2 * 1024 * 1024) {
      setUploadError('El archivo debe ser menor a 2MB');
      return;
    }

    setUploading(true);
    setUploadError(null);

    try {
      // Generate unique filename
      const fileExt = file.name.split('.').pop();
      const fileName = `logo-${Date.now()}.${fileExt}`;
      const filePath = `logos/${fileName}`;

      // Upload to Supabase Storage
      const { data, error } = await supabase.storage
        .from('assets')
        .upload(filePath, file, {
          cacheControl: '3600',
          upsert: true
        });

      if (error) throw error;

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('assets')
        .getPublicUrl(filePath);

      setFormData({ ...formData, logo_url: urlData.publicUrl });
    } catch (err) {
      console.error('Error uploading logo:', err);
      setUploadError('Error al subir el logo. Verifica que el bucket "assets" exista.');
    } finally {
      setUploading(false);
    }
  };

  const handleSave = async () => {
    if (!companyId) {
      alert('Error: No se encontró el ID de la empresa. Recarga la página.');
      return;
    }

    setSaving(true);
    try {
      // Save to Supabase
      const { error } = await supabase
        .from('companies')
        .update({
          name: formData.name,
          ruc: formData.ruc,
          dv: formData.dv,
          address: formData.address,
          phone: formData.phone,
          itbms_rate: formData.itbms_rate,
          logo_url: formData.logo_url,
          updated_at: new Date().toISOString()
        })
        .eq('id', companyId);

      if (error) throw error;
      alert('Datos guardados correctamente');
    } catch (err) {
      console.error('Error saving company:', err);
      alert('Error al guardar: ' + err.message);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center min-h-[300px]">
        <Loader2 className="w-8 h-8 animate-spin text-primary-500" />
      </div>
    );
  }

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Datos de la Empresa</h2>
          <p className="text-sm text-slate-500">Información general del negocio</p>
        </div>
        <button onClick={handleSave} disabled={saving} className="btn-primary">
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          {saving ? 'Guardando...' : 'Guardar'}
        </button>
      </div>
      
      <div className="grid grid-cols-2 gap-4">
        {/* Logo Upload Section */}
        <div className="col-span-2 p-4 bg-slate-50 rounded-xl">
          <label className="block text-sm font-medium text-slate-700 mb-3">Logo de la Empresa</label>
          <div className="flex items-start gap-6">
            {/* Logo Preview */}
            <div className="flex-shrink-0">
              {formData.logo_url ? (
                <div className="relative">
                  <img 
                    src={formData.logo_url} 
                    alt="Logo" 
                    className="w-32 h-32 object-contain bg-white rounded-xl border border-slate-200 p-2"
                  />
                  <button
                    onClick={() => setFormData({ ...formData, logo_url: '' })}
                    className="absolute -top-2 -right-2 w-6 h-6 bg-error-500 text-white rounded-full flex items-center justify-center hover:bg-error-600"
                  >
                    <X className="w-4 h-4" />
                  </button>
                </div>
              ) : (
                <div className="w-32 h-32 bg-slate-200 rounded-xl flex items-center justify-center">
                  <Image className="w-12 h-12 text-slate-400" />
                </div>
              )}
            </div>
            
            {/* Upload Controls */}
            <div className="flex-1">
              <input
                type="file"
                ref={fileInputRef}
                onChange={handleLogoUpload}
                accept=".png,.jpg,.jpeg"
                className="hidden"
              />
              <button
                onClick={() => fileInputRef.current?.click()}
                disabled={uploading}
                className="btn-secondary mb-2"
              >
                {uploading ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Subiendo...
                  </>
                ) : (
                  <>
                    <Upload className="w-4 h-4" />
                    Subir Logo
                  </>
                )}
              </button>
              <p className="text-xs text-slate-500">PNG o JPG, máximo 2MB</p>
              {uploadError && (
                <p className="text-xs text-error-600 mt-1">{uploadError}</p>
              )}
            </div>
          </div>
        </div>
        
        <div className="col-span-2">
          <label className="block text-sm font-medium text-slate-700 mb-1">Nombre de Empresa</label>
          <input
            type="text"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            className="input"
          />
        </div>
        
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">RUC</label>
          <input
            type="text"
            value={formData.ruc}
            onChange={(e) => setFormData({ ...formData, ruc: e.target.value })}
            className="input"
          />
        </div>
        
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">DV</label>
          <input
            type="text"
            value={formData.dv}
            onChange={(e) => setFormData({ ...formData, dv: e.target.value })}
            className="input"
          />
        </div>
        
        <div className="col-span-2">
          <label className="block text-sm font-medium text-slate-700 mb-1">Dirección</label>
          <input
            type="text"
            value={formData.address}
            onChange={(e) => setFormData({ ...formData, address: e.target.value })}
            className="input"
          />
        </div>
        
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">Teléfono</label>
          <input
            type="text"
            value={formData.phone}
            onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
            className="input"
          />
        </div>
        
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">ITBMS (%)</label>
          <input
            type="number"
            value={formData.itbms_rate}
            onChange={(e) => setFormData({ ...formData, itbms_rate: parseFloat(e.target.value) })}
            className="input"
          />
        </div>
      </div>
    </div>
  );
}

// Store Settings Section - Multi-store management
function StoreSettings() {
  const [stores, setStores] = useState([]);
  const [currentStoreId, setCurrentStoreId] = useState(null);
  const [companyId, setCompanyId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingStore, setEditingStore] = useState(null);

  // Load stores on mount
  useEffect(() => {
    loadStores();
  }, []);

  const loadStores = async () => {
    setLoading(true);
    try {
      // First get companyId from companies table (in case no stores exist yet)
      const { data: company, error: companyError } = await supabase
        .from('companies')
        .select('id')
        .limit(1)
        .single();

      if (company) {
        setCompanyId(company.id);
      }

      // Get current active store to know which is "current"
      const { data: activeStore } = await supabase
        .from('stores')
        .select('id, company_id')
        .eq('is_active', true)
        .limit(1)
        .maybeSingle(); // Use maybeSingle to avoid error when no stores exist

      if (activeStore) {
        setCurrentStoreId(activeStore.id);
        // Override companyId if we got it from store
        if (activeStore.company_id) {
          setCompanyId(activeStore.company_id);
        }
      }

      const { data, error } = await supabase
        .from('stores')
        .select('*')
        .order('name');
      
      if (error) throw error;
      setStores(data || []);
    } catch (err) {
      console.error('Error loading stores:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteStore = async (storeId) => {
    if (!window.confirm('¿Estás seguro de eliminar esta tienda? Esta acción no se puede deshacer.')) {
      return;
    }
    
    try {
      const { error } = await supabase
        .from('stores')
        .delete()
        .eq('id', storeId);
      
      if (error) throw error;
      setStores(stores.filter(s => s.id !== storeId));
    } catch (err) {
      console.error('Error deleting store:', err);
      alert('Error al eliminar: ' + err.message);
    }
  };

  const handleSaveStore = async (storeData) => {
    // Helper function to add timeout to any promise
    const withTimeout = (promise, ms) => {
      return Promise.race([
        promise,
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error('Timeout: La operación tardó demasiado. Verifica que RLS esté deshabilitado en Supabase.')), ms)
        )
      ]);
    };

    // Helper to validate geolocation
    const isValidGeo = (geo) => {
      if (!geo) return false;
      const lat = Number(geo.lat);
      const lng = Number(geo.lng);
      return !isNaN(lat) && !isNaN(lng) && isFinite(lat) && isFinite(lng);
    };

    try {
      if (editingStore) {
        // Update existing
        console.log('Updating store:', editingStore.id);
        
        // Prepare update data - start with basic fields only
        const updateData = {
          name: storeData.name,
          address: storeData.address || null,
          phone: storeData.phone || null,
          is_active: storeData.is_active,
          updated_at: new Date().toISOString()
        };
        
        // Add opening_hours if present
        if (storeData.opening_hours) {
          updateData.opening_hours = storeData.opening_hours;
        }
        
        console.log('Update data (without geo):', JSON.stringify(updateData, null, 2));
        
        // First update without geolocation
        const result = await withTimeout(
          supabase.from('stores').update(updateData).eq('id', editingStore.id),
          10000
        );
        
        if (result.error) {
          console.error('Supabase update error:', result.error);
          alert('Error al guardar: ' + result.error.message);
          return;
        }
        
        // Now update geolocation separately using RPC function
        if (isValidGeo(storeData.geolocation)) {
          const lat = Number(storeData.geolocation.lat);
          const lng = Number(storeData.geolocation.lng);
          console.log('Updating geolocation via RPC:', { lat, lng });
          
          const geoResult = await withTimeout(
            supabase.rpc('update_store_geolocation', {
              store_id: editingStore.id,
              lat: lat,
              lng: lng
            }),
            10000
          );
          
          if (geoResult.error) {
            console.error('Geolocation RPC error:', geoResult.error);
            // Don't fail the whole operation, just log it
            alert('Nota: Los datos se guardaron pero la geolocalización no se actualizó. Error: ' + geoResult.error.message);
          } else {
            console.log('Geolocation updated successfully via RPC');
          }
        }
        
        console.log('Store updated successfully');
        
      } else {
        // Create new
        if (!companyId) {
          alert('Error: No se encontró una empresa. Primero configura los datos de la empresa.');
          return;
        }
        
        // Insert without geolocation first
        const insertData = {
          company_id: companyId,
          name: storeData.name,
          address: storeData.address || null,
          phone: storeData.phone || null,
          is_active: storeData.is_active !== false
        };
        
        if (storeData.opening_hours) {
          insertData.opening_hours = storeData.opening_hours;
        }
        
        console.log('Insert data:', JSON.stringify(insertData, null, 2));
        
        const result = await withTimeout(
          supabase.from('stores').insert(insertData).select().single(),
          10000
        );
        
        if (result.error) {
          console.error('Supabase insert error:', result.error);
          alert('Error al guardar: ' + result.error.message);
          return;
        }
        
        console.log('Store created successfully:', result.data);
        
        // Now update geolocation using RPC
        if (isValidGeo(storeData.geolocation) && result.data?.id) {
          const lat = Number(storeData.geolocation.lat);
          const lng = Number(storeData.geolocation.lng);
          console.log('Setting geolocation via RPC for new store:', { lat, lng });
          
          const geoResult = await withTimeout(
            supabase.rpc('update_store_geolocation', {
              store_id: result.data.id,
              lat: lat,
              lng: lng
            }),
            10000
          );
          
          if (geoResult.error) {
            console.error('Geolocation RPC error:', geoResult.error);
            alert('Nota: La tienda se creó pero la geolocalización no se guardó. Error: ' + geoResult.error.message);
          } else {
            console.log('Geolocation set successfully via RPC');
          }
        }
      }
      
      // Success - close modal and reload
      setShowModal(false);
      setEditingStore(null);
      loadStores();
      
    } catch (err) {
      console.error('Error saving store:', err);
      alert(err.message || 'Error al guardar');
    }
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="card p-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-lg font-semibold text-slate-800">Tiendas / Ubicaciones</h2>
            <p className="text-sm text-slate-500">Administra las ubicaciones de tu negocio</p>
          </div>
          <button 
            onClick={() => { setEditingStore(null); setShowModal(true); }}
            className="btn-primary"
          >
            <Plus className="w-4 h-4" />
            Nueva Tienda
          </button>
        </div>

        {/* Stores List */}
        {loading ? (
          <div className="flex items-center justify-center py-12">
            <Loader2 className="w-8 h-8 animate-spin text-primary-500" />
          </div>
        ) : stores.length === 0 ? (
          <div className="text-center py-12 text-slate-400">
            <Store className="w-12 h-12 mx-auto mb-3 opacity-50" />
            <p className="font-medium">No hay tiendas configuradas</p>
            <p className="text-sm mt-1">Agrega tu primera tienda para comenzar</p>
          </div>
        ) : (
          <div className="space-y-4">
            {stores.map((storeItem) => (
              <div 
                key={storeItem.id}
                className={`p-4 rounded-xl border-2 transition-all ${
                  storeItem.id === currentStoreId 
                    ? 'border-primary-300 bg-primary-50' 
                    : 'border-slate-200 bg-white hover:border-slate-300'
                }`}
              >
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="font-semibold text-slate-800">{storeItem.name}</h3>
                      {storeItem.id === currentStoreId && (
                        <span className="badge bg-primary-100 text-primary-700 text-xs">Actual</span>
                      )}
                      {!storeItem.is_active && (
                        <span className="badge bg-slate-100 text-slate-500 text-xs">Inactiva</span>
                      )}
                    </div>
                    <p className="text-sm text-slate-500 flex items-center gap-1">
                      <MapPin className="w-3 h-3" />
                      {storeItem.address || 'Sin dirección'}
                    </p>
                    {storeItem.phone && (
                      <p className="text-sm text-slate-500 mt-1">{storeItem.phone}</p>
                    )}
                    {storeItem.geolocation && (
                      <p className="text-xs text-slate-400 mt-1">
                        📍 {storeItem.geolocation.lat?.toFixed(6)}, {storeItem.geolocation.lng?.toFixed(6)}
                      </p>
                    )}
                  </div>
                  <div className="flex items-center gap-2">
                    <button 
                      onClick={() => { setEditingStore(storeItem); setShowModal(true); }}
                      className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-primary-600"
                    >
                      <Edit2 className="w-4 h-4" />
                    </button>
                    <button 
                      onClick={() => handleDeleteStore(storeItem.id)}
                      className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-error-600"
                      disabled={storeItem.id === currentStoreId}
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Store Modal */}
      {showModal && (
        <StoreFormModal
          store={editingStore}
          onClose={() => { setShowModal(false); setEditingStore(null); }}
          onSave={handleSaveStore}
        />
      )}
    </div>
  );
}

// Store Form Modal
function StoreFormModal({ store, onClose, onSave }) {
  const isEditing = store !== null;
  
  const defaultHours = {
    monday: { open: '07:00', close: '20:00', closed: false },
    tuesday: { open: '07:00', close: '20:00', closed: false },
    wednesday: { open: '07:00', close: '20:00', closed: false },
    thursday: { open: '07:00', close: '20:00', closed: false },
    friday: { open: '07:00', close: '20:00', closed: false },
    saturday: { open: '08:00', close: '18:00', closed: false },
    sunday: { open: '09:00', close: '15:00', closed: true },
  };

  const [formData, setFormData] = useState({
    name: store?.name || '',
    address: store?.address || '',
    phone: store?.phone || '',
    is_active: store?.is_active !== false,
    geolocation: store?.geolocation || { lat: 9.0, lng: -79.5 }, // Default to Panama City
    opening_hours: store?.opening_hours || defaultHours,
  });
  
  const [saving, setSaving] = useState(false);
  const [gettingLocation, setGettingLocation] = useState(false);
  const [locationError, setLocationError] = useState(null);

  const dayNames = {
    monday: 'Lunes',
    tuesday: 'Martes',
    wednesday: 'Miércoles',
    thursday: 'Jueves',
    friday: 'Viernes',
    saturday: 'Sábado',
    sunday: 'Domingo',
  };

  const getCurrentLocation = () => {
    if (!navigator.geolocation) {
      setLocationError('Geolocalización no soportada en este navegador');
      return;
    }

    setGettingLocation(true);
    setLocationError(null);

    navigator.geolocation.getCurrentPosition(
      (position) => {
        setFormData({
          ...formData,
          geolocation: {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          }
        });
        setGettingLocation(false);
      },
      (error) => {
        console.error('Geolocation error:', error);
        setLocationError('No se pudo obtener la ubicación. Verifica los permisos.');
        setGettingLocation(false);
      },
      { enableHighAccuracy: true, timeout: 10000 }
    );
  };

  const handleHoursChange = (day, field, value) => {
    setFormData({
      ...formData,
      opening_hours: {
        ...formData.opening_hours,
        [day]: { ...formData.opening_hours[day], [field]: value }
      }
    });
  };

  const handleSubmit = async () => {
    // Validate required fields
    if (!formData.name.trim()) {
      alert('El nombre de la tienda es requerido');
      return;
    }
    
    const lat = formData.geolocation?.lat;
    const lng = formData.geolocation?.lng;
    if (lat == null || lng == null || isNaN(lat) || isNaN(lng)) {
      alert('La geolocalización es requerida. Usa "Usar mi ubicación" o ingresa las coordenadas manualmente.');
      return;
    }

    setSaving(true);
    
    // Use try-finally to ensure saving is always reset
    try {
      await onSave(formData);
    } catch (err) {
      console.error('Error in handleSubmit:', err);
      alert('Error al guardar: ' + (err.message || 'Error desconocido'));
    } finally {
      // Always reset saving state (modal might already be closed, but that's ok)
      setSaving(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-2xl max-h-[90vh] flex flex-col animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">
            {isEditing ? 'Editar Tienda' : 'Nueva Tienda'}
          </h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Form */}
        <div className="flex-1 overflow-y-auto p-6 space-y-6">
          {/* Basic Info */}
          <div className="grid grid-cols-2 gap-4">
            <div className="col-span-2">
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Nombre de Tienda <span className="text-error-500">*</span>
              </label>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="input"
                placeholder="American Laundry - Costa del Este"
              />
            </div>
            
            <div className="col-span-2">
              <label className="block text-sm font-medium text-slate-700 mb-1">Dirección</label>
              <input
                type="text"
                value={formData.address}
                onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                className="input"
                placeholder="Costa del Este, Panamá"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Teléfono</label>
              <input
                type="text"
                value={formData.phone}
                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                className="input"
                placeholder="+507 6123-4567"
              />
            </div>
            
            <div className="flex items-end">
              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={formData.is_active}
                  onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                  className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                />
                <span className="text-sm text-slate-700">Tienda activa</span>
              </label>
            </div>
          </div>

          {/* Geolocation */}
          <div className="p-4 bg-slate-50 rounded-xl">
            <div className="flex items-center justify-between mb-3">
              <div>
                <label className="block text-sm font-medium text-slate-700">
                  Geolocalización <span className="text-error-500">*</span>
                </label>
                <p className="text-xs text-slate-500">Requerida para entregas y mapas</p>
              </div>
              <button
                onClick={getCurrentLocation}
                disabled={gettingLocation}
                className="btn-secondary text-sm"
              >
                {gettingLocation ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Obteniendo...
                  </>
                ) : (
                  <>
                    <MapPin className="w-4 h-4" />
                    Usar mi ubicación
                  </>
                )}
              </button>
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-xs text-slate-500 mb-1">Latitud</label>
                <input
                  type="number"
                  step="0.000001"
                  value={formData.geolocation?.lat ?? ''}
                  onChange={(e) => {
                    const val = e.target.value;
                    setFormData({
                      ...formData,
                      geolocation: { 
                        ...formData.geolocation, 
                        lat: val === '' ? null : parseFloat(val) 
                      }
                    });
                  }}
                  className="input"
                  placeholder="9.0"
                />
              </div>
              <div>
                <label className="block text-xs text-slate-500 mb-1">Longitud</label>
                <input
                  type="number"
                  step="0.000001"
                  value={formData.geolocation?.lng ?? ''}
                  onChange={(e) => {
                    const val = e.target.value;
                    setFormData({
                      ...formData,
                      geolocation: { 
                        ...formData.geolocation, 
                        lng: val === '' ? null : parseFloat(val) 
                      }
                    });
                  }}
                  className="input"
                  placeholder="-79.5"
                />
              </div>
            </div>
            
            {locationError && (
              <p className="text-xs text-error-600 mt-2">{locationError}</p>
            )}
            
            {formData.geolocation?.lat && formData.geolocation?.lng && (
              <a
                href={`https://www.google.com/maps?q=${formData.geolocation.lat},${formData.geolocation.lng}`}
                target="_blank"
                rel="noopener noreferrer"
                className="text-xs text-primary-600 hover:underline mt-2 inline-block"
              >
                Ver en Google Maps →
              </a>
            )}
          </div>

          {/* Opening Hours */}
          <div>
            <h3 className="text-sm font-medium text-slate-700 mb-3">Horario de Atención</h3>
            <div className="space-y-2">
              {Object.entries(formData.opening_hours).map(([day, schedule]) => (
                <div key={day} className="flex items-center gap-3 py-2 border-b border-slate-100 last:border-0">
                  <span className="w-24 text-sm font-medium text-slate-700">{dayNames[day]}</span>
                  
                  <label className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      checked={!schedule.closed}
                      onChange={(e) => handleHoursChange(day, 'closed', !e.target.checked)}
                      className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                    />
                    <span className="text-xs text-slate-600">Abierto</span>
                  </label>
                  
                  {!schedule.closed ? (
                    <>
                      <input
                        type="time"
                        value={schedule.open}
                        onChange={(e) => handleHoursChange(day, 'open', e.target.value)}
                        className="input w-28 text-sm"
                      />
                      <span className="text-slate-400 text-sm">a</span>
                      <input
                        type="time"
                        value={schedule.close}
                        onChange={(e) => handleHoursChange(day, 'close', e.target.value)}
                        className="input w-28 text-sm"
                      />
                    </>
                  ) : (
                    <span className="text-sm text-slate-400">Cerrado</span>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
        
        {/* Footer */}
        <div className="flex items-center justify-end gap-3 p-4 border-t border-slate-100">
          <button type="button" onClick={onClose} className="btn-secondary">
            Cancelar
          </button>
          <button 
            onClick={handleSubmit}
            disabled={saving}
            className="btn-primary"
          >
            {saving ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Guardando...
              </>
            ) : (
              <>
                <Save className="w-4 h-4" />
                {isEditing ? 'Guardar Cambios' : 'Crear Tienda'}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

// Workflow Settings Section
function WorkflowSettings() {
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [companyId, setCompanyId] = useState(null);
  const [formData, setFormData] = useState({
    default_completion_days: 1,
    express_completion_days: 0,
  });

  // Load workflow settings from database
  useEffect(() => {
    loadWorkflowSettings();
  }, []);

  const loadWorkflowSettings = async () => {
    setLoading(true);
    try {
      // Get company directly (in case no stores exist)
      const { data: company, error: companyError } = await supabase
        .from('companies')
        .select('id, default_completion_days, express_completion_days')
        .limit(1)
        .single();

      if (companyError) {
        console.error('No company found:', companyError);
        setLoading(false);
        return;
      }

      setCompanyId(company.id);
      setFormData({
        default_completion_days: company.default_completion_days ?? 1,
        express_completion_days: company.express_completion_days ?? 0,
      });
    } catch (err) {
      console.error('Error loading workflow settings:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    if (!companyId) {
      alert('Error: No se encontró el ID de la empresa. Recarga la página.');
      return;
    }

    setSaving(true);
    try {
      // Save to companies table (workflow settings stored with company)
      const { error } = await supabase
        .from('companies')
        .update({
          default_completion_days: formData.default_completion_days,
          express_completion_days: formData.express_completion_days,
          updated_at: new Date().toISOString()
        })
        .eq('id', companyId);

      if (error) throw error;
      alert('Configuración guardada correctamente');
    } catch (err) {
      console.error('Error saving workflow settings:', err);
      alert('Error al guardar: ' + err.message);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center min-h-[200px]">
        <Loader2 className="w-8 h-8 animate-spin text-primary-500" />
      </div>
    );
  }

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Flujo de Trabajo</h2>
          <p className="text-sm text-slate-500">Tiempos de procesamiento de órdenes</p>
        </div>
        <button onClick={handleSave} disabled={saving} className="btn-primary">
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          {saving ? 'Guardando...' : 'Guardar'}
        </button>
      </div>
      
      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Tiempo de entrega normal (días)
          </label>
          <select
            value={formData.default_completion_days}
            onChange={(e) => setFormData({ ...formData, default_completion_days: parseInt(e.target.value) })}
            className="input w-48"
          >
            <option value={0}>Mismo día</option>
            <option value={1}>+1 día</option>
            <option value={2}>+2 días</option>
            <option value={3}>+3 días</option>
          </select>
          <p className="text-xs text-slate-500 mt-1">Tiempo estimado para órdenes regulares</p>
        </div>
        
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Tiempo de entrega express (días)
          </label>
          <select
            value={formData.express_completion_days}
            onChange={(e) => setFormData({ ...formData, express_completion_days: parseInt(e.target.value) })}
            className="input w-48"
          >
            <option value={0}>Mismo día</option>
            <option value={1}>+1 día</option>
          </select>
          <p className="text-xs text-slate-500 mt-1">Tiempo estimado para órdenes express</p>
        </div>
      </div>
    </div>
  );
}

// Users Settings Section
function UsersSettings() {
  const [users, setUsers] = useState([]);
  const [storeId, setStoreId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [noStore, setNoStore] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [editingUser, setEditingUser] = useState(null);
  const [saving, setSaving] = useState(false);
  const [inviting, setInviting] = useState(false);

  useEffect(() => {
    loadUsers();
  }, []);

  const loadUsers = async () => {
    try {
      // Get active store ID
      const { data: store, error: storeError } = await supabase
        .from('stores')
        .select('id')
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();

      if (!store) {
        setNoStore(true);
        setLoading(false);
        return;
      }
      
      setStoreId(store.id);

      const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('store_id', store.id)
        .order('full_name');

      if (error) throw error;
      setUsers(data || []);
    } catch (err) {
      console.error('Error loading users:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleInviteUser = async (userData) => {
    if (!storeId) {
      alert('Error: No se encontró la tienda. Recarga la página.');
      return;
    }

    setInviting(true);
    try {
      // First create the user record in our users table
      const { data: newUser, error: insertError } = await supabase
        .from('users')
        .insert({
          store_id: storeId,
          full_name: userData.full_name,
          email: userData.email,
          role: userData.role,
          initials: userData.full_name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase(),
          is_active: true
        })
        .select()
        .single();

      if (insertError) throw insertError;

      // Then send invitation email via Supabase Auth
      // Using signUp which will send a confirmation email
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email: userData.email,
        password: crypto.randomUUID(), // Temporary password - user will set their own
        options: {
          data: {
            full_name: userData.full_name,
            role: userData.role,
          },
          emailRedirectTo: `${window.location.origin}/set-password`
        }
      });

      if (authError) {
        // If auth fails, still keep the user in our table but warn
        console.warn('Auth signup warning:', authError);
        
        // Try sending a password reset email instead
        const { error: resetError } = await supabase.auth.resetPasswordForEmail(userData.email, {
          redirectTo: `${window.location.origin}/set-password`
        });
        
        if (resetError) {
          alert('Usuario creado pero hubo un problema enviando la invitación. El usuario puede usar "Olvidé mi contraseña" para acceder.');
        } else {
          alert('Invitación enviada correctamente a ' + userData.email);
        }
      } else {
        // Link auth_id if we got one
        if (authData?.user?.id) {
          await supabase
            .from('users')
            .update({ auth_id: authData.user.id })
            .eq('id', newUser.id);
        }
        alert('Invitación enviada correctamente a ' + userData.email);
      }

      await loadUsers();
      setShowModal(false);
    } catch (err) {
      console.error('Error inviting user:', err);
      if (err.message?.includes('duplicate key') || err.message?.includes('already exists')) {
        alert('Ya existe un usuario con ese email');
      } else {
        alert('Error al crear usuario: ' + err.message);
      }
    } finally {
      setInviting(false);
    }
  };

  const handleResendInvitation = async (user) => {
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(user.email, {
        redirectTo: `${window.location.origin}/set-password`
      });
      
      if (error) throw error;
      alert('Invitación reenviada a ' + user.email);
    } catch (err) {
      console.error('Error resending invitation:', err);
      alert('Error al reenviar invitación: ' + err.message);
    }
  };

  const handleUpdateUser = async (userData) => {
    setSaving(true);
    try {
      const { error } = await supabase
        .from('users')
        .update({
          full_name: userData.full_name,
          role: userData.role,
          initials: userData.full_name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase(),
          is_active: userData.is_active,
          updated_at: new Date().toISOString()
        })
        .eq('id', editingUser.id);

      if (error) throw error;

      await loadUsers();
      setShowModal(false);
      setEditingUser(null);
    } catch (err) {
      console.error('Error updating user:', err);
      alert('Error al actualizar usuario: ' + err.message);
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteUser = async (userId) => {
    if (!window.confirm('¿Estás seguro de eliminar este usuario? Esta acción no se puede deshacer.')) return;

    try {
      const { error } = await supabase
        .from('users')
        .delete()
        .eq('id', userId);

      if (error) throw error;
      await loadUsers();
    } catch (err) {
      console.error('Error deleting user:', err);
      alert('Error al eliminar usuario: ' + err.message);
    }
  };

  const toggleUserActive = async (user) => {
    try {
      const { error } = await supabase
        .from('users')
        .update({ is_active: !user.is_active, updated_at: new Date().toISOString() })
        .eq('id', user.id);

      if (error) throw error;
      await loadUsers();
    } catch (err) {
      console.error('Error updating user:', err);
    }
  };

  const roleLabels = {
    admin: 'Administrador',
    supervisor: 'Supervisor',
    operator: 'Operador',
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center">
        <Loader2 className="w-6 h-6 animate-spin text-primary-500" />
      </div>
    );
  }

  if (noStore) {
    return (
      <div className="card p-6">
        <div className="text-center py-12 text-slate-400">
          <Store className="w-12 h-12 mx-auto mb-3 opacity-50" />
          <p className="font-medium">No hay tienda configurada</p>
          <p className="text-sm mt-1">Primero crea una tienda en la sección "Tiendas"</p>
        </div>
      </div>
    );
  }

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Gestión de Usuarios</h2>
          <p className="text-sm text-slate-500">Invita y administra los usuarios del sistema</p>
        </div>
        <button 
          onClick={() => { setEditingUser(null); setShowModal(true); }}
          className="btn-primary"
        >
          <Mail className="w-4 h-4" />
          Invitar Usuario
        </button>
      </div>

      <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
        <p className="text-sm text-blue-700">
          <strong>Nota:</strong> Los nuevos usuarios recibirán un email de invitación. Al confirmar, podrán establecer su contraseña.
        </p>
      </div>
      
      {users.length > 0 ? (
        <div className="space-y-3">
          {users.map((user) => (
            <div key={user.id} className={`flex items-center gap-4 p-4 bg-slate-50 rounded-xl ${!user.is_active ? 'opacity-50' : ''}`}>
              <div className={`w-10 h-10 ${user.auth_id ? 'bg-primary-500' : 'bg-amber-500'} text-white rounded-full flex items-center justify-center font-semibold`}>
                {user.initials || user.full_name?.split(' ').map(n => n[0]).join('').slice(0, 2) || '??'}
              </div>
              <div className="flex-1">
                <p className="font-medium text-slate-800">{user.full_name}</p>
                <p className="text-sm text-slate-500">{user.email}</p>
              </div>
              <span className={`badge ${
                user.role === 'admin' ? 'bg-purple-100 text-purple-700' :
                user.role === 'supervisor' ? 'bg-blue-100 text-blue-700' :
                'bg-slate-100 text-slate-700'
              }`}>
                {roleLabels[user.role] || user.role}
              </span>
              {!user.auth_id ? (
                <span className="badge bg-amber-100 text-amber-700">Pendiente</span>
              ) : (
                <span className="badge bg-success-100 text-success-700">Confirmado</span>
              )}
              {!user.is_active && (
                <span className="badge bg-red-100 text-red-700">Inactivo</span>
              )}
              <label className="relative inline-flex items-center cursor-pointer">
                <input 
                  type="checkbox" 
                  checked={user.is_active} 
                  onChange={() => toggleUserActive(user)}
                  className="sr-only peer" 
                />
                <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
              </label>
              {!user.auth_id && (
                <button 
                  onClick={() => handleResendInvitation(user)}
                  className="p-2 hover:bg-white rounded-lg text-slate-500 hover:text-primary-600"
                  title="Reenviar invitación"
                >
                  <Send className="w-4 h-4" />
                </button>
              )}
              <button 
                onClick={() => { setEditingUser(user); setShowModal(true); }}
                className="p-2 hover:bg-white rounded-lg text-slate-500 hover:text-primary-600"
                title="Editar usuario"
              >
                <Edit2 className="w-4 h-4" />
              </button>
              <button 
                onClick={() => handleDeleteUser(user.id)}
                className="p-2 hover:bg-white rounded-lg text-slate-500 hover:text-error-600"
                title="Eliminar usuario"
              >
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          ))}
        </div>
      ) : (
        <div className="text-center py-8 text-slate-400">
          <Users className="w-12 h-12 mx-auto mb-2 opacity-50" />
          <p>No hay usuarios registrados</p>
          <p className="text-sm mt-1">Invita al primer usuario para comenzar</p>
        </div>
      )}

      {/* User Form Modal */}
      {showModal && (
        <UserFormModal
          user={editingUser}
          onClose={() => { setShowModal(false); setEditingUser(null); }}
          onSave={editingUser ? handleUpdateUser : handleInviteUser}
          saving={saving || inviting}
          isInvite={!editingUser}
        />
      )}
    </div>
  );
}

// User Form Modal
function UserFormModal({ user, onClose, onSave, saving, isInvite }) {
  const isEditing = user !== null;
  const [formData, setFormData] = useState({
    full_name: user?.full_name || '',
    email: user?.email || '',
    role: user?.role || 'operator',
    is_active: user?.is_active !== false,
  });

  const handleSubmit = () => {
    if (!formData.full_name.trim()) {
      alert('El nombre es requerido');
      return;
    }
    if (!formData.email.trim() || !formData.email.includes('@')) {
      alert('Email válido es requerido');
      return;
    }
    onSave(formData);
  };

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in">
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">
            {isEditing ? 'Editar Usuario' : 'Invitar Nuevo Usuario'}
          </h2>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg transition-colors">
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>

        <div className="p-6 space-y-4">
          {isInvite && (
            <div className="bg-blue-50 border border-blue-200 rounded-xl p-3 text-sm text-blue-700">
              El usuario recibirá un email con un enlace para establecer su contraseña.
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Nombre Completo <span className="text-error-500">*</span>
            </label>
            <input
              type="text"
              value={formData.full_name}
              onChange={(e) => setFormData({ ...formData, full_name: e.target.value })}
              className="input"
              placeholder="Juan Pérez"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Email <span className="text-error-500">*</span>
            </label>
            <input
              type="email"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className="input"
              placeholder="juan@ejemplo.com"
              disabled={isEditing} // Can't change email after creation
            />
            {isEditing && (
              <p className="text-xs text-slate-500 mt-1">El email no se puede modificar</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Rol</label>
            <select
              value={formData.role}
              onChange={(e) => setFormData({ ...formData, role: e.target.value })}
              className="input"
            >
              <option value="operator">Operador</option>
              <option value="supervisor">Supervisor</option>
              <option value="admin">Administrador</option>
            </select>
            <p className="text-xs text-slate-500 mt-1">
              {formData.role === 'admin' && 'Acceso completo a todas las funciones'}
              {formData.role === 'supervisor' && 'Puede gestionar órdenes y ver reportes'}
              {formData.role === 'operator' && 'Puede crear y procesar órdenes'}
            </p>
          </div>

          {isEditing && (
            <div className="flex items-center gap-3">
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={formData.is_active}
                  onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
              </label>
              <span className="text-sm text-slate-700">Usuario activo</span>
            </div>
          )}
        </div>

        <div className="flex items-center justify-end gap-3 p-4 border-t border-slate-100">
          <button onClick={onClose} className="btn-secondary">Cancelar</button>
          <button onClick={handleSubmit} disabled={saving} className="btn-primary">
            {saving ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                {isInvite ? 'Enviando...' : 'Guardando...'}
              </>
            ) : (
              <>
                {isInvite ? <Send className="w-4 h-4" /> : <Save className="w-4 h-4" />}
                {isInvite ? 'Enviar Invitación' : 'Guardar Cambios'}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

// Payment Methods Settings Section
function PaymentMethodsSettings() {
  const [saving, setSaving] = useState(false);
  const [methods, setMethods] = useState([]);
  const [loading, setLoading] = useState(true);
  const [storeId, setStoreId] = useState(null);
  const [noStore, setNoStore] = useState(false);

  // Load payment methods from database
  useEffect(() => {
    loadPaymentMethods();
  }, []);

  const loadPaymentMethods = async () => {
    try {
      // Get active store ID
      const { data: store, error: storeError } = await supabase
        .from('stores')
        .select('id')
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();

      if (!store) {
        setNoStore(true);
        setLoading(false);
        return;
      }
      
      setStoreId(store.id);

      const { data, error } = await supabase
        .from('payment_methods')
        .select('*')
        .eq('store_id', store.id)
        .order('display_order');

      if (error) throw error;
      
      // If no methods exist, create defaults
      if (!data || data.length === 0) {
        const defaultMethods = [
          { name: 'Efectivo', icon: '💵', is_active: true, display_order: 0 },
          { name: 'Tarjeta', icon: '💳', is_active: true, display_order: 1 },
          { name: 'Yappy', icon: '📱', is_active: true, display_order: 2 },
          { name: 'ACH', icon: '🏦', is_active: true, display_order: 3 },
          { name: 'Facturar', icon: '📄', is_active: true, display_order: 4 },
          { name: 'Pagar al Recoger', icon: '🛒', is_active: true, display_order: 5 },
        ];
        setMethods(defaultMethods.map((m, i) => ({ ...m, id: `temp-${i}`, store_id: store.id })));
      } else {
        setMethods(data);
      }
    } catch (err) {
      console.error('Error loading payment methods:', err);
    } finally {
      setLoading(false);
    }
  };

  const toggleMethod = (id) => {
    setMethods(methods.map(m => 
      m.id === id ? { ...m, is_active: !m.is_active } : m
    ));
  };

  const handleSave = async () => {
    if (!storeId) {
      alert('Error: No se encontró la tienda. Recarga la página.');
      return;
    }

    setSaving(true);
    try {
      // Upsert all payment methods
      for (const method of methods) {
        if (method.id.toString().startsWith('temp-')) {
          // Insert new method
          const { error } = await supabase
            .from('payment_methods')
            .insert({
              store_id: storeId,
              name: method.name,
              icon: method.icon,
              is_active: method.is_active,
              display_order: method.display_order
            });
          if (error) throw error;
        } else {
          // Update existing method
          const { error } = await supabase
            .from('payment_methods')
            .update({ is_active: method.is_active })
            .eq('id', method.id);
          if (error) throw error;
        }
      }
      
      alert('Métodos de pago guardados correctamente');
      loadPaymentMethods(); // Reload to get proper IDs
    } catch (err) {
      console.error('Error saving payment methods:', err);
      alert('Error al guardar: ' + err.message);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center">
        <Loader2 className="w-6 h-6 animate-spin text-primary-500" />
      </div>
    );
  }

  if (noStore) {
    return (
      <div className="card p-6">
        <div className="text-center py-12 text-slate-400">
          <Store className="w-12 h-12 mx-auto mb-3 opacity-50" />
          <p className="font-medium">No hay tienda configurada</p>
          <p className="text-sm mt-1">Primero crea una tienda en la sección "Tiendas"</p>
        </div>
      </div>
    );
  }

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Métodos de Pago</h2>
          <p className="text-sm text-slate-500">Configura las formas de pago aceptadas</p>
        </div>
        <button onClick={handleSave} disabled={saving} className="btn-primary">
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          {saving ? 'Guardando...' : 'Guardar'}
        </button>
      </div>
      
      <div className="space-y-3">
        {methods.map((method) => (
          <div key={method.id} className="flex items-center gap-4 p-4 bg-slate-50 rounded-xl">
            <span className="text-2xl">{method.icon}</span>
            <span className="flex-1 font-medium text-slate-700">{method.name}</span>
            <label className="relative inline-flex items-center cursor-pointer">
              <input 
                type="checkbox" 
                checked={method.is_active} 
                onChange={() => toggleMethod(method.id)}
                className="sr-only peer" 
              />
              <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
            </label>
          </div>
        ))}
      </div>
    </div>
  );
}

// Notifications Settings Section with SMTP Configuration
function NotificationsSettings() {
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [testing, setTesting] = useState(false);
  const [companyId, setCompanyId] = useState(null);
  const [showPassword, setShowPassword] = useState(false);
  const [testEmail, setTestEmail] = useState('');
  const [activeTab, setActiveTab] = useState('smtp'); // smtp, templates
  
  const [smtpConfig, setSmtpConfig] = useState({
    smtp_host: '',
    smtp_port: 587,
    smtp_user: '',
    smtp_pass: '',
    smtp_from_name: '',
    smtp_from_email: '',
    smtp_secure: true, // TLS
  });

  const [templates, setTemplates] = useState([
    { id: 'welcome', name: 'Bienvenida', description: 'Email de bienvenida al registrar cliente', enabled: true, subject: '¡Bienvenido a {company_name}!' },
    { id: 'order_created', name: 'Orden Creada', description: 'Confirmación de recepción de orden', enabled: true, subject: 'Tu orden #{order_number} ha sido recibida' },
    { id: 'order_ready', name: 'Orden Lista', description: 'Notificación cuando la orden está lista para recoger', enabled: true, subject: 'Tu orden #{order_number} está lista' },
    { id: 'order_delivered', name: 'Orden Entregada', description: 'Confirmación de entrega completada', enabled: false, subject: 'Tu orden #{order_number} ha sido entregada' },
  ]);

  useEffect(() => {
    loadSettings();
  }, []);

  const loadSettings = async () => {
    setLoading(true);
    try {
      // Load company SMTP settings
      const { data: company, error } = await supabase
        .from('companies')
        .select('id, name, smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email, smtp_secure')
        .limit(1)
        .single();

      if (error) throw error;

      setCompanyId(company.id);
      setSmtpConfig({
        smtp_host: company.smtp_host || '',
        smtp_port: company.smtp_port || 587,
        smtp_user: company.smtp_user || '',
        smtp_pass: company.smtp_pass || '',
        smtp_from_name: company.smtp_from_name || company.name || '',
        smtp_from_email: company.smtp_from_email || '',
        smtp_secure: company.smtp_secure !== false,
      });

      // Load notification settings if they exist
      const { data: notifSettings } = await supabase
        .from('notification_settings')
        .select('*')
        .eq('company_id', company.id);

      if (notifSettings && notifSettings.length > 0) {
        setTemplates(prev => prev.map(t => {
          const saved = notifSettings.find(n => n.template_id === t.id);
          return saved ? { ...t, enabled: saved.enabled, subject: saved.subject || t.subject } : t;
        }));
      }

    } catch (err) {
      console.error('Error loading SMTP settings:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleSaveSMTP = async () => {
    console.log('=== handleSaveSMTP called ===');
    console.log('companyId:', companyId);
    
    if (!companyId) {
      alert('Error: No se encontró la empresa');
      return;
    }

    setSaving(true);
    try {
      const updateData = {
        smtp_host: smtpConfig.smtp_host || null,
        smtp_port: smtpConfig.smtp_port || 587,
        smtp_user: smtpConfig.smtp_user || null,
        smtp_pass: smtpConfig.smtp_pass || null,
        smtp_from_name: smtpConfig.smtp_from_name || null,
        smtp_from_email: smtpConfig.smtp_from_email || null,
        smtp_secure: smtpConfig.smtp_secure,
        updated_at: new Date().toISOString()
      };
      
      console.log('Sending update (fire and forget)...');

      // Fire the update but don't wait for it
      supabase
        .from('companies')
        .update(updateData)
        .eq('id', companyId)
        .then(res => console.log('Update completed:', res))
        .catch(err => console.log('Update error:', err));

      // Wait 2 seconds then verify
      await new Promise(r => setTimeout(r, 2000));
      
      console.log('Verifying save...');
      const { data: verifyData, error: verifyError } = await supabase
        .from('companies')
        .select('smtp_host, smtp_user, smtp_port, smtp_from_name')
        .eq('id', companyId)
        .single();
      
      console.log('Verification result:', verifyData, verifyError);
      
      if (verifyError) {
        throw verifyError;
      }
      
      if (verifyData?.smtp_host === smtpConfig.smtp_host && 
          verifyData?.smtp_user === smtpConfig.smtp_user) {
        console.log('Verified: Data was saved');
        alert('✅ Configuración SMTP guardada correctamente');
      } else {
        console.log('Data mismatch. Expected:', smtpConfig.smtp_host, 'Got:', verifyData?.smtp_host);
        // Data didn't match - maybe needs more time
        await new Promise(r => setTimeout(r, 2000));
        
        // Try one more verification
        const { data: retry } = await supabase
          .from('companies')
          .select('smtp_host, smtp_user')
          .eq('id', companyId)
          .single();
          
        if (retry?.smtp_host === smtpConfig.smtp_host) {
          alert('✅ Configuración SMTP guardada correctamente');
        } else {
          alert('⚠️ No se pudo verificar si los datos se guardaron.\n\nRecarga la página para verificar.');
        }
      }
      
    } catch (err) {
      console.error('Error:', err);
      alert('Error: ' + (err.message || JSON.stringify(err)));
    } finally {
      setSaving(false);
      console.log('=== handleSaveSMTP finished ===');
    }
  };

  const handleTestEmail = async () => {
    if (!testEmail) {
      alert('Ingresa un email de prueba');
      return;
    }
    if (!smtpConfig.smtp_host || !smtpConfig.smtp_user) {
      alert('Primero configura y guarda los datos SMTP');
      return;
    }

    setTesting(true);
    try {
      // Call Vercel API endpoint
      const response = await fetch('/api/send-email', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          to: testEmail,
          subject: '✅ Prueba de Email - American Laundry',
          html: `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
              <h1 style="color: #0891b2;">¡Configuración Exitosa!</h1>
              <p>Este es un email de prueba de tu sistema American Laundry OMS.</p>
              <p>Si recibes este mensaje, tu configuración SMTP está funcionando correctamente.</p>
              <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
              <p style="color: #64748b; font-size: 12px;">
                Enviado desde: ${smtpConfig.smtp_from_name || 'American Laundry'}<br>
                Servidor: ${smtpConfig.smtp_host}:${smtpConfig.smtp_port}
              </p>
            </div>
          `,
          company_id: companyId
        })
      });

      const data = await response.json();
      
      if (data.success) {
        alert('✅ Email de prueba enviado correctamente a ' + testEmail);
      } else {
        alert('❌ Error: ' + (data.error || 'No se pudo enviar el email'));
      }
    } catch (err) {
      console.error('Error sending test email:', err);
      alert('Error: ' + err.message);
    } finally {
      setTesting(false);
    }
  };

  const toggleTemplate = async (templateId) => {
    const template = templates.find(t => t.id === templateId);
    const newEnabled = !template.enabled;
    
    setTemplates(prev => prev.map(t => 
      t.id === templateId ? { ...t, enabled: newEnabled } : t
    ));

    // Save to database
    try {
      const { error } = await supabase
        .from('notification_settings')
        .upsert({
          company_id: companyId,
          template_id: templateId,
          enabled: newEnabled,
          subject: template.subject,
          updated_at: new Date().toISOString()
        }, { onConflict: 'company_id,template_id' });

      if (error) throw error;
    } catch (err) {
      console.error('Error saving template setting:', err);
      // Revert on error
      setTemplates(prev => prev.map(t => 
        t.id === templateId ? { ...t, enabled: !newEnabled } : t
      ));
    }
  };

  const smtpPresets = [
    { name: 'Gmail', host: 'smtp.gmail.com', port: 587 },
    { name: 'Outlook', host: 'smtp.office365.com', port: 587 },
    { name: 'Yahoo', host: 'smtp.mail.yahoo.com', port: 587 },
    { name: 'SendGrid', host: 'smtp.sendgrid.net', port: 587 },
    { name: 'Mailgun', host: 'smtp.mailgun.org', port: 587 },
  ];

  const applyPreset = (preset) => {
    setSmtpConfig(prev => ({
      ...prev,
      smtp_host: preset.host,
      smtp_port: preset.port
    }));
  };

  if (loading) {
    return (
      <div className="card p-6 flex items-center justify-center">
        <Loader2 className="w-6 h-6 animate-spin text-primary-500" />
      </div>
    );
  }

  const isConfigured = smtpConfig.smtp_host && smtpConfig.smtp_user && smtpConfig.smtp_pass;

  return (
    <div className="space-y-6">
      {/* Tabs */}
      <div className="flex gap-2 border-b border-slate-200 pb-2">
        <button
          onClick={() => setActiveTab('smtp')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            activeTab === 'smtp' 
              ? 'bg-primary-500 text-white' 
              : 'text-slate-600 hover:bg-slate-100'
          }`}
        >
          <SettingsIcon className="w-4 h-4 inline mr-2" />
          Configuración SMTP
        </button>
        <button
          onClick={() => setActiveTab('templates')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            activeTab === 'templates' 
              ? 'bg-primary-500 text-white' 
              : 'text-slate-600 hover:bg-slate-100'
          }`}
        >
          <Mail className="w-4 h-4 inline mr-2" />
          Plantillas
        </button>
      </div>

      {activeTab === 'smtp' && (
        <div className="card p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-lg font-semibold text-slate-800">Configuración del Servidor SMTP</h2>
              <p className="text-sm text-slate-500">Configura tu servidor de correo para enviar notificaciones</p>
            </div>
            {isConfigured ? (
              <span className="badge bg-success-100 text-success-700">
                <Check className="w-3 h-3 mr-1" />
                Configurado
              </span>
            ) : (
              <span className="badge bg-amber-100 text-amber-700">
                Sin configurar
              </span>
            )}
          </div>

          {/* Presets */}
          <div className="mb-6">
            <label className="block text-sm font-medium text-slate-700 mb-2">Presets rápidos</label>
            <div className="flex flex-wrap gap-2">
              {smtpPresets.map(preset => (
                <button
                  key={preset.name}
                  onClick={() => applyPreset(preset)}
                  className="px-3 py-1.5 text-sm bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors"
                >
                  {preset.name}
                </button>
              ))}
            </div>
          </div>

          {/* SMTP Form */}
          <div className="grid grid-cols-2 gap-4 mb-6">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Servidor SMTP <span className="text-error-500">*</span>
              </label>
              <input
                type="text"
                value={smtpConfig.smtp_host}
                onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_host: e.target.value })}
                className="input"
                placeholder="smtp.gmail.com"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Puerto <span className="text-error-500">*</span>
              </label>
              <input
                type="number"
                value={smtpConfig.smtp_port}
                onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_port: parseInt(e.target.value) || 587 })}
                className="input"
                placeholder="587"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Usuario / Email <span className="text-error-500">*</span>
              </label>
              <input
                type="email"
                value={smtpConfig.smtp_user}
                onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_user: e.target.value })}
                className="input"
                placeholder="tu-email@gmail.com"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Contraseña / App Password <span className="text-error-500">*</span>
              </label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={smtpConfig.smtp_pass}
                  onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_pass: e.target.value })}
                  className="input pr-10"
                  placeholder="••••••••••••"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Nombre del remitente</label>
              <input
                type="text"
                value={smtpConfig.smtp_from_name}
                onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_from_name: e.target.value })}
                className="input"
                placeholder="American Laundry"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Email del remitente</label>
              <input
                type="email"
                value={smtpConfig.smtp_from_email}
                onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_from_email: e.target.value })}
                className="input"
                placeholder="notificaciones@tuempresa.com"
              />
              <p className="text-xs text-slate-400 mt-1">Dejar vacío para usar el usuario SMTP</p>
            </div>

            <div className="col-span-2">
              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={smtpConfig.smtp_secure}
                  onChange={(e) => setSmtpConfig({ ...smtpConfig, smtp_secure: e.target.checked })}
                  className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                />
                <span className="text-sm text-slate-700">Usar TLS/SSL (recomendado)</span>
              </label>
            </div>
          </div>

          {/* Gmail Help */}
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
            <p className="text-sm text-blue-700 font-medium mb-2">📧 Usando Gmail?</p>
            <ol className="text-sm text-blue-600 space-y-1 list-decimal list-inside">
              <li>Activa la verificación en 2 pasos en tu cuenta de Google</li>
              <li>Ve a <a href="https://myaccount.google.com/apppasswords" target="_blank" rel="noopener noreferrer" className="underline">myaccount.google.com/apppasswords</a></li>
              <li>Crea una "Contraseña de aplicación" para "Correo"</li>
              <li>Usa esa contraseña (16 caracteres) en el campo de arriba</li>
            </ol>
          </div>

          {/* Actions - Sticky at bottom */}
          <div className="sticky bottom-0 bg-white pt-4 pb-2 border-t border-slate-200 -mx-6 px-6 mt-6">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <input
                  type="email"
                  value={testEmail}
                  onChange={(e) => setTestEmail(e.target.value)}
                  className="input w-64"
                  placeholder="Email para prueba"
                />
                <button
                  onClick={handleTestEmail}
                  disabled={testing || !isConfigured}
                  className="btn-secondary"
                >
                  {testing ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      Enviando...
                    </>
                  ) : (
                    <>
                      <Send className="w-4 h-4" />
                      Enviar Prueba
                    </>
                  )}
                </button>
              </div>
              
              <button
                onClick={() => {
                  console.log('Save button clicked!');
                  handleSaveSMTP();
                }}
                disabled={saving}
                className="btn-primary px-6"
              >
                {saving ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Guardando...
                  </>
                ) : (
                  <>
                    <Save className="w-4 h-4" />
                    Guardar Configuración
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      )}

      {activeTab === 'templates' && (
        <div className="card p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-lg font-semibold text-slate-800">Plantillas de Notificación</h2>
              <p className="text-sm text-slate-500">Activa o desactiva las notificaciones automáticas</p>
            </div>
          </div>

          {!isConfigured && (
            <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-6">
              <p className="text-sm text-amber-700">
                <strong>⚠️ Atención:</strong> Primero configura el servidor SMTP para poder enviar notificaciones.
              </p>
            </div>
          )}

          <div className="space-y-3">
            {templates.map((template) => (
              <div 
                key={template.id} 
                className={`flex items-center gap-4 p-4 rounded-xl transition-colors ${
                  isConfigured ? 'bg-slate-50 hover:bg-slate-100' : 'bg-slate-50 opacity-60'
                }`}
              >
                <div className={`w-10 h-10 rounded-full flex items-center justify-center ${
                  template.enabled && isConfigured ? 'bg-primary-100 text-primary-600' : 'bg-slate-200 text-slate-400'
                }`}>
                  <Mail className="w-5 h-5" />
                </div>
                <div className="flex-1">
                  <p className="font-medium text-slate-700">{template.name}</p>
                  <p className="text-sm text-slate-500">{template.description}</p>
                  <p className="text-xs text-slate-400 mt-1">Asunto: {template.subject}</p>
                </div>
                <label className={`relative inline-flex items-center ${isConfigured ? 'cursor-pointer' : 'cursor-not-allowed'}`}>
                  <input 
                    type="checkbox" 
                    checked={template.enabled}
                    onChange={() => isConfigured && toggleTemplate(template.id)}
                    disabled={!isConfigured}
                    className="sr-only peer" 
                  />
                  <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
                </label>
              </div>
            ))}
          </div>

          {/* Variables Info */}
          <div className="mt-6 p-4 bg-slate-50 rounded-xl">
            <p className="text-sm font-medium text-slate-700 mb-2">Variables disponibles en plantillas:</p>
            <div className="grid grid-cols-2 gap-2 text-xs text-slate-500">
              <span><code className="bg-slate-200 px-1 rounded">{'{customer_name}'}</code> - Nombre del cliente</span>
              <span><code className="bg-slate-200 px-1 rounded">{'{order_number}'}</code> - Número de orden</span>
              <span><code className="bg-slate-200 px-1 rounded">{'{company_name}'}</code> - Nombre de la empresa</span>
              <span><code className="bg-slate-200 px-1 rounded">{'{total}'}</code> - Total de la orden</span>
              <span><code className="bg-slate-200 px-1 rounded">{'{promised_date}'}</code> - Fecha prometida</span>
              <span><code className="bg-slate-200 px-1 rounded">{'{store_phone}'}</code> - Teléfono de la tienda</span>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

// Products Settings - Full Implementation
function ProductsSettings() {
  const { state, actions } = useApp();
  const { 
    updateProductsOrder, 
    addProduct: dbAddProduct, 
    updateProduct: dbUpdateProduct, 
    deleteProduct: dbDeleteProduct,
    addSection: dbAddSection,
    updateSection: dbUpdateSection,
    deleteSection: dbDeleteSection,
    storeId
  } = useDataLoader();
  const [activeTab, setActiveTab] = useState('products'); // products, sections, preferences
  const [selectedSection, setSelectedSection] = useState('all');
  const [showAddModal, setShowAddModal] = useState(false);
  const [editingProduct, setEditingProduct] = useState(null);
  const [showSectionModal, setShowSectionModal] = useState(false);
  const [editingSection, setEditingSection] = useState(null);
  const [draggedItem, setDraggedItem] = useState(null);
  const [dragOverItem, setDragOverItem] = useState(null);
  const [savingProducts, setSavingProducts] = useState(new Set()); // Track products being saved
  const [saving, setSaving] = useState(false);
  
  const ITBMS_RATE = state.settings?.itbms_rate || 7;
  
  // Helper to calculate price with ITBMS
  const getPriceWithTax = (basePrice) => {
    if (!basePrice) return null;
    return basePrice * (1 + ITBMS_RATE / 100);
  };
  
  // Sections from state
  const sections = state.sections || [];
  
  // Products from state
  const products = state.products || [];
  
  // Group and sort products: parents with their children, sorted by display_order
  const getGroupedProducts = () => {
    // Filter by section first
    const sectionProducts = selectedSection === 'all' 
      ? [...products] 
      : products.filter(p => p.section_id === selectedSection);
    
    // Separate parents, standalone, and children
    const parentProducts = sectionProducts.filter(p => p.has_children);
    const childProducts = sectionProducts.filter(p => p.parent_id);
    const standaloneProducts = sectionProducts.filter(p => !p.has_children && !p.parent_id);
    
    // Create grouped structure
    const groups = [];
    
    // Add parent products with their children
    parentProducts
      .sort((a, b) => (a.display_order || 0) - (b.display_order || 0))
      .forEach(parent => {
        const children = childProducts
          .filter(c => c.parent_id === parent.id)
          .sort((a, b) => (a.display_order || 0) - (b.display_order || 0));
        groups.push({ type: 'group', parent, children });
      });
    
    // Add standalone products
    standaloneProducts
      .sort((a, b) => (a.display_order || 0) - (b.display_order || 0))
      .forEach(product => {
        groups.push({ type: 'standalone', product });
      });
    
    // Sort all groups by the display_order of the first item
    groups.sort((a, b) => {
      const orderA = a.type === 'group' ? (a.parent.display_order || 0) : (a.product.display_order || 0);
      const orderB = b.type === 'group' ? (b.parent.display_order || 0) : (b.product.display_order || 0);
      return orderA - orderB;
    });
    
    return groups;
  };
  
  const groupedProducts = getGroupedProducts();
  
  // Drag handlers for groups/standalone products
  const handleDragStart = (e, index, type) => {
    setDraggedItem({ index, type });
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/plain', index);
    // Add visual feedback
    setTimeout(() => {
      e.target.closest('.drag-group')?.classList.add('opacity-50');
    }, 0);
  };
  
  const handleDragEnd = (e) => {
    e.target.closest('.drag-group')?.classList.remove('opacity-50');
    setDraggedItem(null);
    setDragOverItem(null);
  };
  
  const handleDragOver = (e, index) => {
    e.preventDefault();
    if (draggedItem?.index !== index) {
      setDragOverItem(index);
    }
  };
  
  const handleDragLeave = () => {
    setDragOverItem(null);
  };
  
  const handleDrop = async (e, dropIndex) => {
    e.preventDefault();
    
    if (draggedItem === null || draggedItem.index === dropIndex) {
      setDragOverItem(null);
      return;
    }
    
    // Reorder the groups
    const newGroups = [...groupedProducts];
    const [removed] = newGroups.splice(draggedItem.index, 1);
    newGroups.splice(dropIndex, 0, removed);
    
    // Calculate new display orders and update products
    let order = 0;
    const updates = [];
    
    newGroups.forEach(group => {
      if (group.type === 'group') {
        updates.push({ id: group.parent.id, display_order: order++ });
        group.children.forEach(child => {
          updates.push({ id: child.id, display_order: order++ });
        });
      } else {
        updates.push({ id: group.product.id, display_order: order++ });
      }
    });
    
    // Mark products as saving (show transparency)
    const savingIds = new Set(updates.map(u => u.id));
    setSavingProducts(savingIds);
    
    setDraggedItem(null);
    setDragOverItem(null);
    
    // Update all products with new order
    try {
      await updateProductsOrder(updates);
    } finally {
      // Clear saving state after DB update completes
      setSavingProducts(new Set());
    }
  };
  
  // Drag handlers for children within a group
  const handleChildDragStart = (e, parentId, childIndex) => {
    setDraggedItem({ parentId, childIndex, type: 'child' });
    e.dataTransfer.effectAllowed = 'move';
    e.stopPropagation();
  };
  
  const handleChildDragOver = (e, parentId, childIndex) => {
    e.preventDefault();
    e.stopPropagation();
    if (draggedItem?.type === 'child' && draggedItem?.parentId === parentId && draggedItem?.childIndex !== childIndex) {
      setDragOverItem({ parentId, childIndex });
    }
  };
  
  const handleChildDrop = async (e, parentId, dropIndex) => {
    e.preventDefault();
    e.stopPropagation();
    
    if (draggedItem?.type !== 'child' || draggedItem?.parentId !== parentId) {
      return;
    }
    
    const group = groupedProducts.find(g => g.type === 'group' && g.parent.id === parentId);
    if (!group) return;
    
    const newChildren = [...group.children];
    const [removed] = newChildren.splice(draggedItem.childIndex, 1);
    newChildren.splice(dropIndex, 0, removed);
    
    // Update child display orders
    const updates = newChildren.map((child, index) => ({
      id: child.id,
      display_order: (group.parent.display_order || 0) + index + 1
    }));
    
    // Mark products as saving (show transparency)
    const savingIds = new Set(updates.map(u => u.id));
    setSavingProducts(savingIds);
    
    setDraggedItem(null);
    setDragOverItem(null);
    
    try {
      await updateProductsOrder(updates);
    } finally {
      // Clear saving state after DB update completes
      setSavingProducts(new Set());
    }
  };
  
  // Handle save product - saves to Supabase
  const handleSaveProduct = async (productData) => {
    setSaving(true);
    try {
      if (editingProduct) {
        // Update existing product
        await dbUpdateProduct(editingProduct.id, productData);
      } else {
        // Add new product with display_order at the end
        const maxOrder = Math.max(...products.map(p => p.display_order || 0), 0);
        await dbAddProduct({ ...productData, display_order: maxOrder + 1 });
      }
      setShowAddModal(false);
      setEditingProduct(null);
    } catch (err) {
      console.error('Error saving product:', err);
      alert('Error al guardar el producto: ' + err.message);
    } finally {
      setSaving(false);
    }
  };
  
  // Handle delete product - deletes from Supabase
  const handleDeleteProduct = async (productId) => {
    if (window.confirm('¿Estás seguro de eliminar este producto?')) {
      try {
        await dbDeleteProduct(productId);
      } catch (err) {
        console.error('Error deleting product:', err);
        alert('Error al eliminar el producto: ' + err.message);
      }
    }
  };

  // Handle save section - saves to Supabase
  const handleSaveSection = async (sectionData) => {
    setSaving(true);
    try {
      if (editingSection) {
        await dbUpdateSection(editingSection.id, sectionData);
      } else {
        const maxOrder = Math.max(...sections.map(s => s.display_order || 0), 0);
        await dbAddSection({ ...sectionData, display_order: maxOrder + 1 });
      }
      setShowSectionModal(false);
      setEditingSection(null);
    } catch (err) {
      console.error('Error saving section:', err);
      alert('Error al guardar la sección: ' + err.message);
    } finally {
      setSaving(false);
    }
  };

  // Handle delete section - deletes from Supabase
  const handleDeleteSection = async (sectionId) => {
    if (window.confirm('¿Estás seguro de eliminar esta sección? Los productos asociados perderán su sección.')) {
      try {
        await dbDeleteSection(sectionId);
      } catch (err) {
        console.error('Error deleting section:', err);
        alert('Error al eliminar la sección: ' + err.message);
      }
    }
  };
  
  return (
    <div className="space-y-6">
      {/* Sub-navigation tabs */}
      <div className="flex items-center gap-2 border-b border-slate-200">
        {[
          { id: 'products', label: 'Productos' },
          { id: 'sections', label: 'Secciones' },
          { id: 'preferences', label: 'Preferencias' },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`px-4 py-3 text-sm font-medium border-b-2 transition-colors ${
              activeTab === tab.id
                ? 'border-primary-500 text-primary-600'
                : 'border-transparent text-slate-500 hover:text-slate-700'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>
      
      {/* Products Tab */}
      {activeTab === 'products' && (
        <div className="card">
          {/* Header */}
          <div className="p-4 border-b border-slate-100 flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h2 className="text-lg font-semibold text-slate-800">Productos</h2>
              
              {/* Section Filter */}
              <select
                value={selectedSection}
                onChange={(e) => setSelectedSection(e.target.value)}
                className="input w-48"
              >
                <option value="all">Todas las secciones</option>
                {sections.map((section) => (
                  <option key={section.id} value={section.id}>{section.name}</option>
                ))}
              </select>
            </div>
            
            <button 
              onClick={() => { setEditingProduct(null); setShowAddModal(true); }}
              className="btn-primary"
            >
              <Plus className="w-4 h-4" />
              Nuevo Producto
            </button>
          </div>
          
          {/* Instructions */}
          <div className="px-4 py-2 bg-blue-50 border-b border-blue-100 text-xs text-blue-700 flex items-center gap-2">
            <GripVertical className="w-4 h-4" />
            <span>Arrastra los productos para cambiar el orden en la pantalla de órdenes. Los productos padre se mueven con sus sub-productos.</span>
          </div>
          
          {/* Products List - Draggable Groups */}
          <div className="p-4 space-y-2">
            {groupedProducts.map((group, groupIndex) => {
              // Check if any product in this group is being saved
              const isGroupSaving = group.type === 'group' 
                ? savingProducts.has(group.parent.id) || group.children.some(c => savingProducts.has(c.id))
                : savingProducts.has(group.product.id);
              
              return (
              <div
                key={group.type === 'group' ? group.parent.id : group.product.id}
                className={`drag-group rounded-xl transition-all duration-300 ${
                  dragOverItem === groupIndex ? 'ring-2 ring-primary-400 ring-offset-2' : ''
                } ${isGroupSaving ? 'opacity-50' : 'opacity-100'}`}
                draggable={!isGroupSaving}
                onDragStart={(e) => handleDragStart(e, groupIndex, group.type)}
                onDragEnd={handleDragEnd}
                onDragOver={(e) => handleDragOver(e, groupIndex)}
                onDragLeave={handleDragLeave}
                onDrop={(e) => handleDrop(e, groupIndex)}
              >
                {group.type === 'group' ? (
                  // Parent with children
                  <div className={`border border-purple-200 rounded-xl overflow-hidden bg-gradient-to-r from-purple-50 to-white ${isGroupSaving ? 'pointer-events-none' : ''}`}>
                    {/* Parent Row */}
                    <div className="flex items-center gap-3 p-3 bg-purple-50 border-b border-purple-100">
                      <GripVertical className={`w-5 h-5 text-purple-300 flex-shrink-0 ${isGroupSaving ? 'animate-pulse' : 'cursor-grab'}`} />
                      <span className="text-2xl flex-shrink-0">{group.parent.icon || '📦'}</span>
                      <div className="flex-1 min-w-0">
                        <p className="font-semibold text-purple-900">{group.parent.name}</p>
                        <p className="text-xs text-purple-600">
                          {isGroupSaving ? 'Guardando...' : `${group.children.length} sub-productos`}
                        </p>
                      </div>
                      <span 
                        className="badge text-xs"
                        style={{ 
                          backgroundColor: `${sections.find(s => s.id === group.parent.section_id)?.color}20`, 
                          color: sections.find(s => s.id === group.parent.section_id)?.color 
                        }}
                      >
                        {sections.find(s => s.id === group.parent.section_id)?.name || '-'}
                      </span>
                      <span className="badge bg-purple-100 text-purple-700 text-xs">Padre</span>
                      {group.parent.is_active !== false ? (
                        <span className="w-6 h-6 bg-success-100 text-success-600 rounded-full flex items-center justify-center">
                          <Check className="w-4 h-4" />
                        </span>
                      ) : (
                        <span className="w-6 h-6 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center">
                          <X className="w-4 h-4" />
                        </span>
                      )}
                      <div className="flex items-center gap-1">
                        <button 
                          onClick={(e) => { e.stopPropagation(); setEditingProduct(group.parent); setShowAddModal(true); }}
                          className="p-2 hover:bg-purple-100 rounded-lg transition-colors text-purple-500 hover:text-purple-700"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                        <button 
                          onClick={(e) => { e.stopPropagation(); handleDeleteProduct(group.parent.id); }}
                          className="p-2 hover:bg-purple-100 rounded-lg transition-colors text-purple-500 hover:text-error-600"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </div>
                    
                    {/* Children Rows */}
                    <div className="divide-y divide-purple-100">
                      {group.children.map((child, childIndex) => {
                        const section = sections.find(s => s.id === child.section_id);
                        const isChildDragOver = dragOverItem?.parentId === group.parent.id && dragOverItem?.childIndex === childIndex;
                        const isChildSaving = savingProducts.has(child.id);
                        
                        return (
                          <div
                            key={child.id}
                            className={`flex items-center gap-3 p-3 pl-8 bg-white transition-all duration-300 ${
                              isChildDragOver ? 'ring-2 ring-primary-300 ring-inset' : ''
                            } ${isChildSaving ? 'opacity-50 pointer-events-none' : 'hover:bg-slate-50'}`}
                            draggable={!isChildSaving}
                            onDragStart={(e) => handleChildDragStart(e, group.parent.id, childIndex)}
                            onDragOver={(e) => handleChildDragOver(e, group.parent.id, childIndex)}
                            onDrop={(e) => handleChildDrop(e, group.parent.id, childIndex)}
                            onDragEnd={handleDragEnd}
                          >
                            <GripVertical className={`w-4 h-4 text-slate-300 flex-shrink-0 ${isChildSaving ? 'animate-pulse' : 'cursor-grab'}`} />
                            <span className="text-slate-400 text-sm">↳</span>
                            <span className="text-xl flex-shrink-0">{child.icon || '📦'}</span>
                            <div className="flex-1 min-w-0">
                              <p className="font-medium text-slate-700 text-sm">{child.name}</p>
                              {isChildSaving && <p className="text-xs text-amber-600">Guardando...</p>}
                            </div>
                            <span className="text-sm font-medium text-slate-800 w-24 text-right">
                              {child.price ? `B/${getPriceWithTax(child.price).toFixed(2)}` : '-'}
                            </span>
                            <span className="text-sm text-slate-500 w-24 text-right">
                              {child.express_price ? `B/${getPriceWithTax(child.express_price).toFixed(2)}` : '-'}
                            </span>
                            {child.pricing_type === 'weight' ? (
                              <span className="badge bg-blue-100 text-blue-700 text-xs w-20 justify-center">
                                <Scale className="w-3 h-3 mr-1" />
                                Peso
                              </span>
                            ) : (
                              <span className="badge bg-slate-100 text-slate-700 text-xs w-20 justify-center">
                                <Hash className="w-3 h-3 mr-1" />
                                Cant.
                              </span>
                            )}
                            {child.is_active !== false ? (
                              <span className="w-6 h-6 bg-success-100 text-success-600 rounded-full flex items-center justify-center">
                                <Check className="w-4 h-4" />
                              </span>
                            ) : (
                              <span className="w-6 h-6 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center">
                                <X className="w-4 h-4" />
                              </span>
                            )}
                            <div className="flex items-center gap-1">
                              <button 
                                onClick={(e) => { e.stopPropagation(); setEditingProduct(child); setShowAddModal(true); }}
                                className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-primary-600"
                              >
                                <Edit2 className="w-4 h-4" />
                              </button>
                              <button 
                                onClick={(e) => { e.stopPropagation(); handleDeleteProduct(child.id); }}
                                className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-error-600"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            </div>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                ) : (
                  // Standalone product
                  <div className={`flex items-center gap-3 p-3 border border-slate-200 rounded-xl bg-white ${isGroupSaving ? 'pointer-events-none' : 'hover:bg-slate-50'}`}>
                    <GripVertical className={`w-5 h-5 text-slate-300 flex-shrink-0 ${isGroupSaving ? 'animate-pulse' : 'cursor-grab'}`} />
                    <span className="text-2xl flex-shrink-0">{group.product.icon || '📦'}</span>
                    <div className="flex-1 min-w-0">
                      <p className="font-medium text-slate-800">{group.product.name}</p>
                      {isGroupSaving && <p className="text-xs text-amber-600">Guardando...</p>}
                    </div>
                    <span 
                      className="badge text-xs"
                      style={{ 
                        backgroundColor: `${sections.find(s => s.id === group.product.section_id)?.color}20`, 
                        color: sections.find(s => s.id === group.product.section_id)?.color 
                      }}
                    >
                      {sections.find(s => s.id === group.product.section_id)?.name || '-'}
                    </span>
                    <span className="text-sm font-medium text-slate-800 w-24 text-right">
                      {group.product.price ? `B/${getPriceWithTax(group.product.price).toFixed(2)}` : '-'}
                    </span>
                    <span className="text-sm text-slate-500 w-24 text-right">
                      {group.product.express_price ? `B/${getPriceWithTax(group.product.express_price).toFixed(2)}` : '-'}
                    </span>
                    {group.product.pricing_type === 'weight' ? (
                      <span className="badge bg-blue-100 text-blue-700 text-xs w-20 justify-center">
                        <Scale className="w-3 h-3 mr-1" />
                        Peso
                      </span>
                    ) : (
                      <span className="badge bg-slate-100 text-slate-700 text-xs w-20 justify-center">
                        <Hash className="w-3 h-3 mr-1" />
                        Cant.
                      </span>
                    )}
                    {group.product.is_active !== false ? (
                      <span className="w-6 h-6 bg-success-100 text-success-600 rounded-full flex items-center justify-center">
                        <Check className="w-4 h-4" />
                      </span>
                    ) : (
                      <span className="w-6 h-6 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center">
                        <X className="w-4 h-4" />
                      </span>
                    )}
                    <div className="flex items-center gap-1">
                      <button 
                        onClick={(e) => { e.stopPropagation(); setEditingProduct(group.product); setShowAddModal(true); }}
                        className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-primary-600"
                      >
                        <Edit2 className="w-4 h-4" />
                      </button>
                      <button 
                        onClick={(e) => { e.stopPropagation(); handleDeleteProduct(group.product.id); }}
                        className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-error-600"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                )}
              </div>
            );
            })}
            
            {groupedProducts.length === 0 && (
              <div className="text-center py-12 text-slate-400">
                <Package className="w-12 h-12 mx-auto mb-3 opacity-50" />
                <p className="font-medium">No hay productos</p>
                <p className="text-sm mt-1">Agrega un producto para comenzar</p>
              </div>
            )}
          </div>
        </div>
      )}
      
      {/* Sections Tab */}
      {activeTab === 'sections' && (
        <div className="card p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-lg font-semibold text-slate-800">Secciones de Productos</h2>
              <p className="text-sm text-slate-500">Organiza tus productos en categorías</p>
            </div>
            <button 
              onClick={() => setShowSectionModal(true)}
              className="btn-primary"
            >
              <Plus className="w-4 h-4" />
              Nueva Sección
            </button>
          </div>
          
          <div className="space-y-3">
            {sections.map((section, index) => (
              <div 
                key={section.id}
                className="flex items-center gap-4 p-4 bg-slate-50 rounded-xl"
              >
                <GripVertical className="w-5 h-5 text-slate-300 cursor-grab" />
                <div 
                  className="w-4 h-4 rounded-full"
                  style={{ backgroundColor: section.color }}
                />
                <span className="flex-1 font-medium text-slate-700">{section.name}</span>
                <span className="text-sm text-slate-400">
                  {products.filter(p => p.section_id === section.id).length} productos
                </span>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input 
                    type="checkbox" 
                    checked={section.is_active !== false}
                    onChange={(e) => dbUpdateSection(section.id, { is_active: e.target.checked })}
                    className="sr-only peer" 
                  />
                  <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
                </label>
                <button 
                  onClick={() => { setEditingSection(section); setShowSectionModal(true); }}
                  className="p-2 hover:bg-white rounded-lg transition-colors text-slate-500 hover:text-primary-600"
                >
                  <Edit2 className="w-4 h-4" />
                </button>
                <button 
                  onClick={() => handleDeleteSection(section.id)}
                  className="p-2 hover:bg-white rounded-lg transition-colors text-slate-500 hover:text-error-600"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            ))}
            
            {sections.length === 0 && (
              <div className="text-center py-8 text-slate-400">
                <Package className="w-10 h-10 mx-auto mb-2 opacity-50" />
                <p>No hay secciones</p>
                <p className="text-sm">Crea una sección para organizar tus productos</p>
              </div>
            )}
          </div>
        </div>
      )}
      
      {/* Preferences Tab */}
      {activeTab === 'preferences' && (
        <div className="card p-6">
          <div className="mb-6">
            <h2 className="text-lg font-semibold text-slate-800">Preferencias de Pedido</h2>
            <p className="text-sm text-slate-500">Opciones que los clientes pueden elegir al hacer un pedido</p>
          </div>
          
          <div className="space-y-6">
            {/* Scent Preferences */}
            <div>
              <h3 className="font-medium text-slate-700 mb-3">Perlas de Olor</h3>
              <div className="space-y-2">
                {['Sin preferencia', 'Suave', 'Media', 'Fuerte', 'Sin perlas'].map((option) => (
                  <div key={option} className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                    <span className="flex-1 text-slate-700">{option}</span>
                    <button className="text-sm text-primary-600 hover:underline">Editar</button>
                    <button className="text-sm text-error-600 hover:underline">Eliminar</button>
                  </div>
                ))}
                <button className="w-full py-2 border-2 border-dashed border-slate-200 rounded-lg text-sm text-slate-500 hover:border-primary-300 hover:text-primary-600 transition-colors">
                  + Agregar opción
                </button>
              </div>
            </div>
            
            {/* Softener Preferences */}
            <div>
              <h3 className="font-medium text-slate-700 mb-3">Tipo de Suavizante</h3>
              <div className="space-y-2">
                {['Sin preferencia', 'Regular', 'Hipoalergénico', 'Sin suavizante'].map((option) => (
                  <div key={option} className="flex items-center gap-3 p-3 bg-slate-50 rounded-lg">
                    <span className="flex-1 text-slate-700">{option}</span>
                    <button className="text-sm text-primary-600 hover:underline">Editar</button>
                    <button className="text-sm text-error-600 hover:underline">Eliminar</button>
                  </div>
                ))}
                <button className="w-full py-2 border-2 border-dashed border-slate-200 rounded-lg text-sm text-slate-500 hover:border-primary-300 hover:text-primary-600 transition-colors">
                  + Agregar opción
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
      
      {/* Add/Edit Product Modal */}
      {showAddModal && (
        <ProductFormModal
          product={editingProduct}
          sections={sections}
          products={products}
          onClose={() => { setShowAddModal(false); setEditingProduct(null); }}
          onSave={handleSaveProduct}
          saving={saving}
        />
      )}
      
      {showSectionModal && (
        <SectionFormModal
          section={editingSection}
          onClose={() => { setShowSectionModal(false); setEditingSection(null); }}
          onSave={handleSaveSection}
          saving={saving}
        />
      )}
    </div>
  );
}

// Product Form Modal
function ProductFormModal({ product, sections, products, onClose, onSave, saving }) {
  const { state } = useApp();
  const ITBMS_RATE = state.settings?.itbms_rate || 7; // Default 7%
  
  const isEditing = product !== null;
  
  // Calculate initial total prices from base prices if editing
  const calculateTotalFromBase = (basePrice, isTaxable) => {
    if (!basePrice) return '';
    if (!isTaxable) return basePrice.toFixed(2);
    return (basePrice * (1 + ITBMS_RATE / 100)).toFixed(2);
  };
  
  const [formData, setFormData] = useState({
    name: product?.name || '',
    section_id: product?.section_id || sections[0]?.id || '',
    icon: product?.icon || '📦',
    pricing_type: product?.pricing_type || 'quantity',
    // Store displayed prices for input
    display_price: product?.price ? calculateTotalFromBase(product.price, product?.is_taxable !== false) : '',
    display_express_price: product?.express_price ? calculateTotalFromBase(product.express_price, product?.is_taxable !== false) : '',
    cost: product?.cost || '',
    min_quantity: product?.min_quantity || 1,
    pieces_per_unit: product?.pieces || 1,
    parent_id: product?.parent_id || '',
    is_active: product?.is_active !== false,
    is_taxable: product?.is_taxable !== false,
    has_children: product?.has_children || false, // Is this a parent product?
    extra_days: product?.extra_days || 0,
  });
  
  // Calculate base price and ITBMS from total price (only when is_taxable is true)
  const calculatePriceBreakdown = (totalPrice) => {
    if (!totalPrice || isNaN(parseFloat(totalPrice))) {
      return { basePrice: 0, itbms: 0 };
    }
    const total = parseFloat(totalPrice);
    const basePrice = total / (1 + ITBMS_RATE / 100);
    const itbms = total - basePrice;
    return { basePrice, itbms };
  };
  
  const priceBreakdown = formData.is_taxable ? calculatePriceBreakdown(formData.display_price) : null;
  const expressPriceBreakdown = formData.is_taxable ? calculatePriceBreakdown(formData.display_express_price) : null;
  
  const handleChange = (field, value) => {
    setFormData(prev => {
      const newData = { ...prev, [field]: value };
      
      // If setting as parent product, clear parent_id (can't be both)
      if (field === 'has_children' && value === true) {
        newData.parent_id = '';
      }
      
      // If selecting a parent, can't be a parent itself
      if (field === 'parent_id' && value) {
        newData.has_children = false;
      }
      
      return newData;
    });
  };
  
  const handleSubmit = () => {
    let priceToSave = 0, expressPriceToSave = 0;
    
    // Only process prices if NOT a parent product
    if (!formData.has_children) {
      if (formData.is_taxable) {
        // When taxable: input is WITH ITBMS, save WITHOUT ITBMS
        const { basePrice } = calculatePriceBreakdown(formData.display_price);
        const { basePrice: expressBasePrice } = calculatePriceBreakdown(formData.display_express_price);
        priceToSave = parseFloat(basePrice.toFixed(2)) || 0;
        expressPriceToSave = parseFloat(expressBasePrice.toFixed(2)) || 0;
      } else {
        // When not taxable: input is the actual price, save as-is
        priceToSave = parseFloat(formData.display_price) || 0;
        expressPriceToSave = parseFloat(formData.display_express_price) || 0;
      }
    }
    
    const productData = {
      name: formData.name,
      section_id: formData.section_id,
      icon: formData.icon,
      pricing_type: formData.pricing_type,
      price: priceToSave,
      express_price: expressPriceToSave,
      cost: formData.has_children ? 0 : (parseFloat(formData.cost) || 0),
      min_quantity: formData.has_children ? 1 : formData.min_quantity,
      pieces: formData.has_children ? 1 : formData.pieces_per_unit,
      parent_id: formData.parent_id || null,
      is_active: formData.is_active,
      is_taxable: formData.has_children ? false : formData.is_taxable,
      has_children: formData.has_children,
      extra_days: formData.has_children ? 0 : formData.extra_days,
    };
    
    // Only include ID when editing existing product
    if (product?.id) {
      productData.id = product.id;
    }
    
    onSave(productData);
  };
  
  // Parent products (only those with has_children: true)
  const parentProducts = products.filter(p => p.has_children && p.id !== product?.id);
  
  // Common emoji options for icons
  const iconOptions = ['📦', '👕', '👖', '🧺', '🧹', '🧼', '🧴', '🛏️', '🪥', '🧽', '🧤', '🧦', '👔', '👗', '🩳', '🩱'];
  
  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-2xl max-h-[90vh] flex flex-col animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">
            {isEditing ? 'Editar Producto' : 'Nuevo Producto'}
          </h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Form */}
        <div className="flex-1 overflow-y-auto p-6 space-y-4">
          <div className="grid grid-cols-2 gap-4">
            {/* Name */}
            <div className="col-span-2">
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Nombre del Producto <span className="text-error-500">*</span>
              </label>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => handleChange('name', e.target.value)}
                className="input"
                placeholder="Lava y Dobla (por kg)"
              />
            </div>
            
            {/* Section */}
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Sección <span className="text-error-500">*</span>
              </label>
              <select
                value={formData.section_id}
                onChange={(e) => handleChange('section_id', e.target.value)}
                className="input"
              >
                {sections.map((section) => (
                  <option key={section.id} value={section.id}>{section.name}</option>
                ))}
              </select>
            </div>
            
            {/* Icon */}
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Icono</label>
              <div className="flex items-center gap-2">
                <span className="text-3xl p-2 bg-slate-100 rounded-lg">{formData.icon}</span>
                <div className="flex flex-wrap gap-1">
                  {iconOptions.slice(0, 8).map((emoji) => (
                    <button
                      key={emoji}
                      type="button"
                      onClick={() => handleChange('icon', emoji)}
                      className={`p-1 text-lg rounded hover:bg-slate-100 ${formData.icon === emoji ? 'bg-primary-100' : ''}`}
                    >
                      {emoji}
                    </button>
                  ))}
                </div>
              </div>
            </div>
            
            {/* Product Type - Parent or Regular */}
            <div className="col-span-2 p-4 bg-gradient-to-r from-purple-50 to-indigo-50 rounded-xl border border-purple-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-slate-700">Tipo de Producto</p>
                  <p className="text-xs text-slate-500 mt-0.5">
                    {formData.has_children 
                      ? 'Tile contenedor que abre modal con sub-productos' 
                      : 'Producto con precio que se agrega al ticket'}
                  </p>
                </div>
                <label className="flex items-center gap-3 cursor-pointer">
                  <span className={`text-sm ${!formData.has_children ? 'font-medium text-slate-700' : 'text-slate-400'}`}>
                    Regular
                  </span>
                  <div 
                    onClick={() => handleChange('has_children', !formData.has_children)}
                    className={`relative w-12 h-6 rounded-full transition-colors cursor-pointer ${
                      formData.has_children ? 'bg-purple-500' : 'bg-slate-300'
                    }`}
                  >
                    <div className={`absolute top-1 left-1 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                      formData.has_children ? 'translate-x-6' : ''
                    }`} />
                  </div>
                  <span className={`text-sm ${formData.has_children ? 'font-medium text-purple-700' : 'text-slate-400'}`}>
                    Padre
                  </span>
                </label>
              </div>
              
              {formData.has_children && (
                <div className="mt-3 p-3 bg-white/60 rounded-lg border border-purple-100">
                  <p className="text-xs text-purple-700">
                    <strong>Producto Padre:</strong> Este producto aparecerá como un tile en la pantalla de órdenes. 
                    Al hacer clic, abrirá un modal para seleccionar los sub-productos. 
                    No tiene precio propio - los precios se definen en los sub-productos.
                  </p>
                </div>
              )}
            </div>
            
            {/* Parent Product Selector - Only show if NOT a parent */}
            {!formData.has_children && (
              <div className="col-span-2">
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  Producto Padre (opcional)
                </label>
                <select
                  value={formData.parent_id}
                  onChange={(e) => handleChange('parent_id', e.target.value)}
                  className="input"
                  disabled={parentProducts.length === 0}
                >
                  <option value="">Ninguno (producto independiente)</option>
                  {parentProducts.map((p) => (
                    <option key={p.id} value={p.id}>{p.icon} {p.name}</option>
                  ))}
                </select>
                <p className="text-xs text-slate-400 mt-1">
                  {parentProducts.length === 0 
                    ? 'No hay productos padre. Crea uno primero si deseas agrupar productos.'
                    : 'Si este es un sub-producto, selecciona a qué producto padre pertenece'}
                </p>
              </div>
            )}
            
            {/* Pricing Type - Only show if NOT a parent */}
            {!formData.has_children && (
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Tipo de Precio</label>
                <div className="flex gap-2">
                  <button
                    type="button"
                    onClick={() => handleChange('pricing_type', 'quantity')}
                    className={`flex-1 py-2 px-3 rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-2 ${
                      formData.pricing_type === 'quantity'
                        ? 'bg-primary-500 text-white'
                        : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                    }`}
                  >
                    <Hash className="w-4 h-4" />
                    Cantidad
                  </button>
                  <button
                    type="button"
                    onClick={() => handleChange('pricing_type', 'weight')}
                    className={`flex-1 py-2 px-3 rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-2 ${
                      formData.pricing_type === 'weight'
                        ? 'bg-primary-500 text-white'
                        : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                    }`}
                  >
                    <Scale className="w-4 h-4" />
                    Por Peso
                  </button>
                </div>
              </div>
            )}
            
            {/* Spacer for grid alignment when not parent */}
            {!formData.has_children && <div></div>}
            
            {/* Price Section - Only show if NOT a parent */}
            {!formData.has_children && (
            <div className="col-span-2 p-4 bg-slate-50 rounded-xl space-y-4">
              {/* ITBMS Toggle - BEFORE price inputs */}
              <div className="flex items-center justify-between pb-3 border-b border-slate-200">
                <div className="flex items-center gap-2">
                  <Percent className="w-4 h-4 text-primary-500" />
                  <span className="text-sm font-medium text-slate-700">Configuración de Impuesto</span>
                </div>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    checked={formData.is_taxable}
                    onChange={(e) => handleChange('is_taxable', e.target.checked)}
                    className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                  />
                  <span className="text-sm text-slate-700">Aplica ITBMS ({ITBMS_RATE}%)</span>
                </label>
              </div>
              
              {/* Info text based on ITBMS setting */}
              <p className="text-xs text-slate-500">
                {formData.is_taxable 
                  ? `Ingresa el precio CON ITBMS incluido. Se guardará el precio base y el ITBMS se calculará en checkout.`
                  : `Ingresa el precio final del producto. No se aplicará ITBMS en checkout.`
                }
              </p>
              
              <div className="grid grid-cols-2 gap-4">
                {/* Regular Price */}
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">
                    Precio de Venta {formData.pricing_type === 'weight' ? '(por kg)' : ''} <span className="text-error-500">*</span>
                  </label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                    <input
                      type="number"
                      step="0.01"
                      value={formData.display_price}
                      onChange={(e) => handleChange('display_price', e.target.value)}
                      className="input pl-9"
                      placeholder="0.00"
                    />
                  </div>
                  {/* ITBMS Calculator - only shown when is_taxable is true */}
                  {formData.is_taxable && formData.display_price && priceBreakdown && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio base (se guarda):</span>
                        <span className="font-medium text-primary-600">B/{priceBreakdown.basePrice.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1">
                        <span className="text-slate-500">ITBMS ({ITBMS_RATE}%):</span>
                        <span className="font-medium text-slate-700">B/{priceBreakdown.itbms.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1 pt-1 border-t border-slate-100">
                        <span className="text-slate-600 font-medium">Total (cliente paga):</span>
                        <span className="font-bold text-slate-800">B/{parseFloat(formData.display_price).toFixed(2)}</span>
                      </div>
                    </div>
                  )}
                  {/* Simple display when not taxable */}
                  {!formData.is_taxable && formData.display_price && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio guardado:</span>
                        <span className="font-bold text-primary-600">B/{parseFloat(formData.display_price).toFixed(2)}</span>
                      </div>
                      <div className="text-xs text-slate-400 mt-1">Sin ITBMS</div>
                    </div>
                  )}
                </div>
                
                {/* Express Price */}
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">
                    Precio Express {formData.pricing_type === 'weight' ? '(por kg)' : ''}
                  </label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                    <input
                      type="number"
                      step="0.01"
                      value={formData.display_express_price}
                      onChange={(e) => handleChange('display_express_price', e.target.value)}
                      className="input pl-9"
                      placeholder="0.00"
                    />
                  </div>
                  {/* ITBMS Calculator - only shown when is_taxable is true */}
                  {formData.is_taxable && formData.display_express_price && expressPriceBreakdown && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio base (se guarda):</span>
                        <span className="font-medium text-warning-600">B/{expressPriceBreakdown.basePrice.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1">
                        <span className="text-slate-500">ITBMS ({ITBMS_RATE}%):</span>
                        <span className="font-medium text-slate-700">B/{expressPriceBreakdown.itbms.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1 pt-1 border-t border-slate-100">
                        <span className="text-slate-600 font-medium">Total (cliente paga):</span>
                        <span className="font-bold text-slate-800">B/{parseFloat(formData.display_express_price).toFixed(2)}</span>
                      </div>
                    </div>
                  )}
                  {/* Simple display when not taxable */}
                  {!formData.is_taxable && formData.display_express_price && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio guardado:</span>
                        <span className="font-bold text-warning-600">B/{parseFloat(formData.display_express_price).toFixed(2)}</span>
                      </div>
                      <div className="text-xs text-slate-400 mt-1">Sin ITBMS</div>
                    </div>
                  )}
                </div>
              </div>
            </div>
            )}
            
            {/* Cost - Only show if NOT a parent */}
            {!formData.has_children && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Costo (interno)
              </label>
              <div className="relative">
                <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                <input
                  type="number"
                  step="0.01"
                  value={formData.cost}
                  onChange={(e) => handleChange('cost', e.target.value)}
                  className="input pl-9"
                  placeholder="0.00"
                />
              </div>
              <p className="text-xs text-slate-400 mt-1">Para cálculo de margen (no incluye ITBMS)</p>
            </div>
            )}
            
            {/* Min Quantity - Only show if NOT a parent */}
            {!formData.has_children && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Cantidad Mínima
              </label>
              <input
                type="number"
                value={formData.min_quantity}
                onChange={(e) => handleChange('min_quantity', parseInt(e.target.value) || 1)}
                className="input"
                min="1"
              />
            </div>
            )}
            
            {/* Pieces per Unit - Only show if NOT a parent */}
            {!formData.has_children && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Piezas por Unidad
              </label>
              <input
                type="number"
                value={formData.pieces_per_unit}
                onChange={(e) => handleChange('pieces_per_unit', parseInt(e.target.value) || 1)}
                className="input"
                min="1"
              />
            </div>
            )}
            
            {/* Extra Days - Only show if NOT a parent */}
            {!formData.has_children && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Días Extra de Procesamiento
              </label>
              <select
                value={formData.extra_days}
                onChange={(e) => handleChange('extra_days', parseInt(e.target.value))}
                className="input"
              >
                <option value={0}>Sin días extra</option>
                <option value={1}>+1 día</option>
                <option value={2}>+2 días</option>
                <option value={3}>+3 días</option>
              </select>
            </div>
            )}
            
            {/* Toggles */}
            <div className="col-span-2 flex items-center gap-6 pt-4 border-t border-slate-100">
              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={formData.is_active}
                  onChange={(e) => handleChange('is_active', e.target.checked)}
                  className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                />
                <span className="text-sm text-slate-700">Producto activo</span>
              </label>
            </div>
          </div>
        </div>
        
        {/* Footer */}
        <div className="flex items-center justify-end gap-3 p-4 border-t border-slate-100">
          <button type="button" onClick={onClose} className="btn-secondary">
            Cancelar
          </button>
          <button type="button" onClick={handleSubmit} disabled={saving} className="btn-primary">
            {saving ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Guardando...
              </>
            ) : (
              <>
                <Save className="w-4 h-4" />
                {isEditing ? 'Guardar Cambios' : 'Crear Producto'}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

// Section Form Modal
function SectionFormModal({ section, onClose, onSave, saving }) {
  const isEditing = section !== null;
  
  const [formData, setFormData] = useState({
    name: section?.name || '',
    color: section?.color || '#3B82F6',
    is_active: section?.is_active !== false,
  });
  
  const colorOptions = [
    '#3B82F6', // Blue
    '#10B981', // Green
    '#F59E0B', // Amber
    '#EF4444', // Red
    '#8B5CF6', // Purple
    '#EC4899', // Pink
    '#06B6D4', // Cyan
    '#F97316', // Orange
    '#6366F1', // Indigo
    '#84CC16', // Lime
  ];

  const handleSubmit = () => {
    if (!formData.name.trim()) {
      alert('El nombre de la sección es requerido');
      return;
    }
    onSave(formData);
  };

  return (
    <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-md animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">
            {isEditing ? 'Editar Sección' : 'Nueva Sección'}
          </h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {/* Form */}
        <div className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Nombre de la Sección <span className="text-error-500">*</span>
            </label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              className="input"
              placeholder="Ej: Lava y Dobla"
              autoFocus
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-2">Color</label>
            <div className="flex flex-wrap gap-2">
              {colorOptions.map((color) => (
                <button
                  key={color}
                  type="button"
                  onClick={() => setFormData({ ...formData, color })}
                  className={`w-8 h-8 rounded-full transition-all ${
                    formData.color === color 
                      ? 'ring-2 ring-offset-2 ring-primary-500 scale-110' 
                      : 'hover:scale-110'
                  }`}
                  style={{ backgroundColor: color }}
                />
              ))}
            </div>
          </div>
          
          <div className="flex items-center gap-3">
            <label className="relative inline-flex items-center cursor-pointer">
              <input
                type="checkbox"
                checked={formData.is_active}
                onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                className="sr-only peer"
              />
              <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
            </label>
            <span className="text-sm text-slate-700">Sección activa</span>
          </div>
        </div>
        
        {/* Footer */}
        <div className="flex items-center justify-end gap-3 p-4 border-t border-slate-100">
          <button type="button" onClick={onClose} className="btn-secondary">
            Cancelar
          </button>
          <button
            onClick={handleSubmit}
            disabled={saving}
            className="btn-primary"
          >
            {saving ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Guardando...
              </>
            ) : (
              <>
                <Save className="w-4 h-4" />
                {isEditing ? 'Guardar Cambios' : 'Crear Sección'}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

// Promotions Settings (placeholder)
function PromotionsSettings() {
  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Promociones y Descuentos</h2>
          <p className="text-sm text-slate-500">Crea y gestiona ofertas especiales</p>
        </div>
        <button className="btn-primary">
          <Tag className="w-4 h-4" />
          Nueva Promoción
        </button>
      </div>
      
      <div className="text-center py-12 text-slate-400">
        <Tag className="w-16 h-16 mx-auto mb-4 opacity-50" />
        <p className="font-medium">Próximamente</p>
        <p className="text-sm mt-1">La gestión de promociones estará disponible pronto</p>
      </div>
    </div>
  );
}

// Gift Cards Settings (placeholder)
function GiftCardsSettings() {
  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Tarjetas de Regalo</h2>
          <p className="text-sm text-slate-500">Gestiona gift cards</p>
        </div>
        <button className="btn-primary">
          <Gift className="w-4 h-4" />
          Nueva Gift Card
        </button>
      </div>
      
      <div className="text-center py-12 text-slate-400">
        <Gift className="w-16 h-16 mx-auto mb-4 opacity-50" />
        <p className="font-medium">Próximamente</p>
        <p className="text-sm mt-1">La gestión de gift cards estará disponible pronto</p>
      </div>
    </div>
  );
}

export default SettingsPage;
