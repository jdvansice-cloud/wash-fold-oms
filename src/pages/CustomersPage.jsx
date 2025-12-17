import React, { useState, useMemo } from 'react';
import { 
  Search, Plus, User, Phone, Mail, Building, 
  MapPin, Edit, Trash2, Eye, Star, Clock 
} from 'lucide-react';
import { useApp } from '../context/AppContext';

function CustomersPage() {
  const { state, actions } = useApp();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCustomer, setSelectedCustomer] = useState(null);
  const [showAddModal, setShowAddModal] = useState(false);
  
  const filteredCustomers = useMemo(() => {
    if (!searchQuery.trim()) return state.customers;
    
    const query = searchQuery.toLowerCase();
    return state.customers.filter(customer => {
      const fullName = `${customer.first_name} ${customer.last_name}`.toLowerCase();
      const phone = customer.phone?.toLowerCase() || '';
      const email = customer.email?.toLowerCase() || '';
      
      return fullName.includes(query) || phone.includes(query) || email.includes(query);
    });
  }, [searchQuery, state.customers]);
  
  const formatCurrency = (amount) => `B/${amount?.toFixed(2) || '0.00'}`;
  
  return (
    <div className="p-6 animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-display font-bold text-slate-800">Clientes</h1>
          <p className="text-sm text-slate-500">{state.customers.length} clientes registrados</p>
        </div>
        
        <button 
          onClick={() => setShowAddModal(true)}
          className="btn-primary"
        >
          <Plus className="w-4 h-4" />
          Nuevo Cliente
        </button>
      </div>
      
      {/* Search */}
      <div className="relative mb-6">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
        <input
          type="text"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          placeholder="Buscar por nombre, teléfono o email..."
          className="input pl-10 max-w-md"
        />
      </div>
      
      {/* Customers Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredCustomers.map((customer) => (
          <CustomerCard
            key={customer.id}
            customer={customer}
            onClick={() => setSelectedCustomer(customer)}
          />
        ))}
      </div>
      
      {/* Empty State */}
      {filteredCustomers.length === 0 && (
        <div className="text-center py-12 text-slate-400">
          <User className="w-16 h-16 mx-auto mb-4 opacity-50" />
          <p className="text-lg font-medium">No se encontraron clientes</p>
          <p className="text-sm mt-1">
            {searchQuery ? 'Intenta con otra búsqueda' : 'Agrega tu primer cliente'}
          </p>
        </div>
      )}
      
      {/* Customer Details Modal */}
      {selectedCustomer && (
        <CustomerDetailsModal
          customer={selectedCustomer}
          onClose={() => setSelectedCustomer(null)}
          orders={state.orders.filter(o => o.customer_id === selectedCustomer.id)}
        />
      )}
      
      {/* Add Customer Modal */}
      {showAddModal && (
        <AddCustomerModal
          onClose={() => setShowAddModal(false)}
          onSave={(customer) => {
            actions.addCustomer(customer);
            setShowAddModal(false);
          }}
        />
      )}
    </div>
  );
}

function CustomerCard({ customer, onClick }) {
  const hasBalance = customer.account_balance > 0;
  
  return (
    <div
      onClick={onClick}
      className="card p-4 cursor-pointer hover:shadow-soft transition-shadow group"
    >
      <div className="flex items-start gap-3">
        <div className="w-12 h-12 bg-gradient-to-br from-primary-400 to-primary-600 text-white rounded-full flex items-center justify-center font-semibold text-lg flex-shrink-0">
          {customer.first_name[0]}{customer.last_name[0]}
        </div>
        
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <h3 className="font-semibold text-slate-800 truncate group-hover:text-primary-600 transition-colors">
              {customer.first_name} {customer.last_name}
            </h3>
            {customer.company_name && (
              <Building className="w-4 h-4 text-slate-400 flex-shrink-0" />
            )}
          </div>
          
          <div className="flex items-center gap-2 mt-1 text-sm text-slate-500">
            <Phone className="w-3.5 h-3.5" />
            <span>{customer.phone_country_code} {customer.phone}</span>
          </div>
          
          {customer.email && (
            <div className="flex items-center gap-2 mt-1 text-sm text-slate-500 truncate">
              <Mail className="w-3.5 h-3.5 flex-shrink-0" />
              <span className="truncate">{customer.email}</span>
            </div>
          )}
        </div>
      </div>
      
      <div className="flex items-center justify-between mt-4 pt-3 border-t border-slate-100">
        <div className="flex items-center gap-1 text-xs text-slate-500">
          <Star className="w-3.5 h-3.5 text-warning-500" />
          <span>{customer.loyalty_points || 0} pts</span>
        </div>
        
        {hasBalance ? (
          <span className="badge bg-error-100 text-error-700">
            Debe: B/{customer.account_balance.toFixed(2)}
          </span>
        ) : customer.can_be_invoiced ? (
          <span className="badge bg-primary-100 text-primary-700">
            Facturación
          </span>
        ) : null}
      </div>
    </div>
  );
}

function CustomerDetailsModal({ customer, onClose, orders }) {
  const formatCurrency = (amount) => `B/${amount?.toFixed(2) || '0.00'}`;
  
  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
    }).format(date);
  };
  
  const totalSpent = orders.reduce((sum, order) => sum + (order.total || 0), 0);
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-2xl max-h-[90vh] overflow-hidden animate-scale-in">
        <div className="bg-gradient-to-r from-primary-500 to-primary-600 p-6 text-white">
          <div className="flex items-start justify-between">
            <div className="flex items-center gap-4">
              <div className="w-16 h-16 bg-white/20 backdrop-blur rounded-full flex items-center justify-center text-2xl font-bold">
                {customer.first_name[0]}{customer.last_name[0]}
              </div>
              <div>
                <h2 className="text-xl font-bold">
                  {customer.first_name} {customer.last_name}
                </h2>
                {customer.company_name && (
                  <p className="text-primary-100 flex items-center gap-1">
                    <Building className="w-4 h-4" />
                    {customer.company_name}
                  </p>
                )}
              </div>
            </div>
            <button
              onClick={onClose}
              className="p-2 hover:bg-white/10 rounded-lg transition-colors"
            >
              <span className="text-2xl">&times;</span>
            </button>
          </div>
          
          <div className="grid grid-cols-3 gap-4 mt-6">
            <div className="bg-white/10 backdrop-blur rounded-xl p-3 text-center">
              <p className="text-2xl font-bold">{orders.length}</p>
              <p className="text-xs text-primary-100">Órdenes</p>
            </div>
            <div className="bg-white/10 backdrop-blur rounded-xl p-3 text-center">
              <p className="text-2xl font-bold">{formatCurrency(totalSpent)}</p>
              <p className="text-xs text-primary-100">Total Gastado</p>
            </div>
            <div className="bg-white/10 backdrop-blur rounded-xl p-3 text-center">
              <p className="text-2xl font-bold">{customer.loyalty_points || 0}</p>
              <p className="text-xs text-primary-100">Puntos</p>
            </div>
          </div>
        </div>
        
        <div className="p-6 overflow-y-auto max-h-[50vh] scrollbar-thin">
          <div className="mb-6">
            <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">
              Información de Contacto
            </h3>
            <div className="grid grid-cols-2 gap-4">
              <div className="flex items-center gap-3 text-sm">
                <Phone className="w-4 h-4 text-slate-400" />
                <span className="text-slate-700">{customer.phone_country_code} {customer.phone}</span>
              </div>
              {customer.email && (
                <div className="flex items-center gap-3 text-sm">
                  <Mail className="w-4 h-4 text-slate-400" />
                  <span className="text-slate-700">{customer.email}</span>
                </div>
              )}
            </div>
            
            {customer.address_street && (
              <div className="flex items-start gap-3 text-sm mt-3">
                <MapPin className="w-4 h-4 text-slate-400 mt-0.5" />
                <div className="text-slate-700">
                  <p>{customer.address_street}</p>
                  {customer.address_building && <p>{customer.address_building}</p>}
                  <p>{customer.address_corregimiento}, {customer.address_district}</p>
                </div>
              </div>
            )}
          </div>
          
          {customer.preferences && (
            <div className="mb-6">
              <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">
                Preferencias
              </h3>
              <div className="flex flex-wrap gap-2">
                {customer.preferences.scent && (
                  <span className="badge bg-purple-100 text-purple-700">
                    🌸 {customer.preferences.scent}
                  </span>
                )}
                {customer.preferences.softener && (
                  <span className="badge bg-blue-100 text-blue-700">
                    💧 {customer.preferences.softener}
                  </span>
                )}
              </div>
            </div>
          )}
          
          <div>
            <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">
              Órdenes Recientes
            </h3>
            
            {orders.length > 0 ? (
              <div className="space-y-2">
                {orders.slice(0, 5).map((order) => (
                  <div
                    key={order.id}
                    className="flex items-center justify-between p-3 bg-slate-50 rounded-xl"
                  >
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center text-xs font-bold">
                        #{order.order_number}
                      </div>
                      <div>
                        <p className="text-sm font-medium text-slate-700">
                          {order.total_weight?.toFixed(2) || '0.00'} kg
                        </p>
                        <p className="text-xs text-slate-500">
                          {formatDate(order.created_at)}
                        </p>
                      </div>
                    </div>
                    <span className="font-semibold text-slate-800">
                      {formatCurrency(order.total)}
                    </span>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-sm text-slate-400 text-center py-4">
                Sin órdenes registradas
              </p>
            )}
          </div>
        </div>
        
        <div className="p-4 border-t border-slate-100 flex gap-3">
          <button className="btn-secondary flex-1">
            <Edit className="w-4 h-4" />
            Editar
          </button>
          <button className="btn-primary flex-1">
            <Plus className="w-4 h-4" />
            Nueva Orden
          </button>
        </div>
      </div>
    </div>
  );
}

function AddCustomerModal({ onClose, onSave }) {
  const [formData, setFormData] = useState({
    first_name: '',
    last_name: '',
    phone_country_code: '+507',
    phone: '',
    email: '',
    address_street: '',
    address_building: '',
    address_city: 'Panamá',
    address_district: 'Panamá',
    address_corregimiento: '',
    id_type: null,
    id_number: '',
    company_name: '',
    ruc: '',
    dv: '',
  });
  
  const [errors, setErrors] = useState({});
  
  const handleChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: null }));
    }
  };
  
  const validate = () => {
    const newErrors = {};
    if (!formData.first_name.trim()) newErrors.first_name = 'Nombre requerido';
    if (!formData.last_name.trim()) newErrors.last_name = 'Apellido requerido';
    if (!formData.phone.trim()) newErrors.phone = 'Teléfono requerido';
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };
  
  const handleSubmit = () => {
    if (!validate()) return;
    
    const newCustomer = {
      id: `cust-${Date.now()}`,
      store_id: 'store-001',
      ...formData,
      can_be_invoiced: formData.id_type === 'ruc',
      account_balance: 0,
      loyalty_points: 0,
      preferences: { scent: 'Sin preferencia', softener: 'Sin preferencia' },
    };
    
    onSave(newCustomer);
  };
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[90vh] overflow-hidden animate-scale-in">
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">Nuevo Cliente</h2>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-lg transition-colors">
            <span className="text-slate-500 text-xl">&times;</span>
          </button>
        </div>
        
        <div className="p-4 overflow-y-auto max-h-[60vh] scrollbar-thin space-y-4">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Nombre *</label>
              <input
                type="text"
                value={formData.first_name}
                onChange={(e) => handleChange('first_name', e.target.value)}
                className={`input ${errors.first_name ? 'input-error' : ''}`}
                placeholder="Juan"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Apellido *</label>
              <input
                type="text"
                value={formData.last_name}
                onChange={(e) => handleChange('last_name', e.target.value)}
                className={`input ${errors.last_name ? 'input-error' : ''}`}
                placeholder="Pérez"
              />
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Teléfono *</label>
            <div className="flex gap-2">
              <select
                value={formData.phone_country_code}
                onChange={(e) => handleChange('phone_country_code', e.target.value)}
                className="input w-24"
              >
                <option value="+507">+507</option>
                <option value="+1">+1</option>
              </select>
              <input
                type="tel"
                value={formData.phone}
                onChange={(e) => handleChange('phone', e.target.value)}
                className={`input flex-1 ${errors.phone ? 'input-error' : ''}`}
                placeholder="6123-4567"
              />
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Email</label>
            <input
              type="email"
              value={formData.email}
              onChange={(e) => handleChange('email', e.target.value)}
              className="input"
              placeholder="correo@ejemplo.com"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Dirección</label>
            <input
              type="text"
              value={formData.address_street}
              onChange={(e) => handleChange('address_street', e.target.value)}
              className="input mb-2"
              placeholder="Calle, Avenida..."
            />
            <input
              type="text"
              value={formData.address_building}
              onChange={(e) => handleChange('address_building', e.target.value)}
              className="input"
              placeholder="Edificio, Apt, Casa..."
            />
          </div>
          
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Distrito</label>
              <select
                value={formData.address_district}
                onChange={(e) => handleChange('address_district', e.target.value)}
                className="input"
              >
                <option value="Panamá">Panamá</option>
                <option value="San Miguelito">San Miguelito</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Corregimiento</label>
              <input
                type="text"
                value={formData.address_corregimiento}
                onChange={(e) => handleChange('address_corregimiento', e.target.value)}
                className="input"
                placeholder="Bella Vista"
              />
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Tipo de Identificación</label>
            <div className="flex gap-2">
              {['cedula', 'passport', 'ruc'].map((type) => (
                <button
                  key={type}
                  type="button"
                  onClick={() => handleChange('id_type', formData.id_type === type ? null : type)}
                  className={`flex-1 py-2 px-3 rounded-lg text-sm font-medium transition-colors ${
                    formData.id_type === type
                      ? 'bg-primary-500 text-white'
                      : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                  }`}
                >
                  {type === 'cedula' ? 'Cédula' : type === 'passport' ? 'Pasaporte' : 'RUC'}
                </button>
              ))}
            </div>
          </div>
          
          {formData.id_type === 'ruc' && (
            <>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">Nombre de Empresa</label>
                <input
                  type="text"
                  value={formData.company_name}
                  onChange={(e) => handleChange('company_name', e.target.value)}
                  className="input"
                  placeholder="Empresa S.A."
                />
              </div>
              <div className="grid grid-cols-3 gap-3">
                <div className="col-span-2">
                  <label className="block text-sm font-medium text-slate-700 mb-1">RUC</label>
                  <input
                    type="text"
                    value={formData.ruc}
                    onChange={(e) => handleChange('ruc', e.target.value)}
                    className="input"
                    placeholder="155737034-2-2023"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">DV</label>
                  <input
                    type="text"
                    value={formData.dv}
                    onChange={(e) => handleChange('dv', e.target.value)}
                    className="input"
                    placeholder="38"
                  />
                </div>
              </div>
            </>
          )}
        </div>
        
        <div className="p-4 border-t border-slate-100 flex gap-3">
          <button onClick={onClose} className="btn-secondary flex-1">Cancelar</button>
          <button onClick={handleSubmit} className="btn-primary flex-1">Guardar Cliente</button>
        </div>
      </div>
    </div>
  );
}

export default CustomersPage;
