import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import '../models/nudge.dart';
import '../models/nudge_local.dart';
import '../repositories/nudge_repository.dart';
import '../repositories/nudge_local_repository.dart';

part 'nudge_providers.g.dart';

// --- Repositories ---

@riverpod
NudgeRepository nudgeRepository(NudgeRepositoryRef ref) {
  return NudgeRepository(Supabase.instance.client);
}

@riverpod
NudgeLocalRepository nudgeLocalRepository(NudgeLocalRepositoryRef ref) {
  if (!Hive.isBoxOpen('nudges')) {
    throw Exception('Hive box "nudges" is not open');
  }
  final box = Hive.box<NudgeLocal>('nudges');
  return NudgeLocalRepository(box);
}

// --- Queries ---

/// Stream of unviewed nudges for current user (real-time)
@riverpod
Stream<List<Nudge>> unviewedNudges(UnviewedNudgesRef ref, String userId) {
  final repo = ref.watch(nudgeRepositoryProvider);
  return repo.watchUnviewedNudges(userId);
}

/// Get recent nudges from local storage
@riverpod
List<NudgeLocal> recentNudgesLocal(RecentNudgesLocalRef ref, String pairId) {
  final repo = ref.watch(nudgeLocalRepositoryProvider);
  return repo.getRecentNudges(pairId, limit: 5);
}

/// Get unviewed nudges count
@riverpod
int unviewedNudgesCount(UnviewedNudgesCountRef ref, String userId) {
  final unviewedAsync = ref.watch(unviewedNudgesProvider(userId));
  return unviewedAsync.when(
    data: (nudges) => nudges.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
}

// --- Actions ---

@riverpod
class NudgeSender extends _$NudgeSender {
  @override
  FutureOr<void> build() {}

  Future<Nudge> sendNudge({
    required String pairId,
    required String senderId,
    required String receiverId,
    String nudgeType = 'thinking_of_you',
  }) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(nudgeRepositoryProvider);
      final localRepo = ref.read(nudgeLocalRepositoryProvider);

      // 1. Send to cloud
      final nudge = await cloudRepo.sendNudge(
        pairId: pairId,
        senderId: senderId,
        receiverId: receiverId,
        nudgeType: nudgeType,
      );

      // 2. Save to local storage
      final localNudge = NudgeLocal.fromNudge(nudge);
      await localRepo.saveNudge(localNudge);

      // 3. Invalidate queries
      ref.invalidate(unviewedNudgesProvider(receiverId));
      ref.invalidate(recentNudgesLocalProvider(pairId));

      state = const AsyncValue.data(null);
      return nudge;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class NudgeViewer extends _$NudgeViewer {
  @override
  FutureOr<void> build() {}

  Future<void> markAsViewed(String nudgeId, String userId, String pairId) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(nudgeRepositoryProvider);
      final localRepo = ref.read(nudgeLocalRepositoryProvider);

      // 1. Update cloud
      await cloudRepo.markAsViewed(nudgeId);

      // 2. Update local
      await localRepo.markAsViewed(nudgeId);

      // 3. Invalidate queries
      ref.invalidate(unviewedNudgesProvider(userId));
      ref.invalidate(recentNudgesLocalProvider(pairId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
