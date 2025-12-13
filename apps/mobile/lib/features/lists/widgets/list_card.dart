import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../models/collaborative_list.dart';
import '../providers/lists_providers.dart';

class ListCard extends ConsumerWidget {
  final CollaborativeList list;
  final VoidCallback onTap;

  const ListCard({
    super.key,
    required this.list,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incompleteCount = ref.watch(incompleteItemsCountProvider(list.id));

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: CupcakeColors.cream,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getListTypeColor(list.listType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getListTypeIcon(list.listType),
                  color: _getListTypeColor(list.listType),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list.title,
                      style: CupcakeTypography.h3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (list.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        list.description!,
                        style: CupcakeTypography.bodySmall.copyWith(
                          color: CupcakeColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (list.listType == ListType.chitJar) ...[
                      const SizedBox(height: 8),
                      _buildChitJarBadge(),
                    ],
                  ],
                ),
              ),

              // Incomplete count badge
              if (incompleteCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
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
                color: CupcakeColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChitJarBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupcakeColors.accentLavender.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupcakeColors.accentLavender.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.casino,
            size: 14,
            color: CupcakeColors.accentLavender,
          ),
          const SizedBox(width: 4),
          Text(
            'Chit Jar',
            style: CupcakeTypography.bodySmall.copyWith(
              color: CupcakeColors.accentLavender,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
