import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../models/list_item.dart';
import '../providers/lists_providers.dart';

class ListItemTile extends ConsumerWidget {
  final ListItem item;
  final String listId;
  final String currentUserId;
  final bool isChitJarMode;

  const ListItemTile({
    super.key,
    required this.item,
    required this.listId,
    required this.currentUserId,
    this.isChitJarMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAssignedToMe = item.assignedTo == currentUserId;
    final isAssignedToPartner = item.assignedTo != null && !isAssignedToMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: item.isCompleted ? 0 : 1,
        color: item.isCompleted
            ? CupcakeColors.textSecondary.withOpacity(0.05)
            : CupcakeColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isChitJarMode && isAssignedToMe
              ? BorderSide(color: CupcakeColors.accentLavender, width: 2)
              : BorderSide.none,
        ),
        child: ListTile(
          leading: Checkbox(
            value: item.isCompleted,
            onChanged: (_) => _toggleCompletion(ref),
            activeColor: CupcakeColors.accentPeach,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Text(
            item.title,
            style: CupcakeTypography.body.copyWith(
              decoration: item.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: item.isCompleted
                  ? CupcakeColors.textSecondary
                  : CupcakeColors.textPrimary,
            ),
          ),
          subtitle: item.description != null || isChitJarMode && item.assignedTo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.description!,
                        style: CupcakeTypography.bodySmall.copyWith(
                          color: CupcakeColors.textSecondary,
                          decoration: item.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                    if (isChitJarMode && item.assignedTo != null) ...[
                      const SizedBox(height: 8),
                      _buildAssignmentBadge(isAssignedToMe),
                    ],
                  ],
                )
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            iconSize: 20,
            color: CupcakeColors.textSecondary,
            onPressed: () => _showItemOptions(context, ref),
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentBadge(bool isAssignedToMe) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAssignedToMe
            ? CupcakeColors.accentLavender.withOpacity(0.1)
            : CupcakeColors.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAssignedToMe
              ? CupcakeColors.accentLavender.withOpacity(0.3)
              : CupcakeColors.textSecondary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAssignedToMe ? Icons.person : Icons.people,
            size: 14,
            color: isAssignedToMe
                ? CupcakeColors.accentLavender
                : CupcakeColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            isAssignedToMe ? 'Your task' : 'Partner\'s task',
            style: CupcakeTypography.bodySmall.copyWith(
              color: isAssignedToMe
                  ? CupcakeColors.accentLavender
                  : CupcakeColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleCompletion(WidgetRef ref) async {
    try {
      await ref.read(listItemUpdaterProvider.notifier).toggleItemCompletion(
            item.id,
            listId,
            currentUserId,
          );
    } catch (e) {
      // Error handling is done in the provider
    }
  }

  void _showItemOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CupcakeColors.cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete Item'),
              onTap: () async {
                Navigator.pop(context);
                await ref
                    .read(listItemDeleterProvider.notifier)
                    .deleteItem(item.id, listId, currentUserId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item deleted'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
