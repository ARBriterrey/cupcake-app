import { createClient, SupabaseClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseServiceRole = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

if (!supabaseUrl || !supabaseServiceRole) {
  console.warn('⚠️  Supabase credentials not configured. Check .env file.');
}

/**
 * Supabase client with service role access
 * This bypasses RLS policies - use carefully!
 */
export const supabaseClient: SupabaseClient = createClient(
  supabaseUrl,
  supabaseServiceRole,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  }
);

export default supabaseClient;
