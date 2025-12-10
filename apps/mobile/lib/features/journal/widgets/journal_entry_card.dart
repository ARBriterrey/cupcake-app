import 'package:flutter/material.dart';
import 'package:cupcake_ui/ui.dart';
import 'package:cupcake_core/core.dart';
import 'package:intl/intl.dart';
import '../models/journal_entry_local.dart';
import '../screens/journal_entry_screen.dart';

class JournalEntryCard extends StatelessWidget {
  final JournalEntryLocal entry;

  const JournalEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Determine status color
    final isShared = entry.visibilityEnum == EventVisibility.shared;
    final statusColor = isShared ? CupcakeColors.accentLavender : CupcakeColors.textSecondary;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JournalEntryScreen(
              pairId: entry.pairId,
              userId: entry.createdBy ?? '', // Should handle null better in real app
              existingEntry: entry,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.title,
                    style: CupcakeTypography.heading4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isShared ? Icons.people_outline : Icons.lock_outline,
                  size: 16,
                  color: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.toJournalEntry().bodyPreview, // Using the logic from main model via conversion or duplicate logic
              style: CupcakeTypography.bodyMedium.copyWith(
                color: CupcakeColors.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(entry.createdAt),
                  style: CupcakeTypography.caption.copyWith(
                    color: CupcakeColors.textTertiary,
                  ),
                ),
                if (!entry.isSynced)
                  const Icon(
                    Icons.cloud_off,
                    size: 14,
                    color: CupcakeColors.textTertiary,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
