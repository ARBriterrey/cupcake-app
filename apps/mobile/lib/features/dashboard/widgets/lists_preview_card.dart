import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cupcake_ui/ui.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../../lists/providers/lists_providers.dart';
import '../../lists/models/collaborative_list.dart';

class ListsPreviewCard extends ConsumerWidget {
  const ListsPreviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentPairAsync = ref.watch(currentPairProvider);

    return currentPairAsync.when(
      data: (pair) {
        if (currentUser == null || pair == null) {
          return const SizedBox.shrink();
        }

        final pairId = pair.id;
        final listsAsync = ref.watch(listsForPairProvider(pairId));

        return _buildCard(context, ref, listsAsync);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildCard(BuildContext context, WidgetRef ref, dynamic listsAsync) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  Icons.checklist,
                  color: CupcakeColors.accentPeach,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Lists',
                  style: CupcakeTypography.h3.copyWith(
                    color: CupcakeColors.textPrimary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/lists'),
                  child: Text(
                    'View All',
                    style: TextStyle(color: CupcakeColors.accentPeach),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Recent lists
            listsAsync.when(
              data: (lists) {
                if (lists.isEmpty) {
                  return _buildEmptyState(context);
                }

                // Show up to 3 recent lists
                final recentLists = lists.take(3).toList();

                return Column(
                  children: recentLists.map((list) {
                    return _buildListPreview(context, ref, list);
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => _buildErrorState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListPreview(
    BuildContext context,
    WidgetRef ref,
    CollaborativeList list,
  ) {
    final incompleteCount = ref.watch(incompleteItemsCountProvider(list.id));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/lists/${list.id}', extra: list),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupcakeColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getListTypeColor(list.listType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getListTypeIcon(list.listType),
                  size: 16,
                  color: _getListTypeColor(list.listType),
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list.title,
                      style: CupcakeTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (list.listType == ListType.chitJar) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Chit Jar',
                        style: CupcakeTypography.bodySmall.copyWith(
                          color: CupcakeColors.accentLavender,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Incomplete count badge
              if (incompleteCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: CupcakeColors.accentPeach,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$incompleteCount',
                    style: CupcakeTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: CupcakeColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.checklist,
          size: 48,
          color: CupcakeColors.textSecondary.withOpacity(0.5),
        ),
        const SizedBox(height: 12),
        Text(
          'No lists yet',
          style: CupcakeTypography.body.copyWith(
            color: CupcakeColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => context.push('/lists'),
          icon: const Icon(Icons.add),
          label: const Text('Create Your First List'),
          style: TextButton.styleFrom(
            foregroundColor: CupcakeColors.accentPeach,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Text(
        'Could not load lists',
        style: CupcakeTypography.bodySmall.copyWith(
          color: CupcakeColors.textSecondary,
        ),
      ),
    );
  }

  IconData _getListTypeIcon(ListType type) {
    switch (type) {
      case ListType.chitJar:
        return Icons.casino;
      case ListType.shopping:
        return Icons.shopping_cart;
      default:
        return Icons.checklist;
    }
  }

  Color _getListTypeColor(ListType type) {
    switch (type) {
      case ListType.chitJar:
        return CupcakeColors.accentLavender;
      case ListType.shopping:
        return CupcakeColors.accentBlue;
      default:
        return CupcakeColors.accentPeach;
    }
  }
}
