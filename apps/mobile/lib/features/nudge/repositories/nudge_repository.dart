import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/nudge.dart';

class NudgeRepository {
  final SupabaseClient _supabase;

  NudgeRepository(this._supabase);

  /// Send a nudge to partner
  Future<Nudge> sendNudge({
    required String pairId,
    required String senderId,
    required String receiverId,
    String nudgeType = 'thinking_of_you',
  }) async {
    final response = await _supabase.from('nudges').insert({
      'pair_id': pairId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'nudge_type': nudgeType,
    }).select().single();

    return Nudge.fromJson(response);
  }

  /// Mark nudge as viewed
  Future<void> markAsViewed(String nudgeId) async {
    await _supabase.from('nudges').update({
      'viewed_at': DateTime.now().toIso8601String(),
    }).eq('id', nudgeId);
  }

  /// Get unviewed nudges for a user
  Future<List<Nudge>> getUnviewedNudges(String userId) async {
    final response = await _supabase
        .from('nudges')
        .select()
        .eq('receiver_id', userId)
        .is_('viewed_at', null)
        .gt('expires_at', DateTime.now().toIso8601String())
        .order('created_at', ascending: false);

    return (response as List).map((json) => Nudge.fromJson(json)).toList();
  }

  /// Get recent nudges for a pair (for history)
  Future<List<Nudge>> getRecentNudges(String pairId, {int limit = 10}) async {
    final response = await _supabase
        .from('nudges')
        .select()
        .eq('pair_id', pairId)
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List).map((json) => Nudge.fromJson(json)).toList();
  }

  /// Stream of unviewed nudges (real-time)
  Stream<List<Nudge>> watchUnviewedNudges(String userId) {
    return _supabase
        .from('nudges')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', userId)
        .order('created_at', ascending: false)
        .map((data) => data
            .where((json) =>
                json['viewed_at'] == null &&
                DateTime.parse(json['expires_at']).isAfter(DateTime.now()))
            .map((json) => Nudge.fromJson(json))
            .toList());
  }
}
