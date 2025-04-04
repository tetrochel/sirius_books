import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final bool disablePadding;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.actions,
    this.disablePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: disablePadding ? 0 : 8,
      ),
      child: Row(
        spacing: 4,
        children: [
          Expanded(
            child: Text(
              title,
              style: context.textStyles.s24w400,
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}
