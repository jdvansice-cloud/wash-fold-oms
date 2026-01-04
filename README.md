# Wash & Fold OMS - American Laundry Panama

A modern, responsive Order Management System for wash and fold laundry services built with React, Vite, TailwindCSS, and Supabase.

## Features

- **POS System**: Product tiles with weight-based and quantity-based pricing
- **Ticket Management**: Real-time ticket with customer assignment, express toggle, notes
- **Service Workflow**: Kanban-style tracking (Pending → Washing → Drying → Folding → Ready)
- **Customer Management**: Full customer database with Panama-specific fields (Cédula, RUC, DV)
- **Payment Processing**: Multiple payment methods with cash change calculator
- **Multi-store Support**: Designed for multi-location businesses
- **Real-time Data**: Powered by Supabase PostgreSQL

## Tech Stack

- React 18
- Vite 5
- TailwindCSS 3
- React Router DOM 6
- Lucide React Icons
- Supabase (PostgreSQL)

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn
- Supabase account

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new project
2. Note your **Project URL** and **anon key** from Settings → API

### 2. Set Up Database

1. In Supabase, go to **SQL Editor**
2. Copy and run the entire contents of `supabase-schema.sql`
3. This creates all tables and inserts sample data

### 3. Configure Environment Variables

**For Vercel:**
Add these in your Vercel project settings → Environment Variables:

| Variable | Value |
|----------|-------|
| `SUPABASE_URL` | `https://your-project.supabase.co` |
| `SUPABASE_ANON_KEY` | Your anon/public key |

**For Local Development:**
Create a `.env` file in the project root:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

### 4. Install & Run

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

## Deployment to Vercel

1. Push your code to GitHub
2. Connect repository to Vercel
3. Add environment variables:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
4. Deploy!

## Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── Header.jsx       # Top navigation bar
│   ├── Sidebar.jsx      # Side navigation menu
│   ├── Layout.jsx       # Main layout wrapper
│   ├── TicketPanel.jsx  # POS ticket sidebar
│   └── modals/          # Modal components
├── context/
│   └── AppContext.jsx   # Global state management
├── data/
│   └── helpers.js       # Utility functions
├── hooks/
│   └── useDataLoader.js # Supabase data operations
├── lib/
│   └── supabase.js      # Supabase client
├── pages/
│   ├── POSScreen.jsx    # Main POS/order entry
│   ├── OrdersPage.jsx   # Orders listing
│   ├── MachinesPage.jsx # Kanban workflow
│   ├── CustomersPage.jsx
│   ├── AnalyticsPage.jsx
│   └── SettingsPage.jsx
├── App.jsx              # App root with routing
├── main.jsx             # Entry point
└── index.css            # TailwindCSS styles
```

## Database Schema

The `supabase-schema.sql` file creates:

- **companies** - Business information
- **stores** - Multi-store support
- **users** - User accounts with roles
- **sections** - Product categories
- **products** - Service & retail products
- **customers** - Customer database
- **orders** - Order records
- **order_items** - Line items per order
- **payments** - Payment records
- **payment_methods** - Available payment options
- **invoices** - Pending invoices
- **refunds** - Refund records
- **gift_cards** - Gift card management
- **promotions** - Discount codes
- **eod_closings** - End of day reports
- **machines** - Washer/dryer equipment

## Panama-Specific Features

- Address format: Corregimiento → Distrito → Provincia (no ZIP)
- ID types: Cédula, Pasaporte, RUC (mutually exclusive)
- Tax: ITBMS at 7%
- Currency: B/ (Balboas = USD)
- Spanish language interface

## Error Handling

If you see configuration errors:

1. **"Supabase no está configurado"** - Add environment variables
2. **"No se encontró una tienda activa"** - Run the SQL schema in Supabase
3. **"Error de conexión"** - Check your Supabase URL and key

## License

Proprietary - American Laundry Panama
