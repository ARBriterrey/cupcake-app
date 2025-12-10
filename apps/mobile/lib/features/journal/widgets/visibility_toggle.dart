import 'package:flutter/material.dart';
import 'package:cupcake_ui/ui.dart';
import 'package:cupcake_core/core.dart';

class VisibilityToggle extends StatelessWidget {
  final EventVisibility value;
  final ValueChanged<EventVisibility> onChanged;

  const VisibilityToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isShared = value == EventVisibility.shared;
    
    return GestureDetector(
      onTap: () {
        // Toggle
        onChanged(isShared ? EventVisibility.private : EventVisibility.shared);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isShared ? CupcakeColors.accentLavender.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isShared ? CupcakeColors.accentLavender : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isShared ? Icons.people : Icons.lock_outline,
              size: 16,
              color: isShared ? CupcakeColors.accentLavender : CupcakeColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              isShared ? 'Shared with partner' : 'Private (Only you)',
              style: CupcakeTypography.caption.copyWith(
                color: isShared ? CupcakeColors.accentLavender : CupcakeColors.textSecondary,
                fontWeight: isShared ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
