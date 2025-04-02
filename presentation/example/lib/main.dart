import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'config/navigation/navigation.dart';
import 'package:example/generated/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ru'),
      theme: ThemeData(
        extensions: [
          AppColors(
            primary: const Color(0xFF019DA1),
            grey: const Color(0xFF7F8585),
            white: const Color(0xFFFFFFFF),
          ),
          AppTextStyles(
            s14w400: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            s16w600: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            s20w400: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            s24w400: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      routerConfig: router,
    );
  }
}

class BookTest extends StatelessWidget {
  const BookTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => BookWidget(
          name: "Евгений Онегин",
          authorName: "Александр Пушкин",
          genre: "Роман",
          isFavorite: true,
          onTap: () {},
          onTapFavorite: () {},
        ),
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldWidget(
              controller: TextEditingController(),
              hint: AppLocalizations.of(context)!.email,
              label: AppLocalizations.of(context)!.email,
              prefixIcon: Icons.person,
              obscureText: false, inputType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldWidget(
              controller: TextEditingController(),
              hint: AppLocalizations.of(context)!.password,
              label: AppLocalizations.of(context)!.password,
              prefixIcon: Icons.key,
              obscureText: true, inputType: TextInputType.visiblePassword,
            ),
          ),
        ],
      ),
    );
  }
}
