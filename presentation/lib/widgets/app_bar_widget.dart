import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        spacing: 4,
        children: [
          Text(
            title,
            style: context.textStyles.s24w400,
          ),
          Spacer(),
          ...actions,
        ],
      ),
    );
  }
}
