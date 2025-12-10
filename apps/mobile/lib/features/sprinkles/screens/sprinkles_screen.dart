import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';

class SprinklesScreen extends ConsumerWidget {
  const SprinklesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sprinkles'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: EmptyStateWidget(
          icon: Icons.extension_outlined,
          title: 'Sprinkles Coming Soon',
          description:
              'Modular features you can add to customize your Cupcake experience. Browse and activate sprinkles to enhance your app.',
        ),
      ),
    );
  }
}
