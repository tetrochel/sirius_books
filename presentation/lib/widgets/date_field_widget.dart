import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';

class DateFieldWidget extends StatelessWidget {
  final Function()? onTap;
  final TextEditingController controller;
  final String label;

  const DateFieldWidget({
    super.key,
    required this.onTap,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textStyles.s16w600,
        ),
        SizedBox(height: 4),
        TextField(
          canRequestFocus: false,
          onTap: onTap,
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            prefixIconColor: context.colors.primary,
            prefixIcon: const Icon(Icons.calendar_today),
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
        ),
      ],
    );
  }
}
