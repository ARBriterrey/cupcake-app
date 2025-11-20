-- Cupcake Initial Migration: Users and Pairs
-- This migration establishes the core couple-centric data model

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- USERS PROFILE TABLE
-- =====================================================
-- Extends Supabase auth.users with couple-specific profile data
CREATE TABLE public.profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    display_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view their own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id);

-- =====================================================
-- PAIRS TABLE (Core Couple Linking Model)
-- =====================================================
CREATE TABLE public.pairs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_a UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    user_b UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'inactive')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Ensure a user can only be in one active pair
    CONSTRAINT unique_users CHECK (user_a != user_b),
    CONSTRAINT unique_pair UNIQUE (user_a, user_b)
);

-- Enable RLS on pairs
ALTER TABLE public.pairs ENABLE ROW LEVEL SECURITY;

-- Pairs policies
CREATE POLICY "Users can view their own pairs"
    ON public.pairs FOR SELECT
    USING (auth.uid() = user_a OR auth.uid() = user_b);

CREATE POLICY "Users can create pairs with themselves as user_a"
    ON public.pairs FOR INSERT
    WITH CHECK (auth.uid() = user_a);

CREATE POLICY "Users in a pair can update it"
    ON public.pairs FOR UPDATE
    USING (auth.uid() = user_a OR auth.uid() = user_b);

-- =====================================================
-- PAIR INVITATIONS TABLE
-- =====================================================
-- Handles the invitation flow for couple linking
CREATE TABLE public.pair_invitations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    inviter_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    invitee_email TEXT NOT NULL,
    invitee_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    invitation_code TEXT UNIQUE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected', 'expired')),
    expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '7 days'),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Ensure user can't invite themselves
    CONSTRAINT no_self_invite CHECK (inviter_id != invitee_id)
);

-- Enable RLS on invitations
ALTER TABLE public.pair_invitations ENABLE ROW LEVEL SECURITY;

-- Invitation policies
CREATE POLICY "Users can view invitations they sent or received"
    ON public.pair_invitations FOR SELECT
    USING (
        auth.uid() = inviter_id
        OR auth.uid() = invitee_id
        OR auth.email() = invitee_email
    );

CREATE POLICY "Users can create invitations"
    ON public.pair_invitations FOR INSERT
    WITH CHECK (auth.uid() = inviter_id);

CREATE POLICY "Invitees can update invitations sent to them"
    ON public.pair_invitations FOR UPDATE
    USING (auth.uid() = invitee_id OR auth.email() = invitee_email);

-- =====================================================
-- PAIR ENTITLEMENTS (Sprinkle Purchases)
-- =====================================================
CREATE TABLE public.pair_entitlements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pair_id UUID REFERENCES public.pairs(id) ON DELETE CASCADE NOT NULL,
    sprinkle_key TEXT NOT NULL,
    purchased_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    purchase_id TEXT,
    expires_at TIMESTAMPTZ, -- NULL for one-time purchases
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT unique_pair_sprinkle UNIQUE (pair_id, sprinkle_key)
);

-- Enable RLS on entitlements
ALTER TABLE public.pair_entitlements ENABLE ROW LEVEL SECURITY;

-- Entitlements policies
CREATE POLICY "Users can view entitlements for their pair"
    ON public.pair_entitlements FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.pairs
            WHERE pairs.id = pair_entitlements.pair_id
            AND (pairs.user_a = auth.uid() OR pairs.user_b = auth.uid())
        )
    );

-- =====================================================
-- HELPER FUNCTIONS
-- =====================================================

-- Function to get the current user's active pair_id
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
    WHERE (user_a = auth.uid() OR user_b = auth.uid())
    AND status = 'active'
    LIMIT 1;

    RETURN v_pair_id;
END;
$$;

-- Function to check if user has access to a sprinkle
CREATE OR REPLACE FUNCTION public.has_sprinkle_access(p_sprinkle_key TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_pair_id UUID;
    v_has_access BOOLEAN;
BEGIN
    v_pair_id := public.get_my_pair_id();

    IF v_pair_id IS NULL THEN
        RETURN FALSE;
    END IF;

    SELECT EXISTS (
        SELECT 1 FROM public.pair_entitlements
        WHERE pair_id = v_pair_id
        AND sprinkle_key = p_sprinkle_key
        AND (expires_at IS NULL OR expires_at > NOW())
    ) INTO v_has_access;

    RETURN v_has_access;
END;
$$;

-- =====================================================
-- TRIGGERS
-- =====================================================

-- Trigger to auto-create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    INSERT INTO public.profiles (id, email, display_name)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'display_name', split_part(NEW.email, '@', 1))
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER pairs_updated_at
    BEFORE UPDATE ON public.pairs
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX idx_pairs_user_a ON public.pairs(user_a);
CREATE INDEX idx_pairs_user_b ON public.pairs(user_b);
CREATE INDEX idx_pairs_status ON public.pairs(status);
CREATE INDEX idx_pair_entitlements_pair_id ON public.pair_entitlements(pair_id);
CREATE INDEX idx_pair_invitations_inviter ON public.pair_invitations(inviter_id);
CREATE INDEX idx_pair_invitations_invitee_email ON public.pair_invitations(invitee_email);
CREATE INDEX idx_pair_invitations_code ON public.pair_invitations(invitation_code);

-- =====================================================
-- COMMENTS FOR DOCUMENTATION
-- =====================================================

COMMENT ON TABLE public.profiles IS 'User profiles extending Supabase auth.users';
COMMENT ON TABLE public.pairs IS 'Core couple linking table - each pair represents a relationship';
COMMENT ON TABLE public.pair_invitations IS 'Invitation system for linking couples';
COMMENT ON TABLE public.pair_entitlements IS 'Purchased sprinkles (add-ons) for each couple';
COMMENT ON FUNCTION public.get_my_pair_id() IS 'Returns the active pair_id for the current authenticated user';
COMMENT ON FUNCTION public.has_sprinkle_access(TEXT) IS 'Checks if current user has access to a specific sprinkle';
