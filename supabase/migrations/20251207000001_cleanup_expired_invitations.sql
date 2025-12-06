-- Enable the pg_cron extension
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Create a function to delete expired invitations
CREATE OR REPLACE FUNCTION public.delete_expired_invitations()
RETURNS void AS $$
BEGIN
  DELETE FROM public.pair_invitations
  WHERE status = 'pending'
    AND expires_at < NOW();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Schedule the job to run every day at midnight (00:00)
-- Job name: 'cleanup_expired_invitations'
SELECT cron.schedule(
  'cleanup_expired_invitations',
  '0 0 * * *',
  $$SELECT public.delete_expired_invitations()$$
);
