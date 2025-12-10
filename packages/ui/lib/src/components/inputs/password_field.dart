import 'package:flutter/material.dart';

/// A themed password input field with visibility toggle
///
/// Features:
/// - Password visibility toggle icon
/// - Automatic obscuring of text
/// - Validation support
/// - Consistent styling with Cupcake theme
///
/// Example:
/// ```dart
/// PasswordField(
///   controller: _passwordController,
///   labelText: 'Password',
///   validator: (value) {
///     if (value == null || value.isEmpty) return 'Required';
///     if (value.length < 6) return 'Too short';
///     return null;
///   },
/// )
/// ```
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.labelText = 'Password',
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
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.lock_outlined),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
