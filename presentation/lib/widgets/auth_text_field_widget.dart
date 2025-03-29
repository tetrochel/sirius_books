import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onToggleVisibility;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.label,
    required this.isPassword,
    required this.prefixIcon,
    this.errorText,
    this.onChanged,
    this.onToggleVisibility,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword && obscureText,
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: context.colors.primary,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: context.colors.primary,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        hintText: hint,
        labelText: label,
        labelStyle:
            context.textStyles.s14w400.copyWith(color: context.colors.grey),
        border: const OutlineInputBorder(
          // Make border edge circular
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
      ),
    );
  }
}
