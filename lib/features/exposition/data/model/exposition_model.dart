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

  ExpositionModel copyWith({
    String? id,
    String? topic,
    String? name,
    String? description,
    List<BookModel>? books,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ExpositionModel(
      id: id ?? this.id,
      topic: topic ?? this.topic,
      name: name ?? this.name,
      description: description ?? this.description,
      books: books ?? this.books,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
