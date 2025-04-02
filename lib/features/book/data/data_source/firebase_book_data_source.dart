import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';

class FirebaseBookDataSource {
  Future<void> addBook(BookModel bookModel) async {
    try {
      await FirebaseFirestore.instance.collection('myCollection').add({
        'Наименование': bookModel.name.toString(),
        'Автор': bookModel.authorName.toString(),
        'Год': bookModel.publicationYear.toString(),
        'Изд-во': bookModel.publisher.toString(),
        'ISBN': bookModel.isbn.toString(),
        'Переплет': _convertCoverToString(bookModel.cover).toString(),
        'Страниц': bookModel.pagesCount.toString(),
        'Количество': bookModel.booksCount.toString(),
        'Стоимсоть': bookModel.price.toString(),
        'Вес': (bookModel.weight * 100).toString(),
        'Жанр': bookModel.genre.toString(),
        'Место': bookModel.location.toString(),
      });
    } on Exception catch (_) {
      return;
    }
  }

  Future<List<BookModel>?> getBookList() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('myCollection').get();

      final bookModelList = <BookModel>[];
      for (final doc in querySnapshot.docs) {
        //ai-generated methods
        // Проверка цены
        final priceString = doc.get('Стоимсоть').toString();
        final price = priceString.isNotEmpty 
            ? double.parse(priceString.replaceAll(' ', '').replaceAll(',', '.'))
            : 0.0;

        // Проверка веса
        final weightString = doc.get('Вес').toString();
        final weight = weightString.isNotEmpty
            ? int.parse(weightString.replaceAll(' ', '').replaceAll(',', '')) ~/ 100
            : 0;

        // Проверка года издания
        final yearString = doc.get('Год').toString();
        final year = yearString.isNotEmpty
            ? int.parse(yearString)
            : 0;

        // Проверка количества страниц
        final pagesString = doc.get('Страниц').toString();
        final pages = pagesString.isNotEmpty
            ? int.parse(pagesString)
            : 0;

        // Проверка количества книг
        final countString = doc.get('Количество').toString();
        final count = countString.isNotEmpty
            ? int.parse(countString)
            : 0;

        final idString = doc.id;

        bookModelList.add(
          BookModel(
            firebaseId: idString,
            name: doc.get('Наименование').toString(),
            authorName: doc.get('Автор').toString(),
            publicationYear: year,
            publisher: doc.get('Изд-во').toString(),
            genre: 'Жанр',
            isbn: doc.get('ISBN').toString(),
            cover: _convertCover(doc.get('Переплет').toString()),
            pagesCount: pages,
            booksCount: count,
            price: price,
            weight: weight,
            location: 'Место',
          ),
        );
      }

      return bookModelList;
    } on Exception catch (_) {
      return null;
    }
  }

  Cover _convertCover(String coverString) {
    if (coverString == 'в пер') {
      return Cover.hard;
    } else if (coverString == 'в пер., супер.') {
      return Cover.jacket;
    } else {
      return Cover.soft;
    }
  }

  String _convertCoverToString(Cover cover) {
    switch (cover) {
      case Cover.hard:
        return 'в пер';
      case Cover.jacket:
        return 'в пер., супер.';
      case Cover.soft:
        return 'мягкий';
    }
  }
}
