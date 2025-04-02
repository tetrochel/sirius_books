import 'package:sirius_books/features/book/data/model/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>?> getAllBooks();

  Future<void> addBook(BookModel bookModel);
}