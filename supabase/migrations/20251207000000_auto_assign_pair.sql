-- Create a function that will be called by the trigger
CREATE OR REPLACE FUNCTION public.handle_new_pair()
RETURNS TRIGGER AS $$
BEGIN
  -- Only proceed if the pair status is 'active'
  IF NEW.status = 'active' THEN
    -- Update User 1's profile
    UPDATE public.profiles
    SET active_pair_id = NEW.id,
        updated_at = NOW()
    WHERE id = NEW.user1_id;

    -- Update User 2's profile
    UPDATE public.profiles
    SET active_pair_id = NEW.id,
        updated_at = NOW()
    WHERE id = NEW.user2_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create the trigger
CREATE OR REPLACE TRIGGER on_pair_created
  AFTER INSERT OR UPDATE OF status ON public.pairs
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_pair();
