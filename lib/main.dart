import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/navigation/navigation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

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
      // TODO(ivan): Вынести определение локали в блок
      locale: const Locale('ru'),
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF019DA1),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        extensions: const [
          AppColors(
            primary: Color(0xFF019DA1),
            grey: Color(0xFF7F8585),
            white: Color(0xFFFFFFFF),
          ),
          AppTextStyles(
            s14w400: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            s16w600: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            s20w400: TextStyle(
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
