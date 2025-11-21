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

    final response = await _supabase
        .from('pair_invitations')
        .insert({
          'from_user_id': userId,
          'to_user_email': toUserEmail,
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
        .select()
        .eq('to_user_email', userEmail)
        .eq('status', InvitationStatus.pending.name)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => PairInvitation.fromJson(json))
        .toList();
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
    final pairResponse = await _supabase
        .from('pairs')
        .insert({
          'user1_id': invitation.fromUserId,
          'user2_id': userId,
        })
        .select()
        .single();

    final pair = Pair.fromJson(pairResponse);

    // Update invitation status
    await _supabase
        .from('pair_invitations')
        .update({
          'status': InvitationStatus.accepted.name,
          'to_user_id': userId,
          'updated_at': DateTime.now().toIso8601String(),
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

    await _supabase
        .from('pair_invitations')
        .update({
          'status': InvitationStatus.rejected.name,
          'to_user_id': userId,
          'updated_at': DateTime.now().toIso8601String(),
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
