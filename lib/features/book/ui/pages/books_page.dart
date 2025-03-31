import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksPage extends StatelessWidget {
  late final List<BookModel> books = List.generate(
    40,
    (index) => BookModel(
      name: 'Евгений Онегин',
      authorName: 'Александр Пушкин',
      genre: 'Роман',
      publicationYear: index,
      cover: Cover.soft,
      publisher: 'Издательство',
      price: index.toDouble(),
      isbn: 'ISBN',
      pagesCount: 100,
      booksCount: 10,
      weight: 100,
      location: 'Третья полка сверху',
    ),
  );

  BooksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }
}
