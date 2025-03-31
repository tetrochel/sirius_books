import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AuthTextField(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  hint: AppLocalizations.of(context)!.email,
                  label: AppLocalizations.of(context)!.email,
                  isPassword: false,
                  prefixIcon: Icons.person,
                  obscureText: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AuthTextField(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                  hint: AppLocalizations.of(context)!.password,
                  label: AppLocalizations.of(context)!.password,
                  isPassword: true,
                  prefixIcon: Icons.key,
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
