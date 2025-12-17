import React, { useState, useMemo } from 'react';
import { X, Search, Plus, User, Phone, Mail, Building } from 'lucide-react';
import { useApp } from '../../context/AppContext';

function CustomerSearchModal({ onClose, onSelect }) {
  const { state, actions } = useApp();
  const [searchQuery, setSearchQuery] = useState('');
  const [showAddForm, setShowAddForm] = useState(false);
  
  // Filter customers based on search
  const filteredCustomers = useMemo(() => {
    if (!searchQuery.trim()) return state.customers.slice(0, 10);
    
    const query = searchQuery.toLowerCase();
    return state.customers.filter(customer => {
      const fullName = `${customer.first_name} ${customer.last_name}`.toLowerCase();
      const phone = customer.phone?.toLowerCase() || '';
      const email = customer.email?.toLowerCase() || '';
      
      return fullName.includes(query) || phone.includes(query) || email.includes(query);
    });
  }, [searchQuery, state.customers]);
  
  const handleSelectWalkIn = () => {
    onSelect(null);
  };
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[85vh] flex flex-col animate-scale-in">
        {/* Header */}
        <div className="flex items-center justify-between p-4 border-b border-slate-100">
          <h2 className="text-lg font-semibold text-slate-800">
            {showAddForm ? 'Nuevo Cliente' : 'Seleccionar Cliente'}
          </h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-slate-500" />
          </button>
        </div>
        
        {showAddForm ? (
          <AddCustomerForm 
            onCancel={() => setShowAddForm(false)}
            onSave={(customer) => {
              actions.addCustomer(customer);
              onSelect(customer);
            }}
          />
        ) : (
          <>
            {/* Search */}
            <div className="p-4 border-b border-slate-100">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="Buscar por nombre, teléfono o email..."
                  className="input pl-10"
                  autoFocus
                />
              </div>
            </div>
            
            {/* Customer List */}
            <div className="flex-1 overflow-y-auto p-2 scrollbar-thin">
              {/* Walk-in Option */}
              <button
                onClick={handleSelectWalkIn}
                className="w-full flex items-center gap-3 p-3 rounded-xl hover:bg-slate-50 transition-colors mb-2"
              >
                <div className="w-10 h-10 bg-slate-200 rounded-full flex items-center justify-center">
                  <User className="w-5 h-5 text-slate-500" />
                </div>
                <div className="flex-1 text-left">
                  <p className="font-medium text-slate-700">Walk-in</p>
                  <p className="text-xs text-slate-500">Cliente sin registrar</p>
                </div>
              </button>
              
              {/* Customer Results */}
              {filteredCustomers.map((customer) => (
                <button
                  key={customer.id}
                  onClick={() => onSelect(customer)}
                  className="w-full flex items-center gap-3 p-3 rounded-xl hover:bg-slate-50 transition-colors"
                >
                  <div className="w-10 h-10 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center font-semibold">
                    {customer.first_name[0]}{customer.last_name[0]}
                  </div>
                  <div className="flex-1 text-left min-w-0">
                    <p className="font-medium text-slate-800 truncate">
                      {customer.first_name} {customer.last_name}
                    </p>
                    <div className="flex items-center gap-3 text-xs text-slate-500">
                      <span className="flex items-center gap-1">
                        <Phone className="w-3 h-3" />
                        {customer.phone}
                      </span>
                      {customer.email && (
                        <span className="flex items-center gap-1 truncate">
                          <Mail className="w-3 h-3" />
                          {customer.email}
                        </span>
                      )}
                    </div>
                  </div>
                  {customer.company_name && (
                    <span className="badge bg-slate-100 text-slate-600">
                      <Building className="w-3 h-3 mr-1" />
                      Corp
                    </span>
                  )}
                </button>
              ))}
              
              {filteredCustomers.length === 0 && searchQuery && (
                <div className="text-center py-8 text-slate-400">
                  <User className="w-12 h-12 mx-auto mb-3 opacity-50" />
                  <p className="text-sm">No se encontraron clientes</p>
                </div>
              )}
            </div>
            
            {/* Add New Customer Button */}
            <div className="p-4 border-t border-slate-100">
              <button
                onClick={() => setShowAddForm(true)}
                className="w-full btn-primary"
              >
                <Plus className="w-4 h-4" />
                Agregar Nuevo Cliente
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

// Add Customer Form Component
function AddCustomerForm({ onCancel, onSave }) {
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
    <div className="flex-1 overflow-y-auto p-4 scrollbar-thin">
      <div className="space-y-4">
        {/* Name Fields */}
        <div className="grid grid-cols-2 gap-3">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Nombre <span className="text-error-500">*</span>
            </label>
            <input
              type="text"
              value={formData.first_name}
              onChange={(e) => handleChange('first_name', e.target.value)}
              className={`input ${errors.first_name ? 'input-error' : ''}`}
              placeholder="Juan"
            />
            {errors.first_name && (
              <p className="text-xs text-error-500 mt-1">{errors.first_name}</p>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Apellido <span className="text-error-500">*</span>
            </label>
            <input
              type="text"
              value={formData.last_name}
              onChange={(e) => handleChange('last_name', e.target.value)}
              className={`input ${errors.last_name ? 'input-error' : ''}`}
              placeholder="Pérez"
            />
            {errors.last_name && (
              <p className="text-xs text-error-500 mt-1">{errors.last_name}</p>
            )}
          </div>
        </div>
        
        {/* Phone */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Teléfono <span className="text-error-500">*</span>
          </label>
          <div className="flex gap-2">
            <select
              value={formData.phone_country_code}
              onChange={(e) => handleChange('phone_country_code', e.target.value)}
              className="input w-24"
            >
              <option value="+507">+507</option>
              <option value="+1">+1</option>
              <option value="+57">+57</option>
            </select>
            <input
              type="tel"
              value={formData.phone}
              onChange={(e) => handleChange('phone', e.target.value)}
              className={`input flex-1 ${errors.phone ? 'input-error' : ''}`}
              placeholder="6123-4567"
            />
          </div>
          {errors.phone && (
            <p className="text-xs text-error-500 mt-1">{errors.phone}</p>
          )}
        </div>
        
        {/* Email */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Email
          </label>
          <input
            type="email"
            value={formData.email}
            onChange={(e) => handleChange('email', e.target.value)}
            className="input"
            placeholder="correo@ejemplo.com"
          />
        </div>
        
        {/* Address */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Dirección
          </label>
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
        
        {/* Location */}
        <div className="grid grid-cols-2 gap-3">
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Distrito
            </label>
            <select
              value={formData.address_district}
              onChange={(e) => handleChange('address_district', e.target.value)}
              className="input"
            >
              <option value="Panamá">Panamá</option>
              <option value="San Miguelito">San Miguelito</option>
              <option value="Arraiján">Arraiján</option>
              <option value="La Chorrera">La Chorrera</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Corregimiento
            </label>
            <input
              type="text"
              value={formData.address_corregimiento}
              onChange={(e) => handleChange('address_corregimiento', e.target.value)}
              className="input"
              placeholder="Bella Vista"
            />
          </div>
        </div>
        
        {/* ID Type */}
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">
            Tipo de Identificación
          </label>
          <div className="flex gap-2">
            {['cedula', 'passport', 'ruc'].map((type) => (
              <button
                key={type}
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
        
        {/* ID Number */}
        {formData.id_type && formData.id_type !== 'ruc' && (
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">
              Número de {formData.id_type === 'cedula' ? 'Cédula' : 'Pasaporte'}
            </label>
            <input
              type="text"
              value={formData.id_number}
              onChange={(e) => handleChange('id_number', e.target.value)}
              className="input"
              placeholder={formData.id_type === 'cedula' ? '8-123-4567' : 'AB123456'}
            />
          </div>
        )}
        
        {/* RUC Fields */}
        {formData.id_type === 'ruc' && (
          <>
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Nombre de Empresa
              </label>
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
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  RUC
                </label>
                <input
                  type="text"
                  value={formData.ruc}
                  onChange={(e) => handleChange('ruc', e.target.value)}
                  className="input"
                  placeholder="155737034-2-2023"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  DV
                </label>
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
      
      {/* Actions */}
      <div className="flex gap-3 mt-6 pt-4 border-t border-slate-100">
        <button onClick={onCancel} className="btn-secondary flex-1">
          Cancelar
        </button>
        <button onClick={handleSubmit} className="btn-primary flex-1">
          Guardar Cliente
        </button>
      </div>
    </div>
  );
}

export default CustomerSearchModal;
