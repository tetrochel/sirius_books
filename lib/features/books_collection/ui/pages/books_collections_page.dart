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
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        var collections = <CollectionModel>[];
        if (context.read<UserBloc>().state.userModel != null) {
          context.read<CollectionBloc>().add(OnLoadCollections());
          collections = state.collectionList;
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: (!context.watch<UserBloc>().state.isLoading)
                    ? UserWidget(
                        email: context.watch<UserBloc>().state.userModel?.email,
                        loginLabel: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          if (context.read<UserBloc>().state.userModel !=
                              null) {
                            context.read<UserBloc>().add(OnLogOutPressed());
                          } else {
                            context.push('/collections/auth');
                          }
                        },
                      )
                    : const LoadingCard(),
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
                        onTap: () {
                          context.push(
                            '/collections/details',
                            extra: collections[index],
                          );
                        },
                      ),
                    ),
                  ),
                  childCount: collections.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key});

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.person_outline,
              color: context.colors.white,
              size: 40,
            ),
            const SizedBox(width: 8),
            Text(
              'Загрузка...',
              style: context.textStyles.s20w400.copyWith(
                color: context.colors.white,
              ),
            ),
            const Spacer(),
            RotationTransition(
              turns: _animation,
              child: Icon(
                Icons.refresh,
                color: context.colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
