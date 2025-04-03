import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/theme/theme_picker.dart';

class TextFieldWithLabelWidget extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final bool readOnly;
  final List<TextInputFormatter>? formatters;
  final TextInputType? textInputType;

  const TextFieldWithLabelWidget({
    super.key,
    required this.label,
    required this.textController,
    required this.readOnly,
    this.formatters,
    this.textInputType,
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
          maxLines: textInputType == TextInputType.multiline ? null : 1,
          keyboardType: textInputType,
          inputFormatters: formatters,
          readOnly: readOnly,
          controller: textController,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
