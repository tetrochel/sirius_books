import 'package:sirius_books/features/book/data/model/book_model.dart';

sealed class BookEvent {}

class OnLoadBook extends BookEvent {}

class OnAddBook extends BookEvent {
  BookModel bookModel;

  OnAddBook({required this.bookModel});
}

class OnFilterBooks extends BookEvent {}

class OnFilterChanged<T> extends BookEvent {
  final String id;
  final T value;

  OnFilterChanged({
    required this.id,
    required this.value,
  });
}

class OnFiltersReset extends BookEvent {}

class OnUpdateBook extends BookEvent {
  BookModel bookModel;

  OnUpdateBook({required this.bookModel});
}

class OnAddBookToCollection extends BookEvent {
  BookModel bookModel;
  String collectionModelId;

  OnAddBookToCollection({
    required this.bookModel,
    required this.collectionModelId,
  });
}

class OnRemoveBookFromCollectionPressed extends BookEvent {
  BookModel bookModel;
  String collectionModelId;

  OnRemoveBookFromCollectionPressed({
    required this.bookModel,
    required this.collectionModelId,
  });
}

class OnDeleteBookPressed extends BookEvent {
  BookModel bookModel;

  OnDeleteBookPressed({
    required this.bookModel,
  });
}
