import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/theme/theme_picker.dart';
import 'package:sirius_books/config/navigation/navigation.dart';
import 'package:sirius_books/di.dart';
import 'package:sirius_books/features/book/ui/bloc/book_bloc.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_bloc.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_event.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/firebase_options.dart';
import 'package:sirius_books/generated/app_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appScopeHolder = AppScopeHolder();
  await appScopeHolder.create();
  runApp(
    MainApp(
      appScopeHolder: appScopeHolder,
    ),
  );
}

class MainApp extends StatelessWidget {
  final AppScopeHolder appScopeHolder;

  const MainApp({
    required this.appScopeHolder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScopeProvider(
      holder: appScopeHolder,
      child: ScopeBuilder<AppScopeContainer>(
        builder: (context, rootScope) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UserBloc(
                  userRepository: rootScope!.userRepositoryDep.get,
                  navigationController: rootScope.navigationControllerDep.get,
                )..add(OnFindLocally()),
              ),
              BlocProvider<BookBloc>(
                create: (context) => BookBloc(
                  bookRepository: rootScope!.bookRepositoryDep.get,
                )..add(OnLoadBook()),
              ),
              BlocProvider<ExpositionBloc>(
                create: (context) => ExpositionBloc(
                  expositionRepository: rootScope!.expositionRepositoryDep.get,
                )..add(OnLoadExposition()),
              ),
            ],
            child: MaterialApp.router(
              scaffoldMessengerKey:
                  rootScope!.navigationControllerDep.get.scaffoldMessengerState,
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
                    s12w400: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    s14w400: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    s14w600: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
            ),
          );
        },
      ),
    );
  }
}
