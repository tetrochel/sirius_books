import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
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

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.white,
      ),
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
                obscureText: obscurePassword,
                inputType: TextInputType.visiblePassword,
                onToggleVisibility: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              TextFieldWidget(
                controller: repeatPasswordController,
                hint: AppLocalizations.of(context)!.repeatPassword,
                label: AppLocalizations.of(context)!.repeatPassword,
                obscureText: obscureRepeatPassword,
                inputType: TextInputType.visiblePassword,
                prefixIcon: Icons.key,
                onToggleVisibility: () {
                  setState(() {
                    obscureRepeatPassword = !obscureRepeatPassword;
                  });
                },
              ),
              Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: AppButton(
                  type: ButtonType.primary,
                  onPressed: () {
                    if (passwordController.text !=
                        repeatPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пароли не совпадают'),
                        ),
                      );
                    } else if (passwordController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Введите данные'),
                        ),
                      );
                    } else if (passwordController.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пароль должен содержать не менее 6 символов'),
                        ),
                      );
                    }else {
                      context.read<UserBloc>().add(
                            OnSignUpPressed(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                      context.go('/collections');
                    }
                  },
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
}
