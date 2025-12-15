import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import 'package:intl/intl.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../providers/nudge_providers.dart';

class NudgeCard extends ConsumerWidget {
  const NudgeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentPair = ref.watch(currentPairProvider).value;

    if (currentUser == null || currentPair == null) {
      return const SizedBox.shrink();
    }

    final userId = currentUser.id;
    final pairId = currentPair.id;

    // Get partner ID
    final partnerId = currentPair.user1Id == userId
        ? currentPair.user2Id
        : currentPair.user1Id;

    final unviewedNudgesAsync = ref.watch(unviewedNudgesProvider(userId));

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: CupcakeColors.cream,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: CupcakeColors.accentLavender,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Nudges',
                  style: CupcakeTypography.h3.copyWith(
                    color: CupcakeColors.textPrimary,
                  ),
                ),
                const Spacer(),
                // Unviewed count badge
                unviewedNudgesAsync.when(
                  data: (nudges) {
                    if (nudges.isEmpty) return const SizedBox.shrink();
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: CupcakeColors.accentLavender,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${nudges.length}',
                        style: CupcakeTypography.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Received nudges
            unviewedNudgesAsync.when(
              data: (nudges) {
                if (nudges.isEmpty) {
                  return Text(
                    'No new nudges',
                    style: CupcakeTypography.body.copyWith(
                      color: CupcakeColors.textSecondary,
                    ),
                  );
                }

                final latestNudge = nudges.first;
                final timeAgo = _getTimeAgo(latestNudge.createdAt);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupcakeColors.accentLavender.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getNudgeIcon(latestNudge.nudgeType),
                            color: CupcakeColors.accentLavender,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getNudgeMessage(latestNudge.nudgeType),
                                  style: CupcakeTypography.body.copyWith(
                                    color: CupcakeColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  timeAgo,
                                  style: CupcakeTypography.bodySmall.copyWith(
                                    color: CupcakeColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.check_circle_outline),
                            color: CupcakeColors.accentLavender,
                            onPressed: () {
                              ref
                                  .read(nudgeViewerProvider.notifier)
                                  .markAsViewed(latestNudge.id, userId, pairId);
                            },
                          ),
                        ],
                      ),
                    ),
                    if (nudges.length > 1) ...[
                      const SizedBox(height: 8),
                      Text(
                        '+ ${nudges.length - 1} more',
                        style: CupcakeTypography.bodySmall.copyWith(
                          color: CupcakeColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Text(
                'Could not load nudges',
                style: CupcakeTypography.body.copyWith(
                  color: CupcakeColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Send nudge button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(nudgeSenderProvider.notifier).sendNudge(
                        pairId: pairId,
                        senderId: userId,
                        receiverId: partnerId,
                        nudgeType: 'simple_nudge',
                      );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Nudge sent!'),
                        backgroundColor: CupcakeColors.accentLavender,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CupcakeColors.accentLavender,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Send Nudge'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }

  IconData _getNudgeIcon(String nudgeType) {
    return Icons.favorite;
  }

  String _getNudgeMessage(String nudgeType) {
    return 'You have been nudged!';
  }
}
