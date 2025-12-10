import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cupcake_ui/ui.dart';
import '../../auth/providers/auth_providers.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(currentUserProfileProvider).value;

    return Drawer(
      child: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(
              color: CupcakeTheme.primaryPeach,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  backgroundImage: userProfile?.avatarUrl != null
                      ? NetworkImage(userProfile!.avatarUrl!)
                      : null,
                  child: userProfile?.avatarUrl == null
                      ? const Icon(Icons.person, size: 40, color: CupcakeTheme.primaryPeach)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  userProfile?.displayName ?? 'Cupcake User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: CupcakeTheme.textDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.person_outline, color: CupcakeTheme.textDark),
            title: const Text('My Profile'),
            onTap: () {
              // Navigate to profile
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined, color: CupcakeTheme.textDark),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: CupcakeTheme.textDark),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              context.push('/settings');
            },
          ),

          const Spacer(),

          // Logout at bottom
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              await ref.read(authServiceProvider).signOut();
              if (context.mounted) {
                context.go('/sign-in');
              }
            },
          ),
          const SizedBox(height: 24), // Bottom padding
        ],
      ),
    );
  }
}
