import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/constants.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class ExpositionsPage extends StatelessWidget {
  late final List<int> subscriptions = List.generate(
    4,
    (index) => index * 2,
  );
  late final List<ExpositionModel> expositions = List.generate(
    10,
    (index) => ExpositionModel(
      id: index,
      name: 'Русская классика',
      description:
          'Описание описание описание описание описание описание описание описание',
      topic: 'Тема',
      location: 'Кремль',
      books: [
        BookModel(
          name: '1984',
          authorName: 'Джордж Оруэлл',
          publicationYear: 1949,
          publisher: 'Слог Пресс',
          genre: 'Антиутопия',
          isbn: '978-5-389-09762-3',
          cover: Cover.hard,
          pagesCount: 352,
          booksCount: 10,
          price: 799.99,
          weight: 400,
          location: 'Полка A1',
        ),
        BookModel(
          name: 'Мастер и Маргарита',
          authorName: 'Михаил Булгаков',
          publicationYear: 1967,
          publisher: 'АСТ',
          genre: 'Классика',
          isbn: '978-5-17-118366-1',
          cover: Cover.jacket,
          pagesCount: 480,
          booksCount: 7,
          price: 649.50,
          weight: 550,
          location: 'Полка B3',
        ),
        BookModel(
          name: 'Гарри Поттер и философский камень',
          authorName: 'Дж. К. Роулинг',
          publicationYear: 1997,
          publisher: 'Росмэн',
          genre: 'Фэнтези',
          isbn: '978-5-353-05768-1',
          cover: Cover.soft,
          pagesCount: 432,
          booksCount: 15,
          price: 990.00,
          weight: 300,
          location: 'Полка C2',
        ),
        BookModel(
          name: 'Преступление и наказание',
          authorName: 'Фёдор Достоевский',
          publicationYear: 1866,
          publisher: 'Азбука',
          genre: 'Роман',
          isbn: '978-5-389-07420-4',
          cover: Cover.hard,
          pagesCount: 576,
          booksCount: 5,
          price: 599.00,
          weight: 700,
          location: 'Полка D4',
        ),
        BookModel(
          name: 'Война и мир',
          authorName: 'Лев Толстой',
          publicationYear: 1869,
          publisher: 'Эксмо',
          genre: 'Исторический роман',
          isbn: '978-5-04-116181-4',
          cover: Cover.jacket,
          pagesCount: 1225,
          booksCount: 3,
          price: 1499.99,
          weight: 1200,
          location: 'Полка E1',
        ),
      ],
      startDate: DateTime(2025, 2),
      endDate: DateTime(2025, 2, 5),
    ),
  );

  ExpositionsPage({
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
            title: AppLocalizations.of(context)!.expositions,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: context.colors.primary,
                ),
              ),
            ],
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
                  child: ExpositionWidget(
                    name: expositions[index].name,
                    onTap: () {
                      context.push(
                        '/expositions/details',
                        extra: expositions[index],
                      );
                    },
                    onTapSubscribe: () {},
                    isSubscribed: subscriptions.contains(expositions[index].id),
                    startDate:
                        defaultDateFormat.format(expositions[index].startDate),
                    endDate:
                        defaultDateFormat.format(expositions[index].endDate),
                  ),
                ),
              ),
              childCount: expositions.length,
            ),
          ),
        ),
      ],
    );
  }
}
