import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/features/book/repository/book_repository.dart';
import 'package:sirius_books/features/book/ui/data/book_event.dart';
import 'package:sirius_books/features/book/ui/data/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc({
    required this.bookRepository,
  }) : super(BookState()) {
    on<BookEvent>((event, emit) async {
      switch (event) {
        case OnLoadBook():
          await _handleOnLoadBook(event, emit);
      }
    });
  }

  Future<void> _handleOnLoadBook(OnLoadBook event, Emitter<BookState> emit) async {
    try {
      final bookList = await bookRepository.getAllBooks();
      if (bookList != null) {
        emit(BookState()..bookList = bookList);
      }
    } on Exception catch (_) {
      return;
    }
  }
}
