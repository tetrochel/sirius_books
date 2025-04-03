import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';

class FirebaseExpositionDataSource {
  Future<void> addExposition(ExpositionModel expositionModel) async {
    try {
      await FirebaseFirestore.instance.collection('expositions').add({
        'Название': expositionModel.name.toString(),
        'Тема': expositionModel.topic.toString(),
        'Список книг': expositionModel.bookList.map((book) => book.firebaseId).toList(),
        'Место проведения': expositionModel.location.toString(),
        'Дата начала': expositionModel.startDate.toString(),
        'Дата окончания': expositionModel.endDate.toString(),
      });
    } on Exception catch(_) {
      return;
    }
  }

  Future<List<ExpositionModel>> getExpositionList() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('expositions').get();

      final expositionModelList = <ExpositionModel>[];
      for (final doc in querySnapshot.docs) {
        final idString = doc.id;
        final bookIds = List<String>.from(doc.get('Список книг') as List);
        
        // Получаем список книг для экспозиции
        final bookList = <BookModel>[];
        for (final bookId in bookIds) {
          final bookDoc = await FirebaseFirestore.instance
              .collection('myCollection')
              .doc(bookId)
              .get();
          
          if (bookDoc.exists) {
            final bookData = bookDoc.data()!;
            
            // Проверка года издания
            final yearString = bookData['Год'].toString();
            final year = yearString.isNotEmpty
                ? int.parse(yearString)
                : 0;

            // Проверка количества страниц
            final pagesString = bookData['Страниц'].toString();
            final pages = pagesString.isNotEmpty
                ? int.parse(pagesString)
                : 0;

            // Проверка количества книг
            final countString = bookData['Количество'].toString();
            final count = countString.isNotEmpty
                ? int.parse(countString)
                : 0;

            // Проверка цены
            final priceString = bookData['Стоимсоть'].toString();
            final price = priceString.isNotEmpty 
                ? double.parse(priceString.replaceAll(' ', '').replaceAll(',', '.'))
                : 0.0;

            // Проверка веса
            final weightString = bookData['Вес'].toString();
            final weight = weightString.isNotEmpty
                ? int.parse(weightString.replaceAll(' ', '').replaceAll(',', '')) ~/ 100
                : 0;

            bookList.add(
              BookModel(
                firebaseId: bookId,
                name: bookData['Наименование'].toString(),
                authorName: bookData['Автор'].toString(),
                publicationYear: year,
                publisher: bookData['Изд-во'].toString(),
                genre: 'Жанр',
                isbn: bookData['ISBN'].toString(),
                cover: _convertCover(bookData['Переплет'].toString()),
                pagesCount: pages,
                booksCount: count,
                price: price,
                weight: weight,
                location: 'Место',
              ),
            );
          }
        }

        expositionModelList.add(
          ExpositionModel(
            id: int.parse(idString),
            topic: doc.get('Тема').toString(),
            name: doc.get('Название').toString(),
            bookList: bookList,
            location: doc.get('Место проведения').toString(),
            startDate: DateTime.parse(doc.get('Дата начала').toString()),
            endDate: DateTime.parse(doc.get('Дата окончания').toString()),
          ),
        );
      }

      return expositionModelList;
    } on Exception catch (_) {
      return [];
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
}