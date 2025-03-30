import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/ui/pages/books_page.dart';
import 'package:sirius_books/generated/app_localizations.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expositions',
  routes: [
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        body: child,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashFactory: InkRipple.splashFactory,
          ),
          child: NavBar(
            expositionsLabel: AppLocalizations.of(context)!.expositions,
            expositionsIcon: Icons.calendar_today,
            booksLabel: AppLocalizations.of(context)!.books,
            booksIcon: Icons.menu_book,
            collectionsLabel: AppLocalizations.of(context)!.collections,
            collectionsIcon: Icons.collections_bookmark,
            currentIndex: _getCurrentIndex(state),
            onTabSelected: (index) => _switchPage(context, index),
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: '/expositions',
          pageBuilder: (context, state) =>
              noTransitionPage(child: const SizedBox.shrink(), state: state),
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
            child: Scaffold(
              backgroundColor: context.colors.white,
              body: BooksPage(
                appBar: AppBarWidget(
                  title: AppLocalizations.of(context)!.books,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: context.colors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                children: List.generate(
                  40,
                  (index) => BookWidget(
                    name: 'Евгений Онегин',
                    authorName: 'Александр Пушкин',
                    genre: 'Роман',
                    isFavorite: index.isEven,
                    onTap: () {},
                    onTapFavorite: () {},
                  ),
                ),
              ),
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
          pageBuilder: (context, state) =>
              noTransitionPage(child: const SizedBox.shrink(), state: state),
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
  ],
);

CustomTransitionPage<void> noTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
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
