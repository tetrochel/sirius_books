import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:animations/animations.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expositions',
  routes: [
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        body: child,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashFactory: InkRipple.splashFactory),
          child: BottomNavigationBar(
            selectedItemColor: context.colors.primary,
            unselectedItemColor: context.colors.grey,
            items: [
              // TODO: move strings somewhere else
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Выставки'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: 'Книги'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark), label: 'Коллекции'),
            ],
            currentIndex: _getCurrentIndex(state),
            onTap: (index) {
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
            },
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: '/expositions',
          pageBuilder: (context, state) =>
              noTransitionPage(child: const SizedBox.shrink(), state: state),
        ),
        GoRoute(
          path: '/books',
          pageBuilder: (context, state) =>
              noTransitionPage(child: const BookTest(), state: state),
        ),
        GoRoute(
          path: '/collections',
          pageBuilder: (context, state) =>
              noTransitionPage(child: const SizedBox.shrink(), state: state),
        ),
      ],
    ),
  ],
);

int _getCurrentIndex(GoRouterState state) {
  if (state.uri.toString().startsWith('/expositions')) return 0;
  if (state.uri.toString().startsWith('/books')) return 1;
  if (state.uri.toString().startsWith('/collections')) return 2;
  return 0;
}

CustomTransitionPage<void> noTransitionPage(
    {required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}
