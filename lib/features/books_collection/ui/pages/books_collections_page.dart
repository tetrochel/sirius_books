import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksCollectionsPage extends StatelessWidget {
  const BooksCollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: UserWidget(
              email: null,
              loginLabel: AppLocalizations.of(context)!.login,
              onPressed: () {
                context.push('/auth');
              },
            ),
          ),
        ),
        SliverAppBar(
          shadowColor: Colors.black,
          backgroundColor: context.colors.white,
          surfaceTintColor: context.colors.white,
          title: AppBarWidget(
            title: AppLocalizations.of(context)!.collections,
            actions: const [],
          ),
          pinned: true,
        ),
      ],
    );
  }
}
