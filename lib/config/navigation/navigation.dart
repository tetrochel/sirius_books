import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expositions',
  routes: [
    ShellRoute(
      builder: (context, state, child) => const SizedBox.shrink(),
      routes: [
        GoRoute(
          path: '/expositions',
          builder: (context, state) => const SizedBox.shrink(),
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
          builder: (context, state) => const SizedBox.shrink(),
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
          builder: (context, state) => const SizedBox.shrink(),
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