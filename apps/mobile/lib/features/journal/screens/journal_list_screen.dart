import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../providers/journal_providers.dart';
import '../providers/journal_context_providers.dart';
import '../models/journal_entry_local.dart';
import '../widgets/journal_entry_card.dart';
import 'journal_entry_screen.dart';

class JournalListScreen extends ConsumerStatefulWidget {
  const JournalListScreen({super.key});

  @override
  ConsumerState<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends ConsumerState<JournalListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use injected context providers for real Auth data
    final userId = ref.watch(journalContextUserIdProvider);
    final pairId = ref.watch(journalContextPairIdProvider);

    // Prevent database errors during initialization if IDs are not yet loaded
    if (userId.isEmpty || pairId.isEmpty) {
      return const Scaffold(
        backgroundColor: CupcakeColors.cream,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: CupcakeColors.cream,
      appBar: AppBar(
        title: const Text('Journal'),
        backgroundColor: CupcakeColors.cream,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: CupcakeColors.textPrimary,
          unselectedLabelColor: CupcakeColors.textSecondary,
          indicatorColor: CupcakeColors.accentLavender,
          tabs: const [
            Tab(text: 'Shared'),
            Tab(text: 'Private'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JournalEntryScreen(
                pairId: pairId,
                userId: userId,
              ),
            ),
          );
        },
        backgroundColor: CupcakeColors.accentLavender,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _JournalList(
            provider: sharedJournalEntriesProvider(pairId),
            emptyMessage: 'No shared moments yet.\nWrite something for your partner!',
          ),
          _JournalList(
            provider: privateJournalEntriesProvider(pairId, userId),
            emptyMessage: 'Your private space.\nThoughts here are just for you.',
          ),
        ],
      ),
    );
  }
}

class _JournalList extends ConsumerWidget {
  final ProviderListenable<List<JournalEntryLocal>> provider;
  final String emptyMessage;

  const _JournalList({
    required this.provider,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(provider);

    if (entries.isEmpty) {
      return Center(
        child: EmptyStateWidget(
          title: 'Empty Journal',
          description: emptyMessage,
          icon: Icons.book_outlined,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: JournalEntryCard(entry: entry),
        );
      },
    );
  }
}
