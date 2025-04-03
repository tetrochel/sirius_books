import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_bloc.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_event.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_state.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksCollectionsPage extends StatefulWidget {
  const BooksCollectionsPage({super.key});

  @override
  State<BooksCollectionsPage> createState() => _BooksCollectionsPageState();
}

class _BooksCollectionsPageState extends State<BooksCollectionsPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
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
                  context.push('/collections/auth');
                }
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverAppBar(
            shadowColor: Colors.black,
            backgroundColor: context.colors.white,
            surfaceTintColor: context.colors.white,
            title: AppBarWidget(
              title: AppLocalizations.of(context)!.collections,
              actions: const [],
            ),
            pinned: true,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: BookCollectionWidget(
                    bookCount:
                        '${AppLocalizations.of(context)!.bookCount.toString()}: ${collections[index].books.length.toString()}',
                    name: collections[index].name,
                    onTap: () {},
                  ),
                ),
              ),
              childCount: collections.length,
            ),
          ),
        ),
      ],
    );
  }
}
