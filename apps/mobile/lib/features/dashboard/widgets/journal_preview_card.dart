import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cupcake_ui/ui.dart';
import 'package:intl/intl.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../../journal/providers/journal_providers.dart';

class JournalPreviewCard extends ConsumerWidget {
  const JournalPreviewCard({super.key});

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
        final entriesAsync = ref.watch(journalEntriesProvider(pairId));

        return _buildCard(context, entriesAsync);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildCard(BuildContext context, dynamic entriesAsync) {

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
                  Icons.book,
                  color: CupcakeColors.accentPeach,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Journal',
                  style: CupcakeTypography.h3.copyWith(
                    color: CupcakeColors.textPrimary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/journal'),
                  child: Text(
                    'View All',
                    style: TextStyle(color: CupcakeColors.accentPeach),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Recent entries
            entriesAsync.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return _buildEmptyState(context);
                }

                // Show up to 3 recent entries
                final recentEntries = entries.take(3).toList();

                return Column(
                  children: recentEntries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupcakeColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Visibility icon
                            Icon(
                              entry.visibility == 'shared'
                                  ? Icons.people
                                  : Icons.lock,
                              size: 16,
                              color: entry.visibility == 'shared'
                                  ? CupcakeColors.accentLavender
                                  : CupcakeColors.textSecondary,
                            ),
                            const SizedBox(width: 12),

                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.title,
                                    style: CupcakeTypography.body.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    DateFormat('MMM d, h:mm a')
                                        .format(entry.createdAt),
                                    style: CupcakeTypography.bodySmall.copyWith(
                                      color: CupcakeColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.book_outlined,
          size: 48,
          color: CupcakeColors.textSecondary.withOpacity(0.5),
        ),
        const SizedBox(height: 12),
        Text(
          'No entries yet',
          style: CupcakeTypography.body.copyWith(
            color: CupcakeColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => context.push('/journal'),
          icon: const Icon(Icons.add),
          label: const Text('Start Writing Together'),
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
        'Could not load entries',
        style: CupcakeTypography.bodySmall.copyWith(
          color: CupcakeColors.textSecondary,
        ),
      ),
    );
  }
}
