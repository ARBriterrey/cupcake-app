-- Migration: Add soft delete functionality to calendar_events table
-- This enables two-phase deletion: mark as deleted → actual deletion after retention period

-- Add soft delete columns
ALTER TABLE public.calendar_events
ADD COLUMN deleted_at TIMESTAMPTZ,
ADD COLUMN deleted_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
ADD COLUMN is_deleted BOOLEAN NOT NULL DEFAULT false;

-- Add index for performance optimization on soft-deleted queries
CREATE INDEX idx_calendar_events_deleted ON public.calendar_events(is_deleted, deleted_at);

-- Update RLS policy to exclude soft-deleted events from normal queries
DROP POLICY IF EXISTS "Users can view their pair's calendar events" ON public.calendar_events;

CREATE POLICY "Users can view their pair's calendar events"
    ON public.calendar_events FOR SELECT
    USING (
        -- User must be in the pair
        EXISTS (
            SELECT 1 FROM public.pairs
            WHERE pairs.id = calendar_events.pair_id
            AND (pairs.user1_id = auth.uid() OR pairs.user2_id = auth.uid())
            AND pairs.status = 'active'
        )
        AND (
            -- Event is shared OR private to current user
            calendar_events.visibility = 'shared'
            OR calendar_events.visible_to_user_id = auth.uid()
        )
        -- NEW: Filter out soft-deleted events
        AND calendar_events.is_deleted = false
    );

-- Update helper function to exclude soft-deleted events
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
    -- Get user's active pair
    v_pair_id := public.get_my_pair_id();

    IF v_pair_id IS NULL THEN
        RETURN;
    END IF;

    RETURN QUERY
    SELECT * FROM public.calendar_events
    WHERE pair_id = v_pair_id
    AND start_time >= p_start_date
    AND start_time <= p_end_date
    AND is_deleted = false  -- NEW: Exclude soft-deleted
    AND (
        visibility = 'shared'
        OR visible_to_user_id = auth.uid()
    )
    ORDER BY start_time ASC;
END;
$$;

-- Update upcoming events function to exclude soft-deleted
CREATE OR REPLACE FUNCTION public.get_upcoming_events(p_limit INTEGER DEFAULT 10)
RETURNS SETOF public.calendar_events
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_pair_id UUID;
BEGIN
    -- Get user's active pair
    v_pair_id := public.get_my_pair_id();

    IF v_pair_id IS NULL THEN
        RETURN;
    END IF;

    RETURN QUERY
    SELECT * FROM public.calendar_events
    WHERE pair_id = v_pair_id
    AND start_time >= NOW()
    AND start_time <= NOW() + INTERVAL '30 days'
    AND is_deleted = false  -- NEW: Exclude soft-deleted
    AND (
        visibility = 'shared'
        OR visible_to_user_id = auth.uid()
    )
    ORDER BY start_time ASC
    LIMIT p_limit;
END;
$$;

-- New function for soft delete operation
CREATE OR REPLACE FUNCTION public.soft_delete_calendar_event(
    p_event_id UUID
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Soft delete: mark as deleted without removing from database
    UPDATE public.calendar_events
    SET
        is_deleted = true,
        deleted_at = NOW(),
        deleted_by = auth.uid(),
        updated_at = NOW()
    WHERE id = p_event_id
    AND created_by = auth.uid();  -- Only creator can delete

    -- Raise exception if no rows were updated (event not found or not owned by user)
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Event not found or you do not have permission to delete it';
    END IF;
END;
$$;

-- Garbage collection function for scheduled cleanup
-- This permanently deletes events that have been soft-deleted beyond the retention period
CREATE OR REPLACE FUNCTION public.cleanup_deleted_events(p_retention_days INTEGER DEFAULT 30)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_deleted_count INTEGER;
BEGIN
    -- Hard delete events that have been soft-deleted for more than retention period
    WITH deleted_events AS (
        DELETE FROM public.calendar_events
        WHERE is_deleted = true
        AND deleted_at < NOW() - (p_retention_days || ' days')::INTERVAL
        RETURNING id
    )
    SELECT COUNT(*) INTO v_deleted_count FROM deleted_events;

    RETURN v_deleted_count;
END;
$$;

-- Add comments for documentation
COMMENT ON COLUMN public.calendar_events.is_deleted IS 'Soft delete flag - true means event is deleted but not yet purged';
COMMENT ON COLUMN public.calendar_events.deleted_at IS 'Timestamp when event was soft-deleted';
COMMENT ON COLUMN public.calendar_events.deleted_by IS 'User who deleted the event';
COMMENT ON FUNCTION public.soft_delete_calendar_event(UUID) IS 'Soft delete a calendar event (mark as deleted without removing from database). Only the creator can delete.';
COMMENT ON FUNCTION public.cleanup_deleted_events(INTEGER) IS 'Hard delete events that have been soft-deleted beyond retention period (default 30 days). Returns count of deleted events.';
