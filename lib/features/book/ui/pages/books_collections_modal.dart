import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/ui/bloc/book_bloc.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_bloc.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class BooksCollectionsModal extends StatelessWidget {
  final BookModel book;

  const BooksCollectionsModal({
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: Builder(
            builder: (context) {
              final collections = context.watch<CollectionBloc>().state.collectionList;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    shadowColor: Colors.black,
                    backgroundColor: context.colors.white,
                    surfaceTintColor: context.colors.white,
                    title: AppBarWidget(
                      title: AppLocalizations.of(context)!.collections,
                      actions: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList.builder(
                      itemBuilder: (context, index) {
                        final collection = collections[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              collection.name,
                              style: context.textStyles.s16w600,
                            ),
                            IconButton(
                              onPressed: () {
                                if (collection.books.contains(book)) {
                                  // context.read<BookBloc>().add(
                                  //       OnRemoveBookFromCollection(
                                  //         bookModel: book,
                                  //         collectionModelId: collection.firebaseId!,
                                  //       ),
                                  //     );
                                }
                                if (collection.firebaseId != null) {
                                  context.read<BookBloc>().add(
                                        OnAddBookToCollection(
                                          bookModel: book,
                                          collectionModelId: collection.firebaseId!,
                                        ),
                                      );
                                  context.read<CollectionBloc>().add(OnLoadCollections());
                                }
                              },
                              icon: Icon(
                                collection.books.contains(book) ? Icons.remove : Icons.add,
                                color: context.colors.primary,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: collections.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
