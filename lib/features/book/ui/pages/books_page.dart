import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

class _BooksPageState extends State<BooksPage>
    with SingleTickerProviderStateMixin {
  late List<BookModel> books;
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
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.search,
                    //     color: context.colors.primary,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        context.push('/filter');
                        context.read<BookBloc>().add(OnFiltersReset());
                      },
                      icon: Icon(
                        Icons.filter_alt,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (books.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.refresh,
                            size: 48,
                            color: context.colors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Загрузка...',
                          style: context.textStyles.s20w400.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList.builder(
                  itemBuilder: (context, index) => BookWidget(
                    name: books[index].name,
                    authorName: books[index].authorName,
                    genre: books[index].genre,
                    isFavorite: index.isEven,
                    onTap: () {
                      context.push('/books/details', extra: books[index]);
                    },
                    onTapFavorite: () {},
                  ),
                  itemCount: books.length,
                ),
            ],
          ),
        );
      },
    );
  }
}
