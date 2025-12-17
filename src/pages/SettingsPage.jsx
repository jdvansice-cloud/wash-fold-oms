import React, { useState } from 'react';
import { 
  Building, Store, Users, CreditCard, Bell, Mail,
  Gift, Tag, Package, Clock, Percent, Save,
  ChevronRight, Check, Settings as SettingsIcon,
  Plus, Edit2, Trash2, X, Scale, Hash, ChevronDown,
  GripVertical, Eye, EyeOff
} from 'lucide-react';
import { useApp } from '../context/AppContext';

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
          {activeSection === 'company' && <CompanySettings company={state.company} />}
          {activeSection === 'store' && <StoreSettings store={state.store} />}
          {activeSection === 'workflow' && <WorkflowSettings settings={state.settings} />}
          {activeSection === 'users' && <UsersSettings />}
          {activeSection === 'payments' && <PaymentMethodsSettings methods={state.paymentMethods} />}
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
function CompanySettings({ company }) {
  const [formData, setFormData] = useState({
    name: company?.name || 'American Laundry',
    ruc: company?.ruc || '155737034-2-2023',
    dv: company?.dv || '70',
    address: company?.address || 'Panamá, Panamá',
    phone: company?.phone || '+507 6123-4567',
    itbms_rate: company?.itbms_rate || 7,
    logo_url: company?.logo_url || '',
  });

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Datos de la Empresa</h2>
          <p className="text-sm text-slate-500">Información general del negocio</p>
        </div>
        <button className="btn-primary">
          <Save className="w-4 h-4" />
          Guardar
        </button>
      </div>
      
      <div className="grid grid-cols-2 gap-4">
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
        
        <div className="col-span-2">
          <label className="block text-sm font-medium text-slate-700 mb-1">URL del Logo</label>
          <input
            type="url"
            value={formData.logo_url}
            onChange={(e) => setFormData({ ...formData, logo_url: e.target.value })}
            className="input"
            placeholder="https://..."
          />
        </div>
      </div>
    </div>
  );
}

// Store Settings Section
function StoreSettings({ store }) {
  const [formData, setFormData] = useState({
    name: store?.name || 'American Laundry - Costa del Este',
    address: store?.address || 'Costa del Este, Panamá',
    phone: store?.phone || '+507 6123-4567',
  });

  const [hours, setHours] = useState({
    monday: { open: '07:00', close: '20:00', closed: false },
    tuesday: { open: '07:00', close: '20:00', closed: false },
    wednesday: { open: '07:00', close: '20:00', closed: false },
    thursday: { open: '07:00', close: '20:00', closed: false },
    friday: { open: '07:00', close: '20:00', closed: false },
    saturday: { open: '08:00', close: '18:00', closed: false },
    sunday: { open: '09:00', close: '15:00', closed: true },
  });

  const dayNames = {
    monday: 'Lunes',
    tuesday: 'Martes',
    wednesday: 'Miércoles',
    thursday: 'Jueves',
    friday: 'Viernes',
    saturday: 'Sábado',
    sunday: 'Domingo',
  };

  return (
    <div className="space-y-6">
      <div className="card p-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-lg font-semibold text-slate-800">Datos de la Tienda</h2>
            <p className="text-sm text-slate-500">Información de esta ubicación</p>
          </div>
          <button className="btn-primary">
            <Save className="w-4 h-4" />
            Guardar
          </button>
        </div>
        
        <div className="grid grid-cols-2 gap-4">
          <div className="col-span-2">
            <label className="block text-sm font-medium text-slate-700 mb-1">Nombre de Tienda</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              className="input"
            />
          </div>
          
          <div>
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
        </div>
      </div>
      
      {/* Opening Hours */}
      <div className="card p-6">
        <h3 className="text-lg font-semibold text-slate-800 mb-4">Horario de Atención</h3>
        
        <div className="space-y-3">
          {Object.entries(hours).map(([day, schedule]) => (
            <div key={day} className="flex items-center gap-4 py-2 border-b border-slate-100 last:border-0">
              <span className="w-24 font-medium text-slate-700">{dayNames[day]}</span>
              
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  checked={!schedule.closed}
                  onChange={(e) => setHours({ ...hours, [day]: { ...schedule, closed: !e.target.checked } })}
                  className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                />
                <span className="text-sm text-slate-600">Abierto</span>
              </label>
              
              {!schedule.closed && (
                <>
                  <input
                    type="time"
                    value={schedule.open}
                    onChange={(e) => setHours({ ...hours, [day]: { ...schedule, open: e.target.value } })}
                    className="input w-32"
                  />
                  <span className="text-slate-400">a</span>
                  <input
                    type="time"
                    value={schedule.close}
                    onChange={(e) => setHours({ ...hours, [day]: { ...schedule, close: e.target.value } })}
                    className="input w-32"
                  />
                </>
              )}
              
              {schedule.closed && (
                <span className="text-sm text-slate-400">Cerrado</span>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

// Workflow Settings Section
function WorkflowSettings({ settings }) {
  const [formData, setFormData] = useState({
    default_completion_days: settings?.default_completion_days || 1,
    express_completion_days: settings?.express_completion_days || 0,
  });

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Flujo de Trabajo</h2>
          <p className="text-sm text-slate-500">Tiempos de procesamiento de órdenes</p>
        </div>
        <button className="btn-primary">
          <Save className="w-4 h-4" />
          Guardar
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
  const users = [
    { id: 1, name: 'Juan David VanSice', email: 'juan@americanlaundry.com', role: 'admin', active: true },
    { id: 2, name: 'María González', email: 'maria@americanlaundry.com', role: 'supervisor', active: true },
    { id: 3, name: 'Carlos Pérez', email: 'carlos@americanlaundry.com', role: 'operator', active: true },
  ];

  const roleLabels = {
    admin: 'Administrador',
    supervisor: 'Supervisor',
    operator: 'Operador',
  };

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Gestión de Usuarios</h2>
          <p className="text-sm text-slate-500">Administra los usuarios del sistema</p>
        </div>
        <button className="btn-primary">
          <Users className="w-4 h-4" />
          Nuevo Usuario
        </button>
      </div>
      
      <div className="space-y-3">
        {users.map((user) => (
          <div key={user.id} className="flex items-center gap-4 p-4 bg-slate-50 rounded-xl">
            <div className="w-10 h-10 bg-primary-500 text-white rounded-full flex items-center justify-center font-semibold">
              {user.name.split(' ').map(n => n[0]).join('').slice(0, 2)}
            </div>
            <div className="flex-1">
              <p className="font-medium text-slate-800">{user.name}</p>
              <p className="text-sm text-slate-500">{user.email}</p>
            </div>
            <span className={`badge ${
              user.role === 'admin' ? 'bg-purple-100 text-purple-700' :
              user.role === 'supervisor' ? 'bg-blue-100 text-blue-700' :
              'bg-slate-100 text-slate-700'
            }`}>
              {roleLabels[user.role]}
            </span>
            <button className="text-sm text-primary-600 hover:underline">Editar</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// Payment Methods Settings Section
function PaymentMethodsSettings({ methods }) {
  const paymentMethods = [
    { id: 'cash', name: 'Efectivo', enabled: true, icon: '💵' },
    { id: 'card', name: 'Tarjeta', enabled: true, icon: '💳' },
    { id: 'yappy', name: 'Yappy', enabled: true, icon: '📱' },
    { id: 'ach', name: 'ACH', enabled: true, icon: '🏦' },
    { id: 'invoice', name: 'Facturar', enabled: true, icon: '📄' },
    { id: 'pickup', name: 'Pagar al Recoger', enabled: true, icon: '🛒' },
  ];

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Métodos de Pago</h2>
          <p className="text-sm text-slate-500">Configura las formas de pago aceptadas</p>
        </div>
        <button className="btn-primary">
          <Save className="w-4 h-4" />
          Guardar
        </button>
      </div>
      
      <div className="space-y-3">
        {paymentMethods.map((method) => (
          <div key={method.id} className="flex items-center gap-4 p-4 bg-slate-50 rounded-xl">
            <span className="text-2xl">{method.icon}</span>
            <span className="flex-1 font-medium text-slate-700">{method.name}</span>
            <label className="relative inline-flex items-center cursor-pointer">
              <input type="checkbox" defaultChecked={method.enabled} className="sr-only peer" />
              <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
            </label>
          </div>
        ))}
      </div>
    </div>
  );
}

// Notifications Settings Section
function NotificationsSettings() {
  const templates = [
    { id: 'welcome', name: 'Bienvenida', description: 'Email de bienvenida al registrar cliente', enabled: true },
    { id: 'order_created', name: 'Orden Creada', description: 'Confirmación de recepción de orden', enabled: true },
    { id: 'order_ready', name: 'Orden Lista', description: 'Notificación cuando la orden está lista', enabled: true },
    { id: 'order_delivered', name: 'Orden Entregada', description: 'Confirmación de entrega', enabled: false },
  ];

  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Notificaciones por Email</h2>
          <p className="text-sm text-slate-500">Configura las plantillas de correo electrónico</p>
        </div>
      </div>
      
      <div className="space-y-3">
        {templates.map((template) => (
          <div key={template.id} className="flex items-center gap-4 p-4 bg-slate-50 rounded-xl">
            <Mail className="w-5 h-5 text-slate-400" />
            <div className="flex-1">
              <p className="font-medium text-slate-700">{template.name}</p>
              <p className="text-sm text-slate-500">{template.description}</p>
            </div>
            <label className="relative inline-flex items-center cursor-pointer">
              <input type="checkbox" defaultChecked={template.enabled} className="sr-only peer" />
              <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
            </label>
            <button className="text-sm text-primary-600 hover:underline">Editar</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// Products Settings - Full Implementation
function ProductsSettings() {
  const { state } = useApp();
  const [activeTab, setActiveTab] = useState('products'); // products, sections, preferences
  const [selectedSection, setSelectedSection] = useState('all');
  const [showAddModal, setShowAddModal] = useState(false);
  const [editingProduct, setEditingProduct] = useState(null);
  const [showSectionModal, setShowSectionModal] = useState(false);
  
  // Sample sections from state
  const sections = state.sections || [
    { id: 'sec-001', name: 'Lava y Dobla', color: '#0ea5e9', is_active: true },
    { id: 'sec-002', name: 'Lavamático', color: '#8b5cf6', is_active: true },
    { id: 'sec-003', name: 'Productos', color: '#10b981', is_active: true },
    { id: 'sec-004', name: 'Corporativo', color: '#f59e0b', is_active: true },
  ];
  
  // Sample products from state
  const products = state.products || [];
  
  // Filter products by section
  const filteredProducts = selectedSection === 'all' 
    ? products 
    : products.filter(p => p.section_id === selectedSection);
  
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
          
          {/* Products Table */}
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-slate-50 border-b border-slate-200">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase w-8"></th>
                  <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">Producto</th>
                  <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase">Sección</th>
                  <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Precio</th>
                  <th className="px-4 py-3 text-right text-xs font-semibold text-slate-500 uppercase">Express</th>
                  <th className="px-4 py-3 text-center text-xs font-semibold text-slate-500 uppercase">Tipo</th>
                  <th className="px-4 py-3 text-center text-xs font-semibold text-slate-500 uppercase">Activo</th>
                  <th className="px-4 py-3 text-center text-xs font-semibold text-slate-500 uppercase">Acciones</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {filteredProducts.map((product) => {
                  const section = sections.find(s => s.id === product.section_id);
                  const isChild = product.parent_id !== null;
                  
                  return (
                    <tr key={product.id} className={`hover:bg-slate-50 ${isChild ? 'bg-slate-25' : ''}`}>
                      <td className="px-4 py-3">
                        <GripVertical className="w-4 h-4 text-slate-300 cursor-grab" />
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-3">
                          <span className="text-2xl">{product.icon || '📦'}</span>
                          <div>
                            <p className={`font-medium text-slate-800 ${isChild ? 'pl-4 text-sm' : ''}`}>
                              {isChild && <span className="text-slate-400 mr-1">↳</span>}
                              {product.name}
                            </p>
                            {product.has_children && (
                              <p className="text-xs text-slate-400">Tiene sub-productos</p>
                            )}
                          </div>
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <span 
                          className="badge text-xs"
                          style={{ 
                            backgroundColor: `${section?.color}20`, 
                            color: section?.color 
                          }}
                        >
                          {section?.name || '-'}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-right font-medium text-slate-800">
                        {product.price ? `B/${product.price.toFixed(2)}` : '-'}
                      </td>
                      <td className="px-4 py-3 text-right text-slate-600">
                        {product.express_price ? `B/${product.express_price.toFixed(2)}` : '-'}
                      </td>
                      <td className="px-4 py-3 text-center">
                        {product.pricing_type === 'weight' ? (
                          <span className="badge bg-blue-100 text-blue-700">
                            <Scale className="w-3 h-3 mr-1" />
                            Peso
                          </span>
                        ) : (
                          <span className="badge bg-slate-100 text-slate-700">
                            <Hash className="w-3 h-3 mr-1" />
                            Cantidad
                          </span>
                        )}
                      </td>
                      <td className="px-4 py-3 text-center">
                        {product.is_active !== false ? (
                          <span className="w-6 h-6 bg-success-100 text-success-600 rounded-full flex items-center justify-center mx-auto">
                            <Check className="w-4 h-4" />
                          </span>
                        ) : (
                          <span className="w-6 h-6 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center mx-auto">
                            <X className="w-4 h-4" />
                          </span>
                        )}
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center justify-center gap-1">
                          <button 
                            onClick={() => { setEditingProduct(product); setShowAddModal(true); }}
                            className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-primary-600"
                          >
                            <Edit2 className="w-4 h-4" />
                          </button>
                          <button className="p-2 hover:bg-slate-100 rounded-lg transition-colors text-slate-500 hover:text-error-600">
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
            
            {filteredProducts.length === 0 && (
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
                    defaultChecked={section.is_active} 
                    className="sr-only peer" 
                  />
                  <div className="w-11 h-6 bg-slate-200 peer-focus:ring-2 peer-focus:ring-primary-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary-500"></div>
                </label>
                <button className="p-2 hover:bg-white rounded-lg transition-colors text-slate-500 hover:text-primary-600">
                  <Edit2 className="w-4 h-4" />
                </button>
              </div>
            ))}
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
          onSave={(product) => {
            console.log('Saving product:', product);
            setShowAddModal(false);
            setEditingProduct(null);
          }}
        />
      )}
    </div>
  );
}

// Product Form Modal
function ProductFormModal({ product, sections, products, onClose, onSave }) {
  const { state } = useApp();
  const ITBMS_RATE = state.settings?.itbms_rate || 7; // Default 7%
  
  const isEditing = product !== null;
  
  // Calculate initial total prices from base prices if editing
  const calculateTotalFromBase = (basePrice) => {
    if (!basePrice) return '';
    return (basePrice * (1 + ITBMS_RATE / 100)).toFixed(2);
  };
  
  const [formData, setFormData] = useState({
    name: product?.name || '',
    section_id: product?.section_id || sections[0]?.id || '',
    icon: product?.icon || '📦',
    pricing_type: product?.pricing_type || 'quantity',
    // Store total prices (with ITBMS) for input
    total_price: product?.price ? calculateTotalFromBase(product.price) : '',
    total_express_price: product?.express_price ? calculateTotalFromBase(product.express_price) : '',
    cost: product?.cost || '',
    min_quantity: product?.min_quantity || 1,
    pieces_per_unit: product?.pieces_per_unit || 1,
    parent_id: product?.parent_id || '',
    is_active: product?.is_active !== false,
    is_taxable: product?.is_taxable !== false,
    extra_days: product?.extra_days || 0,
  });
  
  // Calculate base price and ITBMS from total price
  const calculatePriceBreakdown = (totalPrice) => {
    if (!totalPrice || isNaN(parseFloat(totalPrice))) {
      return { basePrice: 0, itbms: 0 };
    }
    const total = parseFloat(totalPrice);
    const basePrice = total / (1 + ITBMS_RATE / 100);
    const itbms = total - basePrice;
    return { basePrice, itbms };
  };
  
  const priceBreakdown = calculatePriceBreakdown(formData.total_price);
  const expressPriceBreakdown = calculatePriceBreakdown(formData.total_express_price);
  
  const handleChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };
  
  const handleSubmit = () => {
    // Calculate base prices to store in DB
    const { basePrice } = calculatePriceBreakdown(formData.total_price);
    const { basePrice: expressBasePrice } = calculatePriceBreakdown(formData.total_express_price);
    
    onSave({
      id: product?.id || `prod-${Date.now()}`,
      name: formData.name,
      section_id: formData.section_id,
      icon: formData.icon,
      pricing_type: formData.pricing_type,
      // Store base price (without ITBMS) in DB
      price: parseFloat(basePrice.toFixed(2)) || 0,
      express_price: parseFloat(expressBasePrice.toFixed(2)) || 0,
      cost: parseFloat(formData.cost) || 0,
      min_quantity: formData.min_quantity,
      pieces_per_unit: formData.pieces_per_unit,
      parent_id: formData.parent_id || null,
      is_active: formData.is_active,
      is_taxable: formData.is_taxable,
      extra_days: formData.extra_days,
    });
  };
  
  // Parent products (those without parent_id)
  const parentProducts = products.filter(p => !p.parent_id && p.id !== product?.id);
  
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
            
            {/* Pricing Type */}
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
            
            {/* Parent Product */}
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Producto Padre (opcional)
              </label>
              <select
                value={formData.parent_id}
                onChange={(e) => handleChange('parent_id', e.target.value)}
                className="input"
              >
                <option value="">Ninguno (producto principal)</option>
                {parentProducts.map((p) => (
                  <option key={p.id} value={p.id}>{p.name}</option>
                ))}
              </select>
              <p className="text-xs text-slate-400 mt-1">Si es sub-producto, selecciona el padre</p>
            </div>
            
            {/* Price Section - with ITBMS calculation */}
            <div className="col-span-2 p-4 bg-slate-50 rounded-xl space-y-4">
              <div className="flex items-center gap-2 mb-2">
                <Percent className="w-4 h-4 text-primary-500" />
                <span className="text-sm font-medium text-slate-700">
                  Precios (ITBMS {ITBMS_RATE}% incluido)
                </span>
              </div>
              
              <div className="grid grid-cols-2 gap-4">
                {/* Total Price (with ITBMS) */}
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">
                    Precio de Venta {formData.pricing_type === 'weight' ? '(por kg)' : ''} <span className="text-error-500">*</span>
                  </label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                    <input
                      type="number"
                      step="0.01"
                      value={formData.total_price}
                      onChange={(e) => handleChange('total_price', e.target.value)}
                      className="input pl-9"
                      placeholder="0.00"
                    />
                  </div>
                  {formData.total_price && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio base:</span>
                        <span className="font-medium text-slate-700">B/{priceBreakdown.basePrice.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1">
                        <span className="text-slate-500">ITBMS ({ITBMS_RATE}%):</span>
                        <span className="font-medium text-slate-700">B/{priceBreakdown.itbms.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1 pt-1 border-t border-slate-100">
                        <span className="text-slate-600 font-medium">Total:</span>
                        <span className="font-bold text-primary-600">B/{parseFloat(formData.total_price).toFixed(2)}</span>
                      </div>
                    </div>
                  )}
                </div>
                
                {/* Express Total Price (with ITBMS) */}
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">
                    Precio Express {formData.pricing_type === 'weight' ? '(por kg)' : ''}
                  </label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">B/</span>
                    <input
                      type="number"
                      step="0.01"
                      value={formData.total_express_price}
                      onChange={(e) => handleChange('total_express_price', e.target.value)}
                      className="input pl-9"
                      placeholder="0.00"
                    />
                  </div>
                  {formData.total_express_price && (
                    <div className="mt-2 p-2 bg-white rounded-lg border border-slate-200">
                      <div className="flex justify-between text-xs">
                        <span className="text-slate-500">Precio base:</span>
                        <span className="font-medium text-slate-700">B/{expressPriceBreakdown.basePrice.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1">
                        <span className="text-slate-500">ITBMS ({ITBMS_RATE}%):</span>
                        <span className="font-medium text-slate-700">B/{expressPriceBreakdown.itbms.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-xs mt-1 pt-1 border-t border-slate-100">
                        <span className="text-slate-600 font-medium">Total:</span>
                        <span className="font-bold text-warning-600">B/{parseFloat(formData.total_express_price).toFixed(2)}</span>
                      </div>
                    </div>
                  )}
                </div>
              </div>
            </div>
            
            {/* Cost */}
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
            
            {/* Min Quantity */}
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
            
            {/* Pieces per Unit */}
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
            
            {/* Extra Days */}
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
              
              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={formData.is_taxable}
                  onChange={(e) => handleChange('is_taxable', e.target.checked)}
                  className="rounded border-slate-300 text-primary-500 focus:ring-primary-500"
                />
                <span className="text-sm text-slate-700">Aplica ITBMS</span>
              </label>
            </div>
          </div>
        </div>
        
        {/* Footer */}
        <div className="flex items-center justify-end gap-3 p-4 border-t border-slate-100">
          <button type="button" onClick={onClose} className="btn-secondary">
            Cancelar
          </button>
          <button type="button" onClick={handleSubmit} className="btn-primary">
            <Save className="w-4 h-4" />
            {isEditing ? 'Guardar Cambios' : 'Crear Producto'}
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
