enum Cover { soft, hard, jacket }

class BookModel {
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
  });
}
