import React, { useState, useEffect, useMemo } from 'react';
import { 
  Plus, X, User, Zap, ChevronDown, ChevronUp, 
  Trash2, Tag, Truck, MessageSquare, AlertCircle,
  Award, Coins, Stamp, Gift
} from 'lucide-react';
import { useApp } from '../context/AppContext';
import { useDataLoader } from '../hooks/useDataLoader';
import CustomerSearchModal from './modals/CustomerSearchModal';
import PaymentModal from './modals/PaymentModal';
import { 
  generateReceiptData, 
  generateReceiptText, 
  printReceipt, 
  saveReceiptToStorage,
  isPrinterConnected
} from '../utils/receiptPrinter';

// Helper to fetch customer loyalty data
const fetchCustomerLoyalty = async (customerId) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
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
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
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

// Helper to add loyalty points after order (excluding Lavamático, loyalty payments, and free services)
const addLoyaltyPointsForOrder = async (customerId, storeId, subtotal, orderId, totalExclusions = 0) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
  // Exclude ineligible amounts from points calculation
  const eligibleSubtotal = subtotal - totalExclusions;
  
  if (!url || !key || !customerId || !storeId || eligibleSubtotal <= 0) {
    if (totalExclusions > 0) {
      console.log(`Loyalty: Excluding B/${totalExclusions.toFixed(2)} from points (Lavamático/loyalty payment/free services)`);
    }
    if (eligibleSubtotal <= 0) {
      console.log('Loyalty: No eligible amount for earning points');
    }
    return null;
  }
  
  try {
    // 1. Get loyalty settings
    const settingsRes = await fetch(
      `${url}/rest/v1/loyalty_settings?store_id=eq.${storeId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (!settingsRes.ok) return null;
    const settings = await settingsRes.json();
    
    if (!settings || settings.length === 0 || !settings[0].points_enabled) {
      console.log('Points program not enabled');
      return null;
    }
    
    const loyaltySettings = settings[0];
    const pointsEarned = Math.round(eligibleSubtotal * loyaltySettings.points_per_dollar * 100) / 100;
    
    if (pointsEarned <= 0) return null;
    
    if (totalExclusions > 0) {
      console.log(`Loyalty: Calculating points on B/${eligibleSubtotal.toFixed(2)} (excluded B/${totalExclusions.toFixed(2)})`);
    }
    
    // 2. Get or create customer loyalty record
    let loyaltyRes = await fetch(
      `${url}/rest/v1/customer_loyalty?customer_id=eq.${customerId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    let loyalty = null;
    if (loyaltyRes.ok) {
      const loyaltyData = await loyaltyRes.json();
      loyalty = loyaltyData && loyaltyData.length > 0 ? loyaltyData[0] : null;
    }
    
    // Create loyalty record if doesn't exist
    if (!loyalty) {
      const createRes = await fetch(`${url}/rest/v1/customer_loyalty`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
          'Prefer': 'return=representation'
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          points_balance: 0,
          total_points_earned: 0,
          total_points_redeemed: 0,
        })
      });
      
      if (createRes.ok) {
        const created = await createRes.json();
        loyalty = created && created.length > 0 ? created[0] : null;
      }
    }
    
    if (!loyalty) {
      console.error('Could not get or create loyalty record');
      return null;
    }
    
    const balanceBefore = loyalty.points_balance || 0;
    const balanceAfter = Math.round((balanceBefore + pointsEarned) * 100) / 100;
    const totalEarned = (loyalty.total_points_earned || 0) + pointsEarned;
    
    // 3. Update loyalty balance
    const updateRes = await fetch(
      `${url}/rest/v1/customer_loyalty?id=eq.${loyalty.id}`,
      {
        method: 'PATCH',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          points_balance: balanceAfter,
          total_points_earned: totalEarned,
          last_points_date: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        })
      }
    );
    
    if (!updateRes.ok) {
      console.error('Error updating loyalty balance:', await updateRes.text());
      return null;
    }
    
    // 4. Log the transaction
    await fetch(`${url}/rest/v1/loyalty_transactions`, {
      method: 'POST',
      headers: {
        'apikey': key,
        'Authorization': `Bearer ${key}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        customer_id: customerId,
        store_id: storeId,
        order_id: orderId,
        transaction_type: 'points_earned',
        points_amount: pointsEarned,
        balance_before: balanceBefore,
        balance_after: balanceAfter,
        order_subtotal: eligibleSubtotal,
      })
    });
    
    console.log(`Loyalty: +B/${pointsEarned.toFixed(2)} earned, balance: B/${balanceAfter.toFixed(2)}`);
    
    return {
      success: true,
      points_earned: pointsEarned,
      balance_before: balanceBefore,
      balance_after: balanceAfter,
    };
  } catch (err) {
    console.error('Error adding loyalty points:', err);
    return null;
  }
};

// Helper to add punch card punches - ONLY for Lavamático section with Lavado/Secado products
// Excludes free services (they don't earn new punches)
const addLoyaltyPunches = async (customerId, storeId, items, sections, orderId, freeServicesUsed = { freeWashes: 0, freeDrys: 0 }) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
  if (!url || !key || !customerId || !storeId || !items || items.length === 0) return null;
  
  try {
    // 1. Get loyalty settings
    const settingsRes = await fetch(
      `${url}/rest/v1/loyalty_settings?store_id=eq.${storeId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (!settingsRes.ok) return null;
    const settings = await settingsRes.json();
    
    if (!settings || settings.length === 0 || !settings[0].punch_card_enabled) {
      console.log('Punch card not enabled');
      return null;
    }
    
    const loyaltySettings = settings[0];
    
    // 2. Find Lavamático section (exact match, case insensitive)
    const lavamatico = sections?.find(s => {
      const name = (s.name || '').toLowerCase().trim();
      return name === 'lavamático' || name === 'lavamatico';
    });
    
    if (!lavamatico) {
      console.log('Punch card: No "Lavamático" section found');
      return null;
    }
    
    // 3. Count wash and dry punches - ONLY from Lavamático section with Lavado/Secado in name
    let washPunches = 0;
    let dryPunches = 0;
    
    items.forEach(item => {
      const product = item.product;
      if (!product) return;
      
      // Must be in Lavamático section
      if (product.section_id !== lavamatico.id) return;
      
      const productName = (product.name || '').toLowerCase();
      
      // Check for "Lavado" in name (wash)
      if (productName.includes('lavado')) {
        washPunches += item.quantity || 1;
        console.log(`Punch card: ${item.quantity || 1} wash punch(es) from "${product.name}"`);
      }
      
      // Check for "Secado" in name (dry)
      if (productName.includes('secado')) {
        dryPunches += item.quantity || 1;
        console.log(`Punch card: ${item.quantity || 1} dry punch(es) from "${product.name}"`);
      }
    });
    
    // 4. Subtract free services - they don't earn new punches
    const freeWashesUsed = freeServicesUsed.freeWashes || 0;
    const freeDrysUsed = freeServicesUsed.freeDrys || 0;
    
    if (freeWashesUsed > 0) {
      washPunches = Math.max(0, washPunches - freeWashesUsed);
      console.log(`Punch card: Excluding ${freeWashesUsed} free wash(es) from punch count`);
    }
    
    if (freeDrysUsed > 0) {
      dryPunches = Math.max(0, dryPunches - freeDrysUsed);
      console.log(`Punch card: Excluding ${freeDrysUsed} free dry(s) from punch count`);
    }
    
    if (washPunches === 0 && dryPunches === 0) {
      console.log('Punch card: No paid Lavado/Secado products to earn punches');
      return null;
    }
    
    // 4. Get or create customer loyalty record
    let loyaltyRes = await fetch(
      `${url}/rest/v1/customer_loyalty?customer_id=eq.${customerId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    let loyalty = null;
    if (loyaltyRes.ok) {
      const loyaltyData = await loyaltyRes.json();
      loyalty = loyaltyData && loyaltyData.length > 0 ? loyaltyData[0] : null;
    }
    
    // Create loyalty record if doesn't exist
    if (!loyalty) {
      const createRes = await fetch(`${url}/rest/v1/customer_loyalty`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
          'Prefer': 'return=representation'
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          wash_punches: 0,
          dry_punches: 0,
          pending_free_washes: 0,
          pending_free_drys: 0,
        })
      });
      
      if (createRes.ok) {
        const created = await createRes.json();
        loyalty = created && created.length > 0 ? created[0] : null;
      }
    }
    
    if (!loyalty) {
      console.error('Could not get or create loyalty record for punches');
      return null;
    }
    
    // 5. Calculate new punch counts and free services earned
    const currentWashPunches = loyalty.wash_punches || 0;
    const currentDryPunches = loyalty.dry_punches || 0;
    
    let newWashPunches = currentWashPunches + washPunches;
    let newDryPunches = currentDryPunches + dryPunches;
    
    let freeWashesEarned = 0;
    let freeDrysEarned = 0;
    
    // Check if free washes earned
    while (newWashPunches >= loyaltySettings.wash_punches_required) {
      freeWashesEarned++;
      newWashPunches -= loyaltySettings.wash_punches_required;
    }
    
    // Check if free drys earned
    while (newDryPunches >= loyaltySettings.dry_punches_required) {
      freeDrysEarned++;
      newDryPunches -= loyaltySettings.dry_punches_required;
    }
    
    // 6. Update loyalty record
    const updateData = {
      wash_punches: newWashPunches,
      dry_punches: newDryPunches,
      last_punch_date: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    };
    
    if (freeWashesEarned > 0) {
      updateData.pending_free_washes = (loyalty.pending_free_washes || 0) + freeWashesEarned;
      updateData.total_free_washes_earned = (loyalty.total_free_washes_earned || 0) + freeWashesEarned;
    }
    
    if (freeDrysEarned > 0) {
      updateData.pending_free_drys = (loyalty.pending_free_drys || 0) + freeDrysEarned;
      updateData.total_free_drys_earned = (loyalty.total_free_drys_earned || 0) + freeDrysEarned;
    }
    
    const updateRes = await fetch(
      `${url}/rest/v1/customer_loyalty?id=eq.${loyalty.id}`,
      {
        method: 'PATCH',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updateData)
      }
    );
    
    if (!updateRes.ok) {
      console.error('Error updating punch card:', await updateRes.text());
      return null;
    }
    
    // 7. Log transactions
    if (washPunches > 0) {
      await fetch(`${url}/rest/v1/loyalty_transactions`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          order_id: orderId,
          transaction_type: 'punch_wash',
          punch_count: washPunches,
          punches_before: currentWashPunches,
          punches_after: newWashPunches,
          notes: `Added ${washPunches} wash punch(es)`,
        })
      });
      
      if (freeWashesEarned > 0) {
        await fetch(`${url}/rest/v1/loyalty_transactions`, {
          method: 'POST',
          headers: {
            'apikey': key,
            'Authorization': `Bearer ${key}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            customer_id: customerId,
            store_id: storeId,
            order_id: orderId,
            transaction_type: 'free_wash_earned',
            punch_count: freeWashesEarned,
            notes: `Earned ${freeWashesEarned} free wash(es)!`,
          })
        });
      }
    }
    
    if (dryPunches > 0) {
      await fetch(`${url}/rest/v1/loyalty_transactions`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          order_id: orderId,
          transaction_type: 'punch_dry',
          punch_count: dryPunches,
          punches_before: currentDryPunches,
          punches_after: newDryPunches,
          notes: `Added ${dryPunches} dry punch(es)`,
        })
      });
      
      if (freeDrysEarned > 0) {
        await fetch(`${url}/rest/v1/loyalty_transactions`, {
          method: 'POST',
          headers: {
            'apikey': key,
            'Authorization': `Bearer ${key}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            customer_id: customerId,
            store_id: storeId,
            order_id: orderId,
            transaction_type: 'free_dry_earned',
            punch_count: freeDrysEarned,
            notes: `Earned ${freeDrysEarned} free dry(es)!`,
          })
        });
      }
    }
    
    console.log(`Punch card updated: Wash ${currentWashPunches}→${newWashPunches}, Dry ${currentDryPunches}→${newDryPunches}`);
    if (freeWashesEarned > 0) console.log(`🎁 Earned ${freeWashesEarned} FREE WASH(ES)!`);
    if (freeDrysEarned > 0) console.log(`🎁 Earned ${freeDrysEarned} FREE DRY(S)!`);
    
    return {
      success: true,
      wash_punches_added: washPunches,
      dry_punches_added: dryPunches,
      new_wash_punches: newWashPunches,
      new_dry_punches: newDryPunches,
      free_washes_earned: freeWashesEarned,
      free_drys_earned: freeDrysEarned,
    };
  } catch (err) {
    console.error('Error adding punch card punches:', err);
    return null;
  }
};

// Helper to calculate Lavamático subtotal (to exclude from points)
const calculateLavamaticSubtotal = (items, sections) => {
  // Find Lavamático section
  const lavamatico = sections?.find(s => {
    const name = (s.name || '').toLowerCase().trim();
    return name === 'lavamático' || name === 'lavamatico';
  });
  
  if (!lavamatico) return 0;
  
  let subtotal = 0;
  items.forEach(item => {
    const product = item.product;
    if (product && product.section_id === lavamatico.id) {
      subtotal += item.lineTotal || 0;
    }
  });
  
  return subtotal;
};

// Helper to redeem loyalty points as payment
const redeemLoyaltyPoints = async (customerId, storeId, amount, orderId) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
  if (!url || !key || !customerId || !storeId || amount <= 0) return null;
  
  try {
    // Get customer loyalty record
    const loyaltyRes = await fetch(
      `${url}/rest/v1/customer_loyalty?customer_id=eq.${customerId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (!loyaltyRes.ok) return null;
    const loyaltyData = await loyaltyRes.json();
    const loyalty = loyaltyData && loyaltyData.length > 0 ? loyaltyData[0] : null;
    
    if (!loyalty || loyalty.points_balance < amount) {
      console.error('Insufficient loyalty points balance');
      return null;
    }
    
    const balanceBefore = loyalty.points_balance;
    const balanceAfter = Math.round((balanceBefore - amount) * 100) / 100;
    const totalRedeemed = (loyalty.total_points_redeemed || 0) + amount;
    
    // Update loyalty balance
    const updateRes = await fetch(
      `${url}/rest/v1/customer_loyalty?id=eq.${loyalty.id}`,
      {
        method: 'PATCH',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          points_balance: balanceAfter,
          total_points_redeemed: totalRedeemed,
          updated_at: new Date().toISOString(),
        })
      }
    );
    
    if (!updateRes.ok) {
      console.error('Error updating loyalty balance:', await updateRes.text());
      return null;
    }
    
    // Log the transaction
    await fetch(`${url}/rest/v1/loyalty_transactions`, {
      method: 'POST',
      headers: {
        'apikey': key,
        'Authorization': `Bearer ${key}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        customer_id: customerId,
        store_id: storeId,
        order_id: orderId,
        transaction_type: 'points_redeemed',
        points_amount: -amount,
        balance_before: balanceBefore,
        balance_after: balanceAfter,
        notes: `Redeemed B/${amount.toFixed(2)} in loyalty points`,
      })
    });
    
    console.log(`Loyalty points redeemed: -B/${amount.toFixed(2)}, new balance: B/${balanceAfter.toFixed(2)}`);
    
    return {
      success: true,
      points_redeemed: amount,
      balance_before: balanceBefore,
      balance_after: balanceAfter,
    };
  } catch (err) {
    console.error('Error redeeming loyalty points:', err);
    return null;
  }
};

// Helper to redeem free services
const redeemFreeServices = async (customerId, storeId, freeWashes, freeDrys, orderId) => {
  const url = import.meta.env.SUPABASE_URL;
  const key = import.meta.env.SUPABASE_ANON_KEY;
  
  if (!url || !key || !customerId || (freeWashes <= 0 && freeDrys <= 0)) return null;
  
  try {
    // Get customer loyalty record
    const loyaltyRes = await fetch(
      `${url}/rest/v1/customer_loyalty?customer_id=eq.${customerId}&select=*`,
      { headers: { 'apikey': key, 'Authorization': `Bearer ${key}` } }
    );
    
    if (!loyaltyRes.ok) return null;
    const loyaltyData = await loyaltyRes.json();
    const loyalty = loyaltyData && loyaltyData.length > 0 ? loyaltyData[0] : null;
    
    if (!loyalty) {
      console.error('No loyalty record found');
      return null;
    }
    
    const updateData = { updated_at: new Date().toISOString() };
    
    // Update free washes
    if (freeWashes > 0) {
      const currentFreeWashes = loyalty.pending_free_washes || 0;
      if (currentFreeWashes < freeWashes) {
        console.error('Insufficient free washes');
        return null;
      }
      updateData.pending_free_washes = currentFreeWashes - freeWashes;
      updateData.total_free_washes_redeemed = (loyalty.total_free_washes_redeemed || 0) + freeWashes;
    }
    
    // Update free drys
    if (freeDrys > 0) {
      const currentFreeDrys = loyalty.pending_free_drys || 0;
      if (currentFreeDrys < freeDrys) {
        console.error('Insufficient free drys');
        return null;
      }
      updateData.pending_free_drys = currentFreeDrys - freeDrys;
      updateData.total_free_drys_redeemed = (loyalty.total_free_drys_redeemed || 0) + freeDrys;
    }
    
    // Update loyalty record
    const updateRes = await fetch(
      `${url}/rest/v1/customer_loyalty?id=eq.${loyalty.id}`,
      {
        method: 'PATCH',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updateData)
      }
    );
    
    if (!updateRes.ok) {
      console.error('Error updating free services:', await updateRes.text());
      return null;
    }
    
    // Log transactions
    if (freeWashes > 0) {
      await fetch(`${url}/rest/v1/loyalty_transactions`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          order_id: orderId,
          transaction_type: 'redeem_free_wash',
          punch_count: -freeWashes,
          notes: `Redeemed ${freeWashes} free wash(es)`,
        })
      });
    }
    
    if (freeDrys > 0) {
      await fetch(`${url}/rest/v1/loyalty_transactions`, {
        method: 'POST',
        headers: {
          'apikey': key,
          'Authorization': `Bearer ${key}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          customer_id: customerId,
          store_id: storeId,
          order_id: orderId,
          transaction_type: 'redeem_free_dry',
          punch_count: -freeDrys,
          notes: `Redeemed ${freeDrys} free dry(s)`,
        })
      });
    }
    
    console.log(`Free services redeemed: ${freeWashes} wash(es), ${freeDrys} dry(s)`);
    
    return { success: true, freeWashes, freeDrys };
  } catch (err) {
    console.error('Error redeeming free services:', err);
    return null;
  }
};

function TicketPanel() {
  const { state, actions, ticketCalculations } = useApp();
  const { addOrder: dbAddOrder } = useDataLoader();
  const [customerModalOpen, setCustomerModalOpen] = useState(false);
  const [paymentModalOpen, setPaymentModalOpen] = useState(false);
  const [discountExpanded, setDiscountExpanded] = useState(false);
  const [notesExpanded, setNotesExpanded] = useState(false);
  const [detailsExpanded, setDetailsExpanded] = useState(false);
  const [processing, setProcessing] = useState(false);
  
  // Printer state
  const [printingReceipt, setPrintingReceipt] = useState(false);
  
  // Loyalty state
  const [customerLoyalty, setCustomerLoyalty] = useState(null);
  const [loyaltySettings, setLoyaltySettings] = useState(null);
  const [loadingLoyalty, setLoadingLoyalty] = useState(false);
  
  const calculations = ticketCalculations();
  const { ticket } = state;
  
  // Count pending orders for the selected customer
  const pendingOrdersCount = ticket.customer 
    ? state.orders.filter(o => 
        o.customer_id === ticket.customer.id && 
        !['completed', 'cancelled'].includes(o.status)
      ).length 
    : 0;
  
  // Calculate free services that can be auto-applied (including ITBMS)
  const freeServicesApplied = useMemo(() => {
    if (!customerLoyalty || !loyaltySettings?.punch_card_enabled) {
      return { freeWashes: 0, freeDrys: 0, discountAmount: 0, taxDiscount: 0, items: [] };
    }
    
    const pendingFreeWashes = customerLoyalty.pending_free_washes || 0;
    const pendingFreeDrys = customerLoyalty.pending_free_drys || 0;
    
    if (pendingFreeWashes === 0 && pendingFreeDrys === 0) {
      return { freeWashes: 0, freeDrys: 0, discountAmount: 0, taxDiscount: 0, items: [] };
    }
    
    // Find Lavamático section
    const lavamatico = state.sections?.find(s => {
      const name = (s.name || '').toLowerCase().trim();
      return name === 'lavamático' || name === 'lavamatico';
    });
    
    if (!lavamatico) {
      return { freeWashes: 0, freeDrys: 0, discountAmount: 0, taxDiscount: 0, items: [] };
    }
    
    // Get ITBMS rate
    const itbmsRate = (state.settings?.itbms_rate || 7) / 100;
    
    let freeWashesUsed = 0;
    let freeDrysUsed = 0;
    let totalDiscount = 0; // Base price discount
    let totalTaxDiscount = 0; // Tax discount
    const discountedItems = [];
    
    // Check ticket items for Lavado/Secado products
    ticket.items.forEach((item, index) => {
      const product = item.product;
      if (!product || product.section_id !== lavamatico.id) return;
      
      const productName = (product.name || '').toLowerCase();
      const quantity = item.quantity || 1;
      const isTaxable = product.is_taxable !== false; // Default to taxable
      
      // Check for "Lavado" products
      if (productName.includes('lavado') && freeWashesUsed < pendingFreeWashes) {
        const freeCount = Math.min(quantity, pendingFreeWashes - freeWashesUsed);
        const discountPerUnit = item.unitPrice || 0;
        const itemDiscount = freeCount * discountPerUnit;
        const itemTaxDiscount = isTaxable ? Math.round(itemDiscount * itbmsRate * 100) / 100 : 0;
        
        if (freeCount > 0 && itemDiscount > 0) {
          freeWashesUsed += freeCount;
          totalDiscount += itemDiscount;
          totalTaxDiscount += itemTaxDiscount;
          discountedItems.push({
            index,
            productName: product.name,
            type: 'wash',
            freeCount,
            discount: itemDiscount,
            taxDiscount: itemTaxDiscount,
          });
        }
      }
      
      // Check for "Secado" products
      if (productName.includes('secado') && freeDrysUsed < pendingFreeDrys) {
        const freeCount = Math.min(quantity, pendingFreeDrys - freeDrysUsed);
        const discountPerUnit = item.unitPrice || 0;
        const itemDiscount = freeCount * discountPerUnit;
        const itemTaxDiscount = isTaxable ? Math.round(itemDiscount * itbmsRate * 100) / 100 : 0;
        
        if (freeCount > 0 && itemDiscount > 0) {
          freeDrysUsed += freeCount;
          totalDiscount += itemDiscount;
          totalTaxDiscount += itemTaxDiscount;
          discountedItems.push({
            index,
            productName: product.name,
            type: 'dry',
            freeCount,
            discount: itemDiscount,
            taxDiscount: itemTaxDiscount,
          });
        }
      }
    });
    
    return {
      freeWashes: freeWashesUsed,
      freeDrys: freeDrysUsed,
      discountAmount: totalDiscount, // Base price
      taxDiscount: totalTaxDiscount, // ITBMS on free items
      totalDiscount: totalDiscount + totalTaxDiscount, // Full amount including tax
      items: discountedItems,
    };
  }, [ticket.items, customerLoyalty, loyaltySettings, state.sections, state.settings?.itbms_rate]);
  
  // Adjust total with free services discount (includes base price + ITBMS)
  const adjustedTotal = Math.max(0, calculations.total - (freeServicesApplied.totalDiscount || 0));
  
  // Load loyalty settings on mount
  useEffect(() => {
    const loadSettings = async () => {
      if (state.store?.id) {
        const settings = await fetchLoyaltySettings(state.store.id);
        setLoyaltySettings(settings);
      }
    };
    loadSettings();
  }, [state.store?.id]);
  
  // Load customer loyalty when customer changes
  useEffect(() => {
    const loadLoyalty = async () => {
      if (ticket.customer?.id) {
        setLoadingLoyalty(true);
        const loyalty = await fetchCustomerLoyalty(ticket.customer.id);
        setCustomerLoyalty(loyalty);
        setLoadingLoyalty(false);
      } else {
        setCustomerLoyalty(null);
      }
    };
    loadLoyalty();
  }, [ticket.customer?.id]);
  
  const formatCurrency = (amount) => {
    return `B/${amount.toFixed(2)}`;
  };
  
  const formatDate = (date) => {
    return new Intl.DateTimeFormat('es-PA', {
      weekday: 'short',
      day: 'numeric',
      month: 'short',
    }).format(date);
  };
  
  const handleRemoveItem = (index) => {
    actions.removeItem(index);
  };
  
  const handleQuantityChange = (index, delta) => {
    const item = ticket.items[index];
    const newQuantity = Math.max(1, item.quantity + delta);
    actions.updateItem(index, {
      quantity: newQuantity,
      lineTotal: newQuantity * item.unitPrice,
    });
  };

  // Per-line manual discount (amount or % of the line gross).
  const lineDiscountAmount = (item) => {
    const d = item.discount;
    if (!d || !d.value) return 0;
    const gross = item.lineTotal || 0;
    const amt = d.mode === 'pct' ? gross * (d.value / 100) : d.value;
    return Math.min(Math.max(0, amt), gross);
  };

  const handleItemDiscount = (index, patch) => {
    const item = ticket.items[index];
    const current = item.discount || { mode: 'amount', value: 0 };
    actions.updateItem(index, { discount: { ...current, ...patch } });
  };
  
  // Require both items AND customer confirmation to process
  const canProcess = ticket.items.length > 0 && ticket.customerConfirmed;
  
  return (
    <div className="ticket-sidebar h-full flex flex-col bg-white">
      {/* Customer Selection */}
      <div className="p-4 border-b border-slate-100">
        <div className="flex items-center gap-2">
          <button
            onClick={() => setCustomerModalOpen(true)}
            className={`flex-1 flex items-center gap-3 px-4 py-3 rounded-xl transition-colors text-left ${
              ticket.customerConfirmed 
                ? 'bg-slate-50 hover:bg-slate-100' 
                : 'bg-amber-50 border-2 border-amber-200 hover:bg-amber-100'
            }`}
          >
            <User className={`w-5 h-5 ${ticket.customerConfirmed ? 'text-slate-400' : 'text-amber-500'}`} />
            <div className="flex-1 min-w-0">
              {ticket.customer ? (
                <>
                  <p className="font-medium text-slate-800 truncate">
                    {ticket.customer.first_name} {ticket.customer.last_name}
                  </p>
                  <p className="text-xs text-slate-500">
                    {ticket.customer.phone_country_code} {ticket.customer.phone}
                  </p>
                </>
              ) : ticket.customerConfirmed ? (
                <>
                  <p className="font-medium text-slate-700">Walk-in</p>
                  <p className="text-xs text-slate-500">Cliente sin registrar</p>
                </>
              ) : (
                <>
                  <p className="text-amber-700 font-medium">Seleccionar Cliente</p>
                  <p className="text-xs text-amber-600">Haz clic para elegir</p>
                </>
              )}
            </div>
            {ticket.customer && (
              <span className="text-xs text-slate-400">ID</span>
            )}
          </button>
          
          <button
            onClick={() => setCustomerModalOpen(true)}
            className="p-3 bg-primary-500 hover:bg-primary-600 text-white rounded-xl transition-colors"
          >
            <Plus className="w-5 h-5" />
          </button>
        </div>
        
        {/* Express Toggle */}
        <div className="flex items-center mt-3">
          <label className="flex items-center gap-2 px-3 py-2 bg-slate-50 rounded-lg cursor-pointer">
            <input
              type="checkbox"
              checked={ticket.isExpress}
              onChange={(e) => actions.setExpress(e.target.checked)}
              className="sr-only"
            />
            <div className={`relative w-10 h-5 rounded-full transition-colors ${
              ticket.isExpress ? 'bg-warning-500' : 'bg-slate-300'
            }`}>
              <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                ticket.isExpress ? 'translate-x-5' : ''
              }`} />
            </div>
            <Zap className={`w-4 h-4 ${ticket.isExpress ? 'text-warning-500' : 'text-slate-400'}`} />
            <span className={`text-sm font-medium ${ticket.isExpress ? 'text-warning-600' : 'text-slate-500'}`}>
              Express
            </span>
          </label>
        </div>
        
        {/* Pending Orders Alert - Only show if customer has pending orders */}
        {ticket.customer && ticket.customerConfirmed && pendingOrdersCount > 0 && (
          <div className="mt-3 flex items-center gap-2 px-3 py-2 bg-amber-50 text-amber-700 rounded-lg text-sm">
            <AlertCircle className="w-4 h-4 flex-shrink-0" />
            <span>{pendingOrdersCount} {pendingOrdersCount === 1 ? 'orden pendiente' : 'órdenes pendientes'}</span>
          </div>
        )}
        
        {/* Loyalty Info - Compact single line when customer is selected */}
        {ticket.customer && ticket.customerConfirmed && (loyaltySettings?.punch_card_enabled || loyaltySettings?.points_enabled) && (
          <div className="mt-3">
            {loadingLoyalty ? (
              <div className="flex items-center justify-center py-2">
                <div className="w-4 h-4 border-2 border-primary-500 border-t-transparent rounded-full animate-spin" />
              </div>
            ) : (
              <div className="flex items-center gap-3 px-3 py-2 bg-gradient-to-r from-emerald-50 to-blue-50 rounded-lg text-xs">
                <Award className="w-4 h-4 text-emerald-600 flex-shrink-0" />
                
                {/* Points */}
                {loyaltySettings?.points_enabled && (
                  <div className="flex items-center gap-1">
                    <Coins className="w-3.5 h-3.5 text-emerald-500" />
                    <span className="font-bold text-emerald-700">B/{(customerLoyalty?.points_balance || 0).toFixed(2)}</span>
                  </div>
                )}
                
                {loyaltySettings?.points_enabled && loyaltySettings?.punch_card_enabled && (
                  <span className="text-slate-300">|</span>
                )}
                
                {/* Punches */}
                {loyaltySettings?.punch_card_enabled && (
                  <div className="flex items-center gap-2">
                    <span className="text-slate-600">
                      🌀 {customerLoyalty?.wash_punches || 0}/{loyaltySettings.wash_punches_required}
                      {(customerLoyalty?.pending_free_washes || 0) > 0 && (
                        <span className="text-success-600 font-bold">+{customerLoyalty.pending_free_washes}🎁</span>
                      )}
                    </span>
                    <span className="text-slate-600">
                      ☀️ {customerLoyalty?.dry_punches || 0}/{loyaltySettings.dry_punches_required}
                      {(customerLoyalty?.pending_free_drys || 0) > 0 && (
                        <span className="text-success-600 font-bold">+{customerLoyalty.pending_free_drys}🎁</span>
                      )}
                    </span>
                  </div>
                )}
              </div>
            )}
          </div>
        )}
      </div>
      
      {/* Ticket Items */}
      <div className="flex-1 overflow-y-auto scrollbar-thin p-4">
        {calculations.productItems.length === 0 && calculations.deliveryItems.length === 0 ? (
          <div className="h-full flex flex-col items-center justify-center text-slate-400">
            <div className="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center mb-4">
              <Tag className="w-8 h-8 text-slate-300" />
            </div>
            <p className="text-sm font-medium">Ticket vacío</p>
            <p className="text-xs mt-1">Selecciona productos para comenzar</p>
          </div>
        ) : (
          <div className="space-y-3">
            {/* Product Items (non-delivery) */}
            {calculations.productItems.map((item) => {
              const actualIndex = ticket.items.findIndex(i => i === item);
              const isWeight = item.product.pricing_type === 'weight';
              const taxable = item.product.is_taxable !== false;
              const lineDisc = lineDiscountAmount(item);
              const net = (item.lineTotal || 0) - lineDisc;
              const disc = item.discount || { mode: 'amount', value: 0 };
              return (
                <div key={actualIndex} className="bg-slate-50 rounded-xl p-3 animate-slide-up">
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex-1 min-w-0">
                      <span className="font-medium text-slate-800 truncate block">
                        {item.product.name}
                      </span>

                      {/* Weight entries breakdown */}
                      {item.weightEntries && item.weightEntries.length > 0 && (
                        <div className="mt-1 space-y-0.5">
                          {item.weightEntries.map((entry, i) => (
                            <p key={i} className="text-xs text-slate-500 pl-2 border-l-2 border-slate-200">
                              {entry.weight}kg
                              {entry.pieces && ` • ${entry.pieces} piezas`}
                            </p>
                          ))}
                        </div>
                      )}

                      {/* Unit price · discount · tax */}
                      <div className="mt-1 flex flex-wrap items-center gap-x-2 gap-y-0.5 text-xs text-slate-500">
                        <span>
                          {isWeight
                            ? `${item.totalWeight?.toFixed(2)}kg × ${formatCurrency(item.unitPrice)}/kg`
                            : `${item.quantity} × ${formatCurrency(item.unitPrice)}`}
                        </span>
                        {lineDisc > 0 && (
                          <span className="text-error-500">− {formatCurrency(lineDisc)} desc.</span>
                        )}
                        <span className="text-slate-400">{taxable ? 'ITBMS' : 'exento'}</span>
                      </div>
                    </div>

                    <div className="flex items-start gap-2">
                      <div className="text-right">
                        {lineDisc > 0 && (
                          <span className="block text-xs text-slate-400 line-through">
                            {formatCurrency(item.lineTotal)}
                          </span>
                        )}
                        <span className="font-semibold text-slate-800">{formatCurrency(net)}</span>
                      </div>
                      <button
                        onClick={() => handleRemoveItem(actualIndex)}
                        className="p-1.5 text-slate-400 hover:text-error-500 hover:bg-error-50 rounded-lg transition-colors"
                      >
                        <X className="w-4 h-4" />
                      </button>
                    </div>
                  </div>

                  {/* Quantity stepper + per-line discount */}
                  <div className="mt-2 flex flex-wrap items-center gap-2">
                    {!isWeight && (
                      <span className="flex items-center rounded-lg border border-slate-200 bg-white">
                        <button
                          onClick={() => handleQuantityChange(actualIndex, -1)}
                          className="px-2.5 py-1 text-slate-600 hover:bg-slate-100 rounded-l-lg"
                        >
                          −
                        </button>
                        <span className="w-7 text-center text-sm font-medium text-slate-700">{item.quantity}</span>
                        <button
                          onClick={() => handleQuantityChange(actualIndex, 1)}
                          className="px-2.5 py-1 text-slate-600 hover:bg-slate-100 rounded-r-lg"
                        >
                          +
                        </button>
                      </span>
                    )}
                    <label className="flex items-center gap-1 text-xs text-slate-500">
                      Desc.
                      <input
                        type="number"
                        step="0.01"
                        min={0}
                        value={disc.value || ''}
                        onChange={(e) => handleItemDiscount(actualIndex, { value: Number(e.target.value) || 0 })}
                        placeholder="0"
                        className="w-16 rounded-lg border border-slate-200 px-2 py-1 text-sm text-right outline-none focus:border-primary-500"
                      />
                      <select
                        value={disc.mode}
                        onChange={(e) => handleItemDiscount(actualIndex, { mode: e.target.value })}
                        className="rounded-lg border border-slate-200 bg-white px-1.5 py-1 text-sm"
                      >
                        <option value="amount">B/.</option>
                        <option value="pct">%</option>
                      </select>
                    </label>
                  </div>
                </div>
              );
            })}
            
            {/* Delivery Items Section */}
            {calculations.deliveryItems.length > 0 && (
              <>
                <div className="border-t border-slate-200 pt-3 mt-3">
                  <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2 flex items-center gap-1">
                    <Truck className="w-3 h-3" />
                    Entrega / Recogida
                  </p>
                </div>
                {calculations.deliveryItems.map((item) => {
                  const actualIndex = ticket.items.findIndex(i => i === item);
                  return (
                    <div key={actualIndex} className="bg-amber-50 rounded-xl p-3 animate-slide-up border border-amber-200">
                      <div className="flex items-center justify-between gap-2">
                        <div className="flex items-center gap-2">
                          <Truck className="w-4 h-4 text-amber-600" />
                          <span className="font-medium text-slate-800">
                            {item.product.name}
                          </span>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className={`font-semibold ${ticket.freeDelivery ? 'line-through text-slate-400' : 'text-slate-800'}`}>
                            {formatCurrency(item.lineTotal)}
                          </span>
                          {ticket.freeDelivery && (
                            <span className="text-xs text-success-600 font-medium">GRATIS</span>
                          )}
                          <button
                            onClick={() => handleRemoveItem(actualIndex)}
                            className="p-1.5 text-slate-400 hover:text-error-500 hover:bg-error-50 rounded-lg transition-colors"
                          >
                            <X className="w-4 h-4" />
                          </button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </>
            )}
          </div>
        )}
      </div>
      
      {/* Footer */}
      <div className="border-t border-slate-100 p-4 space-y-3">
        {/* Pieces & Bags Counter - Always Visible */}
        <div className="flex gap-3">
          <div className="flex-1 bg-slate-50 rounded-lg px-3 py-2">
            <span className="text-xs text-slate-500">Piezas</span>
            <p className="font-semibold text-slate-800">{calculations.totalPieces}</p>
          </div>
          <div className="flex-1 bg-slate-50 rounded-lg px-3 py-2">
            <span className="text-xs text-slate-500">Bolsas</span>
            <p className="font-semibold text-slate-800">{calculations.totalBags}</p>
          </div>
        </div>
        
        {/* Toggle Details Button */}
        <button
          onClick={() => setDetailsExpanded(!detailsExpanded)}
          className="w-full flex items-center justify-center gap-2 px-3 py-2 bg-slate-100 rounded-lg hover:bg-slate-200 transition-colors text-sm text-slate-600"
        >
          {detailsExpanded ? (
            <>
              <ChevronUp className="w-4 h-4" />
              Ocultar Detalles
            </>
          ) : (
            <>
              <ChevronDown className="w-4 h-4" />
              Ver Detalles (Notas, Descuentos, Totales)
            </>
          )}
        </button>
        
        {/* Collapsible Details Section */}
        {detailsExpanded && (
          <div className="space-y-3 animate-slide-up">
            {/* Notes Section */}
            <button
              onClick={() => setNotesExpanded(!notesExpanded)}
              className="w-full flex items-center justify-between px-3 py-2 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors"
            >
              <div className="flex items-center gap-2">
                <MessageSquare className="w-4 h-4 text-slate-400" />
                <span className="text-sm text-slate-600">Notas</span>
                {ticket.notes && (
                  <span className="w-2 h-2 bg-primary-500 rounded-full"></span>
                )}
              </div>
              {notesExpanded ? (
                <ChevronUp className="w-4 h-4 text-slate-400" />
              ) : (
                <ChevronDown className="w-4 h-4 text-slate-400" />
              )}
            </button>
            
            {notesExpanded && (
              <textarea
                value={ticket.notes}
                onChange={(e) => actions.setNotes(e.target.value)}
                placeholder="Agregar notas al pedido..."
                className="w-full px-3 py-2 bg-slate-50 border-0 rounded-lg text-sm resize-none focus:ring-2 focus:ring-primary-500"
                rows={2}
              />
            )}
            
            {/* Discount Section */}
            <button
              onClick={() => setDiscountExpanded(!discountExpanded)}
              className="w-full flex items-center justify-between px-3 py-2 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors"
            >
              <div className="flex items-center gap-2">
                <Tag className="w-4 h-4 text-slate-400" />
                <span className="text-sm text-slate-600">Descuento</span>
                {ticket.manualDiscount && (
                  <span className="badge bg-warning-100 text-warning-700">
                    -{ticket.manualDiscount.type === 'percentage' 
                      ? `${ticket.manualDiscount.value}%` 
                      : formatCurrency(ticket.manualDiscount.value)}
                  </span>
                )}
              </div>
              {discountExpanded ? (
                <ChevronUp className="w-4 h-4 text-slate-400" />
              ) : (
                <ChevronDown className="w-4 h-4 text-slate-400" />
              )}
            </button>
            
            {discountExpanded && (
              <div className="p-3 bg-slate-50 rounded-lg space-y-3">
                <div className="flex gap-3">
                  {/* Percentage Input */}
                  <div className="flex-1">
                    <label className="text-xs text-slate-500 mb-1 block">Porcentaje</label>
                    <div className="relative">
                      <input
                        type="number"
                        min="0"
                        max="100"
                        step="1"
                        placeholder="0"
                        value={ticket.manualDiscount?.type === 'percentage' ? ticket.manualDiscount.value : ''}
                        onChange={(e) => {
                          const value = parseFloat(e.target.value);
                          if (value > 0 && value <= 100) {
                            actions.setManualDiscount({ type: 'percentage', value });
                          } else if (!e.target.value) {
                            actions.setManualDiscount(null);
                          }
                        }}
                        className={`w-full px-3 py-2 pr-8 bg-white border rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 ${
                          ticket.manualDiscount?.type === 'percentage' 
                            ? 'border-warning-400 bg-warning-50' 
                            : 'border-slate-200'
                        }`}
                      />
                      <span className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">%</span>
                    </div>
                  </div>
                  
                  {/* Amount Input */}
                  <div className="flex-1">
                    <label className="text-xs text-slate-500 mb-1 block">Monto Fijo</label>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">B/</span>
                      <input
                        type="number"
                        min="0"
                        step="0.01"
                        placeholder="0.00"
                        value={ticket.manualDiscount?.type === 'amount' ? ticket.manualDiscount.value : ''}
                        onChange={(e) => {
                          const value = parseFloat(e.target.value);
                          if (value > 0) {
                            actions.setManualDiscount({ type: 'amount', value });
                          } else if (!e.target.value) {
                            actions.setManualDiscount(null);
                          }
                        }}
                        className={`w-full px-3 py-2 pl-9 bg-white border rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 ${
                          ticket.manualDiscount?.type === 'amount' 
                            ? 'border-warning-400 bg-warning-50' 
                            : 'border-slate-200'
                        }`}
                      />
                    </div>
                  </div>
                </div>
                
                {ticket.manualDiscount && (
                  <button
                    onClick={() => actions.setManualDiscount(null)}
                    className="w-full text-xs text-error-600 hover:text-error-700 hover:underline py-1"
                  >
                    Quitar descuento
                  </button>
                )}
              </div>
            )}

            {/* Free Delivery Toggle (only show if there are delivery items) */}
            {calculations.deliveryTotal > 0 && (
              <div className="flex items-center justify-between px-3 py-2 bg-slate-50 rounded-lg">
                <span className="text-sm text-slate-600">Entrega Gratis</span>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={ticket.freeDelivery}
                    onChange={(e) => actions.setFreeDelivery(e.target.checked)}
                    className="sr-only"
                  />
                  <div className={`w-9 h-5 rounded-full transition-colors ${
                    ticket.freeDelivery ? 'bg-success-500' : 'bg-slate-300'
                  }`}>
                    <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${
                      ticket.freeDelivery ? 'translate-x-4' : ''
                    }`} />
                  </div>
                </label>
              </div>
            )}
            
            {/* Totals Breakdown */}
            <div className="space-y-1.5 p-3 bg-slate-50 rounded-lg">
              {/* Products Total (without ITBMS) */}
              <div className="flex justify-between text-sm">
                <span className="text-slate-500">Productos</span>
                <span className="text-slate-700">{formatCurrency(calculations.productsTotal)}</span>
              </div>
              
              {/* Delivery Total (without ITBMS) */}
              {calculations.deliveryTotal > 0 && (
                <div className="flex justify-between text-sm">
                  <span className="text-slate-500">Entrega</span>
                  <span className={ticket.freeDelivery ? 'line-through text-slate-400' : 'text-slate-700'}>
                    {formatCurrency(calculations.deliveryTotal)}
                  </span>
                </div>
              )}
              
              {/* Product Discount */}
              {calculations.productDiscountAmount > 0 && (
                <div className="flex justify-between text-sm">
                  <span className="text-warning-600">
                    Descuento {ticket.promotion ? `(${ticket.promotion.code})` : ''}
                  </span>
                  <span className="text-warning-600">-{formatCurrency(calculations.productDiscountAmount)}</span>
                </div>
              )}
              
              {/* Free Delivery Discount */}
              {ticket.freeDelivery && calculations.deliveryTotal > 0 && (
                <div className="flex justify-between text-sm">
                  <span className="text-success-600">Entrega Gratis</span>
                  <span className="text-success-600">-{formatCurrency(calculations.deliveryTotal)}</span>
                </div>
              )}
              
              {/* Subtotal line */}
              <div className="flex justify-between text-sm pt-1 border-t border-dashed border-slate-200">
                <span className="text-slate-600 font-medium">Subtotal</span>
                <span className="text-slate-700 font-medium">{formatCurrency(calculations.subtotal)}</span>
              </div>
              
              {/* ITBMS */}
              <div className="flex justify-between text-sm">
                <span className="text-slate-500">ITBMS ({state.settings.itbms_rate || 7}%)</span>
                <span className="text-slate-700">{formatCurrency(calculations.taxAmount)}</span>
              </div>
              
              {/* Free Services Applied */}
              {(freeServicesApplied.totalDiscount || 0) > 0 && (
                <div className="bg-emerald-50 rounded-lg p-2 my-1 border border-emerald-200">
                  <div className="flex justify-between text-sm">
                    <span className="text-emerald-700 font-medium flex items-center gap-1">
                      <Gift className="w-3.5 h-3.5" />
                      Servicios Gratis
                    </span>
                    <span className="text-emerald-700 font-bold">-{formatCurrency(freeServicesApplied.totalDiscount)}</span>
                  </div>
                  <div className="text-xs text-emerald-600 mt-1">
                    {freeServicesApplied.freeWashes > 0 && (
                      <span className="mr-2">🌀 {freeServicesApplied.freeWashes} lavado(s)</span>
                    )}
                    {freeServicesApplied.freeDrys > 0 && (
                      <span>☀️ {freeServicesApplied.freeDrys} secado(s)</span>
                    )}
                    <span className="ml-2 text-emerald-500">(incl. ITBMS)</span>
                  </div>
                </div>
              )}
              
              {/* Total */}
              <div className="flex justify-between text-lg font-bold pt-2 border-t border-slate-200">
                <span className="text-slate-800">Total</span>
                <span className="text-slate-800">{formatCurrency(adjustedTotal)}</span>
              </div>
            </div>
          </div>
        )}
        
        {/* Always-visible summary */}
        {ticket.items.length > 0 && (
          <div className="space-y-1 border-t border-slate-100 pt-3 text-sm">
            <div className="flex justify-between">
              <span className="text-slate-500">Subtotal</span>
              <span className="text-slate-700">
                {formatCurrency(calculations.productsTotal + calculations.deliveryTotal)}
              </span>
            </div>
            {calculations.productDiscountAmount > 0 && (
              <div className="flex justify-between text-error-500">
                <span>Descuentos y promociones</span>
                <span>− {formatCurrency(calculations.productDiscountAmount)}</span>
              </div>
            )}
            {calculations.deliveryDiscountAmount > 0 && (
              <div className="flex justify-between text-success-600">
                <span>Entrega gratis</span>
                <span>− {formatCurrency(calculations.deliveryDiscountAmount)}</span>
              </div>
            )}
            <div className="flex justify-between">
              <span className="text-slate-500">ITBMS ({state.settings?.itbms_rate ?? 7}%)</span>
              <span className="text-slate-700">{formatCurrency(calculations.taxAmount)}</span>
            </div>
            {(freeServicesApplied.totalDiscount || 0) > 0 && (
              <div className="flex justify-between text-success-600">
                <span>Servicios gratis</span>
                <span>− {formatCurrency(freeServicesApplied.totalDiscount)}</span>
              </div>
            )}
            <div className="flex justify-between border-t border-slate-200 pt-1 text-base font-bold text-slate-800">
              <span>Total</span>
              <span>{formatCurrency(adjustedTotal)}</span>
            </div>
          </div>
        )}

        {/* Customer Required Warning */}
        {ticket.items.length > 0 && !ticket.customerConfirmed && (
          <div className="px-3 py-2 bg-amber-50 border border-amber-200 rounded-lg text-center">
            <p className="text-sm text-amber-700 font-medium">
              Selecciona un cliente para procesar
            </p>
          </div>
        )}
        
        {/* Process Button - Always Visible */}
        <button
          onClick={() => setPaymentModalOpen(true)}
          disabled={!canProcess || printingReceipt}
          className={`w-full py-4 rounded-xl font-semibold text-white transition-all ${
            canProcess && !printingReceipt
              ? 'bg-success-500 hover:bg-success-600 shadow-lg hover:shadow-xl active:scale-[0.98]' 
              : 'bg-slate-300 cursor-not-allowed'
          }`}
        >
          <div className="flex items-center justify-center gap-3">
            {printingReceipt ? (
              <>
                <span className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin" />
                <span>Imprimiendo...</span>
              </>
            ) : (
              <>
                <span>Procesar</span>
                <span className={canProcess ? "text-success-200" : "text-slate-400"}>
                  {formatDate(calculations.promisedDate)}
                </span>
                <span className="px-2 py-0.5 bg-white/20 rounded-md">
                  {formatCurrency(adjustedTotal)}
                </span>
              </>
            )}
          </div>
        </button>
      </div>
      
      {/* Modals */}
      {customerModalOpen && (
        <CustomerSearchModal 
          onClose={() => setCustomerModalOpen(false)}
          onSelect={(customer) => {
            actions.setCustomer(customer);
            setCustomerModalOpen(false);
          }}
          onWalkIn={() => {
            actions.confirmWalkIn();
            setCustomerModalOpen(false);
          }}
        />
      )}
      
      {paymentModalOpen && (
        <PaymentModal
          total={adjustedTotal}
          subtotal={calculations.subtotal}
          taxAmount={calculations.taxAmount}
          paymentMethods={(state.paymentMethods || []).filter((m) => m.is_active)}
          storeId={state.store?.id}
          customerLoyalty={customerLoyalty}
          loyaltySettings={loyaltySettings}
          freeServicesApplied={freeServicesApplied}
          onClose={() => setPaymentModalOpen(false)}
          onComplete={async (paymentInfo) => {
            setProcessing(true);
            try {
              // Build order data for database
              const orderData = {
                customer_id: state.ticket.customer?.id || null,
                customer_name: state.ticket.customer
                  ? `${state.ticket.customer.first_name} ${state.ticket.customer.last_name}`
                  : 'Walk-in',
                is_walk_in: !state.ticket.customer,
                is_express: state.ticket.isExpress,
                subtotal: calculations.subtotal,
                discount_amount: calculations.discountAmount + (freeServicesApplied.totalDiscount || 0), // Include free services discount with tax
                delivery_charge: calculations.deliveryCharge,
                tax_amount: calculations.taxAmount - (freeServicesApplied.taxDiscount || 0), // Reduce tax by the free services tax discount
                total: adjustedTotal, // Use adjusted total
                total_weight: calculations.totalWeight,
                total_bags: calculations.totalBags,
                total_pieces: calculations.totalPieces,
                notes: state.ticket.notes + ((freeServicesApplied.totalDiscount || 0) > 0 
                  ? `\n[Servicios gratis: ${freeServicesApplied.freeWashes} lavado(s), ${freeServicesApplied.freeDrys} secado(s) = -B/${(freeServicesApplied.totalDiscount || 0).toFixed(2)} incl. ITBMS]` 
                  : ''),
                promised_date: calculations.promisedDate.toISOString(),
                items: state.ticket.items,
                payments: paymentInfo.payments, // Now an array of payments
                total_paid: paymentInfo.totalPaid,
                change_given: paymentInfo.change,
              };
              
              const newOrder = await dbAddOrder(orderData);
              
              // Initialize loyalty info for receipt (will be populated if customer is registered)
              let loyaltyInfoForReceipt = null;
              
              // Handle loyalty operations if customer is registered
              if (state.ticket.customer?.id) {
                // 1. Redeem free services if applied
                if (freeServicesApplied.freeWashes > 0 || freeServicesApplied.freeDrys > 0) {
                  try {
                    await redeemFreeServices(
                      state.ticket.customer.id,
                      state.store?.id,
                      freeServicesApplied.freeWashes,
                      freeServicesApplied.freeDrys,
                      newOrder?.id
                    );
                    console.log(`Free services redeemed: ${freeServicesApplied.freeWashes} washes, ${freeServicesApplied.freeDrys} drys`);
                  } catch (freeErr) {
                    console.error('Error redeeming free services (order still completed):', freeErr);
                  }
                }
                
                // 2. Redeem loyalty points if used as payment
                const loyaltyPayment = paymentInfo.payments.find(p => p.method === 'loyalty_points');
                const loyaltyPointsUsedAsPayment = loyaltyPayment?.loyaltyPointsUsed || 0;
                
                if (loyaltyPayment) {
                  try {
                    await redeemLoyaltyPoints(
                      state.ticket.customer.id,
                      state.store?.id,
                      loyaltyPayment.loyaltyPointsUsed,
                      newOrder?.id
                    );
                    console.log(`Loyalty points used as payment: B/${loyaltyPayment.loyaltyPointsUsed}`);
                  } catch (pointsErr) {
                    console.error('Error redeeming loyalty points (order still completed):', pointsErr);
                  }
                }
                
                // 3. Calculate exclusions from points earning
                const lavamaticSubtotal = calculateLavamaticSubtotal(state.ticket.items, state.sections);
                // Loyalty points used as payment should not generate new points
                const totalExclusions = lavamaticSubtotal + loyaltyPointsUsedAsPayment + freeServicesApplied.discountAmount;
                
                // Track loyalty results for receipt
                let loyaltyResultForReceipt = null;
                let punchResultForReceipt = null;
                
                // 4. Add points if points program is enabled (excluding Lavamático, loyalty payment, and free services)
                if (loyaltySettings?.points_enabled && calculations.subtotal > 0) {
                  try {
                    const loyaltyResult = await addLoyaltyPointsForOrder(
                      state.ticket.customer.id,
                      state.store?.id,
                      calculations.subtotal,
                      newOrder?.id,
                      totalExclusions // Pass total exclusions (Lavamático + loyalty points used + free services)
                    );
                    if (loyaltyResult?.success) {
                      loyaltyResultForReceipt = loyaltyResult;
                      console.log(`Loyalty points added: B/${loyaltyResult.points_earned} earned, new balance: B/${loyaltyResult.balance_after}`);
                    }
                  } catch (loyaltyErr) {
                    console.error('Error adding loyalty points (order still completed):', loyaltyErr);
                  }
                }
                
                // 5. Add punch card punches if punch card is enabled (only Lavamático with Lavado/Secado)
                // Free services don't earn new punches
                if (loyaltySettings?.punch_card_enabled) {
                  try {
                    const punchResult = await addLoyaltyPunches(
                      state.ticket.customer.id,
                      state.store?.id,
                      state.ticket.items,
                      state.sections,
                      newOrder?.id,
                      { freeWashes: freeServicesApplied.freeWashes, freeDrys: freeServicesApplied.freeDrys }
                    );
                    if (punchResult?.success) {
                      punchResultForReceipt = punchResult;
                      if (punchResult.free_washes_earned > 0 || punchResult.free_drys_earned > 0) {
                        // Could show a toast notification here
                        console.log(`🎉 Customer earned free services!`);
                      }
                    }
                  } catch (punchErr) {
                    console.error('Error adding punch card punches (order still completed):', punchErr);
                  }
                }
                
                // Build loyalty info for receipt
                loyaltyInfoForReceipt = {
                  pointsEarned: loyaltyResultForReceipt?.points_earned || 0,
                  pointsBalance: loyaltyResultForReceipt?.balance_after || (customerLoyalty?.points_balance - loyaltyPointsUsedAsPayment) || 0,
                  pointsUsed: loyaltyPointsUsedAsPayment,
                  washPunches: punchResultForReceipt?.wash_punches_added || 0,
                  dryPunches: punchResultForReceipt?.dry_punches_added || 0,
                  washPunchesTotal: punchResultForReceipt?.wash_punches_after || customerLoyalty?.wash_punches || 0,
                  dryPunchesTotal: punchResultForReceipt?.dry_punches_after || customerLoyalty?.dry_punches || 0,
                  punchesRequired: loyaltySettings?.punches_required || 10,
                  freeWashesEarned: punchResultForReceipt?.free_washes_earned || 0,
                  freeDrysEarned: punchResultForReceipt?.free_drys_earned || 0,
                  freeWashesAvailable: punchResultForReceipt?.pending_free_washes_after || (customerLoyalty?.pending_free_washes - freeServicesApplied.freeWashes) || 0,
                  freeDrysAvailable: punchResultForReceipt?.pending_free_drys_after || (customerLoyalty?.pending_free_drys - freeServicesApplied.freeDrys) || 0,
                  freeServicesUsed: {
                    washes: freeServicesApplied.freeWashes || 0,
                    drys: freeServicesApplied.freeDrys || 0,
                  },
                };
              }
              
              // === RECEIPT PRINTING AND SAVING ===
              if (newOrder) {
                try {
                  setPrintingReceipt(true);
                  
                  // Generate receipt data with loyalty info
                  const receiptData = generateReceiptData(
                    newOrder,
                    state.company,
                    state.store,
                    state.ticket.items,
                    paymentInfo.payments,
                    loyaltyInfoForReceipt
                  );
                  
                  // Generate text version
                  const receiptText = generateReceiptText(receiptData);
                  
                  // Save receipt to Supabase Storage
                  console.log('Saving receipt for order:', newOrder.order_number, 'store:', state.store?.id);
                  const receiptPath = await saveReceiptToStorage(
                    receiptText, 
                    newOrder.order_number, 
                    state.store?.id
                  );
                  
                  if (receiptPath) {
                    console.log('Receipt saved, updating order with path:', receiptPath);
                    // Update order with receipt path
                    const url = import.meta.env.SUPABASE_URL;
                    const key = import.meta.env.SUPABASE_ANON_KEY;
                    if (url && key) {
                      try {
                        await fetch(`${url}/rest/v1/orders?id=eq.${newOrder.id}`, {
                          method: 'PATCH',
                          headers: {
                            'apikey': key,
                            'Authorization': `Bearer ${key}`,
                            'Content-Type': 'application/json',
                          },
                          body: JSON.stringify({ receipt_path: receiptPath }),
                        });
                        console.log('Order updated with receipt path');
                      } catch (e) {
                        console.error('Could not save receipt path to order:', e);
                      }
                    }
                  } else {
                    console.warn('Receipt was not saved - check Supabase Storage bucket and policies');
                  }
                  
                  // Print receipt (if printer connected in settings)
                  if (isPrinterConnected()) {
                    // Check if cash payment - open drawer
                    const hasCashPayment = paymentInfo.payments.some(p => p.method === 'cash');
                    await printReceipt(receiptData, hasCashPayment);
                    console.log('Receipt printed successfully');
                  } else {
                    // Printer not connected - just log, don't try to auto-connect
                    console.log('Printer not connected. Connect in Settings > Impresora to enable printing.');
                  }
                } catch (receiptErr) {
                  console.error('Receipt error (order still completed):', receiptErr);
                } finally {
                  setPrintingReceipt(false);
                }
              }
              
              actions.clearTicket();
              setPaymentModalOpen(false);
            } catch (err) {
              console.error('Error processing order:', err);
              alert('Error al procesar la orden: ' + err.message);
            } finally {
              setProcessing(false);
            }
          }}
        />
      )}
    </div>
  );
}

export default TicketPanel;
