import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/repository/book_repository.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/book/ui/bloc/book_state.dart';
import 'package:sirius_books/features/filter/data/model/filter_model.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  late Map<Type, Map<String, Object>> filters;
  List<BookModel> allLoadedBooks = [];

  BookBloc({
    required this.bookRepository,
  }) : super(BookState()) {
    filters = {
      String: {},
      Range: {},
      List<Cover>: {},
    };
    on<BookEvent>((event, emit) async {
      switch (event) {
        case OnLoadBook():
          await _handleOnLoadBook(event, emit);
        case OnAddBook():
          await _handleOnAddBook(event, emit);
        case OnFilterBooks():
          _handleOnFilterBooks(event, emit);
        case OnFilterChanged():
          _handleOnFilterChanged(event, emit);
        case OnFiltersReset():
          _handleOnFiltersReset(event, emit);
        case OnUpdateBook():
          await _handleOnUpdateBook(event, emit);
        case OnAddBookToCollection():
          await _handleOnAddBookToCollection(event, emit);
        case OnRemoveBookFromCollectionPressed():
          await _handleOnRemoveBookFromCollectionPressed(event, emit);
        case OnDeleteBookPressed():
          await _handleOnDeleteBookPressed(event, emit);
      }
    });
  }

  Future<void> _handleOnAddBookToCollection(
    OnAddBookToCollection event,
    Emitter<BookState> emit,
  ) async {
    try {
      await bookRepository.addBookToCollection(
        event.bookModel,
        event.collectionModelId,
      );
      event.callback();
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnLoadBook(
    OnLoadBook event,
    Emitter<BookState> emit,
  ) async {
    try {
      final bookList = await bookRepository.getAllBooks();
      if (bookList != null) {
        allLoadedBooks = bookList;
        emit(BookState()..bookList = allLoadedBooks);
      }
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnAddBook(
    OnAddBook event,
    Emitter<BookState> emit,
  ) async {
    try {
      await bookRepository.addBook(event.bookModel);
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnUpdateBook(
    OnUpdateBook event,
    Emitter<BookState> emit,
  ) async {
    try {
      await bookRepository.updateBook(event.bookModel);
    } on Exception catch (_) {
      return;
    }
  }

  void _handleOnFilterBooks(
    OnFilterBooks event,
    Emitter<BookState> emit,
  ) {
    final newBooks = <BookModel>[];

    for (final book in allLoadedBooks) {
      var good = true;
      for (final type in filters.keys) {
        for (final id in filters[type]!.keys) {
          final value = filters[type]![id];
          final currentGood = Filters.filters.firstWhere((filter) {
            return filter.id == id;
          }).check(book: book, value: value);
          if (!currentGood) {
            good = false;
          }
        }
      }
      if (good) {
        newBooks.add(book);
      }
    }
    emit(BookState()..bookList = newBooks);
  }

  void _handleOnFilterChanged(
    OnFilterChanged event,
    Emitter<BookState> emit,
  ) {
    filters[event.value.runtimeType]![event.id] = event.value;
  }

  void _handleOnFiltersReset(
    OnFiltersReset event,
    Emitter<BookState> emit,
  ) {
    filters = {
      String: {},
      Range: {},
      List<Cover>: {},
    };
    emit(BookState()..bookList = allLoadedBooks);
  }

  Future<void> _handleOnRemoveBookFromCollectionPressed(
    OnRemoveBookFromCollectionPressed event,
    Emitter<BookState> emit,
  ) async {
    try {
      await bookRepository.removeBookFromCollection(
        event.bookModel,
        event.collectionModelId,
      );
      event.callback();
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnDeleteBookPressed(
    OnDeleteBookPressed event,
    Emitter<BookState> emit,
  ) async {
    try {
      await bookRepository.deleteBook(event.bookModel);
      allLoadedBooks.removeWhere((book) => book.firebaseId == event.bookModel.firebaseId);
      emit(BookState()..bookList = allLoadedBooks);
    } on Exception catch (_) {
      return;
    }
  }
}

typedef Range = (int, int);
