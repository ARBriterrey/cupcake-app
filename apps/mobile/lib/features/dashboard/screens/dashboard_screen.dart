import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_providers.dart';
import '../../pairing/providers/pairing_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/couple_status_card.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/sprinkles_overview_card.dart';
import '../widgets/user_profile_card.dart';
import '../widgets/upcoming_events_card.dart';

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
          // User Avatar Bubble (Opens End Drawer)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppTheme.primaryPeach,
                    backgroundImage: currentUserAsync.value?.avatarUrl != null
                        ? NetworkImage(currentUserAsync.value!.avatarUrl!)
                        : null,
                    child: currentUserAsync.value?.avatarUrl == null
                        ? const Icon(Icons.person, size: 20, color: Colors.white)
                        : null,
                  ),
                );
              }
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
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

              // Upcoming Events
              const UpcomingEventsCard(),
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
              
              // No Bottom Profile Card anymore since we have it in drawer
              // But keeping it as per original design might be desired?
              // The user said "replace the setting icon... move logout...".
              // User didn't explicitly say "remove the bottom profile card".
              // But duplicate profile info is weird.
              // I'll keep it for now as "User Profile Card" usually shows more details (stats, etc)
              // Actually looking at code (line 102), it shows UserProfileCard.
              // I'll leave it be for now to be safe.
              
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
