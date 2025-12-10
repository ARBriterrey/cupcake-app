-- Create nudges table for "thinking of you" signals
CREATE TABLE IF NOT EXISTS public.nudges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pair_id UUID REFERENCES public.pairs(id) ON DELETE CASCADE NOT NULL,
    sender_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    receiver_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,

    nudge_type TEXT NOT NULL DEFAULT 'thinking_of_you'
        CHECK (nudge_type IN ('thinking_of_you', 'miss_you', 'love_you', 'hug')),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    viewed_at TIMESTAMPTZ,
    expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '24 hours'),

    -- Constraints
    CONSTRAINT nudge_pair_check CHECK (sender_id != receiver_id)
);

-- Enable RLS
ALTER TABLE public.nudges ENABLE ROW LEVEL SECURITY;

-- RLS Policies

-- Users can view nudges in their pair
CREATE POLICY "Users can view nudges in their pair"
ON public.nudges FOR SELECT
USING (
    pair_id IN (
        SELECT pair_id FROM public.profiles WHERE id = auth.uid()
    )
);

-- Users can send nudges to their partner
CREATE POLICY "Users can send nudges to their partner"
ON public.nudges FOR INSERT
WITH CHECK (
    pair_id IN (
        SELECT pair_id FROM public.profiles WHERE id = auth.uid()
    )
    AND sender_id = auth.uid()
);

-- Users can update nudges they received (mark as viewed)
CREATE POLICY "Users can update nudges they received"
ON public.nudges FOR UPDATE
USING (receiver_id = auth.uid());

-- Indexes for performance
CREATE INDEX nudges_pair_id_idx ON public.nudges(pair_id);
CREATE INDEX nudges_receiver_id_idx ON public.nudges(receiver_id);
CREATE INDEX nudges_expires_at_idx ON public.nudges(expires_at);
CREATE INDEX nudges_viewed_at_idx ON public.nudges(viewed_at) WHERE viewed_at IS NULL;

-- Cleanup function for expired nudges (run daily via cron or edge function)
CREATE OR REPLACE FUNCTION cleanup_expired_nudges()
RETURNS VOID AS $$
BEGIN
    DELETE FROM public.nudges
    WHERE expires_at < NOW();
END;
$$ LANGUAGE plpgsql;

-- Optional: Create a cron job to run cleanup daily
-- This requires pg_cron extension
-- SELECT cron.schedule('cleanup-expired-nudges', '0 2 * * *', 'SELECT cleanup_expired_nudges()');
