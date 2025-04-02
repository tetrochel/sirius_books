import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/ui/pages/books_page.dart';
import 'package:sirius_books/features/books_collection/ui/pages/books_collections_page.dart';
import 'package:sirius_books/features/exposition/ui/pages/expositions_page.dart';
import 'package:sirius_books/features/filter/ui/pages/filter_page.dart';
import 'package:sirius_books/features/user/ui/pages/auth_page.dart';
import 'package:sirius_books/generated/app_localizations.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expositions',
  routes: [
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        body: SafeArea(
          child: child,
        ),
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
      ),
      routes: [
        GoRoute(
          path: '/expositions',
          pageBuilder: (context, state) => noTransitionPage(
            child: ExpositionsPage(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                // final id = state.pathParameters['id'];
                return const SizedBox.shrink();
                // return ExpositionDetailsScreen(id: id);
              },
            ),
            GoRoute(
              path: 'new',
              builder: (context, state) => const SizedBox.shrink(),
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
              path: ':id',
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
              path: ':id',
              builder: (context, state) {
                // final id = state.pathParameters['id'];
                return const SizedBox.shrink();
              },
            ),
            GoRoute(
              path: 'new',
              builder: (context, state) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/filter',
      pageBuilder: (context, state) =>
          const ModalPage<void>(child: FilterPage()),
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
