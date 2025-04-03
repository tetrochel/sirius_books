import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/ui/pages/books_page.dart';
import 'package:sirius_books/features/books_collection/ui/pages/books_collections_page.dart';
import 'package:sirius_books/features/exposition/ui/pages/expositions_page.dart';
import 'package:sirius_books/features/exposition/ui/pages/new_exposition_page.dart';
import 'package:sirius_books/features/filter/ui/pages/filter_page.dart';
import 'package:sirius_books/features/user/data/model/user_model.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/pages/auth_page.dart';
import 'package:sirius_books/features/user/ui/pages/registration_page.dart';
import 'package:sirius_books/features/user/ui/pages/reset_password_page.dart';
import 'package:sirius_books/generated/app_localizations.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expositions',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        var showActionButton = false;
        if (context.watch<UserBloc>().state.userModel != null &&
            context.watch<UserBloc>().state.userModel!.role == UserRole.keeper) {
          showActionButton = true;
        }
        if (state.fullPath == '/collections') {
          showActionButton = false;
        }
        return Scaffold(
          body: SafeArea(
            child: child,
          ),
          floatingActionButton: showActionButton
              ? FloatingActionButton(
                  onPressed: () {
                    if (state.fullPath == '/expositions') {
                      context.go('/expositions/new');
                    } else {
                      context.go('/books/new');
                    }
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.white,
                )
              : null,
          bottomNavigationBar: NavBar(
            items: [
              (
                label: AppLocalizations.of(context)!.expositions,
                icon: Icons.calendar_today,
              ),
              (
                label: AppLocalizations.of(context)!.books,
                icon: Icons.menu_book,
              ),
              (
                label: AppLocalizations.of(context)!.collections,
                icon: Icons.collections_bookmark,
              ),
            ],
            currentIndex: _getCurrentIndex(state),
            onTabSelected: (index) => _switchPage(context, index),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/expositions',
          pageBuilder: (context, state) => noTransitionPage(
            // ColoredBox для фона
            child: ColoredBox(
              color: context.colors.white,
              child: ExpositionsPage(),
            ),
            state: state,
          ),
          routes: [
            GoRoute(
              path: 'details/:id',
              builder: (context, state) {
                // final id = state.pathParameters['id'];
                return const SizedBox.shrink();
                // return ExpositionDetailsScreen(id: id);
              },
            ),
            GoRoute(
              path: 'new',
              builder: (context, state) => const NewExpositionPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/books',
          pageBuilder: (context, state) => noTransitionPage(
            state: state,
            // ColoredBox для фона
            child: ColoredBox(
              color: context.colors.white,
              child: const BooksPage(),
            ),
          ),
          routes: [
            GoRoute(
              path: 'details/:id',
              builder: (context, state) {
                // final id = state.pathParameters['id'];
                return const SizedBox.shrink();
                // return BookDetailsScreen(id: id);
              },
            ),
            GoRoute(
              path: 'new',
              builder: (context, state) => const SizedBox.shrink(),
            ),
          ],
        ),
        GoRoute(
          path: '/collections',
          pageBuilder: (context, state) => noTransitionPage(
            // ColoredBox для фона
            child: ColoredBox(
              color: context.colors.white,
              child: const BooksCollectionsPage(),
            ),
            state: state,
          ),
          routes: [
            GoRoute(
              path: 'details/:id',
              builder: (context, state) {
                // final id = state.pathParameters['id'];
                return const SizedBox.shrink();
              },
            ),
            GoRoute(
              path: 'new',
              builder: (context, state) => const SizedBox.shrink(),
            ),
            GoRoute(
              path: 'auth',
              builder: (context, state) => const AuthPage(),
              routes: [
                GoRoute(
                  path: 'registration',
                  builder: (context, state) => const RegistrationPage(),
                ),
                GoRoute(
                  path: 'reset_password',
                  builder: (context, state) => const ResetPasswordPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/filter',
      pageBuilder: (context, state) => ModalPage<void>(child: FilterPage()),
    ),
  ],
);

CustomTransitionPage<void> noTransitionPage({
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) =>
          child,
    );

class ModalPage<T> extends Page<T> {
  final Widget child;

  const ModalPage({required this.child});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        backgroundColor: context.colors.white,
        useSafeArea: true,
        settings: this,
        builder: (context) => child,
        isScrollControlled: true,
      );
}

int _getCurrentIndex(GoRouterState state) {
  if (state.uri.toString().startsWith('/expositions')) return 0;
  if (state.uri.toString().startsWith('/books')) return 1;
  if (state.uri.toString().startsWith('/collections')) return 2;
  return 0;
}

void _switchPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go('/expositions');
      break;
    case 1:
      context.go('/books');
      break;
    case 2:
      context.go('/collections');
      break;
  }
}
