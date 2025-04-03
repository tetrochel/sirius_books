enum Cover { soft, hard, jacket }

class BookModel {
  final String? firebaseId;
  final String name;
  final String authorName;
  final int publicationYear;
  final String publisher;
  final String genre;
  final String isbn;
  final Cover cover;
  final int pagesCount;
  final int booksCount;
  final double price;
  final int weight;
  final String location;

  BookModel({
    required this.name,
    required this.authorName,
    required this.publicationYear,
    required this.publisher,
    required this.genre,
    required this.isbn,
    required this.cover,
    required this.pagesCount,
    required this.booksCount,
    required this.price,
    required this.weight,
    required this.location,
    this.firebaseId,
  });

  //Дзен код
  factory BookModel.fromFirebase(String id, Map<String, dynamic> data) {
    final yearString = data['Год'].toString();
    final year = yearString.isNotEmpty ? int.parse(yearString) : 0;

    final pagesString = data['Страниц'].toString();
    final pages = pagesString.isNotEmpty ? int.parse(pagesString) : 0;

    final countString = data['Количество'].toString();
    final count = countString.isNotEmpty ? int.parse(countString) : 0;

    final priceString = data['Стоимсоть'].toString();
    final price = priceString.isNotEmpty
        ? double.parse(priceString.replaceAll(' ', '').replaceAll(',', '.'))
        : 0.0;

    final weightString = data['Вес'].toString();
    final weight = weightString.isNotEmpty
        ? int.parse(weightString.replaceAll(' ', '').replaceAll(',', '')) ~/ 100
        : 0;

    final coverString = data['Переплет'].toString();
    final cover = coverString == 'в пер'
        ? Cover.hard
        : coverString == 'в пер., супер.'
            ? Cover.jacket
            : Cover.soft;

    return BookModel(
      firebaseId: id,
      name: data['Наименование'].toString(),
      authorName: data['Автор'].toString(),
      publicationYear: year,
      publisher: data['Изд-во'].toString(),
      genre: data['Жанр'] ?? 'Жанр',
      isbn: data['ISBN'].toString(),
      cover: cover,
      pagesCount: pages,
      booksCount: count,
      price: price,
      weight: weight,
      location: 'Место',
    );
  }

  BookModel copyWith({
    String? firebaseId,
    String? name,
    String? authorName,
    int? publicationYear,
    String? publisher,
    String? genre,
    String? isbn,
    Cover? cover,
    int? pagesCount,
    int? booksCount,
    double? price,
    int? weight,
    String? location,
  }) {
    return BookModel(
      firebaseId: firebaseId ?? this.firebaseId,
      name: name ?? this.name,
      authorName: authorName ?? this.authorName,
      publicationYear: publicationYear ?? this.publicationYear,
      publisher: publisher ?? this.publisher,
      genre: genre ?? this.genre,
      isbn: isbn ?? this.isbn,
      cover: cover ?? this.cover,
      pagesCount: pagesCount ?? this.pagesCount,
      booksCount: booksCount ?? this.booksCount,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      location: location ?? this.location,
    );
  }
}
