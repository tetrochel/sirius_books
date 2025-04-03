import 'package:sirius_books/features/book/data/model/book_model.dart';

sealed class FilterModel<Param, F> {
  final String id;
  final Param Function(BookModel book) paramExtractor;

  FilterModel({
    required this.id,
    required this.paramExtractor,
  });

  bool check({
    required BookModel book,
    required F value,
  });
}

class SubStringFilterModel extends FilterModel<String, String> {
  SubStringFilterModel({
    required super.id,
    required super.paramExtractor,
  });

  @override
  bool check({
    required BookModel book,
    required String value,
  }) =>
      paramExtractor(book).contains(value);
}

class SubrangeFilterModel extends FilterModel<num, ({num min, num max})> {
  final num min;
  final num max;

  SubrangeFilterModel({
    required super.id,
    required super.paramExtractor,
    required this.min,
    required this.max,
  });

  @override
  bool check({
    required BookModel book,
    required ({num min, num max}) value,
  }) =>
      paramExtractor(book) >= value.min && paramExtractor(book) <= value.max;
}

class EnumFilterModel extends FilterModel<Cover, List<Cover>> {
  EnumFilterModel({
    required super.id,
    required super.paramExtractor,
  });

  @override
  bool check({
    required BookModel book,
    required List<Cover> value,
  }) =>
      value.contains(paramExtractor(book));
}

class Filters {
  static final filters = [
    SubStringFilterModel(
      id: 'name',
      paramExtractor: (book) => book.name,
    ),
    SubStringFilterModel(
      id: 'authorName',
      paramExtractor: (book) => book.authorName,
    ),
    SubrangeFilterModel(
      id: 'publicationYear',
      paramExtractor: (book) => book.publicationYear,
      min: 1980,
      max: DateTime.now().year,
    ),
    SubStringFilterModel(
      id: 'publisher',
      paramExtractor: (book) => book.publisher,
    ),
    SubStringFilterModel(
      id: 'genre',
      paramExtractor: (book) => book.genre,
    ),
    SubStringFilterModel(
      id: 'isbn',
      paramExtractor: (book) => book.isbn,
    ),
    EnumFilterModel(
      id: 'cover',
      paramExtractor: (book) => book.cover,
    ),
    SubrangeFilterModel(
      id: 'pagesCount',
      paramExtractor: (book) => book.pagesCount,
      min: 1,
      max: 10000,
    ),
    SubrangeFilterModel(
      id: 'booksCount',
      paramExtractor: (book) => book.booksCount,
      min: 1,
      max: 10000,
    ),
    SubrangeFilterModel(
      id: 'price',
      paramExtractor: (book) => book.price,
      min: 1,
      max: 100000,
    ),
    SubrangeFilterModel(
      id: 'weight',
      paramExtractor: (book) => book.weight,
      min: 1,
      max: 100000,
    ),
    SubStringFilterModel(
      id: 'location',
      paramExtractor: (book) => book.location,
    ),
  ];
}
