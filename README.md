# Wash & Fold OMS - American Laundry Panama

A modern, responsive Order Management System for wash and fold laundry services built with React, Vite, and TailwindCSS.

## Features

- **POS System**: Product tiles with weight-based and quantity-based pricing
- **Ticket Management**: Real-time ticket with customer assignment, express toggle, notes
- **Service Workflow**: Kanban-style tracking (Pending → Washing → Drying → Folding → Ready)
- **Customer Management**: Full customer database with Panama-specific fields (Cédula, RUC, DV)
- **Payment Processing**: Multiple payment methods with cash change calculator
- **Multi-store Support**: Designed for multi-location businesses
- **Offline Ready**: Works with localStorage when Supabase is not configured

## Tech Stack

- React 18
- Vite 5
- TailwindCSS 3
- React Router DOM 6
- Lucide React Icons
- Supabase (optional - falls back to localStorage)

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

## Environment Variables

The app works **without any environment variables** using localStorage for data persistence.

To connect to Supabase, add these variables in Vercel (or `.env` locally):

| Variable | Description |
|----------|-------------|
| `SUPABASE_URL` | Your Supabase project URL |
| `SUPABASE_ANON_KEY` | Your Supabase anonymous/public key |

**Note**: No `VITE_` prefix needed - the vite config handles this automatically.

### Local Development with Supabase

Create a `.env` file in the project root:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

## Deployment to Vercel

1. Connect your repository to Vercel
2. (Optional) Add environment variables in Vercel dashboard:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
3. Deploy!

The app will automatically:
- Use **Supabase** if environment variables are configured
- Fall back to **localStorage** if no Supabase connection

A badge in the bottom-left corner shows the current data source.

## Project Structure

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
│   ├── helpers.js       # Utility functions
│   └── sampleData.js    # Sample data & localStorage helpers
├── hooks/
│   └── useDataLoader.js # Supabase/localStorage data loader
├── lib/
│   └── supabase.js      # Supabase client configuration
├── pages/
│   ├── POSScreen.jsx    # Main POS/order entry
│   ├── OrdersPage.jsx   # Orders listing
│   ├── MachinesPage.jsx # Kanban workflow
│   ├── CustomersPage.jsx # Customer management
│   ├── AnalyticsPage.jsx # Reports & analytics
│   └── SettingsPage.jsx  # System settings
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

## Data Persistence

| Mode | Storage | Use Case |
|------|---------|----------|
| Development | localStorage | Testing without backend |
| Production | Supabase | Full database with auth |

## License

Proprietary - American Laundry Panama
