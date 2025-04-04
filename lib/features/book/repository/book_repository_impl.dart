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
  Future<void> addBook(BookModel bookModel) async {
    await firebaseBookDataSource.addBook(bookModel);
  }

  @override
  Future<void> updateBook(BookModel bookModel) async {
    await firebaseBookDataSource.updateBook(bookModel);
  }

  @override
  Future<void> deleteBook(BookModel bookModel) async {
    await firebaseBookDataSource.deleteBook(bookModel);
  }

  @override
  Future<void> addBookToCollection(
    BookModel bookModel,
    String collectionModelId,
  ) async {
    await firebaseBookDataSource.addBookToCollection(
      bookModel,
      collectionModelId,
    );
  }

  @override
  Future<void> removeBookFromCollection(
    BookModel bookModel,
    String collectionModelId,
  ) async {
    await firebaseBookDataSource.removeBookFromCollection(
      bookModel,
      collectionModelId,
    );
  }
}
