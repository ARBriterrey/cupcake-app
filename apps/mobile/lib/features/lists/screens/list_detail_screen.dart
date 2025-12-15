import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../models/collaborative_list.dart';
import '../models/list_item.dart'; // Added import
import '../providers/lists_providers.dart';
import '../widgets/list_item_tile.dart';
import '../widgets/chit_jar_header.dart';

class ListDetailScreen extends ConsumerStatefulWidget {
  final String listId;
  final CollaborativeList? initialList;

  const ListDetailScreen({
    super.key,
    required this.listId,
    this.initialList,
  });

  @override
  ConsumerState<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends ConsumerState<ListDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isAddingItem = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final currentPair = ref.watch(currentPairProvider).value;

    if (currentUser == null || currentPair == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('List')),
        body: const Center(child: Text('Please sign in')),
      );
    }

    final AsyncValue<CollaborativeList?> listAsync = ref.watch(listByIdProvider(widget.listId));
    final AsyncValue<List<ListItem>> itemsAsync = ref.watch(itemsForListProvider(widget.listId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
        backgroundColor: CupcakeColors.cream,
        foregroundColor: CupcakeColors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showListOptions(context, currentUser.id, currentPair.id),
          ),
        ],
      ),
      backgroundColor: CupcakeColors.backgroundLight,
      body: listAsync.when(
        data: (list) {
          if (list == null) {
            return const Center(child: Text('List not found'));
          }

          final isChitJar = list.listType == ListType.chitJar;

          return Column(
            children: [
              // Header with list info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CupcakeColors.cream,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getListTypeIcon(list.listType),
                          color: CupcakeColors.accentPeach,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            list.title,
                            style: CupcakeTypography.h2,
                          ),
                        ),
                      ],
                    ),
                    if (list.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        list.description!,
                        style: CupcakeTypography.body.copyWith(
                          color: CupcakeColors.textSecondary,
                        ),
                      ),
                    ],
                    if (isChitJar) ...[
                      const SizedBox(height: 16),
                      ChitJarHeader(
                        list: list,
                        currentUserId: currentUser.id,
                        pairId: currentPair.id,
                      ),
                    ],
                  ],
                ),
              ),

              // Items list
              Expanded(
                child: itemsAsync.when(
                  data: (items) {
                    final activeItems = items.where((i) => !i.isDeleted).toList();

                    if (activeItems.isEmpty) {
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
                              'No items yet',
                              style: CupcakeTypography.h3.copyWith(
                                color: CupcakeColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add your first item to get started',
                              style: CupcakeTypography.body.copyWith(
                                color: CupcakeColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: activeItems.length,
                      itemBuilder: (context, index) {
                        final item = activeItems[index];
                        return ListItemTile(
                          item: item,
                          listId: widget.listId,
                          currentUserId: currentUser.id,
                          isChitJarMode: isChitJar,
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, _) => Center(
                    child: Text('Error: $error'),
                  ),
                ),
              ),

              // Add item section
              if (_isAddingItem) _buildAddItemForm(currentUser.id),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: !_isAddingItem
          ? FloatingActionButton(
              onPressed: () => setState(() => _isAddingItem = true),
              backgroundColor: CupcakeColors.accentPeach,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildAddItemForm(String userId) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: CupcakeColors.cream,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _titleController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Add an item...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CupcakeColors.textSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CupcakeColors.accentPeach),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _addItem(userId),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _addItem(userId),
            icon: const Icon(Icons.send),
            color: CupcakeColors.accentPeach,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isAddingItem = false;
                _titleController.clear();
              });
            },
            icon: const Icon(Icons.close),
            color: CupcakeColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Future<void> _addItem(String userId) async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    try {
      await ref.read(listItemCreatorProvider.notifier).createItem(
            listId: widget.listId,
            title: title,
            userId: userId,
          );

      _titleController.clear();
      setState(() => _isAddingItem = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showListOptions(BuildContext context, String userId, String pairId) {
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
              title: const Text('Delete List'),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await _showDeleteConfirmation(context);
                if (confirmed == true && mounted) {
                  await ref
                      .read(listDeleterProvider.notifier)
                      .deleteList(widget.listId, pairId, userId);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete List?'),
        content: const Text(
          'This will delete the list and all its items. This action can be undone within 30 days.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
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
}
