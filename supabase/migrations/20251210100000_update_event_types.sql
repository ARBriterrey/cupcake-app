-- Migration: Update event types to reflect addon categories
-- Date: 2025-12-10
-- Description: Updates event_type enum from generic types to addon-aligned categories

-- Step 1: Drop the old CHECK constraint
ALTER TABLE calendar_events
DROP CONSTRAINT IF EXISTS calendar_events_event_type_check;

-- Step 2: Migrate existing data to new event types
UPDATE calendar_events
SET event_type = CASE event_type
  WHEN 'moment' THEN 'reflections'
  WHEN 'date' THEN 'annuals'
  WHEN 'appointment' THEN 'reminders'
  WHEN 'reminder' THEN 'reminders'
  WHEN 'anniversary' THEN 'annuals'
  WHEN 'other' THEN 'others'
  ELSE 'others'  -- Fallback for any unexpected values
END;

-- Step 3: Add new CHECK constraint with the 7 new event types
ALTER TABLE calendar_events
ADD CONSTRAINT calendar_events_event_type_check
CHECK (event_type IN ('wellness', 'reflections', 'habits', 'games', 'annuals', 'reminders', 'others'));

-- Step 4: Update the default value for event_type
ALTER TABLE calendar_events
ALTER COLUMN event_type SET DEFAULT 'reminders';

-- Add comment to document the change
COMMENT ON COLUMN calendar_events.event_type IS 'Event type aligned with addon categories: wellness, reflections, habits, games, annuals, reminders, others';
