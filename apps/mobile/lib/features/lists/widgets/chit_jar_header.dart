import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../models/collaborative_list.dart';
import '../providers/lists_providers.dart';

class ChitJarHeader extends ConsumerWidget {
  final CollaborativeList list;
  final String currentUserId;
  final String pairId;

  const ChitJarHeader({
    super.key,
    required this.list,
    required this.currentUserId,
    required this.pairId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMyTurn = list.currentTurnUserId == currentUserId;
    final unassignedCountAsync = ref.watch(unassignedItemsCountProvider(list.id));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMyTurn
            ? CupcakeColors.accentLavender.withOpacity(0.1)
            : CupcakeColors.textSecondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMyTurn
              ? CupcakeColors.accentLavender.withOpacity(0.3)
              : CupcakeColors.textSecondary.withOpacity(0.1),
          width: isMyTurn ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.casino,
                color: isMyTurn
                    ? CupcakeColors.accentLavender
                    : CupcakeColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isMyTurn ? 'Your turn to pick!' : 'Partner\'s turn',
                  style: CupcakeTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isMyTurn
                        ? CupcakeColors.accentLavender
                        : CupcakeColors.textSecondary,
                  ),
                ),
              ),
              unassignedCountAsync.when(
                data: (count) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: CupcakeColors.accentPeach,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$count left',
                    style: CupcakeTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          if (isMyTurn) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _pickRandomItem(context, ref),
                icon: const Icon(Icons.casino, size: 20),
                label: const Text('Pick for me'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CupcakeColors.accentLavender,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickRandomItem(BuildContext context, WidgetRef ref) async {
    try {
      final pickedItemId = await ref
          .read(chitJarPickerProvider.notifier)
          .pickRandomItem(list.id, pairId, currentUserId);

      if (pickedItemId == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No unassigned items available'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      if (context.mounted) {
        // Show celebration animation
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _PickCelebrationDialog(
            onDismiss: () => Navigator.pop(context),
          ),
        );

        // Auto-dismiss after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _PickCelebrationDialog extends StatelessWidget {
  final VoidCallback onDismiss;

  const _PickCelebrationDialog({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: CupcakeColors.cream,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    Icons.casino,
                    size: 64,
                    color: CupcakeColors.accentLavender,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Task Picked!',
              style: CupcakeTypography.h2.copyWith(
                color: CupcakeColors.accentLavender,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check your list below',
              style: CupcakeTypography.body.copyWith(
                color: CupcakeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
