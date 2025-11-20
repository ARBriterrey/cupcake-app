import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_providers.dart';
import '../../../core/models/pair.dart';
import '../../../core/models/pair_invitation.dart';
import '../../../core/repositories/pair_repository.dart';

/// Provides the current user's pair (if they are paired)
final currentPairProvider = FutureProvider<Pair?>((ref) async {
  final pairRepository = ref.watch(pairRepositoryProvider);
  return await pairRepository.getCurrentPair();
});

/// Provides pending invitations for the current user
final pendingInvitationsProvider =
    FutureProvider<List<PairInvitation>>((ref) async {
  final pairRepository = ref.watch(pairRepositoryProvider);
  return await pairRepository.getPendingInvitations();
});

/// Provides sent invitations from the current user
final sentInvitationsProvider =
    FutureProvider<List<PairInvitation>>((ref) async {
  final pairRepository = ref.watch(pairRepositoryProvider);
  return await pairRepository.getSentInvitations();
});

/// Provides pairing service methods
final pairingServiceProvider = Provider<PairingService>((ref) {
  final pairRepository = ref.watch(pairRepositoryProvider);
  return PairingService(pairRepository, ref);
});

class PairingService {
  final PairRepository _pairRepository;
  final Ref _ref;

  PairingService(this._pairRepository, this._ref);

  Future<PairInvitation> sendInvitation({
    required String toUserEmail,
    String? message,
  }) async {
    final invitation = await _pairRepository.sendInvitation(
      toUserEmail: toUserEmail,
      message: message,
    );

    // Refresh sent invitations
    _ref.invalidate(sentInvitationsProvider);

    return invitation;
  }

  Future<Pair> acceptInvitation(String invitationId) async {
    final pair = await _pairRepository.acceptInvitation(invitationId);

    // Refresh all pairing-related providers
    _ref.invalidate(currentPairProvider);
    _ref.invalidate(pendingInvitationsProvider);

    return pair;
  }

  Future<void> rejectInvitation(String invitationId) async {
    await _pairRepository.rejectInvitation(invitationId);

    // Refresh pending invitations
    _ref.invalidate(pendingInvitationsProvider);
  }

  Future<void> cancelInvitation(String invitationId) async {
    await _pairRepository.cancelInvitation(invitationId);

    // Refresh sent invitations
    _ref.invalidate(sentInvitationsProvider);
  }

  Future<void> updatePairInfo({
    required String pairId,
    String? coupleName,
    DateTime? anniversaryDate,
    Map<String, dynamic>? sharedPreferences,
  }) async {
    await _pairRepository.updatePair(
      pairId: pairId,
      coupleName: coupleName,
      anniversaryDate: anniversaryDate,
      sharedPreferences: sharedPreferences,
    );

    // Refresh current pair
    _ref.invalidate(currentPairProvider);
  }
}
