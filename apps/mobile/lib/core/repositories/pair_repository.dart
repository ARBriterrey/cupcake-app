import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pair.dart';
import '../models/pair_invitation.dart';

class PairRepository {
  final SupabaseClient _supabase;

  PairRepository(this._supabase);

  Future<Pair?> getCurrentPair() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      // Try to get active pair directly from pairs table
      // This works even if active_pair_id column doesn't exist yet
      final pairResponse = await _supabase
          .from('pairs')
          .select()
          .or('user1_id.eq.$userId,user2_id.eq.$userId')
          .eq('status', 'active')
          .maybeSingle();

      if (pairResponse == null) return null;

      return Pair.fromJson(pairResponse);
    } catch (e) {
      // If there's an error (like column doesn't exist), return null
      // User is simply not paired yet
      return null;
    }
  }

  Future<Pair> getPair(String pairId) async {
    final response = await _supabase
        .from('pairs')
        .select()
        .eq('id', pairId)
        .single();

    return Pair.fromJson(response);
  }

  Future<Pair> updatePair({
    required String pairId,
    String? coupleName,
    DateTime? anniversaryDate,
    Map<String, dynamic>? sharedPreferences,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (coupleName != null) updates['couple_name'] = coupleName;
    if (anniversaryDate != null) {
      updates['anniversary_date'] = anniversaryDate.toIso8601String();
    }
    if (sharedPreferences != null) {
      updates['shared_preferences'] = sharedPreferences;
    }

    final response = await _supabase
        .from('pairs')
        .update(updates)
        .eq('id', pairId)
        .select()
        .single();

    return Pair.fromJson(response);
  }

  Future<PairInvitation> sendInvitation({
    required String toUserEmail,
    String? message,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Check if the recipient already has an account - REQUIRED
    // Use RPC function to bypass RLS restrictions
    String? toUserId;
    try {
      final result = await _supabase
          .rpc('get_user_id_by_email', params: {'p_email': toUserEmail});

      if (result == null) {
        // User doesn't exist - throw error
        throw Exception('Your partner hasn\'t signed up yet. Ask them to create an account first!');
      }

      toUserId = result as String;
    } catch (e) {
      // If RPC function doesn't exist, show helpful error
      if (e.toString().contains('function') || e.toString().contains('does not exist')) {
        throw Exception('Database migration needed. Please run: supabase db push');
      }
      // Otherwise re-throw the original error
      rethrow;
    }

    // Check if trying to invite yourself
    if (toUserId == userId) {
      throw Exception('You cannot send an invitation to yourself!');
    }

    final response = await _supabase
        .from('pair_invitations')
        .insert({
          'from_user_id': userId,
          'to_user_email': toUserEmail,
          'to_user_id': toUserId,
          'status': InvitationStatus.pending.name,
          'message': message,
          'expires_at': DateTime.now()
              .add(const Duration(days: 7))
              .toIso8601String(),
        })
        .select()
        .single();

    return PairInvitation.fromJson(response);
  }

  Future<List<PairInvitation>> getPendingInvitations() async {
    final userEmail = _supabase.auth.currentUser?.email;
    if (userEmail == null) return [];

    final response = await _supabase
        .from('pair_invitations')
        .select('*, from_user:profiles!from_user_id(display_name)')
        .eq('to_user_email', userEmail)
        .eq('status', InvitationStatus.pending.name)
        .order('created_at', ascending: false);

    // Transform response to flatten the from_user object
    return (response as List).map((json) {
      final transformed = Map<String, dynamic>.from(json);
      // Extract display_name from nested from_user object
      if (json['from_user'] != null) {
        transformed['from_user_name'] = json['from_user']['display_name'];
      }
      return PairInvitation.fromJson(transformed);
    }).toList();
  }

  Future<List<PairInvitation>> getSentInvitations() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase
        .from('pair_invitations')
        .select()
        .eq('from_user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => PairInvitation.fromJson(json))
        .toList();
  }

  Future<Pair> acceptInvitation(String invitationId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Get the invitation
    final invitationResponse = await _supabase
        .from('pair_invitations')
        .select()
        .eq('id', invitationId)
        .single();

    final invitation = PairInvitation.fromJson(invitationResponse);

    if (invitation.status != InvitationStatus.pending) {
      throw Exception('Invitation is not pending');
    }

    // Create the pair
    // IMPORTANT: Current user must be user1_id to satisfy RLS policy
    final pairResponse = await _supabase
        .from('pairs')
        .insert({
          'user1_id': userId, // Current user (acceptor) is user1
          'user2_id': invitation.fromUserId, // Sender is user2
          'status': 'active', // Set pair as active immediately
        })
        .select()
        .single();

    final pair = Pair.fromJson(pairResponse);

    // Update invitation status (updated_at is auto-updated by trigger)
    await _supabase
        .from('pair_invitations')
        .update({
          'status': InvitationStatus.accepted.name,
          'to_user_id': userId,
        })
        .eq('id', invitationId);

    // Update both users' active_pair_id
    await _supabase
        .from('profiles')
        .update({'active_pair_id': pair.id})
        .inFilter('id', [invitation.fromUserId, userId]);

    return pair;
  }

  Future<void> rejectInvitation(String invitationId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // updated_at is auto-updated by trigger
    await _supabase
        .from('pair_invitations')
        .update({
          'status': InvitationStatus.rejected.name,
          'to_user_id': userId,
        })
        .eq('id', invitationId);
  }

  Future<void> cancelInvitation(String invitationId) async {
    await _supabase
        .from('pair_invitations')
        .delete()
        .eq('id', invitationId);
  }
}
