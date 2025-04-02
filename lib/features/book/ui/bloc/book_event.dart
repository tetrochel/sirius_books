import 'package:sirius_books/features/book/data/model/book_model.dart';

sealed class BookEvent {}

class OnLoadBook extends BookEvent{}

class OnAddBook extends BookEvent{
  BookModel bookModel;
  OnAddBook({required this.bookModel});
}