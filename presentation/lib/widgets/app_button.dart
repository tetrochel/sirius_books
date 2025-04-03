import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

enum ButtonType { primary, secondary, delete }

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback onPressed;
  final Widget child;

  const AppButton({
    super.key,
    required this.type,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // backgroundColor: type == ButtonType.primary
        //     ? context.colors.primary
        //     : context.colors.white,
        backgroundColor: _getButtonColor(context, type),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  Color _getButtonColor(BuildContext context, ButtonType type) {
    switch (type) {
      case ButtonType.primary:
        {
          return context.colors.primary;
        }
      case ButtonType.secondary:
        {
          return context.colors.white;
        }
      case ButtonType.delete:
        {
          return Colors.red;
        }
    }
  }
}
