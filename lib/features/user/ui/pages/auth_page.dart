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
  late final TextEditingController textEditingController1;
  late final TextEditingController textEditingController2;

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
                controller: textEditingController1,
                focusNode: FocusNode(),
                hint: AppLocalizations.of(context)!.email,
                label: AppLocalizations.of(context)!.email,
                isPassword: false,
                prefixIcon: Icons.person,
                obscureText: false,
              ),
              AuthTextField(
                controller: textEditingController2,
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
                    onPressed: () {
                      context.read<UserBloc>().add(
                            OnLoginPressed(
                              email: textEditingController1.text,
                              password: textEditingController2.text,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
  }
}
