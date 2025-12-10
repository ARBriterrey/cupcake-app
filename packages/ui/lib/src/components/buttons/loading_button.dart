import 'package:flutter/material.dart';

/// A themed elevated button with loading state
///
/// Features:
/// - Shows CircularProgressIndicator when loading
/// - Automatically disables when loading
/// - Consistent styling with Cupcake theme
/// - Customizable padding
///
/// Example:
/// ```dart
/// LoadingButton(
///   onPressed: _handleSubmit,
///   isLoading: _isLoading,
///   child: Text('Submit'),
/// )
/// ```
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final EdgeInsetsGeometry padding;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            padding: padding,
          ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : child,
    );
  }
}
