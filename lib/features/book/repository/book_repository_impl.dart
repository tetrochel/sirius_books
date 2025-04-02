import 'package:sirius_books/features/book/data/data_source/firebase_book_data_source.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final FirebaseBookDataSource firebaseBookDataSource;

  BookRepositoryImpl({
    required this.firebaseBookDataSource,
  });

  @override
  Future<List<BookModel>?> getAllBooks() async {
    return firebaseBookDataSource.getBookList();
  }

  @override
  Future<void> addBook() async {

  }
}
