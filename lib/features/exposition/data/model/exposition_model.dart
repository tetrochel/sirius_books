import 'package:sirius_books/features/book/data/model/book_model.dart';

class ExpositionModel {
  final int id;
  final String topic;
  final String name;
  final List<BookModel> bookList;
  final String location;
  final DateTime startDate;
  final DateTime endDate;

  ExpositionModel({
    required this.id,
    required this.topic,
    required this.name,
    required this.bookList,
    required this.location,
    required this.startDate,
    required this.endDate,
  });
}
