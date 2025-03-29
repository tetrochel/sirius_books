import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sirius_books/generated/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // TODO: Вынести определение локали в блок
      locale: const Locale('en'),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.expositions),
            ),
          );
        },
      ),
    );
  }
}
