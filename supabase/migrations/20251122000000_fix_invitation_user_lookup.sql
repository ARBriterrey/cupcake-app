-- Fix invitation user lookup
-- The issue: RLS policy prevents users from looking up other users' profiles by email
-- Solution: Create a secure function that can look up user ID by email (with SECURITY DEFINER)

-- Create function to get user ID by email (bypasses RLS)
CREATE OR REPLACE FUNCTION public.get_user_id_by_email(p_email TEXT)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER -- This allows the function to bypass RLS
AS $$
DECLARE
    v_user_id UUID;
BEGIN
    -- Look up user ID by email in profiles table
    SELECT id INTO v_user_id
    FROM public.profiles
    WHERE LOWER(email) = LOWER(p_email)
    LIMIT 1;

    RETURN v_user_id;
END;
$$;

-- Add comment for documentation
COMMENT ON FUNCTION public.get_user_id_by_email(TEXT) IS 'Returns user ID for a given email address (case-insensitive). Used for sending pair invitations.';

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.get_user_id_by_email(TEXT) TO authenticated;
