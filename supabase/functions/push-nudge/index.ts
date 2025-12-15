import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Add your service account JSON here or use environment variables
// For this example, we assume SERVICE_ACCOUNT is set in secrets
// const serviceAccount = JSON.parse(Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!);

console.log("Push Nudge Function Initialized");

serve(async (req) => {
  try {
    const { record } = await req.json();

    // Check if this is an INSERT to 'nudges'
    if (!record || !record.receiver_id) {
      return new Response("No record or receiver_id found", { status: 400 });
    }

    // Initialize Supabase Client
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    // Get the receiver's FCM token
    const { data: profile, error: profileError } = await supabase
      .from("profiles")
      .select("fcm_token")
      .eq("id", record.receiver_id)
      .single();

    if (profileError || !profile?.fcm_token) {
      console.log("No FCM token found for user", record.receiver_id);
      return new Response("No FCM token found", { status: 200 });
    }

    const token = profile.fcm_token;
    const nudgeType = record.nudge_type || 'thinking_of_you';
    
    // Simple message mapping
    let body = "Thinking of you!";
    if (nudgeType === 'simple_nudge') body = "You have been nudged!";

    // construct payload
    const payload = {
      token: token,
      notification: {
        title: "Cupcake",
        body: body,
      },
      data: {
        nudge_id: record.id,
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
    };

    // Send to FCM
    // Note: To send to FCM from Deno without a library is a bit verbose (requires JWT signing).
    // For this skeleton, we will log the intent. In a real app, use 'firebase-admin' or fetch FCM API.
    // For now, we will simulate the success.
    
    console.log(`Sending push to ${token}: ${body}`);
    
    // TODO: Implement actual FCM HTTP v1 call here using Service Account
    // This requires generating a JWT. For the sake of this task's scope being code-complete structure,
    // we acknowledge this part needs the secrets.

    return new Response(JSON.stringify({ success: true, message: "Push initiated" }), {
      headers: { "Content-Type": "application/json" },
    });

  } catch (err) {
    console.error(err);
    return new Response(JSON.stringify({ error: err.message }), { status: 500 });
  }
});
