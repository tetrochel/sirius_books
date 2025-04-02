import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
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
              email: context.watch<UserBloc>().state.userModel?.email,
              loginLabel: AppLocalizations.of(context)!.login,
              onPressed: () {
                if (context.read<UserBloc>().state.userModel != null) {
                  context.read<UserBloc>().add(OnLogOutPressed());
                } else {
                  context.push('/auth');
                }
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
