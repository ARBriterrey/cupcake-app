import 'package:flutter/material.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class SprinklesOverviewCard extends StatelessWidget {
  const SprinklesOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: EmptyStateWidget(
        icon: Icons.extension_outlined,
        title: 'No Sprinkles Yet',
        description:
            'Sprinkles are modular features you can add to customize your Cupcake experience. Check back soon!',
      ),
    );
  }
}
