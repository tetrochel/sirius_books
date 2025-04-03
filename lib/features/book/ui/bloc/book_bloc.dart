import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/features/book/repository/book_repository.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/book/ui/bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc({
    required this.bookRepository,
  }) : super(BookState()) {
    on<BookEvent>((event, emit) async {
      switch (event) {
        case OnLoadBook():
          await _handleOnLoadBook(event, emit);
        case OnAddBook():
          await _handleOnAddBook(event, emit);
        case OnUpdateBook():
          await _handleOnUpdateBook(event, emit);
      }
    });
  }

  Future<void> _handleOnLoadBook(
    OnLoadBook event,
    Emitter<BookState> emit,
  ) async {
    try {
      final bookList = await bookRepository.getAllBooks();
      if (bookList != null) {
        emit(BookState()..bookList = bookList);
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
}
