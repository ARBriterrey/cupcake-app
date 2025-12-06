import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/user_repository.dart';
import '../repositories/pair_repository.dart';
import '../repositories/calendar_local_repository.dart';

/// Provides the Supabase client instance
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provides the UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return UserRepository(supabase);
});

/// Provides the PairRepository
final pairRepositoryProvider = Provider<PairRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return PairRepository(supabase);
});

/// Provides the CalendarLocalRepository (offline-first storage)
/// Note: Hive box is opened in main.dart during app initialization
final calendarLocalRepositoryProvider = Provider<CalendarLocalRepository>((ref) {
  return CalendarLocalRepository();
});
