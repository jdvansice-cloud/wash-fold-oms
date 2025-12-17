import React, { useState } from 'react';
import { 
  Building, Store, Users, CreditCard, Bell, Mail,
  Gift, Tag, Package, Clock, Percent, Save,
  ChevronRight, Check, Settings as SettingsIcon
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

// Products Settings (placeholder)
function ProductsSettings() {
  return (
    <div className="card p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-800">Gestión de Productos</h2>
          <p className="text-sm text-slate-500">Administra productos y servicios</p>
        </div>
        <button className="btn-primary">
          <Package className="w-4 h-4" />
          Nuevo Producto
        </button>
      </div>
      
      <div className="text-center py-12 text-slate-400">
        <Package className="w-16 h-16 mx-auto mb-4 opacity-50" />
        <p className="font-medium">Próximamente</p>
        <p className="text-sm mt-1">La gestión de productos estará disponible pronto</p>
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
