import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cupcake_ui/ui.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../providers/lists_providers.dart';
import '../models/collaborative_list.dart'; // Added import
import '../widgets/list_card.dart';
import '../widgets/create_list_bottom_sheet.dart';

class ListsOverviewScreen extends ConsumerWidget {
  const ListsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentPair = ref.watch(currentPairProvider).value;

    if (currentUser == null || currentPair == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lists'),
        ),
        body: const Center(
          child: Text('Please sign in to view lists'),
        ),
      );
    }

    final pairId = currentPair.id;
    // Explicitly typed to avoid dynamic inference issues
    final AsyncValue<List<CollaborativeList>> listsAsync = ref.watch(listsForPairProvider(pairId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
        backgroundColor: CupcakeColors.cream,
        foregroundColor: CupcakeColors.textPrimary,
        elevation: 0,
      ),
      backgroundColor: CupcakeColors.backgroundLight,
      body: listsAsync.when(
        data: (lists) {
          if (lists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist,
                    size: 64,
                    color: CupcakeColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No lists yet',
                    style: CupcakeTypography.h3.copyWith(
                      color: CupcakeColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your first shared list to get started',
                    style: CupcakeTypography.body.copyWith(
                      color: CupcakeColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _showCreateListSheet(context, ref, pairId, currentUser.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CupcakeColors.accentPeach,
                    ),
                    child: const Text('Create List'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lists.length,
            itemBuilder: (context, index) {
              final list = lists[index];
              return ListCard(
                list: list,
                onTap: () {
                  context.push('/lists/${list.id}', extra: list);
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: CupcakeColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'Could not load lists',
                style: CupcakeTypography.h3,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: CupcakeTypography.bodySmall.copyWith(
                  color: CupcakeColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateListSheet(context, ref, pairId, currentUser.id),
        backgroundColor: CupcakeColors.accentPeach,
        icon: const Icon(Icons.add),
        label: const Text('New List'),
      ),
    );
  }

  void _showCreateListSheet(
    BuildContext context,
    WidgetRef ref,
    String pairId,
    String userId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateListBottomSheet(
        pairId: pairId,
        userId: userId,
      ),
    );
  }
}

