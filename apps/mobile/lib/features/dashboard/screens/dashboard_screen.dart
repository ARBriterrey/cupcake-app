import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../widgets/couple_status_card.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/sprinkles_overview_card.dart';
import '../widgets/user_profile_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProfileProvider);
    final currentPairAsync = ref.watch(currentPairProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupcake'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if (context.mounted) {
                context.go('/sign-in');
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentUserProfileProvider);
          ref.invalidate(currentPairProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Couple Status Card
              currentPairAsync.when(
                data: (pair) {
                  if (pair == null) {
                    // User is no longer paired, redirect to pairing
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/pairing');
                    });
                    return const SizedBox.shrink();
                  }

                  return CoupleStatusCard(pair: pair);
                },
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (error, stack) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Error: $error'),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              const QuickActionsSection(),
              const SizedBox(height: 24),

              // Sprinkles Section
              Text(
                'Your Sprinkles',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const SprinklesOverviewCard(),
              const SizedBox(height: 24),

              // User Profile Card
              currentUserAsync.when(
                data: (profile) {
                  if (profile == null) return const SizedBox.shrink();
                  return UserProfileCard(profile: profile);
                },
                loading: () => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (error, stack) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
