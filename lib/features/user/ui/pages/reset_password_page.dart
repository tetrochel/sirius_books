import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController emailController;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              AppButton(
                type: ButtonType.secondary,
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    context.read<UserBloc>().add(
                          OnResetPasswordPressed(
                            email: emailController.text,
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Письмо отправлено на указанную почту',
                        ),
                      ),
                    );
                    context.go('/collections');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Введите данные',
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.restorePassword,
                  style: context.textStyles.s14w400.copyWith(
                    color: context.colors.grey,
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
