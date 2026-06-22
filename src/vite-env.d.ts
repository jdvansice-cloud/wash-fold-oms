/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly SUPABASE_URL: string;
  /** New publishable key (resolves to anon as fallback in vite.config.js). */
  readonly SUPABASE_PUBLISHABLE_KEY: string;
  /** @deprecated legacy anon key — use SUPABASE_PUBLISHABLE_KEY. */
  readonly SUPABASE_ANON_KEY: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
