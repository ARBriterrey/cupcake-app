import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

/**
 * Edge function for cleaning up soft-deleted calendar events
 *
 * This function should be scheduled to run daily via a cron job.
 * It calls the cleanup_deleted_events database function which:
 * - Finds events marked as deleted (is_deleted = true)
 * - Checks if they've been deleted for more than the retention period (default 30 days)
 * - Permanently removes them from the database (hard delete)
 *
 * Usage:
 * - Can be called manually via POST request
 * - Should be scheduled as a cron job in Supabase dashboard
 * - Optionally accepts retention_days parameter (default: 30)
 */

interface CleanupRequest {
  retention_days?: number
}

interface CleanupResponse {
  success: boolean
  deletedCount: number
  message?: string
  error?: string
}

serve(async (req) => {
  try {
    // Parse request body for custom retention period
    let retentionDays = 30 // Default retention period

    if (req.method === 'POST') {
      try {
        const body: CleanupRequest = await req.json()
        if (body.retention_days && typeof body.retention_days === 'number') {
          retentionDays = body.retention_days
        }
      } catch {
        // If body parsing fails, use default
      }
    }

    // Create Supabase client with service role key
    const supabaseUrl = Deno.env.get('SUPABASE_URL')
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

    if (!supabaseUrl || !supabaseServiceKey) {
      throw new Error('Missing Supabase environment variables')
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    // Call the database cleanup function
    const { data, error } = await supabase.rpc('cleanup_deleted_events', {
      p_retention_days: retentionDays
    })

    if (error) {
      console.error('Database cleanup error:', error)
      throw error
    }

    const deletedCount = data as number

    const response: CleanupResponse = {
      success: true,
      deletedCount,
      message: `Successfully cleaned up ${deletedCount} deleted events older than ${retentionDays} days`
    }

    console.log(response.message)

    return new Response(JSON.stringify(response), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
      },
    })
  } catch (error) {
    console.error('Cleanup function error:', error)

    const response: CleanupResponse = {
      success: false,
      deletedCount: 0,
      error: error instanceof Error ? error.message : 'Unknown error occurred'
    }

    return new Response(JSON.stringify(response), {
      status: 500,
      headers: {
        'Content-Type': 'application/json',
      },
    })
  }
})
