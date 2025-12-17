import React, { useState, useMemo } from 'react';
import { 
  Clock, ChevronDown, GripVertical, User, Package, 
  Timer, MapPin, AlertCircle, ChevronRight 
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { statusConfig } from '../data/sampleData';

const workflowColumns = [
  { id: 'pending', title: 'Por Hacer', status: 'pending' },
  { id: 'washing', title: 'Lavadoras', status: 'washing' },
  { id: 'drying', title: 'Secadoras', status: 'drying' },
  { id: 'folding', title: 'Doblado', status: 'folding' },
  { id: 'ready', title: 'Completada', status: 'ready' },
];

function MachinesPage() {
  const { state, actions } = useApp();
  const [sortBy, setSortBy] = useState('promised_date');
  const [draggedOrder, setDraggedOrder] = useState(null);
  
  // Group orders by status
  const ordersByStatus = useMemo(() => {
    const grouped = {};
    workflowColumns.forEach(col => {
      grouped[col.status] = state.orders
        .filter(order => order.status === col.status)
        .sort((a, b) => {
          if (sortBy === 'promised_date') {
            return new Date(a.promised_date) - new Date(b.promised_date);
          }
          return new Date(a.created_at) - new Date(b.created_at);
        });
    });
    return grouped;
  }, [state.orders, sortBy]);
  
  const handleDragStart = (e, order) => {
    setDraggedOrder(order);
    e.dataTransfer.effectAllowed = 'move';
  };
  
  const handleDragOver = (e) => {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  };
  
  const handleDrop = (e, targetStatus) => {
    e.preventDefault();
    if (draggedOrder && draggedOrder.status !== targetStatus) {
      actions.updateOrderStatus(draggedOrder.id, targetStatus);
    }
    setDraggedOrder(null);
  };
  
  const handleDragEnd = () => {
    setDraggedOrder(null);
  };
  
  const moveOrder = (order, newStatus) => {
    actions.updateOrderStatus(order.id, newStatus);
  };
  
  return (
    <div className="h-[calc(100vh-4rem)] flex flex-col animate-fade-in">
      {/* Header */}
      <div className="flex items-center justify-between p-4 border-b border-slate-200 bg-white">
        <div>
          <h1 className="text-xl font-display font-bold text-slate-800">Máquinas / En Proceso</h1>
          <p className="text-sm text-slate-500">
            {state.orders.filter(o => ['pending', 'washing', 'drying', 'folding'].includes(o.status)).length} órdenes en proceso
          </p>
        </div>
        
        <div className="flex items-center gap-3">
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value)}
            className="input w-auto text-sm"
          >
            <option value="promised_date">Ordenar por Fecha Prometida</option>
            <option value="created_at">Ordenar por Fecha de Creación</option>
          </select>
        </div>
      </div>
      
      {/* Kanban Board */}
      <div className="flex-1 overflow-x-auto p-4">
        <div className="flex gap-4 h-full min-w-max">
          {workflowColumns.map((column) => (
            <KanbanColumn
              key={column.id}
              column={column}
              orders={ordersByStatus[column.status] || []}
              onDragOver={handleDragOver}
              onDrop={(e) => handleDrop(e, column.status)}
              onDragStart={handleDragStart}
              onDragEnd={handleDragEnd}
              onMoveOrder={moveOrder}
              isDragTarget={draggedOrder && draggedOrder.status !== column.status}
            />
          ))}
        </div>
      </div>
    </div>
  );
}

function KanbanColumn({ column, orders, onDragOver, onDrop, onDragStart, onDragEnd, onMoveOrder, isDragTarget }) {
  const config = statusConfig[column.status];
  
  return (
    <div 
      className={`w-72 flex-shrink-0 flex flex-col bg-slate-100/50 rounded-2xl transition-colors ${
        isDragTarget ? 'ring-2 ring-primary-500 ring-opacity-50 bg-primary-50/50' : ''
      }`}
      onDragOver={onDragOver}
      onDrop={onDrop}
    >
      {/* Column Header */}
      <div className="p-3 border-b border-slate-200/50">
        <div className="flex items-center justify-between">
          <h3 className="font-semibold text-slate-700">{column.title}</h3>
          <span className={`badge ${config.bgClass} ${config.textClass}`}>
            {orders.length}
          </span>
        </div>
        
        {/* Sort dropdown for pending column */}
        {column.status === 'pending' && (
          <button className="flex items-center gap-1 text-xs text-slate-500 mt-2 hover:text-slate-700">
            <Clock className="w-3 h-3" />
            Horario del Pedido
            <ChevronDown className="w-3 h-3" />
          </button>
        )}
      </div>
      
      {/* Orders */}
      <div className="flex-1 overflow-y-auto p-2 space-y-2 scrollbar-thin">
        {orders.map((order) => (
          <OrderCard
            key={order.id}
            order={order}
            column={column}
            onDragStart={onDragStart}
            onDragEnd={onDragEnd}
            onMove={onMoveOrder}
          />
        ))}
        
        {orders.length === 0 && (
          <div className="flex flex-col items-center justify-center py-8 text-slate-400">
            <Package className="w-8 h-8 mb-2 opacity-50" />
            <p className="text-xs">Sin órdenes</p>
          </div>
        )}
      </div>
    </div>
  );
}

function OrderCard({ order, column, onDragStart, onDragEnd, onMove }) {
  const [expanded, setExpanded] = useState(false);
  
  const hoursRemaining = useMemo(() => {
    const promised = new Date(order.promised_date);
    const now = new Date();
    const diff = (promised - now) / (1000 * 60 * 60);
    return diff;
  }, [order.promised_date]);
  
  const isOverdue = hoursRemaining < 0;
  const isUrgent = hoursRemaining > 0 && hoursRemaining < 4;
  
  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    return new Intl.DateTimeFormat('es-PA', {
      day: '2-digit',
      month: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
    }).format(date);
  };
  
  const getNextStatus = () => {
    const statusOrder = ['pending', 'washing', 'drying', 'folding', 'ready', 'completed'];
    const currentIndex = statusOrder.indexOf(order.status);
    return currentIndex < statusOrder.length - 1 ? statusOrder[currentIndex + 1] : null;
  };
  
  const nextStatus = getNextStatus();
  
  return (
    <div
      draggable
      onDragStart={(e) => onDragStart(e, order)}
      onDragEnd={onDragEnd}
      className={`bg-white rounded-xl shadow-card border border-slate-200/50 overflow-hidden cursor-grab active:cursor-grabbing hover:shadow-soft transition-shadow ${
        isOverdue ? 'border-l-4 border-l-error-500' : isUrgent ? 'border-l-4 border-l-warning-500' : ''
      }`}
    >
      {/* Card Header */}
      <div className="p-3">
        <div className="flex items-start justify-between gap-2">
          <div className="flex items-center gap-2">
            <GripVertical className="w-4 h-4 text-slate-300 flex-shrink-0" />
            <div>
              <div className="flex items-center gap-2">
                <span className="font-bold text-slate-800">#{order.order_number}</span>
                {order.is_express && (
                  <span className="text-xs px-1.5 py-0.5 bg-warning-100 text-warning-700 rounded font-medium">
                    ⚡
                  </span>
                )}
              </div>
              <p className="text-sm text-slate-600 font-medium">{order.customer_name}</p>
            </div>
          </div>
          
          <div className="text-right">
            <p className={`text-xs font-medium ${
              isOverdue ? 'text-error-600' : isUrgent ? 'text-warning-600' : 'text-slate-500'
            }`}>
              {Math.abs(hoursRemaining).toFixed(1)}hrs
            </p>
            <p className="text-xs text-slate-400">
              {formatDate(order.promised_date).split(' ')[1]}
            </p>
          </div>
        </div>
        
        {/* Notes Preview */}
        {order.notes && (
          <div className="mt-2 text-xs text-slate-500 bg-slate-50 rounded px-2 py-1 line-clamp-2">
            {order.notes}
          </div>
        )}
        
        {/* Workflow Location */}
        {order.workflow_location && (
          <div className="mt-2 flex items-center gap-1 text-xs text-primary-600">
            <MapPin className="w-3 h-3" />
            {order.workflow_location}
          </div>
        )}
      </div>
      
      {/* Expand/Collapse */}
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full px-3 py-2 bg-slate-50 text-xs text-slate-500 hover:bg-slate-100 transition-colors flex items-center justify-center gap-1"
      >
        {expanded ? 'Ver menos' : 'Ver más'}
        <ChevronDown className={`w-3 h-3 transition-transform ${expanded ? 'rotate-180' : ''}`} />
      </button>
      
      {/* Expanded Content */}
      {expanded && (
        <div className="px-3 pb-3 pt-2 border-t border-slate-100 animate-slide-up">
          {/* Order Details */}
          <div className="grid grid-cols-2 gap-2 mb-3 text-xs">
            <div className="bg-slate-50 rounded-lg p-2">
              <p className="text-slate-400">Peso</p>
              <p className="font-semibold text-slate-700">{order.total_weight?.toFixed(2) || '0.00'} kg</p>
            </div>
            <div className="bg-slate-50 rounded-lg p-2">
              <p className="text-slate-400">Bolsas</p>
              <p className="font-semibold text-slate-700">{order.total_bags || 0}</p>
            </div>
          </div>
          
          {/* Quick Actions */}
          {nextStatus && (
            <button
              onClick={() => onMove(order, nextStatus)}
              className="w-full btn-primary text-xs py-2"
            >
              Mover a {statusConfig[nextStatus]?.label}
              <ChevronRight className="w-3 h-3" />
            </button>
          )}
        </div>
      )}
    </div>
  );
}

export default MachinesPage;
