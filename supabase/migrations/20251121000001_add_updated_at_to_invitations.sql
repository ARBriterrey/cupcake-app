-- Add missing updated_at column to pair_invitations
ALTER TABLE public.pair_invitations
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

-- Create a trigger to auto-update updated_at on row changes
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add trigger to pair_invitations
DROP TRIGGER IF EXISTS update_pair_invitations_updated_at ON public.pair_invitations;
CREATE TRIGGER update_pair_invitations_updated_at
    BEFORE UPDATE ON public.pair_invitations
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- Add the same trigger to other tables for consistency
DROP TRIGGER IF EXISTS update_profiles_updated_at ON public.profiles;
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS update_pairs_updated_at ON public.pairs;
CREATE TRIGGER update_pairs_updated_at
    BEFORE UPDATE ON public.pairs
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS update_pair_entitlements_updated_at ON public.pair_entitlements;
CREATE TRIGGER update_pair_entitlements_updated_at
    BEFORE UPDATE ON public.pair_entitlements
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();
