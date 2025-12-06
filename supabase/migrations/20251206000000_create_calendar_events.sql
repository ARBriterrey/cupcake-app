-- Calendar Events Migration
-- Core shared calendar feature for couples to track moments, dates, and events together

-- =====================================================
-- CALENDAR EVENTS TABLE
-- =====================================================
CREATE TABLE public.calendar_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pair_id UUID REFERENCES public.pairs(id) ON DELETE CASCADE NOT NULL,
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,

    -- Event details
    title TEXT NOT NULL,
    description TEXT,
    event_type TEXT NOT NULL DEFAULT 'moment' CHECK (event_type IN ('moment', 'date', 'appointment', 'reminder', 'anniversary', 'other')),

    -- Timing
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ,
    is_all_day BOOLEAN DEFAULT false,

    -- Location
    location TEXT,
    location_coordinates POINT, -- For future map integration

    -- Visibility and privacy
    visibility TEXT NOT NULL DEFAULT 'shared' CHECK (visibility IN ('private', 'shared')),
    visible_to_user_id UUID REFERENCES public.profiles(id), -- If private, which user can see it

    -- Metadata
    color TEXT, -- Custom color for the event
    tags TEXT[], -- Tags for categorization
    metadata JSONB DEFAULT '{}', -- Flexible storage for sprinkle integrations

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Ensure private events have a visible_to_user_id
    CONSTRAINT private_visibility_check CHECK (
        visibility != 'private' OR visible_to_user_id IS NOT NULL
    )
);

-- Enable RLS on calendar_events
ALTER TABLE public.calendar_events ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- ROW LEVEL SECURITY POLICIES
-- =====================================================

-- Users can view events for their pair (shared events or their own private events)
CREATE POLICY "Users can view their pair's calendar events"
    ON public.calendar_events FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.pairs
            WHERE pairs.id = calendar_events.pair_id
            AND (pairs.user1_id = auth.uid() OR pairs.user2_id = auth.uid())
            AND pairs.status = 'active'
        )
        AND (
            calendar_events.visibility = 'shared'
            OR calendar_events.visible_to_user_id = auth.uid()
        )
    );

-- Users can create events for their own pair
CREATE POLICY "Users can create events for their pair"
    ON public.calendar_events FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.pairs
            WHERE pairs.id = calendar_events.pair_id
            AND (pairs.user1_id = auth.uid() OR pairs.user2_id = auth.uid())
            AND pairs.status = 'active'
        )
        AND created_by = auth.uid()
    );

-- Users can update events they created
CREATE POLICY "Users can update their own events"
    ON public.calendar_events FOR UPDATE
    USING (created_by = auth.uid())
    WITH CHECK (created_by = auth.uid());

-- Users can delete events they created
CREATE POLICY "Users can delete their own events"
    ON public.calendar_events FOR DELETE
    USING (created_by = auth.uid());

-- =====================================================
-- TRIGGERS
-- =====================================================

-- Trigger to update updated_at timestamp
CREATE TRIGGER calendar_events_updated_at
    BEFORE UPDATE ON public.calendar_events
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX idx_calendar_events_pair_id ON public.calendar_events(pair_id);
CREATE INDEX idx_calendar_events_created_by ON public.calendar_events(created_by);
CREATE INDEX idx_calendar_events_start_time ON public.calendar_events(start_time);
CREATE INDEX idx_calendar_events_event_type ON public.calendar_events(event_type);
CREATE INDEX idx_calendar_events_visibility ON public.calendar_events(visibility);
CREATE INDEX idx_calendar_events_tags ON public.calendar_events USING GIN(tags);

-- Composite index for common queries (pair + date range)
CREATE INDEX idx_calendar_events_pair_date ON public.calendar_events(pair_id, start_time);

-- =====================================================
-- HELPER FUNCTIONS
-- =====================================================

-- Function to get calendar events for a date range
CREATE OR REPLACE FUNCTION public.get_calendar_events(
    p_start_date TIMESTAMPTZ,
    p_end_date TIMESTAMPTZ
)
RETURNS SETOF public.calendar_events
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_pair_id UUID;
BEGIN
    v_pair_id := public.get_my_pair_id();

    IF v_pair_id IS NULL THEN
        RETURN;
    END IF;

    RETURN QUERY
    SELECT * FROM public.calendar_events
    WHERE pair_id = v_pair_id
    AND start_time >= p_start_date
    AND start_time <= p_end_date
    AND (
        visibility = 'shared'
        OR visible_to_user_id = auth.uid()
    )
    ORDER BY start_time ASC;
END;
$$;

-- Function to get upcoming events (next 30 days)
CREATE OR REPLACE FUNCTION public.get_upcoming_events(p_limit INTEGER DEFAULT 10)
RETURNS SETOF public.calendar_events
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_pair_id UUID;
BEGIN
    v_pair_id := public.get_my_pair_id();

    IF v_pair_id IS NULL THEN
        RETURN;
    END IF;

    RETURN QUERY
    SELECT * FROM public.calendar_events
    WHERE pair_id = v_pair_id
    AND start_time >= NOW()
    AND start_time <= NOW() + INTERVAL '30 days'
    AND (
        visibility = 'shared'
        OR visible_to_user_id = auth.uid()
    )
    ORDER BY start_time ASC
    LIMIT p_limit;
END;
$$;

-- =====================================================
-- COMMENTS FOR DOCUMENTATION
-- =====================================================

COMMENT ON TABLE public.calendar_events IS 'Shared calendar events for couples - moments, dates, appointments, and reminders';
COMMENT ON COLUMN public.calendar_events.visibility IS 'Controls who can see the event: shared (both partners) or private (one partner)';
COMMENT ON COLUMN public.calendar_events.event_type IS 'Type of event: moment, date, appointment, reminder, anniversary, other';
COMMENT ON COLUMN public.calendar_events.metadata IS 'Flexible JSONB field for sprinkle integrations and custom data';
COMMENT ON FUNCTION public.get_calendar_events(TIMESTAMPTZ, TIMESTAMPTZ) IS 'Get calendar events for the current user''s pair within a date range';
COMMENT ON FUNCTION public.get_upcoming_events(INTEGER) IS 'Get upcoming events for the current user''s pair (default: next 30 days, limit 10)';
