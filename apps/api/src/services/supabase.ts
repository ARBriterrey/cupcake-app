import { createClient, SupabaseClient } from '@supabase/supabase-js';

let _supabaseClient: SupabaseClient | null = null;

/**
 * Get Supabase client with service role access
 * This bypasses RLS policies - use carefully!
 *
 * Lazy-loaded to ensure environment variables are loaded first
 */
export function getSupabaseClient(): SupabaseClient {
  if (_supabaseClient) {
    return _supabaseClient;
  }

  const supabaseUrl = process.env.SUPABASE_URL || '';
  const supabaseServiceRole = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

  if (!supabaseUrl || !supabaseServiceRole) {
    throw new Error('⚠️  Supabase credentials not configured. Check .env file.');
  }

  _supabaseClient = createClient(
    supabaseUrl,
    supabaseServiceRole,
    {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    }
  );

  return _supabaseClient;
}

// For backwards compatibility
export const supabaseClient = getSupabaseClient;
export default getSupabaseClient;
