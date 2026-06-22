import React, { useState, useMemo, useEffect } from 'react';
import { 
  Search, Plus, User, Phone, Mail, Building, 
  MapPin, Edit, Trash2, Eye, Star, Clock,
  Award, Coins, Stamp, Gift
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useDataLoader } from '../hooks/useDataLoader';

// Helper to display order number (legacy CC orders or new orders)
const getOrderDisplayNumber = (order) => {
  if (order.legacy_order_number) {
    return order.legacy_order_number; // e.g., "CC1234"
  }
  return `#${order.order_number}`;
};

// Helper to fetch customer loyalty data
const fetchCustomerLoyalty = async (customerId) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  
  if (!url || !key || !customerId) return null;
  
  try {
    const response = await fetch(
      `${url}/rest/v1/customer_loyalty?customer_id=eq.${customerId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (response.ok) {
      const data = await response.json();
      return data && data.length > 0 ? data[0] : null;
    }
    return null;
  } catch (err) {
    console.error('Error fetching loyalty:', err);
    return null;
  }
};

// Helper to fetch loyalty settings
const fetchLoyaltySettings = async (storeId) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
  
  if (!url || !key || !storeId) return null;
  
  try {
    const response = await fetch(
      `${url}/rest/v1/loyalty_settings?store_id=eq.${storeId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (response.ok) {
      const data = await response.json();
      return data && data.length > 0 ? data[0] : null;
    }
    return null;
  } catch (err) {
    console.error('Error fetching loyalty settings:', err);
    return null;
  }
};

function CustomersPage() {
  const { state, actions } = useApp();
  const { addCustomer: dbAddCustomer, updateCustomer: dbUpdateCustomer } = useDataLoader();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCustomer, setSelectedCustomer] = useState(null);
  const [showAddModal, setShowAddModal] = useState(false);
  const [editingCustomer, setEditingCustomer] = useState(null);
  
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

  const handleEditCustomer = (customer) => {
    setEditingCustomer(customer);
    setSelectedCustomer(null); // Close details modal if open
  };

  const handleSaveEdit = async (updatedData) => {
    try {
      await dbUpdateCustomer(editingCustomer.id, updatedData);
      setEditingCustomer(null);
    } catch (err) {
      console.error('Error updating customer:', err);
      alert('Error al actualizar el cliente');
    }
  };
  
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
      
      {/* Customers List */}
      <div className="card overflow-hidden">
        <table className="w-full">
          <thead className="bg-slate-50 border-b border-slate-200">
            <tr>
              <th className="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Cliente</th>
              <th className="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Teléfono</th>
              <th className="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider hidden md:table-cell">Email</th>
              <th className="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider hidden lg:table-cell">Dirección</th>
              <th className="text-right py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Puntos</th>
              <th className="text-right py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Balance</th>
              <th className="text-center py-3 px-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Acciones</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {filteredCustomers.map((customer) => (
              <CustomerRow
                key={customer.id}
                customer={customer}
                onClick={() => setSelectedCustomer(customer)}
                onEdit={() => handleEditCustomer(customer)}
              />
            ))}
          </tbody>
        </table>
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
          onEdit={() => handleEditCustomer(selectedCustomer)}
          orders={state.orders.filter(o => o.customer_id === selectedCustomer.id)}
        />
      )}
      
      {/* Add Customer Modal */}
      {showAddModal && (
        <AddCustomerModal
          onClose={() => setShowAddModal(false)}
          onSave={async (customerData) => {
            try {
              await dbAddCustomer(customerData);
              setShowAddModal(false);
            } catch (err) {
              alert('Error al crear cliente: ' + err.message);
            }
          }}
        />
      )}

      {/* Edit Customer Modal */}
      {editingCustomer && (
        <EditCustomerModal
          customer={editingCustomer}
          onClose={() => setEditingCustomer(null)}
          onSave={handleSaveEdit}
        />
      )}
    </div>
  );
}

function CustomerRow({ customer, onClick, onEdit }) {
  const hasBalance = customer.account_balance > 0;
  const address = customer.address_street 
    ? `${customer.address_street}${customer.address_corregimiento ? ', ' + customer.address_corregimiento : ''}`
    : '—';
  
  return (
    <tr 
      className="hover:bg-slate-50 cursor-pointer transition-colors group"
      onClick={onClick}
    >
      <td className="py-3 px-4">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 bg-gradient-to-br from-primary-400 to-primary-600 text-white rounded-full flex items-center justify-center font-semibold text-sm flex-shrink-0">
            {customer.first_name[0]}{customer.last_name[0]}
          </div>
          <div>
            <p className="font-medium text-slate-800 group-hover:text-primary-600 transition-colors">
              {customer.first_name} {customer.last_name}
            </p>
            {customer.company_name && (
              <p className="text-xs text-slate-500 flex items-center gap-1">
                <Building className="w-3 h-3" />
                {customer.company_name}
              </p>
            )}
          </div>
        </div>
      </td>
      <td className="py-3 px-4">
        <span className="text-sm text-slate-600">{customer.phone_country} {customer.phone}</span>
      </td>
      <td className="py-3 px-4 hidden md:table-cell">
        <span className="text-sm text-slate-500">{customer.email || '—'}</span>
      </td>
      <td className="py-3 px-4 hidden lg:table-cell">
        <span className="text-sm text-slate-500 truncate max-w-[200px] block">{address}</span>
      </td>
      <td className="py-3 px-4 text-right">
        <div className="flex items-center justify-end gap-1 text-sm text-slate-500">
          <Star className="w-3.5 h-3.5 text-warning-500" />
          <span>{customer.loyalty_points || 0}</span>
        </div>
      </td>
      <td className="py-3 px-4 text-right">
        {hasBalance ? (
          <span className="badge bg-error-100 text-error-700">
            B/{customer.account_balance.toFixed(2)}
          </span>
        ) : (
          <span className="text-sm text-slate-400">B/0.00</span>
        )}
      </td>
      <td className="py-3 px-4 text-center">
        <div className="flex items-center justify-center gap-1">
          <button 
            onClick={(e) => { e.stopPropagation(); onClick(); }}
            className="p-1.5 text-slate-400 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Ver detalles"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button 
            onClick={(e) => { e.stopPropagation(); onEdit(); }}
            className="p-1.5 text-slate-400 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Editar"
          >
            <Edit className="w-4 h-4" />
          </button>
        </div>
      </td>
    </tr>
  );
}

function CustomerDetailsModal({ customer, onClose, onEdit, orders: initialOrders }) {
  const { state } = useApp();
  const [loyalty, setLoyalty] = useState(null);
  const [loyaltySettings, setLoyaltySettings] = useState(null);
  const [loadingLoyalty, setLoadingLoyalty] = useState(true);
  
  // Customer orders from database
  const [customerOrders, setCustomerOrders] = useState(initialOrders || []);
  const [loadingOrders, setLoadingOrders] = useState(true);
  const [orderStats, setOrderStats] = useState({ total: 0, count: 0, weight: 0 });
  const [currentPage, setCurrentPage] = useState(1);
  const ordersPerPage = 10;
  
  const formatCurrency = (amount) => `B/${amount?.toFixed(2) || '0.00'}`;
  
  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
    }).format(date);
  };
  
  // Load all customer orders from database
  useEffect(() => {
    const loadCustomerOrders = async () => {
      setLoadingOrders(true);
      try {
        const url = import.meta.env.SUPABASE_URL;
        const key = import.meta.env.SUPABASE_PUBLISHABLE_KEY;
        
        if (!url || !key || !customer.id) {
          setCustomerOrders(initialOrders || []);
          setLoadingOrders(false);
          return;
        }
        
        // Fetch all orders for this customer
        const response = await fetch(
          `${url}/rest/v1/orders?customer_id=eq.${customer.id}&order=created_at.desc&limit=1000`,
          { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
        );
        
        if (response.ok) {
          const orders = await response.json();
          setCustomerOrders(orders);
          
          // Calculate totals
          const stats = orders.reduce((acc, order) => ({
            total: acc.total + (order.total || 0),
            count: acc.count + 1,
            weight: acc.weight + (order.total_weight || 0),
          }), { total: 0, count: 0, weight: 0 });
          setOrderStats(stats);
        } else {
          setCustomerOrders(initialOrders || []);
        }
      } catch (err) {
        console.error('Error loading customer orders:', err);
        setCustomerOrders(initialOrders || []);
      }
      setLoadingOrders(false);
    };
    
    loadCustomerOrders();
  }, [customer.id, initialOrders]);
  
  // Pagination
  const totalPages = Math.ceil(customerOrders.length / ordersPerPage);
  const paginatedOrders = customerOrders.slice(
    (currentPage - 1) * ordersPerPage,
    currentPage * ordersPerPage
  );
  
  // Load loyalty data
  useEffect(() => {
    const loadLoyalty = async () => {
      setLoadingLoyalty(true);
      const [loyaltyData, settings] = await Promise.all([
        fetchCustomerLoyalty(customer.id),
        fetchLoyaltySettings(state.store?.id)
      ]);
      setLoyalty(loyaltyData);
      setLoyaltySettings(settings);
      setLoadingLoyalty(false);
    };
    loadLoyalty();
  }, [customer.id, state.store?.id]);
  
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
              <p className="text-2xl font-bold">
                {loadingOrders ? '...' : orderStats.count}
              </p>
              <p className="text-xs text-primary-100">Órdenes</p>
            </div>
            <div className="bg-white/10 backdrop-blur rounded-xl p-3 text-center">
              <p className="text-2xl font-bold">
                {loadingOrders ? '...' : formatCurrency(orderStats.total)}
              </p>
              <p className="text-xs text-primary-100">Total Gastado</p>
            </div>
            <div className="bg-white/10 backdrop-blur rounded-xl p-3 text-center">
              <p className="text-2xl font-bold">
                {loadingOrders ? '...' : `${orderStats.weight.toFixed(1)} kg`}
              </p>
              <p className="text-xs text-primary-100">Total Peso</p>
            </div>
          </div>
        </div>
        
        <div className="p-6 overflow-y-auto max-h-[50vh] scrollbar-thin">
          {/* Loyalty Section */}
          {(loyaltySettings?.punch_card_enabled || loyaltySettings?.points_enabled) && (
            <div className="mb-6">
              <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3 flex items-center gap-2">
                <Award className="w-4 h-4" />
                Programa de Lealtad
              </h3>
              
              {loadingLoyalty ? (
                <div className="flex items-center justify-center py-4">
                  <div className="w-5 h-5 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {/* Punch Cards */}
                  {loyaltySettings?.punch_card_enabled && (
                    <div className="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-4 border border-blue-100">
                      <div className="flex items-center gap-2 mb-3">
                        <Stamp className="w-5 h-5 text-blue-600" />
                        <span className="font-medium text-slate-800">Tarjeta de Sellos</span>
                      </div>
                      
                      {/* Wash Punches */}
                      <div className="mb-3">
                        <div className="flex items-center justify-between text-sm mb-1">
                          <span className="text-slate-600">🌀 Lavados</span>
                          <span className="font-medium text-slate-800">
                            {loyalty?.wash_punches || 0} / {loyaltySettings.wash_punches_required}
                          </span>
                        </div>
                        <div className="h-2 bg-blue-100 rounded-full overflow-hidden">
                          <div 
                            className="h-full bg-blue-500 rounded-full transition-all"
                            style={{ width: `${Math.min(100, ((loyalty?.wash_punches || 0) / loyaltySettings.wash_punches_required) * 100)}%` }}
                          />
                        </div>
                        {(loyalty?.pending_free_washes || 0) > 0 && (
                          <p className="text-xs text-success-600 mt-1 flex items-center gap-1">
                            <Gift className="w-3 h-3" />
                            {loyalty.pending_free_washes} lavado{loyalty.pending_free_washes > 1 ? 's' : ''} gratis disponible{loyalty.pending_free_washes > 1 ? 's' : ''}
                          </p>
                        )}
                      </div>
                      
                      {/* Dry Punches */}
                      <div>
                        <div className="flex items-center justify-between text-sm mb-1">
                          <span className="text-slate-600">☀️ Secados</span>
                          <span className="font-medium text-slate-800">
                            {loyalty?.dry_punches || 0} / {loyaltySettings.dry_punches_required}
                          </span>
                        </div>
                        <div className="h-2 bg-orange-100 rounded-full overflow-hidden">
                          <div 
                            className="h-full bg-orange-500 rounded-full transition-all"
                            style={{ width: `${Math.min(100, ((loyalty?.dry_punches || 0) / loyaltySettings.dry_punches_required) * 100)}%` }}
                          />
                        </div>
                        {(loyalty?.pending_free_drys || 0) > 0 && (
                          <p className="text-xs text-success-600 mt-1 flex items-center gap-1">
                            <Gift className="w-3 h-3" />
                            {loyalty.pending_free_drys} secado{loyalty.pending_free_drys > 1 ? 's' : ''} gratis disponible{loyalty.pending_free_drys > 1 ? 's' : ''}
                          </p>
                        )}
                      </div>
                    </div>
                  )}
                  
                  {/* Points Balance */}
                  {loyaltySettings?.points_enabled && (
                    <div className="bg-gradient-to-br from-emerald-50 to-teal-50 rounded-xl p-4 border border-emerald-100">
                      <div className="flex items-center gap-2 mb-3">
                        <Coins className="w-5 h-5 text-emerald-600" />
                        <span className="font-medium text-slate-800">Saldo de Puntos</span>
                      </div>
                      
                      <div className="text-center py-2">
                        <p className="text-3xl font-bold text-emerald-600">
                          {formatCurrency(loyalty?.points_balance || 0)}
                        </p>
                        <p className="text-xs text-slate-500 mt-1">
                          {(loyalty?.points_balance || 0) >= loyaltySettings.min_redemption_amount 
                            ? '✓ Disponible para usar'
                            : `Mínimo para redimir: ${formatCurrency(loyaltySettings.min_redemption_amount)}`
                          }
                        </p>
                      </div>
                      
                      <div className="mt-3 pt-3 border-t border-emerald-100 grid grid-cols-2 gap-2 text-xs">
                        <div className="text-center">
                          <p className="text-slate-500">Total Ganado</p>
                          <p className="font-medium text-slate-700">{formatCurrency(loyalty?.total_points_earned || 0)}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-slate-500">Total Usado</p>
                          <p className="font-medium text-slate-700">{formatCurrency(loyalty?.total_points_redeemed || 0)}</p>
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}
          
          <div className="mb-6">
            <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">
              Información de Contacto
            </h3>
            <div className="grid grid-cols-2 gap-4">
              <div className="flex items-center gap-3 text-sm">
                <Phone className="w-4 h-4 text-slate-400" />
                <span className="text-slate-700">{customer.phone_country} {customer.phone}</span>
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
            <div className="flex items-center justify-between mb-3">
              <h3 className="text-sm font-semibold text-slate-500 uppercase tracking-wider">
                Historial de Órdenes
              </h3>
              {!loadingOrders && customerOrders.length > 0 && (
                <span className="text-xs text-slate-400">
                  {customerOrders.length} órdenes • {formatCurrency(orderStats.total)} total
                </span>
              )}
            </div>
            
            {loadingOrders ? (
              <div className="text-center py-8">
                <div className="w-8 h-8 border-2 border-primary-500 border-t-transparent rounded-full animate-spin mx-auto mb-2"></div>
                <p className="text-sm text-slate-400">Cargando órdenes...</p>
              </div>
            ) : customerOrders.length > 0 ? (
              <>
                <div className="space-y-2">
                  {paginatedOrders.map((order) => (
                    <div
                      key={order.id}
                      className="flex items-center justify-between p-3 bg-slate-50 rounded-xl"
                    >
                      <div className="flex items-center gap-3">
                        <div className={`w-10 h-10 ${order.legacy_order_number ? 'bg-slate-100 text-slate-600' : 'bg-primary-100 text-primary-600'} rounded-full flex items-center justify-center text-xs font-bold`}>
                          {getOrderDisplayNumber(order)}
                        </div>
                        <div>
                          <p className="text-sm font-medium text-slate-700">
                            {order.total_weight?.toFixed(2) || '0.00'} kg
                          </p>
                          <p className="text-xs text-slate-500">
                            {formatDate(order.created_at)}
                            {order.legacy_order_number && (
                              <span className="ml-2 text-slate-400">• Histórico</span>
                            )}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        <span className="font-semibold text-slate-800">
                          {formatCurrency(order.total)}
                        </span>
                        <p className="text-xs text-slate-400">{order.status}</p>
                      </div>
                    </div>
                  ))}
                </div>
                
                {/* Pagination */}
                {totalPages > 1 && (
                  <div className="flex items-center justify-center gap-2 mt-4 pt-4 border-t border-slate-100">
                    <button
                      onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                      disabled={currentPage === 1}
                      className="px-3 py-1 text-sm rounded-lg bg-slate-100 hover:bg-slate-200 disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      ← Anterior
                    </button>
                    <span className="text-sm text-slate-500">
                      Página {currentPage} de {totalPages}
                    </span>
                    <button
                      onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                      disabled={currentPage === totalPages}
                      className="px-3 py-1 text-sm rounded-lg bg-slate-100 hover:bg-slate-200 disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      Siguiente →
                    </button>
                  </div>
                )}
              </>
            ) : (
              <p className="text-sm text-slate-400 text-center py-4">
                Sin órdenes registradas
              </p>
            )}
          </div>
        </div>
        
        <div className="p-4 border-t border-slate-100 flex gap-3">
          <button onClick={onEdit} className="btn-secondary flex-1">
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
    phone_country: '+507',
    phone: '',
    email: '',
    address_street: '',
    address_building: '',
    address_corregimiento: '',
    address_district: 'Panamá',
    address_province: 'Panamá',
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
    
    // Only include fields that exist in the database
    const newCustomer = {
      first_name: formData.first_name,
      last_name: formData.last_name,
      phone_country: formData.phone_country,
      phone: formData.phone,
      email: formData.email || null,
      address_street: formData.address_street || null,
      address_building: formData.address_building || null,
      address_corregimiento: formData.address_corregimiento || null,
      address_district: formData.address_district || null,
      address_province: formData.address_province || null,
      id_type: formData.id_type,
      id_number: formData.id_number || null,
      company_name: formData.company_name || null,
      ruc: formData.ruc || null,
      dv: formData.dv || null,
      can_be_invoiced: formData.id_type === 'ruc',
      account_balance: 0,
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
                value={formData.phone_country}
                onChange={(e) => handleChange('phone_country', e.target.value)}
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

function EditCustomerModal({ customer, onClose, onSave }) {
  const [formData, setFormData] = useState({
    first_name: customer.first_name || '',
    last_name: customer.last_name || '',
    phone_country: customer.phone_country || '+507',
    phone: customer.phone || '',
    email: customer.email || '',
    address_street: customer.address_street || '',
    address_building: customer.address_building || '',
    address_corregimiento: customer.address_corregimiento || '',
    address_district: customer.address_district || 'Panamá',
    address_province: customer.address_province || 'Panamá',
    id_type: customer.id_type || null,
    id_number: customer.id_number || '',
    company_name: customer.company_name || '',
    ruc: customer.ruc || '',
    dv: customer.dv || '',
    can_be_invoiced: customer.can_be_invoiced || false,
    notes: customer.notes || '',
  });
  
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);
  
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
  
  const handleSubmit = async () => {
    if (!validate()) return;
    
    setSaving(true);
    try {
      const updatedCustomer = {
        first_name: formData.first_name,
        last_name: formData.last_name,
        phone_country: formData.phone_country,
        phone: formData.phone,
        email: formData.email || null,
        address_street: formData.address_street || null,
        address_building: formData.address_building || null,
        address_corregimiento: formData.address_corregimiento || null,
        address_district: formData.address_district || null,
        address_province: formData.address_province || null,
        id_type: formData.id_type,
        id_number: formData.id_number || null,
        company_name: formData.company_name || null,
        ruc: formData.ruc || null,
        dv: formData.dv || null,
        can_be_invoiced: formData.id_type === 'ruc' || formData.can_be_invoiced,
        notes: formData.notes || null,
      };
      
      await onSave(updatedCustomer);
    } catch (err) {
      console.error('Error saving customer:', err);
    } finally {
      setSaving(false);
    }
  };
  
  return (
    <div className="modal-backdrop flex items-center justify-center p-4 animate-fade-in">
      <div className="bg-white rounded-2xl shadow-elevated w-full max-w-lg max-h-[90vh] overflow-hidden animate-scale-in">
        <div className="flex items-center justify-between p-4 border-b border-slate-100 bg-gradient-to-r from-primary-500 to-primary-600">
          <h2 className="text-lg font-semibold text-white">Editar Cliente</h2>
          <button onClick={onClose} className="p-2 hover:bg-white/20 rounded-lg transition-colors">
            <span className="text-white text-xl">&times;</span>
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
              {errors.first_name && <p className="text-xs text-error-500 mt-1">{errors.first_name}</p>}
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
              {errors.last_name && <p className="text-xs text-error-500 mt-1">{errors.last_name}</p>}
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Teléfono *</label>
            <div className="flex gap-2">
              <select
                value={formData.phone_country}
                onChange={(e) => handleChange('phone_country', e.target.value)}
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
            {errors.phone && <p className="text-xs text-error-500 mt-1">{errors.phone}</p>}
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
                <option value="Arraiján">Arraiján</option>
                <option value="La Chorrera">La Chorrera</option>
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
          
          {(formData.id_type === 'cedula' || formData.id_type === 'passport') && (
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">
                Número de {formData.id_type === 'cedula' ? 'Cédula' : 'Pasaporte'}
              </label>
              <input
                type="text"
                value={formData.id_number}
                onChange={(e) => handleChange('id_number', e.target.value)}
                className="input"
                placeholder={formData.id_type === 'cedula' ? '8-123-4567' : 'PA1234567'}
              />
            </div>
          )}
          
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

          <div>
            <label className="block text-sm font-medium text-slate-700 mb-1">Notas</label>
            <textarea
              value={formData.notes}
              onChange={(e) => handleChange('notes', e.target.value)}
              className="input resize-none"
              rows={2}
              placeholder="Notas sobre el cliente..."
            />
          </div>

          <div className="flex items-center gap-2">
            <input
              type="checkbox"
              id="can_be_invoiced"
              checked={formData.can_be_invoiced}
              onChange={(e) => handleChange('can_be_invoiced', e.target.checked)}
              className="w-4 h-4 text-primary-600 rounded focus:ring-primary-500"
            />
            <label htmlFor="can_be_invoiced" className="text-sm text-slate-700">
              Puede ser facturado (crédito)
            </label>
          </div>
        </div>
        
        <div className="p-4 border-t border-slate-100 flex gap-3">
          <button onClick={onClose} className="btn-secondary flex-1">Cancelar</button>
          <button 
            onClick={handleSubmit} 
            disabled={saving}
            className="btn-primary flex-1"
          >
            {saving ? 'Guardando...' : 'Guardar Cambios'}
          </button>
        </div>
      </div>
    </div>
  );
}

export default CustomersPage;
