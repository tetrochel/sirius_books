import 'package:sirius_books/features/book/data/model/book_model.dart';

class CollectionModel {
  final String? firebaseId;
  final String name;
  final String description;
  final List<BookModel> books;

  CollectionModel({
    required this.name,
    required this.description,
    required this.books,
    this.firebaseId,
  });
}
