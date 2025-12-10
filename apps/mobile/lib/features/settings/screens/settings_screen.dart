import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cupcake_ui/ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupcakeTheme.warmGray,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: CupcakeTheme.warmGray,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader('Calendar'),
          
          ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.restore_from_trash_outlined, color: CupcakeTheme.textDark),
            title: const Text('Restore Deleted Events'),
            subtitle: const Text('Recover events deleted in the last 30 days'),
            trailing: const Icon(Icons.chevron_right, color: CupcakeTheme.textLight),
            onTap: () {
              context.push('/settings/restore-events');
            },
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('App Info'),
          
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.info_outline, color: CupcakeTheme.textDark),
            title: Text('Version'),
            trailing: Text('1.0.0', style: TextStyle(color: CupcakeTheme.textLight)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: CupcakeTheme.textLight,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
