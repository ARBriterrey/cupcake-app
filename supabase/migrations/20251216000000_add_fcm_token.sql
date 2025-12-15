-- Add fcm_token column to profiles table
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS fcm_token text;

-- Add comment
COMMENT ON COLUMN public.profiles.fcm_token IS 'Firebase Cloud Messaging token for push notifications';
