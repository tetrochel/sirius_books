import 'package:sirius_books/features/book/data/model/book_model.dart';

class ExpositionModel {
  final String? id;
  final String topic;
  final String name;
  final String? description;
  final List<BookModel> books;
  final String location;
  final DateTime startDate;
  final DateTime endDate;

  ExpositionModel({
    required this.topic,
    required this.name,
    required this.books,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.description,
    this.id,
  });
}
