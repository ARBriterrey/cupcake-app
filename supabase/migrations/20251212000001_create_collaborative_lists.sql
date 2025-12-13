-- Migration: Create Collaborative Lists tables
-- Description: Implements shared to-do lists with standard and "Chit Jar" modes
-- Dependencies: Requires pairs and profiles tables

-- ============================================================================
-- TABLE: lists
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pair_id UUID REFERENCES public.pairs(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    list_type TEXT NOT NULL DEFAULT 'standard'
        CHECK (list_type IN ('standard', 'chit_jar', 'shopping')),
    description TEXT,

    -- Chit Jar specific fields
    current_turn_user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    last_pick_at TIMESTAMPTZ,

    -- Metadata
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Soft delete
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMPTZ,
    deleted_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL
);

-- ============================================================================
-- TABLE: list_items
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.list_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    list_id UUID REFERENCES public.lists(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,

    -- Assignment
    assigned_to UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    assigned_at TIMESTAMPTZ,

    -- Completion
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    completed_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    completed_at TIMESTAMPTZ,

    -- Ordering
    sort_order INTEGER NOT NULL DEFAULT 0,

    -- Metadata
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Soft delete
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMPTZ,
    deleted_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL
);

-- ============================================================================
-- INDEXES
-- ============================================================================

-- Lists indexes
CREATE INDEX IF NOT EXISTS idx_lists_pair_id ON public.lists(pair_id);
CREATE INDEX IF NOT EXISTS idx_lists_pair_active ON public.lists(pair_id)
    WHERE is_deleted = FALSE;
CREATE INDEX IF NOT EXISTS idx_lists_created_at ON public.lists(created_at DESC);

-- List items indexes
CREATE INDEX IF NOT EXISTS idx_list_items_list_id ON public.list_items(list_id);
CREATE INDEX IF NOT EXISTS idx_list_items_list_active ON public.list_items(list_id)
    WHERE is_deleted = FALSE;
CREATE INDEX IF NOT EXISTS idx_list_items_assigned ON public.list_items(assigned_to)
    WHERE is_completed = FALSE AND is_deleted = FALSE;
CREATE INDEX IF NOT EXISTS idx_list_items_sort ON public.list_items(list_id, sort_order);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================

ALTER TABLE public.lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.list_items ENABLE ROW LEVEL SECURITY;

-- Lists RLS Policies
CREATE POLICY "Users can view their pair's lists"
    ON public.lists FOR SELECT
    USING (
        pair_id IN (
            SELECT id FROM public.pairs
            WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
            AND status = 'active'
        )
    );

CREATE POLICY "Users can create lists for their pair"
    ON public.lists FOR INSERT
    WITH CHECK (
        pair_id IN (
            SELECT id FROM public.pairs
            WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
            AND status = 'active'
        )
        AND created_by = auth.uid()
    );

CREATE POLICY "Users can update their pair's lists"
    ON public.lists FOR UPDATE
    USING (
        pair_id IN (
            SELECT id FROM public.pairs
            WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
            AND status = 'active'
        )
    );

CREATE POLICY "Users can delete their pair's lists"
    ON public.lists FOR DELETE
    USING (
        pair_id IN (
            SELECT id FROM public.pairs
            WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
            AND status = 'active'
        )
    );

-- List Items RLS Policies
CREATE POLICY "Users can view their pair's list items"
    ON public.list_items FOR SELECT
    USING (
        list_id IN (
            SELECT id FROM public.lists
            WHERE pair_id IN (
                SELECT id FROM public.pairs
                WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
                AND status = 'active'
            )
        )
    );

CREATE POLICY "Users can create items for their pair's lists"
    ON public.list_items FOR INSERT
    WITH CHECK (
        list_id IN (
            SELECT id FROM public.lists
            WHERE pair_id IN (
                SELECT id FROM public.pairs
                WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
                AND status = 'active'
            )
        )
        AND created_by = auth.uid()
    );

CREATE POLICY "Users can update their pair's list items"
    ON public.list_items FOR UPDATE
    USING (
        list_id IN (
            SELECT id FROM public.lists
            WHERE pair_id IN (
                SELECT id FROM public.pairs
                WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
                AND status = 'active'
            )
        )
    );

CREATE POLICY "Users can delete their pair's list items"
    ON public.list_items FOR DELETE
    USING (
        list_id IN (
            SELECT id FROM public.lists
            WHERE pair_id IN (
                SELECT id FROM public.pairs
                WHERE (user1_id = auth.uid() OR user2_id = auth.uid())
                AND status = 'active'
            )
        )
    );

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Auto-update updated_at timestamp for lists
CREATE OR REPLACE FUNCTION update_lists_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER lists_updated_at
    BEFORE UPDATE ON public.lists
    FOR EACH ROW
    EXECUTE FUNCTION update_lists_updated_at();

-- Auto-update updated_at timestamp for list_items
CREATE OR REPLACE FUNCTION update_list_items_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER list_items_updated_at
    BEFORE UPDATE ON public.list_items
    FOR EACH ROW
    EXECUTE FUNCTION update_list_items_updated_at();

-- ============================================================================
-- SOFT DELETE FUNCTIONS
-- ============================================================================

-- Soft delete function for lists
CREATE OR REPLACE FUNCTION soft_delete_list(
    list_id_param UUID,
    user_id_param UUID
)
RETURNS void AS $$
BEGIN
    UPDATE public.lists
    SET
        is_deleted = TRUE,
        deleted_at = NOW(),
        deleted_by = user_id_param
    WHERE id = list_id_param;

    -- Also soft delete all items in the list
    UPDATE public.list_items
    SET
        is_deleted = TRUE,
        deleted_at = NOW(),
        deleted_by = user_id_param
    WHERE list_id = list_id_param;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Soft delete function for list items
CREATE OR REPLACE FUNCTION soft_delete_list_item(
    item_id_param UUID,
    user_id_param UUID
)
RETURNS void AS $$
BEGIN
    UPDATE public.list_items
    SET
        is_deleted = TRUE,
        deleted_at = NOW(),
        deleted_by = user_id_param
    WHERE id = item_id_param;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- CLEANUP FUNCTIONS
-- ============================================================================

-- Permanently delete lists marked as deleted for 30+ days
CREATE OR REPLACE FUNCTION cleanup_deleted_lists()
RETURNS void AS $$
BEGIN
    -- Delete list items first (foreign key dependency)
    DELETE FROM public.list_items
    WHERE is_deleted = TRUE
    AND deleted_at < NOW() - INTERVAL '30 days';

    -- Then delete lists
    DELETE FROM public.lists
    WHERE is_deleted = TRUE
    AND deleted_at < NOW() - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- CHIT JAR HELPER FUNCTIONS
-- ============================================================================

-- Pick random unassigned item for Chit Jar mode
CREATE OR REPLACE FUNCTION pick_chit_jar_item(
    list_id_param UUID,
    user_id_param UUID
)
RETURNS UUID AS $$
DECLARE
    picked_item_id UUID;
BEGIN
    -- Get random unassigned, uncompleted, non-deleted item
    SELECT id INTO picked_item_id
    FROM public.list_items
    WHERE list_id = list_id_param
    AND assigned_to IS NULL
    AND is_completed = FALSE
    AND is_deleted = FALSE
    ORDER BY RANDOM()
    LIMIT 1;

    -- Assign it to the user
    IF picked_item_id IS NOT NULL THEN
        UPDATE public.list_items
        SET
            assigned_to = user_id_param,
            assigned_at = NOW()
        WHERE id = picked_item_id;

        -- Update list's turn tracking
        UPDATE public.lists
        SET
            last_pick_at = NOW(),
            current_turn_user_id = (
                -- Switch turn to partner
                SELECT CASE
                    WHEN user1_id = user_id_param THEN user2_id
                    ELSE user1_id
                END
                FROM public.pairs
                WHERE id = (SELECT pair_id FROM public.lists WHERE id = list_id_param)
            )
        WHERE id = list_id_param;
    END IF;

    RETURN picked_item_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- GRANT PERMISSIONS
-- ============================================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON public.lists TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.list_items TO authenticated;
GRANT EXECUTE ON FUNCTION soft_delete_list TO authenticated;
GRANT EXECUTE ON FUNCTION soft_delete_list_item TO authenticated;
GRANT EXECUTE ON FUNCTION pick_chit_jar_item TO authenticated;
