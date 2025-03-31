import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthTextField(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hint: AppLocalizations.of(context)!.email,
                label: AppLocalizations.of(context)!.email,
                isPassword: false,
                prefixIcon: Icons.person,
                obscureText: false,
              ),
              AuthTextField(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hint: AppLocalizations.of(context)!.password,
                label: AppLocalizations.of(context)!.password,
                isPassword: true,
                prefixIcon: Icons.key,
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    type: ButtonType.secondary,
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.registration,
                      style: context.textStyles.s14w400.copyWith(
                        color: context.colors.grey,
                      ),
                    ),
                  ),
                  AppButton(
                    type: ButtonType.primary,
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: context.textStyles.s14w400.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
