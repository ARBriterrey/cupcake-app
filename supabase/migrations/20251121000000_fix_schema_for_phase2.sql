-- Fix schema to match Phase 2 implementation
-- This migration adds missing columns and renames tables to match the app code

-- Add missing columns to profiles table
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS timezone TEXT,
ADD COLUMN IF NOT EXISTS preferences JSONB DEFAULT '{}',
ADD COLUMN IF NOT EXISTS active_pair_id UUID REFERENCES public.pairs(id) ON DELETE SET NULL;

-- Rename pair columns to match code expectations
ALTER TABLE public.pairs
RENAME COLUMN user_a TO user1_id;

ALTER TABLE public.pairs
RENAME COLUMN user_b TO user2_id;

-- Add missing columns to pairs table
ALTER TABLE public.pairs
ADD COLUMN IF NOT EXISTS couple_name TEXT,
ADD COLUMN IF NOT EXISTS anniversary_date TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS shared_preferences JSONB DEFAULT '{}';

-- Rename invitation columns to match code expectations
ALTER TABLE public.pair_invitations
RENAME COLUMN inviter_id TO from_user_id;

ALTER TABLE public.pair_invitations
RENAME COLUMN invitee_email TO to_user_email;

ALTER TABLE public.pair_invitations
RENAME COLUMN invitee_id TO to_user_id;

-- Remove invitation_code column (not used in app)
ALTER TABLE public.pair_invitations
DROP COLUMN IF EXISTS invitation_code;

-- Add message column to invitations
ALTER TABLE public.pair_invitations
ADD COLUMN IF NOT EXISTS message TEXT;

-- Rename entitlement columns to match code expectations
ALTER TABLE public.pair_entitlements
RENAME COLUMN sprinkle_key TO sprinkle_id;

-- Add missing columns to entitlements
ALTER TABLE public.pair_entitlements
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS metadata JSONB DEFAULT '{}',
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

-- Update the get_my_pair_id function to use new column names
CREATE OR REPLACE FUNCTION public.get_my_pair_id()
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_pair_id UUID;
BEGIN
    SELECT id INTO v_pair_id
    FROM public.pairs
    WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
    AND status = 'active'
    LIMIT 1;

    RETURN v_pair_id;
END;
$$;

-- Update policies to use new column names
DROP POLICY IF EXISTS "Users can view their own pairs" ON public.pairs;
CREATE POLICY "Users can view their own pairs"
    ON public.pairs FOR SELECT
    USING (auth.uid() = user1_id OR auth.uid() = user2_id);

DROP POLICY IF EXISTS "Users can create pairs with themselves as user_a" ON public.pairs;
CREATE POLICY "Users can create pairs with themselves as user1"
    ON public.pairs FOR INSERT
    WITH CHECK (auth.uid() = user1_id);

DROP POLICY IF EXISTS "Users in a pair can update it" ON public.pairs;
CREATE POLICY "Users in a pair can update it"
    ON public.pairs FOR UPDATE
    USING (auth.uid() = user1_id OR auth.uid() = user2_id);

-- Update invitation policies
DROP POLICY IF EXISTS "Users can view invitations they sent or received" ON public.pair_invitations;
CREATE POLICY "Users can view invitations they sent or received"
    ON public.pair_invitations FOR SELECT
    USING (
        auth.uid() = from_user_id
        OR auth.uid() = to_user_id
        OR auth.email() = to_user_email
    );

DROP POLICY IF EXISTS "Users can create invitations" ON public.pair_invitations;
CREATE POLICY "Users can create invitations"
    ON public.pair_invitations FOR INSERT
    WITH CHECK (auth.uid() = from_user_id);

DROP POLICY IF EXISTS "Invitees can update invitations sent to them" ON public.pair_invitations;
CREATE POLICY "Invitees can update invitations sent to them"
    ON public.pair_invitations FOR UPDATE
    USING (auth.uid() = to_user_id OR auth.email() = to_user_email);

-- Remove the no_self_invite constraint as it references old column names
ALTER TABLE public.pair_invitations
DROP CONSTRAINT IF EXISTS no_self_invite;

-- Add it back with new column names
ALTER TABLE public.pair_invitations
ADD CONSTRAINT no_self_invite CHECK (from_user_id != to_user_id);
