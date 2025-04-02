import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksCollectionsPage extends StatelessWidget {
  late final List<BookCollectionModel> collections = [
    BookCollectionModel(
      id: 1,
      name: 'Классика',
      description: 'Коллекция классической литературы',
      books: [
        BookModel(
          name: 'Война и мир',
          authorName: 'Лев Толстой',
          publicationYear: 1869,
          publisher: 'АСТ',
          genre: 'Роман',
          isbn: '978-5-17-118366-3',
          cover: Cover.hard,
          pagesCount: 1225,
          booksCount: 5,
          price: 1500.0,
          weight: 1200,
          location: 'Москва, ул. Ленина, д. 10',
        ),
        BookModel(
          name: 'Преступление и наказание',
          authorName: 'Фёдор Достоевский',
          publicationYear: 1866,
          publisher: 'Эксмо',
          genre: 'Роман',
          isbn: '978-5-04-116437-3',
          cover: Cover.hard,
          pagesCount: 672,
          booksCount: 3,
          price: 1200.0,
          weight: 900,
          location: 'Санкт-Петербург, Невский проспект, д. 20',
        ),
      ],
    ),
    BookCollectionModel(
      id: 2,
      name: 'Фантастика',
      description: 'Лучшие книги в жанре научной фантастики',
      books: [
        BookModel(
          name: 'Дюна',
          authorName: 'Фрэнк Герберт',
          publicationYear: 1965,
          publisher: 'Азбука',
          genre: 'Фантастика',
          isbn: '978-5-389-15844-3',
          cover: Cover.jacket,
          pagesCount: 704,
          booksCount: 4,
          price: 1800.0,
          weight: 1100,
          location: 'Москва, ул. Арбат, д. 5',
        ),
      ],
    ),
    BookCollectionModel(
      id: 2,
      name: 'Фантастика',
      description: 'Лучшие книги в жанре научной фантастики',
      books: [],
    ),
  ];

  BooksCollectionsPage({super.key});

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
