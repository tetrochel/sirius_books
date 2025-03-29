import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/ui/pages/books_page.dart';
import 'package:sirius_books/generated/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // TODO(ivan): Вынести определение локали в блок
      locale: const Locale('en'),
      theme: ThemeData(
        extensions: const [
          AppColors(
            primary: Color(0xFF019DA1),
            grey: Color(0xFF7F8585),
            white: Color(0xFFFFFFFF),
          ),
          AppTextStyles(
            s14w400: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            s16w600: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            s24w400: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.colors.white,
            body: BooksPage(
              appBar: AppBarWidget(
                title: 'Книги',
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: context.colors.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
              children: List.generate(
                40,
                (index) => BookWidget(
                  name: 'Евгений Онегин',
                  authorName: 'Александр Пушкин',
                  genre: 'Роман',
                  isFavorite: index.isEven,
                  onTap: () {},
                  onTapFavorite: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
