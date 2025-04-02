import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController repeatPasswordController;

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
              TextFieldWidget(
                controller: emailController,
                hint: AppLocalizations.of(context)!.email,
                label: AppLocalizations.of(context)!.email,
                prefixIcon: Icons.person,
                obscureText: false,
                inputType: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                controller: passwordController,
                hint: AppLocalizations.of(context)!.password,
                label: AppLocalizations.of(context)!.password,
                prefixIcon: Icons.key,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
              ),
              TextFieldWidget(
                controller: repeatPasswordController,
                hint: AppLocalizations.of(context)!.repeatPassword,
                label: AppLocalizations.of(context)!.repeatPassword,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: AppButton(
                  type: ButtonType.primary,
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: context.textStyles.s14w400.copyWith(
                      color: context.colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }
}
