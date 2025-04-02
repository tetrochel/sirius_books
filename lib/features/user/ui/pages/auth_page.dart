import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

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
            crossAxisAlignment: CrossAxisAlignment.end,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    type: ButtonType.secondary,
                    onPressed: () =>
                        context.go('/collections/auth/registration'),
                    child: Text(
                      AppLocalizations.of(context)!.registration,
                      style: context.textStyles.s14w400.copyWith(
                        color: context.colors.grey,
                      ),
                    ),
                  ),
                  AppButton(
                    type: ButtonType.primary,
                    onPressed: () {
                      context.read<UserBloc>().add(
                            OnLoginPressed(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                      context.pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: context.textStyles.s14w400.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => context.go('/collections/auth/reset_password'),
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: context.textStyles.s14w400
                      .copyWith(color: context.colors.grey),
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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
}
