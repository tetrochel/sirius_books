import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class SubStringFilterWidget extends StatelessWidget {
  final String id;
  final String name;
  final textController = TextEditingController();

  SubStringFilterWidget({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
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
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
