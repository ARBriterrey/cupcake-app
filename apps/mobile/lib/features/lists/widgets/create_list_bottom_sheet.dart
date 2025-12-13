import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../models/collaborative_list.dart';
import '../providers/lists_providers.dart';
import '../../pairing/providers/pairing_providers.dart';

class CreateListBottomSheet extends ConsumerStatefulWidget {
  final String pairId;
  final String userId;

  const CreateListBottomSheet({
    super.key,
    required this.pairId,
    required this.userId,
  });

  @override
  ConsumerState<CreateListBottomSheet> createState() =>
      _CreateListBottomSheetState();
}

class _CreateListBottomSheetState extends ConsumerState<CreateListBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ListType _selectedType = ListType.standard;
  bool _isCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPair = ref.watch(currentPairProvider);

    return Container(
      decoration: const BoxDecoration(
        color: CupcakeColors.cream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Create New List',
                style: CupcakeTypography.h2,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: CupcakeColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Title field
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'List Name',
              hintText: 'e.g., Grocery List',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: CupcakeColors.accentPeach,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Description field
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              hintText: 'What\'s this list for?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: CupcakeColors.accentPeach,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // List type selector
          Text(
            'List Type',
            style: CupcakeTypography.h3,
          ),
          const SizedBox(height: 12),

          _buildListTypeOption(
            type: ListType.standard,
            icon: Icons.checklist,
            title: 'Standard',
            description: 'Basic shared checklist',
          ),
          const SizedBox(height: 8),

          _buildListTypeOption(
            type: ListType.chitJar,
            icon: Icons.casino,
            title: 'Chit Jar',
            description: 'Turn-based task picker game',
          ),
          const SizedBox(height: 8),

          _buildListTypeOption(
            type: ListType.shopping,
            icon: Icons.shopping_cart,
            title: 'Shopping',
            description: 'Shopping list variant',
          ),
          const SizedBox(height: 24),

          // Create button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isCreating ? null : _createList,
              style: ElevatedButton.styleFrom(
                backgroundColor: CupcakeColors.accentPeach,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isCreating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Create List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTypeOption({
    required ListType type,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedType == type;
    final currentPair = ref.watch(currentPairProvider);

    // Get partner ID for Chit Jar initialization
    String? partnerId;
    if (currentPair != null) {
      partnerId = currentPair.user1Id == widget.userId
          ? currentPair.user2Id
          : currentPair.user1Id;
    }

    return InkWell(
      onTap: () => setState(() => _selectedType = type),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? CupcakeColors.accentPeach.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? CupcakeColors.accentPeach
                : CupcakeColors.textSecondary.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? CupcakeColors.accentPeach
                  : CupcakeColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CupcakeTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? CupcakeColors.textPrimary
                          : CupcakeColors.textSecondary,
                    ),
                  ),
                  Text(
                    description,
                    style: CupcakeTypography.bodySmall.copyWith(
                      color: CupcakeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: CupcakeColors.accentPeach,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _createList() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a list name')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      final currentPair = ref.read(currentPairProvider);
      String? currentTurnUserId;

      // For Chit Jar mode, initialize with current user's turn
      if (_selectedType == ListType.chitJar) {
        currentTurnUserId = widget.userId;
      }

      await ref.read(listCreatorProvider.notifier).createList(
            pairId: widget.pairId,
            title: title,
            userId: widget.userId,
            listType: _selectedType,
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
            currentTurnUserId: currentTurnUserId,
          );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title created!'),
            backgroundColor: CupcakeColors.accentPeach,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create list: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }
}
