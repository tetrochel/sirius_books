import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class UserWidget extends StatelessWidget {
  final String? email;
  final String loginLabel;
  final void Function() onPressed;

  const UserWidget({
    super.key,
    required this.email,
    required this.loginLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (email != null)
              Icon(
                Icons.person_outline,
                color: context.colors.white,
                size: 40,
              ),
            Text(
              email ?? loginLabel,
              style: context.textStyles.s20w400.copyWith(
                color: context.colors.white,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                email == null ? Icons.login : Icons.exit_to_app,
                color: context.colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
