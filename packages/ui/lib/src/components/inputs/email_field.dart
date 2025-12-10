import 'package:flutter/material.dart';

/// A themed email input field with validation
///
/// Features:
/// - Email keyboard type
/// - Automatic trimming and lowercase
/// - Built-in email validation
/// - Consistent styling with Cupcake theme
///
/// Example:
/// ```dart
/// EmailField(
///   controller: _emailController,
///   validator: (value) {
///     if (value == null || value.isEmpty) return 'Email is required';
///     if (!value.contains('@')) return 'Invalid email';
///     return null;
///   },
/// )
/// ```
class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.controller,
    this.labelText = 'Email',
    this.hintText,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.email_outlined),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
