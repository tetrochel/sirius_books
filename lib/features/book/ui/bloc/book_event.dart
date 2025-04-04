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
  void Function() callback;

  OnAddBookToCollection({
    required this.bookModel,
    required this.collectionModelId,
    required this.callback,
  });
}

class OnRemoveBookFromCollectionPressed extends BookEvent {
  final BookModel bookModel;
  final String collectionModelId;
  void Function() callback;

  OnRemoveBookFromCollectionPressed({
    required this.bookModel,
    required this.collectionModelId,
    required this.callback,
  });
}

class OnDeleteBookPressed extends BookEvent {
  BookModel bookModel;

  OnDeleteBookPressed({
    required this.bookModel,
  });
}
