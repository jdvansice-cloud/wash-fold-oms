# 📧 SMTP Email Configuration Guide

## Quick Setup

### 1. Run the SQL Migration

Run `supabase-smtp-setup.sql` in Supabase SQL Editor. This adds the required columns and creates the notification_settings table.

### 2. Configure SMTP in the App

Go to **Settings > Notificaciones > Configuración SMTP** and enter your SMTP server details.

---

## SMTP Provider Setup

### Gmail

1. Go to [Google Account Security](https://myaccount.google.com/security)
2. Enable **2-Step Verification**
3. Go to [App Passwords](https://myaccount.google.com/apppasswords)
4. Create a new app password for "Mail"
5. Use these settings:
   - **Server:** smtp.gmail.com
   - **Port:** 587
   - **User:** your-email@gmail.com
   - **Password:** The 16-character app password (not your Gmail password)
   - **TLS:** Enabled

### Outlook / Office 365

- **Server:** smtp.office365.com
- **Port:** 587
- **TLS:** Enabled

### Yahoo Mail

1. Enable "Allow apps that use less secure sign in" in Yahoo settings
2. Use these settings:
   - **Server:** smtp.mail.yahoo.com
   - **Port:** 587
   - **TLS:** Enabled

### SendGrid (Recommended for Production)

1. Create a [SendGrid account](https://sendgrid.com)
2. Go to Settings > API Keys > Create API Key
3. Use these settings:
   - **Server:** smtp.sendgrid.net
   - **Port:** 587
   - **User:** apikey (literally the word "apikey")
   - **Password:** Your SendGrid API key
   - **TLS:** Enabled

### Mailgun

1. Create a [Mailgun account](https://mailgun.com)
2. Get your SMTP credentials from the domain settings
3. Use these settings:
   - **Server:** smtp.mailgun.org
   - **Port:** 587
   - **User:** postmaster@your-domain.mailgun.org
   - **Password:** Your Mailgun SMTP password
   - **TLS:** Enabled

---

## Deploying the Edge Function (Required for Sending Emails)

The app stores SMTP configuration in the database, but actual email sending requires a Supabase Edge Function.

### Prerequisites

1. Install [Supabase CLI](https://supabase.com/docs/guides/cli)
2. Login: `supabase login`
3. Link your project: `supabase link --project-ref YOUR_PROJECT_REF`

### Deploy the Function

```bash
cd wash-fold-oms-react
supabase functions deploy send-email
```

### Set Environment Variables

```bash
# The function uses SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY automatically
# No additional env vars needed
```

---

## Using the Email Function

### From the App (JavaScript)

```javascript
// Send an email
const { data, error } = await supabase.functions.invoke('send-email', {
  body: {
    to: 'customer@example.com',
    subject: 'Your order is ready!',
    html: '<h1>Order Ready</h1><p>Your laundry is ready for pickup.</p>',
    company_id: 'your-company-uuid'
  }
});
```

### Email Templates

The app supports these notification templates:

| Template | Trigger | Variables |
|----------|---------|-----------|
| `welcome` | New customer registered | `{customer_name}`, `{company_name}` |
| `order_created` | Order placed | `{customer_name}`, `{order_number}`, `{total}`, `{promised_date}` |
| `order_ready` | Order ready for pickup | `{customer_name}`, `{order_number}`, `{store_phone}` |
| `order_delivered` | Order delivered | `{customer_name}`, `{order_number}` |

---

## Troubleshooting

### "Connection refused" or timeout

- Check that the SMTP host and port are correct
- Verify TLS setting matches your provider
- Some networks block port 587; try port 465 with SSL

### "Authentication failed"

- For Gmail: Make sure you're using an App Password, not your regular password
- For SendGrid: Username must be literally "apikey"
- Check for typos in username/password

### "From address not allowed"

- Some providers (like Gmail) only allow sending from your verified email
- Set "Email del remitente" to match your SMTP user

### Emails going to spam

- Use a proper "From Name" (your business name)
- Set up SPF, DKIM, and DMARC records for your domain
- Use a dedicated email service like SendGrid for better deliverability

---

## Security Notes

⚠️ **Important:**

1. SMTP passwords are stored in the database. Make sure your Supabase project has proper RLS policies in production.
2. Never expose SMTP credentials in client-side code.
3. The Edge Function uses `SUPABASE_SERVICE_ROLE_KEY` which bypasses RLS - this is intentional for sending emails.
4. Consider using a dedicated email service (SendGrid, Mailgun) instead of your personal email for production.
