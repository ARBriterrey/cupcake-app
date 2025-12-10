import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import 'package:cupcake_core/core.dart';
import '../models/journal_entry_local.dart';
import '../providers/journal_providers.dart';
import '../widgets/visibility_toggle.dart';

class JournalEntryScreen extends ConsumerStatefulWidget {
  final String pairId;
  final String userId;
  final JournalEntryLocal? existingEntry;

  const JournalEntryScreen({
    super.key,
    required this.pairId,
    required this.userId,
    this.existingEntry,
  });

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late EventVisibility _visibility;
  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.existingEntry != null;
    _titleController = TextEditingController(text: widget.existingEntry?.title ?? '');
    _bodyController = TextEditingController(text: widget.existingEntry?.body ?? '');
    _visibility = widget.existingEntry?.visibilityEnum ?? EventVisibility.private;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isEditing) {
        final entry = widget.existingEntry!;
        entry.title = _titleController.text.trim();
        entry.body = _bodyController.text.trim();
        entry.visibility = _visibility.name;
        
        // Handling visibility change logic could be more complex (e.g. prompt user), 
        // but for now simple update
        if (_visibility == EventVisibility.shared && widget.existingEntry!.visibility == 'private') {
           // If switching to shared, might want to set visibleToUserId logic if needed,
           // depending on how we define "shared" (shared with pair vs specific user).
           // Simplify: Shared = visible to pair.
        }

        await ref.read(journalEntryUpdaterProvider.notifier).updateEntry(entry);
      } else {
        await ref.read(journalEntryCreatorProvider.notifier).createEntry(
          pairId: widget.pairId,
          userId: widget.userId,
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
          visibility: _visibility,
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry?'),
        content: const Text('This cannot be undone.'),
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

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(journalEntryDeleterProvider.notifier).deleteEntry(
        widget.existingEntry!.id,
        widget.pairId,
        widget.existingEntry!.calendarEventId,
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: CupcakeColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: _isLoading ? null : _delete,
            ),
          const SizedBox(width: 8),
          Padding(
             padding: const EdgeInsets.only(right: 16),
             child: Center(
               child: _isLoading 
                 ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                 : PrimaryButton(
                     label: 'Save',
                     onPressed: _save,
                     compact: true,
                   ),
             ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _titleController,
              style: CupcakeTypography.heading2,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(color: CupcakeColors.textTertiary),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Title required' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            VisibilityToggle(
              value: _visibility,
              onChanged: (v) => setState(() => _visibility = v),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _bodyController,
              style: CupcakeTypography.bodyLarge.copyWith(height: 1.6),
              decoration: const InputDecoration(
                hintText: 'What\'s on your mind?',
                border: InputBorder.none,
                hintStyle: TextStyle(color: CupcakeColors.textTertiary),
              ),
              maxLines: null, // Expands
              validator: (v) => v == null || v.isEmpty ? 'Content required' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
    );
  }
}
