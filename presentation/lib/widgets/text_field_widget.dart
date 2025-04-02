import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String label;
  final IconData? prefixIcon;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onToggleVisibility;
  final bool obscureText;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.prefixIcon,
    this.errorText,
    this.onChanged,
    this.onToggleVisibility,
    required this.obscureText,
    this.validator,
    required this.inputType,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: inputType == TextInputType.multiline ? 2 : 1,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      obscureText: inputType == TextInputType.visiblePassword && obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor: context.colors.primary,
        suffixIcon: inputType == TextInputType.visiblePassword
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
        border: OutlineInputBorder(
          // Make border edge circular
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: context.colors.grey, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          // Make border edge circular
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: context.colors.grey, width: 1.5),
        ),
      ),
    );
  }
}
