# Cleanup Deleted Events Edge Function

This Supabase Edge Function performs garbage collection on soft-deleted calendar events.

## Purpose

The Cupcake app uses a two-phase deletion system:
1. **Soft delete**: Events are marked as deleted (`is_deleted = true`) but remain in the database
2. **Hard delete**: After a retention period (default 30 days), events are permanently removed

This function handles the second phase - permanently removing events that have been soft-deleted beyond the retention period.

## Deployment

### Deploy the function:
```bash
supabase functions deploy cleanup-deleted-events
```

### Set up scheduled execution:

1. **Option 1: Supabase Cron (Recommended)**
   - Go to your Supabase project dashboard
   - Navigate to Database > Extensions
   - Enable the `pg_cron` extension
   - Run the following SQL:

```sql
-- Schedule cleanup to run daily at 2 AM UTC
SELECT cron.schedule(
  'cleanup-deleted-calendar-events',
  '0 2 * * *',
  $$
  SELECT
    net.http_post(
      url := '<your-supabase-url>/functions/v1/cleanup-deleted-events',
      headers := '{"Authorization": "Bearer <your-service-role-key>"}'::jsonb
    ) AS request_id;
  $$
);
```

2. **Option 2: External Scheduler**
   - Use GitHub Actions, AWS Lambda, or another scheduler
   - Make a POST request to the function URL daily

### Manual execution:

```bash
curl -X POST \
  -H "Authorization: Bearer <your-anon-key>" \
  "<your-supabase-url>/functions/v1/cleanup-deleted-events"
```

### Custom retention period:

```bash
curl -X POST \
  -H "Authorization: Bearer <your-anon-key>" \
  -H "Content-Type: application/json" \
  -d '{"retention_days": 60}' \
  "<your-supabase-url>/functions/v1/cleanup-deleted-events"
```

## Response Format

Success:
```json
{
  "success": true,
  "deletedCount": 15,
  "message": "Successfully cleaned up 15 deleted events older than 30 days"
}
```

Error:
```json
{
  "success": false,
  "deletedCount": 0,
  "error": "Error message here"
}
```

## Monitoring

- Check function logs in Supabase Dashboard > Edge Functions
- Monitor the `deletedCount` to track cleanup operations
- Consider setting up alerts if cleanup fails repeatedly

## Testing

Test locally with Supabase CLI:
```bash
supabase functions serve cleanup-deleted-events
```

Then call it:
```bash
curl -X POST http://localhost:54321/functions/v1/cleanup-deleted-events
```
