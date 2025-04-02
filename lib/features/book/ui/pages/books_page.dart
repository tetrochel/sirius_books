import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/ui/bloc/book_bloc.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/book/ui/bloc/book_state.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({
    super.key,
  });

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<BookModel> books;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        books = state.bookList;
        return RefreshIndicator(
          onRefresh: () async => context.read<BookBloc>().add(OnLoadBook()),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                shadowColor: Colors.black,
                backgroundColor: context.colors.white,
                surfaceTintColor: context.colors.white,
                title: AppBarWidget(
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
                      onPressed: () {
                        // TODO(ivan): Добавить вызов модального окна через router
                      },
                      icon: Icon(
                        Icons.filter_alt,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => BookWidget(
                      name: books[index].name,
                      authorName: books[index].authorName,
                      genre: books[index].genre,
                      isFavorite: index.isEven,
                      onTap: () {},
                      onTapFavorite: () {},
                    ),
                    childCount: books.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
