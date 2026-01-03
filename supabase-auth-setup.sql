-- =================================================================
-- Supabase Auth Setup for User Invitations
-- =================================================================
-- Run this in your Supabase SQL Editor

-- 1. Ensure RLS is enabled on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 2. Create policy to allow users to read their own record
CREATE POLICY "Users can read own profile" ON users
  FOR SELECT USING (auth.uid() = auth_id);

-- 3. Create policy to allow authenticated users to read all users (for admin)
CREATE POLICY "Authenticated users can read all users" ON users
  FOR SELECT USING (auth.role() = 'authenticated');

-- 4. Create policy to allow service role to manage users
CREATE POLICY "Service role can manage users" ON users
  FOR ALL USING (auth.role() = 'service_role');

-- 5. Allow authenticated users to update users (for admin)
CREATE POLICY "Authenticated users can update users" ON users
  FOR UPDATE USING (auth.role() = 'authenticated');

-- 6. Allow authenticated users to insert users (for admin invitations)
CREATE POLICY "Authenticated users can insert users" ON users
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 7. Allow authenticated users to delete users (for admin)
CREATE POLICY "Authenticated users can delete users" ON users
  FOR DELETE USING (auth.role() = 'authenticated');

-- =================================================================
-- Email Template Configuration (do in Supabase Dashboard)
-- =================================================================
-- 
-- Go to: Authentication > Email Templates
--
-- INVITE USER template:
-- Subject: Has sido invitado a American Laundry
-- Body:
-- <h2>¡Bienvenido a American Laundry!</h2>
-- <p>Has sido invitado a unirte al sistema de gestión.</p>
-- <p>Haz clic en el siguiente enlace para establecer tu contraseña:</p>
-- <p><a href="{{ .ConfirmationURL }}">Establecer Contraseña</a></p>
-- <p>Este enlace expira en 24 horas.</p>
--
-- RESET PASSWORD template:
-- Subject: Restablecer contraseña - American Laundry
-- Body:
-- <h2>Restablecer Contraseña</h2>
-- <p>Haz clic en el siguiente enlace para establecer una nueva contraseña:</p>
-- <p><a href="{{ .ConfirmationURL }}">Restablecer Contraseña</a></p>
-- <p>Si no solicitaste este cambio, ignora este correo.</p>
--
-- CONFIRM SIGNUP template:
-- Subject: Confirma tu cuenta - American Laundry
-- Body:
-- <h2>Confirma tu cuenta</h2>
-- <p>Haz clic en el siguiente enlace para confirmar tu cuenta:</p>
-- <p><a href="{{ .ConfirmationURL }}">Confirmar Cuenta</a></p>

-- =================================================================
-- URL Configuration (do in Supabase Dashboard)
-- =================================================================
--
-- Go to: Authentication > URL Configuration
--
-- Set these values:
-- Site URL: https://your-domain.com (your Vercel URL)
-- Redirect URLs: 
--   - https://your-domain.com/set-password
--   - https://your-domain.com/login
--   - http://localhost:5173/set-password (for development)
--   - http://localhost:5173/login (for development)

-- =================================================================
-- Create initial admin user (run once)
-- =================================================================
-- 
-- Option 1: Manual signup
-- Go to Authentication > Users > Invite User
-- Enter the admin email and click "Invite"
-- After user confirms, run this to link the auth user:
--
-- UPDATE users 
-- SET auth_id = (SELECT id FROM auth.users WHERE email = 'admin@example.com')
-- WHERE email = 'admin@example.com';
--
-- Option 2: Create user record first, then invite
-- INSERT INTO users (store_id, email, full_name, role, initials)
-- SELECT id, 'admin@example.com', 'Admin User', 'admin', 'AU'
-- FROM stores LIMIT 1;
-- Then use the app to send invitation

-- =================================================================
-- Troubleshooting
-- =================================================================
--
-- If emails aren't being sent:
-- 1. Check Authentication > Settings > SMTP Settings
-- 2. You can use Supabase's built-in email or configure custom SMTP
-- 3. Check spam folder
--
-- If invitation links don't work:
-- 1. Verify Redirect URLs are configured correctly
-- 2. Check browser console for errors
-- 3. Ensure the /set-password route exists in your app
