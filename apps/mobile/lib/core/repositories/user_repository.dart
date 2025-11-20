import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class UserRepository {
  final SupabaseClient _supabase;

  UserRepository(this._supabase);

  Future<UserProfile?> getCurrentUserProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return UserProfile.fromJson(response);
  }

  Future<UserProfile> getUserProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return UserProfile.fromJson(response);
  }

  Future<UserProfile> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? timezone,
    Map<String, dynamic>? preferences,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (displayName != null) updates['display_name'] = displayName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (timezone != null) updates['timezone'] = timezone;
    if (preferences != null) updates['preferences'] = preferences;

    final response = await _supabase
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  Future<void> deleteProfile(String userId) async {
    await _supabase.from('profiles').delete().eq('id', userId);
  }
}
