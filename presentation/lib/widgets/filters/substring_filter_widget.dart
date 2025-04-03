import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class SubStringFilterWidget extends StatefulWidget {
  final String id;
  final String name;
  final void Function(String) onChanged;

  const SubStringFilterWidget({
    super.key,
    required this.id,
    required this.name,
    required this.onChanged,
  });

  @override
  State<SubStringFilterWidget> createState() => _SubStringFilterWidgetState();
}

class _SubStringFilterWidgetState extends State<SubStringFilterWidget> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: context.textStyles.s16w600,
        ),
        SizedBox(height: 4),
        TextField(
          controller: textController,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onChanged: (value) {
            widget.onChanged(value.trim());
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
