# Wash & Fold OMS - American Laundry Panama

A modern, responsive Order Management System for wash and fold laundry services built with React, Vite, and TailwindCSS.

## Features

- **POS System**: Product tiles with weight-based and quantity-based pricing
- **Ticket Management**: Real-time ticket with customer assignment, express toggle, notes
- **Service Workflow**: Kanban-style tracking (Pending → Washing → Drying → Folding → Ready)
- **Customer Management**: Full customer database with Panama-specific fields (Cédula, RUC, DV)
- **Payment Processing**: Multiple payment methods with cash change calculator
- **Multi-store Support**: Designed for multi-location businesses

## Tech Stack

- React 18
- Vite 5
- TailwindCSS 3
- React Router DOM 6
- Lucide React Icons
- Supabase (database ready)

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

### Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── Header.jsx       # Top navigation bar
│   ├── Sidebar.jsx      # Side navigation menu
│   ├── Layout.jsx       # Main layout wrapper
│   ├── TicketPanel.jsx  # POS ticket sidebar
│   └── modals/          # Modal components
│       ├── CustomerSearchModal.jsx
│       ├── PaymentModal.jsx
│       ├── WeightEntryModal.jsx
│       └── ChildProductsModal.jsx
├── context/
│   └── AppContext.jsx   # Global state management
├── data/
│   └── sampleData.js    # Sample data for development
├── pages/
│   ├── POSScreen.jsx    # Main POS/order entry
│   ├── OrdersPage.jsx   # Orders listing
│   ├── MachinesPage.jsx # Kanban workflow
│   └── CustomersPage.jsx # Customer management
├── App.jsx              # App root with routing
├── main.jsx             # Entry point
└── index.css            # TailwindCSS styles
```

## Panama-Specific Features

- Address format without ZIP codes
- Cédula and RUC/DV identification
- ITBMS (7%) tax calculation
- Currency format: B/ (Balboas)
- Spanish language interface

## Next Steps for Production

1. Connect to Supabase backend
2. Implement authentication with Row Level Security
3. Add real-time subscriptions for order updates
4. Deploy to Netlify

## License

Proprietary - American Laundry Panama
